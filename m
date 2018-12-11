Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00B2C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7518D2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544566949;
	bh=oVulQxci7QzQxkKK/w/q4UvbaHt+68XaOfGFIowHieA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=oqdI08DBAcfSq++LOxAdUzAT0MiZNKI17HQ2LHk33S91iOVKXQCXplNGrsE4Ga03D
	 qjTBgP8YnfFVZycRZUXgyRoMOMdW9IOHvjW3EcBmSsuaKUE2HaLlISDJ8ysW8kU4I1
	 LwC6FiDBv90J2n3ep8tBQBqGughn+84uN1WiaNKs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7518D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeLKWW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:22:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbeLKWW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:22:28 -0500
Received: from [10.80.45.159] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA7D52084C;
        Tue, 11 Dec 2018 22:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544566947;
        bh=oVulQxci7QzQxkKK/w/q4UvbaHt+68XaOfGFIowHieA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RG58DfCRK3JntYQZYTvpKMtpunBPevLDBLzu6T4l9gaS4aThak3wWBpTGknBFqNBg
         4eqYzX5+nLZonoBiWyYr5Pco8kh5B38vhz7tIgAFE/XILI/CuyzxpjTqZFVvxoS0xd
         9SPuqPxziOuzWdSzQ83xoJZIUji9DUqy5gB5PVqI=
Subject: Re: [PATCH v3 2/3] ACPI / OSL: Allow PCI to be disabled
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181210181315.5023-1-okaya@kernel.org>
 <20181210181315.5023-2-okaya@kernel.org> <20181211170957.GA335@infradead.org>
 <342c5dd9-cb3d-d714-c87f-814a942cf395@kernel.org>
 <CAJZ5v0ia+eotSZgjbitt7TAT0ECSmTAz1XJhS3Auz5w5Z61SZA@mail.gmail.com>
 <a9c7cbe1-eef3-40ad-de62-8194df12ca20@kernel.org>
 <CAJZ5v0g5t4sx6mY=mCPWOdZLbhEAXo5Ah1TZw9jZNJQ-+cgWsw@mail.gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <6644defb-9199-6467-6e3e-8ce552b56f87@kernel.org>
Date:   Tue, 11 Dec 2018 17:22:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0g5t4sx6mY=mCPWOdZLbhEAXo5Ah1TZw9jZNJQ-+cgWsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2018 5:16 PM, Rafael J. Wysocki wrote:
>> AFAIK, ACPI spec says that AML code running on non-existing op-regions to be
>> discarded last time I checked.
> I guess you mean "disregarded"?
> 

I have seen Linux complain about reads/writes to non-existing I2C opregions
before as a read/write failure for every single AML transaction. I was under the
impression that we didn't care.

> So the spec appears to expect the OS to silently ignore the failures
> in those cases, so why should an error be returned?
> 

I can certainly return success for this case when CONFIG_PCI is not present.

>> I know Linux is noisy about these.
