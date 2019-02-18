Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F66CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC26217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oZ+lAsOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfBRIi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:38:59 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:44802 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbfBRIi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:38:58 -0500
Received: by mail-lf1-f44.google.com with SMTP id g2so11613431lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 00:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeGyP+ZMm6lXmM1bpT8/YOJ07Ga+W+SBOfteEDPBRio=;
        b=oZ+lAsOt23DjTPlVM0UjB65vovnIOMretRuj65gb37cU3ENvQIY5U/Kv1xEXlhxndR
         1Hb4AzENF5yf0qLkdMf4qbMYV8Zyxo3c/Ac6PGBwPC/oDFLschYj+oHJ8dGzCV5GoFdk
         vm/uezMr8pC6gKa69uV+d+IKPhrLmnnRGZO6dn4nffKYd1xlo3oA59PtZ4m3Vxyl78fG
         2yTppmxeUj+TB9bV2spdFYNZBbFhDb9Q8c/PbQ88orvZAsZOjiMPQJnKYa5/e8UY+ZKB
         RnAT144u+34Bx5FSlhVmhV+VncGL98yJERwPahvP3Hrw74/2UwzOKPV3LC3vqYMZw6Rk
         +gDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeGyP+ZMm6lXmM1bpT8/YOJ07Ga+W+SBOfteEDPBRio=;
        b=GX6f+bHF0CTkX57jrckR8VDze8POj8Suxu1is40WMUEK25J5+aRHTBh/F3INBT4IK+
         Pn9uXNJaGNt0IT55SV3tgeGlnY/bHMaV1ZRakNI8Ic4lf6uNhdBk01TPJv0xllvBnOjf
         YdLzYd5pesECAFiJhC/be2/N9iT3BMVenBUPzRTKo+pd3WhwImaUU53X/t8K0MZnaZ3V
         fMXCMwMD1FbcbCUNwO4WL16L4bjjfiBc6c5rpbgm2TgGXyP5RkSpNEZ3eNwG69288AFa
         rVvHalSMFZ5nYSo1KpEBYScE608socG3aokP4saCgl/0Z/B8TetYdFnuAbeEuly+QksQ
         sQLA==
X-Gm-Message-State: AHQUAubTtZ/JjgIRw+qoyHSrN25g7+S7GWxK5LSAUmfQpwIE/SG28pCj
        khDpwjq7gOCJwvFmEoZ4mHmkn45J/oud2FePg8l/StOd36kyuA==
X-Google-Smtp-Source: AHgI3Ia11rIkJ+G+83B4hvMJAMLiVnrekYjrqdi8unULh3vzi717htgtIA64yRgQbAH0L5ezVnOJhouprR/ZcT+hxlk=
X-Received: by 2002:ac2:53b1:: with SMTP id j17mr12770006lfh.143.1550479136619;
 Mon, 18 Feb 2019 00:38:56 -0800 (PST)
MIME-Version: 1.0
References: <795c3942482d96c696b4368e68de1ba0@codeaurora.org>
In-Reply-To: <795c3942482d96c696b4368e68de1ba0@codeaurora.org>
From:   Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date:   Mon, 18 Feb 2019 09:38:45 +0100
Message-ID: <CAP71WjzHFD0LGjgZxkb_Pix=z3KViNdt_m6CvTdWqSoz_cLFyg@mail.gmail.com>
Subject: Re: Firmware files for QCA BT chip WCN3990.
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Josh Boyer <jwboyer@kernel.org>,
        Linux Firmware <linux-firmware@kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        Hemantg <hemantg@codeaurora.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Linux-arm Msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Balakrishna,

On Mon, Feb 18, 2019 at 7:13 AM Balakrishna Godavarthi
<bgodavar@codeaurora.org> wrote:
>
>
> Hi,
>
> The following changes since commit
> a9c22d3d8af87bd39a078ec6c846b0674dd2ca38:
>
>    qca: Add firmware files for BT chip wcn3990. (2019-02-15 16:07:56
> +0530)
>
> are available in the Git repository at:
>
>    https://github.com/bgodavar/qca_bt_wcn3990_fw.git
>
> for you to fetch changes up to a9c22d3d8af87bd39a078ec6c846b0674dd2ca38:
>
>    qca: Add firmware files for BT chip wcn3990. (2019-02-15 16:07:56
> +0530)

 qca/NOTICE.txt   | 334
++++++++++++++++++++++++++++++++++--------------------------------------------------------

^ This looks a rather unexpected change.

You are missing updates in WHENCE file, as such:

$ make check
E: qca/crbtfw21.tlv not listed in WHENCE
E: qca/crnv21.bin not listed in WHENCE
>
>
> --
> Regards
> Balakrishna.
