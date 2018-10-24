Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723CEC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDD720824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QZbXNXEC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QZbXNXEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDD720824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeJXUdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 16:33:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54712 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeJXUdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 16:33:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CFE9A60C5F; Wed, 24 Oct 2018 12:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540382708;
        bh=M/xzbe4xN96bQmKPUq1GK7Q9XLW5PwfQeBrVwXNpV8I=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=QZbXNXECG/OIM88MiEWjVIHIR5SBoOrdwEdTtf5ggEFPxoogC7e9e5w/nKqfQ7K+O
         lXrot7cVb4xdMubI+2MqCt3HZ62sDGV5fnTo1+w/hosTw4x8EQtvYmlUa9dgE+NLwA
         4Xx+CAPyJKbzvoNWrqsH1ar+gwR4jzDTkJNIfN0U=
Received: from [10.206.28.53] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anilc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BFE106021A;
        Wed, 24 Oct 2018 12:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540382708;
        bh=M/xzbe4xN96bQmKPUq1GK7Q9XLW5PwfQeBrVwXNpV8I=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=QZbXNXECG/OIM88MiEWjVIHIR5SBoOrdwEdTtf5ggEFPxoogC7e9e5w/nKqfQ7K+O
         lXrot7cVb4xdMubI+2MqCt3HZ62sDGV5fnTo1+w/hosTw4x8EQtvYmlUa9dgE+NLwA
         4Xx+CAPyJKbzvoNWrqsH1ar+gwR4jzDTkJNIfN0U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BFE106021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anilc@codeaurora.org
From:   AnilKumar Chimata <anilc@codeaurora.org>
Subject: Re: [PATCH 3/3] crypto: qce: ice: Add support for Inline Crypto
 Engine
To:     AnilKumar Chimata <anilc@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, ebiggers@kernel.org,
        mhalcrow@google.com
References: <1539789476-6098-1-git-send-email-anilc@codeaurora.org>
 <1539789476-6098-4-git-send-email-anilc@codeaurora.org>
 <20181017170446.GD29710@thunk.org>
Message-ID: <3d330886-3d78-bc85-e2c1-f64a65d20205@codeaurora.org>
Date:   Wed, 24 Oct 2018 17:34:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181017170446.GD29710@thunk.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Theodore,

Thanks for the comments,

On 2018-10-17 22:34, Theodore Y. Ts'o wrote:
> First, thanks for the effort for working on getting the core ICE
> driver support into upstreamable patches.
> 
> On Wed, Oct 17, 2018 at 08:47:56PM +0530, AnilKumar Chimata wrote:
>> +2) Per File Encryption (PFE)
>> +Per File Manager(PFM) calls QSEECom api to create the key. PFM has a 
>> peer comp-
>> +onent(PFT) at kernel layer which gets the corresponding key index 
>> from PFM.
>> ...
>> +Further Improvements
>> +====================
>> +Currently, Due to PFE use case, ICE driver is dependent upon 
>> dm-req-crypt to
>> +provide the keys as part of request structure. This couples ICE 
>> driver with
>> +dm-req-crypt based solution. It is under discussion to expose an 
>> IOCTL based
>> +and registration based interface APIs from ICE driver. ICE driver 
>> would use
>> +these two interfaces to find out if any key exists for current 
>> request. If
>> +yes, choose the right key index received from IOCTL or registration 
>> based
>> +APIs. If not, dont set any crypto parameter in the request.
> 
> However, this documentation is referencing components which are not in
> the mainline kernel.

Sure, will clean the documentation and try to minimize the unknown 
components. Provided these details for better understanding of the flow.

> 
> In the long term, what I'd like to see for per-file key support is a
> clean solution which interfaces with the in-kernel fscrypt-enabled
> file systems (e.g., f2fs and ext4).  What I think we need to do is to

Agree, we are working on making per-file key (PFK) driver generic to 
support any file system.

> add a field in the bio structure which references a key id, and then
> define a bdi-specific interface which allows the file system to
> register a struct key and get a key id.  Use of the key id will be
> refcounted, so the device driver knows how many I/O operations are in
> flight using a particular key --- since each ICE hardware will have a
> different number of active keys that it can support.

Understand the point here, we will consider this refcount while working 
on upstreamable PFK driver.

> 
> Until that's there, at least for the upstream documentation, I think
> it would be better to drop mention of code that is not yet upstream
> --- and which may have problems ever going upstream in their current
> form.

Will clean the documentation.

> 
> (I haven't checked in a while, but last time I looked the code in
> question blindly dereferenced private pointers assuming that the only
> two file systems that could ever use ICE were ext4 and f2fs....  not
> that the code used by Google handsets were _that_ much cleaner, but
> at least we dropped in a crypto key into the struct bio, instead of
> playing unnatural games with private pointers from the wrong
> abstraction layer.  :-)

before upstreaming the PFK drivers, we will try to avoid private pointer 
dereferences to achieve better abstraction to file system.

> 
> 						- Ted
