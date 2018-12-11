Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811C9C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400E420870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544549827;
	bh=0ZMcdZUP8UNg1Oh21piVT3rzPWnRpAWcMJr2haqXkSU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=0jIzEbl8bV6fAuJBQDD0YoxeOhQm9lhXOQdqUTRLr5ZGC9Sp/+rn8P55QOvecdk4b
	 z8c+DV8qD3Nu87HiAsDlcXFj/BKWvQZFNW9QgF2EP097oOAKLNAZnTwU7sFOfOi6IL
	 /Wyhga9YmdCPXVaJzABS5ODFPuIp54Am35CppHRg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400E420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeLKRhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:37:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbeLKRhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:37:05 -0500
Received: from [10.80.45.159] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5278E2086D;
        Tue, 11 Dec 2018 17:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544549825;
        bh=0ZMcdZUP8UNg1Oh21piVT3rzPWnRpAWcMJr2haqXkSU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dH5KteToZoItaYT6KvnBVp8cbWbo8UUA32WXk+tbaH5gKnMSC2iJu0AILeVuWfVMj
         NcKya9ODphh5HxS6mTYyuzZI07fwzf833HwiSfaNglk/cA7/79L2KGGVG0nRzjyaOp
         EgFToyEtCFdlALgWzHWGyglaqLChlAV/bkILhc8c=
Subject: Re: [PATCH v3 2/3] ACPI / OSL: Allow PCI to be disabled
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181210181315.5023-1-okaya@kernel.org>
 <20181210181315.5023-2-okaya@kernel.org> <20181211170957.GA335@infradead.org>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <342c5dd9-cb3d-d714-c87f-814a942cf395@kernel.org>
Date:   Tue, 11 Dec 2018 12:37:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181211170957.GA335@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2018 12:09 PM, Christoph Hellwig wrote:
> On Mon, Dec 10, 2018 at 06:13:14PM +0000, Sinan Kaya wrote:
>> Getting ready to allow PCI to be disabled with ACPI enabled. Stub
>> out calls that depend on PCI.
> 
> I think you want to skip building at least all of hwpci.c if CONFIG_PCI
> is disabled.  Or replace that whole stiking pile of crap with something
> resembling C code..
> 

I can give it a try but I'm under the impression that we don't touch
ACPICA code in general.

Feel free to correct me.
