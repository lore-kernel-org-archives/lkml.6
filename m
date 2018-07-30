Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3658EC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D6020892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKF4Eppc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D6020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbeG3VvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:51:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55894 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeG3VvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:51:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so648878wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AEprJgtM66N4uUl/wTKQU72hoRCAldeXHBYfLWmB3TI=;
        b=aKF4EppcJAWhGWApjgLK39MXA5ojcxHqe5wVgeUO6t7M0TnJE1ipHbJ46shT0QFJsM
         YGFtHI/ZnGdo3BJ0Ri7FVUdP3K9zc7vJuZoQDncVGed4PopM7XqwK7oaDzu8xS7V5nWo
         SWR4Xj6/cHOXKOw2uHLYem2341r3w/FtFEOQjtp4yyvvrT4zc6X1CEmsNQqS7302U+0n
         9uZrVD/ya3ITNpDrtQjjDOg0wIo9jx+xEoa0ZD75fn/l9mXIiWm23r2wJqfvOZaXpSMw
         QEFqR2bsaElttfjGr9+fxDJF6Rhq9tjZ3K4DpLPT2erpvCXcak7NHgW6UKdCZOkReuPO
         crSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AEprJgtM66N4uUl/wTKQU72hoRCAldeXHBYfLWmB3TI=;
        b=KIFPMN9rj+2+eIw77RXCEDEQvRpipFbVPR9KCnpaW0RD+KMzjYLJ6MGtYfttobHuqK
         2vz9IperzNtxmLNFMhBDnvIw9t9iQGNDNF5pOTRxp537iUw1IsC1LrzD9n1JqNNUAGYo
         99OefF4FhE0LTjCl3cvcjY7L7fYo20wbXU95u2v/c9MpVqdes3dXIekgZcaoUOmwCagT
         CSxuVVpgUaDnsZwbYCOLkIjasJ08Bd2KYIpzGeFgYB46Txj4xMwSyIb1pQdAV5knpTZ6
         qjwPGE6Blws53b/k22CRJgmyMQ8ixYBPbctTQkeMBUFQLV/xc76v+Jw+uvPrc5JOHmh5
         oPcw==
X-Gm-Message-State: AOUpUlFXKtwN5TsQJq4HawQ8IKySR4vZNCsMyYuX0eeOEFk4RdGi5iKh
        3J2/JRahJw6NWSiK0ykIMVtqR2ujdo614hT9YVs=
X-Google-Smtp-Source: AAOMgpeto8Br4M4EMNZgkhz0J0AyDewQc0cKA8FznR1g/zVjwrRC8ehQpSc8i5g2db3N5vkdPHMnnR8kc8oquwzW/a0=
X-Received: by 2002:a1c:8587:: with SMTP id h129-v6mr394058wmd.105.1532981664189;
 Mon, 30 Jul 2018 13:14:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:979e:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 13:14:23
 -0700 (PDT)
In-Reply-To: <50f9f4f3-76e1-401a-bd84-6ae746fe4647@daenzer.net>
References: <20180723163232.GA17358@embeddedor.com> <CADnq5_Ons4y+sweZGg4LgJpfn8wzgg8xdpytLt-78PVqqg-LpA@mail.gmail.com>
 <50f9f4f3-76e1-401a-bd84-6ae746fe4647@daenzer.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Jul 2018 16:14:23 -0400
Message-ID: <CADnq5_MKR=qYCX-m4wKA47F0EejNcUmS7jsnY9=1nyKKEQhqJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pm: Fix potential Spectre v1
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 5:55 AM, Michel D=C3=A4nzer <michel@daenzer.net> wr=
ote:
> On 2018-07-24 10:53 PM, Alex Deucher wrote:
>> On Mon, Jul 23, 2018 at 12:32 PM, Gustavo A. R. Silva
>> <gustavo@embeddedor.com> wrote:
>>> idx can be indirectly controlled by user-space, hence leading to a
>>> potential exploitation of the Spectre variant 1 vulnerability.
>>>
>>> This issue was detected with the help of Smatch:
>>>
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:408 amdgpu_set_pp_force_state()
>>> warn: potential spectre issue 'data.states'
>>>
>>> Fix this by sanitizing idx before using it to index data.states
>>
>> Is this actually necessary?  We already check that idx is valid a few
>> lines before:
>>         if (ret || idx >=3D ARRAY_SIZE(data.states)) {
>>                         count =3D -EINVAL;
>>                         goto fail;
>>                 }
>
> A Spectre attack would be based on idx ending up too large, but the CPU
> speculatively executing the following code assuming idx <
> ARRAY_SIZE(data.states), and extracting information from the incorrectly
> speculated code via side channels.
>
> I'm not sure if that's actually possible in this case, but better safe
> than sorry?

Yeah, I'm not sure.  I guess this can't hurt.

Alex
