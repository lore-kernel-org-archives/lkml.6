Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B618CC46463
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FAB7208B0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t61Jo6ir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAB7208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbeHBCAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:00:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37741 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeHBCAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:00:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id a26-v6so232985pfo.4;
        Wed, 01 Aug 2018 17:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lu0qwPz6uyONGXUgMw4S2NhfwOadTYxhj1HsXO4CBDc=;
        b=t61Jo6irQ5FZq+PB2EGTGRPzlimOzd/0z+d3ftH4AXTfpL4E1ObRD57LPq0IjtovBO
         N54E0tOgHSFmtMIxpqO226nTBNTbctgahWSdM1cuxwpmOO1XNPOVSImo3lzRSbj+bokt
         l84hLGK3WjAkl1g9umcMfAetv+8a77N0LxuqPWI6zXdPCAOAhcfofH+zMAvv/avhsbdc
         +cKBnSZ5hBcPBb9mRfifZ/Yifp0LpKU5/RMzpq+Dmn+tKO+sPi4PAqHfGn9u8WzLw0tk
         EOVL9pzgyliCHuHHh1dy0VjNMl0WPpAPOjGiURs65mIdRQ+hQTwXDlCbSrBkiX2EdJnq
         WQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lu0qwPz6uyONGXUgMw4S2NhfwOadTYxhj1HsXO4CBDc=;
        b=Fcwg21cqMUlx5kAD2J7rIXaN3pLnH7o4AUoJWNyfRYH9puDuydNdB0QS/mHKrz0Wi7
         D33o5EgRqFeeRhGQAwzBZt086uQxyDpM4uuHldEVOAqShkQZ9JsGmISuPiGVtyppjKF7
         e55oCfTylS1o8taYTROSRFSD664yp8m7Npkoj+d/hACMyDLkTf0T6eqJ85KFz9N5EPru
         kBMEMBVBNH/2OE2I++ZPvbIcpHWYylKH8N6TFm0vql5v72EHMP0WeBBzHC5kxOmKg/fe
         /rSeDxr+bUMsZ6OVDktthnlvSaFOB8AtLNa+Bov23HJVnVUjxeseGWOX0Zvmg7Gz1sxz
         JDPA==
X-Gm-Message-State: AOUpUlGNWXPcowoKn1pdbxJ+EdOUIHljxMy86hglxkpCgaWaJtcqRpZ2
        qPJq8YLoc4pALfgtKxT9brFYyw9N
X-Google-Smtp-Source: AAOMgpeLqj18Q4OCSn1RTcysbAZkf2Fx0hyV1LOi+vBCOZ0PQ4VsC0ATY6o4FPQ9js0Q7GXHbj2TIw==
X-Received: by 2002:a63:cd4c:: with SMTP id a12-v6mr465701pgj.15.1533168749125;
        Wed, 01 Aug 2018 17:12:29 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id b62-v6sm374259pfm.97.2018.08.01.17.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 17:12:28 -0700 (PDT)
Subject: Re: linux-next: Tree for Aug 1
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
References: <20180801175852.36549130@canb.auug.org.au>
 <20180801224813.GA13074@roeck-us.net>
 <1533163965.3158.1.camel@HansenPartnership.com>
 <20180801234727.GA3762@roeck-us.net>
 <CACVXFVMrzLRP5Q=cwZGnqeUeyODL3Pq9jMkT7czZouK9510fUA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b113950e-26d6-e872-1a1e-c199c4fb2dcc@roeck-us.net>
Date:   Wed, 1 Aug 2018 17:12:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACVXFVMrzLRP5Q=cwZGnqeUeyODL3Pq9jMkT7czZouK9510fUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2018 04:57 PM, Ming Lei wrote:
> On Thu, Aug 2, 2018 at 7:47 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On Wed, Aug 01, 2018 at 03:52:45PM -0700, James Bottomley wrote:
>>> On Wed, 2018-08-01 at 15:48 -0700, Guenter Roeck wrote:
>>>> On Wed, Aug 01, 2018 at 05:58:52PM +1000, Stephen Rothwell wrote:
>>>>> Hi all,
>>>>>
>>>>> Changes since 20180731:
>>>>>
>>>>> The pci tree gained a conflict against the pci-current tree.
>>>>>
>>>>> The net-next tree gained a conflict against the bpf tree.
>>>>>
>>>>> The block tree lost its build failure.
>>>>>
>>>>> The staging tree still had its build failure due to an interaction
>>>>> with
>>>>> the vfs tree for which I disabled CONFIG_EROFS_FS.
>>>>>
>>>>> The kspp tree lost its build failure.
>>>>>
>>>>> Non-merge commits (relative to Linus' tree): 10070
>>>>>   9137 files changed, 417605 insertions(+), 179996 deletions(-)
>>>>>
>>>>> -----------------------------------------------------------------
>>>>> -----------
>>>>>
>>>>
>>>> The widespread kernel hang issues are still seen. I managed
>>>> to bisect it after working around the transient build failures.
>>>> Bisect log is attached below. Unfortunately, it doesn't help much.
>>>> The culprit is reported as:
>>>>
>>>> 2d542828c5e9 Merge remote-tracking branch 'scsi/for-next'
>>>>
>>>> The preceding merge,
>>>>
>>>> 453f1d821165 Merge remote-tracking branch 'cgroup/for-next'
>>>>
>>>> checks out fine, as does the tip of scsi-next (commit 103c7b7e0184,
>>>> "Merge branch 'misc' into for-next"). No idea how to proceed.
>>>
>>> This sounds like you may have a problem with this patch:
>>>
>>>      commit d5038a13eca72fb216c07eb717169092e92284f1
>>>       Author: Johannes Thumshirn <jthumshirn@suse.de>
>>>       Date:   Wed Jul 4 10:53:56 2018 +0200
>>>
>>>           scsi: core: switch to scsi-mq by default
>>>
>>> To verify, boot with the additional kernel parameter
>>>
>>> scsi_mod.use_blk_mq=0
>>>
>>> Which will reverse the effect of the above patch.
>>>
>> Yes, that fixes the problem.
> 
> That may not the root cause, given this issue is only started to
> see from next-20180731, but d5038a13eca7 (scsi: core: switch to
> scsi-mq by default)
> has been in -next for quite a while.
> 
> Seems something new causes this issue.
> 

Agreed. I should have said "fixes the symptom". I'll try to bisect
with scsi_mod.use_blk_mq=1 as suggested by James.

Guenter

