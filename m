Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42834C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065CD2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544565457;
	bh=rBsQ/SdO14Lx68BAJmHBDqKYnX0YCBKpXOGs3ZF8Lqg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=XrrofBG00fSnLKmnk7sOyYZw4C8HiAmGCWNLIDD2mrwahatIqYlJg3fYbgdhBhtNr
	 C0ulXU0x8mGY5+eUC8WnftzYWdElR113dQLSsEFmEyYeVJ+c+iI5cKxnSyRuWp+uTd
	 Pt+0E6b0BlPlcb0pnpMijqp6oQN3gbRhP/y6GV70=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065CD2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeLKV5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:57:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:52994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbeLKV5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:57:35 -0500
Received: from [10.80.45.159] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FFC320672;
        Tue, 11 Dec 2018 21:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544565454;
        bh=rBsQ/SdO14Lx68BAJmHBDqKYnX0YCBKpXOGs3ZF8Lqg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ioH33CHptg0BsMe74OQbGaFG2taQCy/DQqDMn40shAT5O9AEFDQxjy5RnWPRS1+rP
         5q3/os3tkbwvdHrszwZsdaveGo7X2/8/ju9WinAURs4UtFfubhB81Y4WB/GQmNcLVl
         Wah6aOFnGzirh4qLIyx4GJEPg5EJB4gblcsKGdbM=
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
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <a9c7cbe1-eef3-40ad-de62-8194df12ca20@kernel.org>
Date:   Tue, 11 Dec 2018 16:57:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ia+eotSZgjbitt7TAT0ECSmTAz1XJhS3Auz5w5Z61SZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2018 4:46 PM, Rafael J. Wysocki wrote:
> On Tue, Dec 11, 2018 at 6:37 PM Sinan Kaya <okaya@kernel.org> wrote:
>>
>> On 12/11/2018 12:09 PM, Christoph Hellwig wrote:
>>> On Mon, Dec 10, 2018 at 06:13:14PM +0000, Sinan Kaya wrote:
>>>> Getting ready to allow PCI to be disabled with ACPI enabled. Stub
>>>> out calls that depend on PCI.
>>>
>>> I think you want to skip building at least all of hwpci.c if CONFIG_PCI
>>> is disabled.  Or replace that whole stiking pile of crap with something
>>> resembling C code..
>>>
>>
>> I can give it a try but I'm under the impression that we don't touch
>> ACPICA code in general.
>>
>> Feel free to correct me.
> 
> We don't as a rule, but depending on what the patch looks like, we
> might not follow the rule this time.
> 

OK. Good to know. I'll take a stab at it.

> I wonder though what we do if some AML wants to access PCI config
> space via an opregion in there.  Have you thought about that?
> 

Return an error.

AFAIK, ACPI spec says that AML code running on non-existing op-regions to be
discarded last time I checked.

I know Linux is noisy about these.

I did boot QEMU without CONFIG_PCI. There was a bunch of ACPI errors reported
during boot as expected but boot succeeded. There was no hard lockup/failure.
