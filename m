Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E5EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D9E23771
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apmLU/bh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D9E23771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbeGBW35 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:29:57 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42775 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753609AbeGBW34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:29:56 -0400
Received: by mail-wr0-f193.google.com with SMTP id p1-v6so16991184wrs.9;
        Mon, 02 Jul 2018 15:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RqjZOyp2ONmBh0Fd62j4s+uDWZ6iaXSQnWLWn03KGmA=;
        b=apmLU/bhdUKpCQOMwVw7sR6WMLNI6vBfzQkgSbdpKOdjawrSFBo7P63+1BD/klbmg/
         OC8mcdlH9HCSpJ/qWX6Om+POGHif11FCEoFDoA70/F+Vje8CSFScHr1PGGoYpqvs6GWC
         /T10g41Mfh0xLeIUHbR3rvQftgiaUosGwYUghUS1b1uHXG0FQkx3juyYn2hZWNXm7EHg
         1+Mj2rQU3JWiZK1ERpPWUgIwP5OPlz1klBchotEOXb9uSx7yFAWi+63ggszyYHABofI4
         4u5Ie9el+j0EqZnFK5gNvOgR4smn5hdqMAGjfevXfW3fNbpSnpZaQ1FhqQ/YyCNjpqez
         iyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RqjZOyp2ONmBh0Fd62j4s+uDWZ6iaXSQnWLWn03KGmA=;
        b=j+9Z77MfD2Pms+7UEl8AdnVhE5YORnGojRfwvKtp2XrDJK+gaUQfTcIaF69M2ncjU4
         MnDfBUSJ+7/vFCCLN55CgI0fggKdnm4BNvHtv6IDn92hbh2wB/EvyYgB6t3jYEdF35fe
         tCBBSTrqTGL5AoqekfbK00uCrmopBJI6/gcyNuy2TU7cTyVqJ+weZ4uXgmRIY7fR/Gv8
         1WjygBDmpuaIssDld2KsqaW0y9GnXccm+cGHkv7/csANtUjsBB4eROmPGGT0t67HmOx2
         m5cVtXXhdGOo6pDp0GOrnnKTwtS2NHTTyKJyYetwk9pMDu2GWjWeDRiqvL0viC/5RJBX
         N1PQ==
X-Gm-Message-State: APt69E2rkRlbq37le5qAY8D6fM9JruX9aGTh99BVJGdqCwL682hXImw8
        v5Gx3Kb11dPPVwtwtst101OolMtNEjaq6wzZX7s=
X-Google-Smtp-Source: AAOMgpdV1N+dKsqSRdmsoiIfPXj16q/R1qWk/ysbJlTRUtMx+/8gV9DGcowdpX/Ds0PJOYmQKA+ZLCMbKK/06tPkg+Y=
X-Received: by 2002:adf:e9c1:: with SMTP id l1-v6mr7660335wrn.14.1530570594798;
 Mon, 02 Jul 2018 15:29:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:dcce:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 15:29:54 -0700 (PDT)
In-Reply-To: <20180702162436.GA3496@vmlxhi-102.adit-jv.com>
References: <2333fe05-da2e-e6f6-931a-16fce2980f17@jusst.de> <20180702162436.GA3496@vmlxhi-102.adit-jv.com>
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date:   Tue, 3 Jul 2018 01:29:54 +0300
Message-ID: <CAB=otbTOwJaxTB=7e0sjFPDAM-hQ+bH-kHfAVZCQkeDpwG-NCg@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] usb: gadget: f_uac*: Support multiple sampling rates
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Julian Scheel <julian@jusst.de>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On Mon, Jul 2, 2018 at 7:30 PM, Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> Hi Julian,
>
> [CC:Takashi, since we are discussing sound-related parts of USB]
>
> On Mon, Jul 02, 2018 at 04:07:19PM +0200, Julian Scheel wrote:
>> Hi Eugeniu,
>>
>> On 30.06.2018 20:16, Eugeniu Rosca wrote:
>> > Would it be possible to revive the uac2 multiple sampling rate
>> > patch-set [1] by rebasing it onto the most recent kernel? If you
>> > don't have time for this, I could help you.
>>
>> I have this on my todo-list for a while now... In fact I fixed the build
>> errors reported by the robot last year, but didn't had the time to
>> verify all of it and push again.
>> Still, I'd be happy to get this merged, so I'll try to check the state
>> of this within the next days and either post to the list or get back to
>> you if more work needs to be done.
>
> We've been living with an internally developed uac2 multiple rate
> support since June 2015, initially written on top of v3.14. Due to
> significant refactoring of uac2 driver brought by v4.13 commit [1], I
> went through the comparison between the in-house implementation (which
> no more applied cleanly to post-[1] vanilla) and your proposal from [2].
>

When Julian posted his patches, I've been working on UAC3 gadget
implementation which I posted later [1]. While I originally tried to make
UAC3 function to have same configfs files as UAC1/2, now, preparing
UAC3 gadget patch I see it doesn't fit this approach, and patch
"usb: gadget: f_uac*: Reduce code duplication" isn't applicable for UAC3
case. Especially for channels configuration which in new spec can be
done only through clusters descriptions, which makes configfs interface
more complicated and not so straightforward as UAC1/2 have.

I didn't finish my UAC3 gadget patch v2 yet, but if you can try to avoid
adding patch "Reduce code duplication" or wait for a few weeks, when
I'll post UAC3 patches, it would be great; so we will be able to take into
account new spec as well.

[1]: https://lkml.org/lkml/2017/11/6/1514

Thanks,
Ruslan
