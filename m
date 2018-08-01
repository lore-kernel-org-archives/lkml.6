Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120D3C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA941208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBLLe9jW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA941208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389427AbeHAPAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:00:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44872 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389283AbeHAPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:00:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id q127-v6so16814000ljq.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NkmcVTYZBQlmNEboSg49HysFn+8w0KavpdroKQoomL4=;
        b=QBLLe9jWECNhYuFj9tNlaIHmP2dD/S2CLIeLMXI/aukKli0GVFy1ylyp3IaRnvHVqB
         uPmJv4fVB0nsIKvUqT69xf1ENOPB4k+MmCNChF0C6x9wz6b0r9O7Y1HZqnq2HlhPNREY
         AvBxL0gxTzIkKiv8trL4/LpV8cEvq92c/oXB7+KlmTA2rHthJn7iSQxpMJpLHZE7koop
         WNV8ESzi3NV4Jc0W9gp2hnTy1MkoCIyNisTH+BUC7aOtIKwQMrBo2SF/UxKJeKEYa7vD
         TjdR2Y6uYAxkJv4Yz/BTLIkO2oYgQzpBpWhQFE/LIeQB11wtGj8MqsA0beXTqgJoGJ/E
         ON9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NkmcVTYZBQlmNEboSg49HysFn+8w0KavpdroKQoomL4=;
        b=LDhyWW6XdojiVtQmR7H/Yz8K4SeodQDYi6hgnoDxYddJrqXdPfHIudmsA+R79oQM8C
         wG7Pkju7bhmeGo9XSQCtHYYaVxFzcXNQZ5TBQyQiTARIhl33LNbnV4ksqYUmFalXYzWd
         Nu7bTDffsU4UokE1VEjC57iDHiic/5eB3NiLmnf1TbWjc8Lg0b4kbWD283a4mGByEKmb
         09lhiGxCmkdEVMBuV0crF2lbS4bQgBJxDrJ0OXop9JxP++soRKTPwfw7S/iGrCnhQZno
         b2Y6mq+brC5LZEHyBT7RnMpOXBgsV66zkohgRlkwYemJPUQkBUrxcxTPOhc7OvY/BzWd
         DpHg==
X-Gm-Message-State: AOUpUlGh7wg6UUHBSz0ilOwf1Tm3RTPZozfQZrTM4mO0PfPYc1L8m7jn
        DO1tTp5NkqaTXg+GkVRDMdf1DFdv0VDn2sLkOmQ=
X-Google-Smtp-Source: AAOMgpe7ZWX3cWrSMu2+QhF7x9gEB554pwJmfYdcGvrQlB4qNkQqaDf2lX5PqCLShxbGwjvxgMnV2bQ7NtpYEEUAF3s=
X-Received: by 2002:a2e:4619:: with SMTP id t25-v6mr20581218lja.96.1533129265665;
 Wed, 01 Aug 2018 06:14:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 06:14:24 -0700 (PDT)
In-Reply-To: <1843623.lUM99VBV1x@phil>
References: <20180731203430.GA30136@jordon-HP-15-Notebook-PC>
 <16141309.kTfAWOe8rM@phil> <CAFqt6zZfLXuMUT75a3dWKeiCCmKZOfi=FdTeFRjcdFDZdfcRVQ@mail.gmail.com>
 <1843623.lUM99VBV1x@phil>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 1 Aug 2018 18:44:24 +0530
Message-ID: <CAFqt6zbd5pJJEV+9_sqs3bML18gpWROBjGA13VeK3AWFgJ_u+A@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: Convert drm_atomic_helper_suspend/resume()
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     hjc@rock-chips.com, airlied@linux.ie,
        Ajit Linux <ajitn.linux@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 6:40 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Am Mittwoch, 1. August 2018, 14:43:47 CEST schrieb Souptick Joarder:
>> On Wed, Aug 1, 2018 at 6:03 PM, Heiko Stuebner <heiko@sntech.de> wrote:
>> > Hi Souptick,
>> >
>> > Am Dienstag, 31. Juli 2018, 22:34:30 CEST schrieb Souptick Joarder:
>> >> convert drm_atomic_helper_suspend/resume() to use
>> >> drm_mode_config_helper_suspend/resume().
>> >>
>> >> With this conversion, rockchip_drm_fb_resume() and
>> >> rockchip_drm_fb_suspend() will not be used anymore.
>> >> Both of these functions can be removed.
>> >>
>> >> Also, in struct rockchip_drm_private state will not be
>> >> used anymore. So this can be removed forever.
>> >>
>> >> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> >> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
>> >
>> > the patch itself looks great, just a simple bookkeeping question.
>> >
>> > What role did Ajit play in creating the patch? If I remember correctly
>> > it is meant to be
>> > - 1st Signed-off: Patch-Author
>> > - 2nd Signed-off: E-Mail sender + patch possibly patch changes
>> > (optional of course if the same)
>> >
>> > So was this meant to be a Reviewed-by from Ajit?
>>
>> We both are working together for these patches to
>> convert drm_atomic_helper_suspend/resume().
>> That's the reason to add his name in 2nd Signed-off
>> in all similar patches.
>>
>> Is it a incorrect way to put 2nd Signed-off here ?
>
> Thanks for the clarification and the interesting question :-)
>
> I've just read through Documentation/process/submitting-patches.rst
> and it seems there is an "official" way to show that relationship, via a
> tag named "Co-Developed-by:" described under number 12.
>
> So I guess we could just adapt the patch accordingly, if that is ok with
> both of you (i.e. I can change this when applying, so no need to resend).

We are ok with it :-)

>
>
> Heiko
>
>
