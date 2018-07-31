Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E95CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1040D20894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uhtkLR5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1040D20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732410AbeGaXL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:11:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46669 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729924AbeGaXL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:11:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id h14-v6so18076141wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oeOhYa6mPWXTYI2iCK0U2uncPg/UiDcurrON6Kt/N04=;
        b=uhtkLR5ulhqHtMAN0HHaqPGLMHXhfERbk4sbWuha6rgA9tee2ZDEKJODvjXTV71qD0
         Lh96Wy9bWmbPiNI9qekSD+zEyTXibXCMZBFMQQWjW5iPgVu7NqwSbg5Ws7mSpvVuZOE3
         SD0OEG5yncWgHL4mJ/ckctpbSy3kexfy0g5hu7tjU7LrPn6QYxZS/+VF7U9FvS1kUMyI
         HG30BBJqaqRZZkPrO0ANFCb37tuaU1MwCn0YCxAoIgLRsLVlB9UikzViMIyAnEl2lMBX
         nyvD15ZjumASL1/dOIQsFPPWHv6hyZml2p+wYvFcFBVNGYu3tMKTLiWoto6xGwUHZcYT
         /kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oeOhYa6mPWXTYI2iCK0U2uncPg/UiDcurrON6Kt/N04=;
        b=TAC/jwq1DI4ahzwPjvnCaSaC9AlSer1bJEk+4RZY1a14KGjo2XJVQaUUXgnBAhlj71
         fAucx/xbUYVQM3zkLfeD8jBD7mTOB1EdX9cA9h5o1SfDtSGogEiKYHx8x3a6+AWWhqAu
         ljNuU0LjW03uDZlXBlZjAMRqmT99HfUpTLsqlP+ZJ7BbLs7NHEeC7utRCQYN5eTqnmPU
         EIWevIN/5b+zgUDaLAC2X6uMq4siMSK5zQ6ItSQJz29hxxX0dte1nm2R5GZ11MZ36Z/a
         lTu+Xe4xQO8ridVIsdJNMHtvBwPowZVZHw8hGGxFr1Qq2uJ4FTIujgYRNeZBKCuV0STk
         yO6g==
X-Gm-Message-State: AOUpUlEM8JPiDiVXAgts8mk7hMQlqYQ8gy23QfIPj1h+9paEHfU2goTu
        x1j9E6ghCyVY2O132RJ2lRAXD6jGH2T1DEzINe4=
X-Google-Smtp-Source: AAOMgpdV+mZdx0CfPfUrwIyELfzy1xHNFNj1MoFNzrwkxyx+XtLo6lZypUpQV0hIbjuv9M2gBgGeddY/RQe2XhIUR+k=
X-Received: by 2002:adf:e287:: with SMTP id v7-v6mr23207515wri.139.1533072549175;
 Tue, 31 Jul 2018 14:29:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:979e:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 14:29:08
 -0700 (PDT)
In-Reply-To: <658cd654-be3e-659a-20a7-f33034c231ce@amd.com>
References: <20180723163232.GA17358@embeddedor.com> <CADnq5_Ons4y+sweZGg4LgJpfn8wzgg8xdpytLt-78PVqqg-LpA@mail.gmail.com>
 <50f9f4f3-76e1-401a-bd84-6ae746fe4647@daenzer.net> <CADnq5_MKR=qYCX-m4wKA47F0EejNcUmS7jsnY9=1nyKKEQhqJQ@mail.gmail.com>
 <658cd654-be3e-659a-20a7-f33034c231ce@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 31 Jul 2018 17:29:08 -0400
Message-ID: <CADnq5_Ma1xeSpKXUDXPx296VmfWaXkHPqtS1iaNk4hfn_q0Cyg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pm: Fix potential Spectre v1
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 2:46 AM, Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
> Am 30.07.2018 um 22:14 schrieb Alex Deucher:
>>
>> On Mon, Jul 30, 2018 at 5:55 AM, Michel D=C3=A4nzer <michel@daenzer.net>=
 wrote:
>>>
>>> On 2018-07-24 10:53 PM, Alex Deucher wrote:
>>>>
>>>> On Mon, Jul 23, 2018 at 12:32 PM, Gustavo A. R. Silva
>>>> <gustavo@embeddedor.com> wrote:
>>>>>
>>>>> idx can be indirectly controlled by user-space, hence leading to a
>>>>> potential exploitation of the Spectre variant 1 vulnerability.
>>>>>
>>>>> This issue was detected with the help of Smatch:
>>>>>
>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:408 amdgpu_set_pp_force_state(=
)
>>>>> warn: potential spectre issue 'data.states'
>>>>>
>>>>> Fix this by sanitizing idx before using it to index data.states
>>>>
>>>> Is this actually necessary?  We already check that idx is valid a few
>>>> lines before:
>>>>          if (ret || idx >=3D ARRAY_SIZE(data.states)) {
>>>>                          count =3D -EINVAL;
>>>>                          goto fail;
>>>>                  }
>>>
>>> A Spectre attack would be based on idx ending up too large, but the CPU
>>> speculatively executing the following code assuming idx <
>>> ARRAY_SIZE(data.states), and extracting information from the incorrectl=
y
>>> speculated code via side channels.
>>>
>>> I'm not sure if that's actually possible in this case, but better safe
>>> than sorry?
>>
>> Yeah, I'm not sure.  I guess this can't hurt.
>
>
> Well is idx actually controlable by userspace in an IOCTL? I guess the
> answer is no.
>
> On the other hand the array_index_nospec() macro makes the overhead absol=
ute
> negligible.
>
> So I agree that we should be better safe than sorry.

Ok.  Applied.

Thanks,

Alex
