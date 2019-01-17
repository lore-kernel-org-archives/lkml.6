Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D785C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013AE20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ADkg4fEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfAQUEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:04:02 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34661 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbfAQUEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:04:00 -0500
Received: by mail-ot1-f67.google.com with SMTP id t5so7251884otk.1;
        Thu, 17 Jan 2019 12:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOQcJ8A/Hy4SFduSRsbtupfkyGSIJzFNagfozlCbUug=;
        b=ADkg4fEN5BbybunEH8TAKxkFPE9qylv300UVJAHLNOUSMdCafMpKpCfjhMnJCLkEuk
         xj/fAoCQnW4Uxj16dEgAhuKeZ2tnjtcmHk6fvbN0u258Cb4AojIVUgkl2oSsqAgQ3BsQ
         Z5WwHwpmOoDvawLfAq6UP0JRCfOlqk8a3P+8QHInDvG1cveuDRkMwxkw20yS1LF7Qk9Q
         gdR+cKaMS6w90oh/tjyq9bOu4IqIr4Hfb5wwWckt9P31ysMoG2KCDvUnaGiOu3mIcw8o
         oxNMo8B0b9HqaKTOTXb2zf3aq1w8trz9XJKQeGPhh31njcVp9HRAJtM5hGVMk1jj7E3H
         vWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOQcJ8A/Hy4SFduSRsbtupfkyGSIJzFNagfozlCbUug=;
        b=l3zuM5z/xtGsUFEL7shao6yN0bRQS/pCXJFMnACEDqBvqNa/w0SEZmIOPNzmtIAJsj
         L3FPvfx6yKNFDHLlRW4GIPceamAIQOTpPlnp7zuNbba0tUc0k4JoK5zTMgVsF3SSxi5A
         zlOPfuduMWHkG9/bpVo2gdRMDOmovQHyzLUMrOdZFDez2lexfvOrME8mXsDKh8kcpCrq
         GXCE2csdXpEmPy0hO4EbrZQ8tt0EH+zzN6EcLRjFkunrRip3VKJukBwxySHop75mIVmo
         O83sIVgQvPfGHHbqdLEwsQfPlO6ZP9OGPS2BfxCZr+KoIxrd+IeJua4Y79bVkABtDgxP
         kmEw==
X-Gm-Message-State: AJcUukdQJf2Np/qbby+Y40KkIz33qzE3aVbVbyphRLP7+xw2LK1cvQfK
        oRx/GDpbE8wt8kq/MR8J8ehKeJuAyU/VnhaCv7U=
X-Google-Smtp-Source: ALg8bN6ghFmN/VZR0Bg50QnZMHKftYcuMKJ0j+U4CijxSRFCMa8133BL6vScOSJpQDQXLIne1KpJIwGnOIJsP3IspYU=
X-Received: by 2002:a9d:491e:: with SMTP id e30mr10121142otf.131.1547755439747;
 Thu, 17 Jan 2019 12:03:59 -0800 (PST)
MIME-Version: 1.0
References: <20190116165236.8330-1-jbrunet@baylibre.com>
In-Reply-To: <20190116165236.8330-1-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 17 Jan 2019 21:03:48 +0100
Message-ID: <CAFBinCBFge2tir-MXw+ojTxzW+7n9Uf4FzCahrw0MDzAYV2SSg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: fix g12a buses
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Wed, Jan 16, 2019 at 5:52 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
[...]
> -               aobus: bus@ff800000 {
> -                       compatible = "simple-bus";
> -                       reg = <0x0 0xff800000 0x0 0x100000>;
are you sure about removing aobus?
in your patch "arm64: dts: meson: g12a: add pinctrl support
controllers" from [0] you're adding back an "rti" bus at the same
memory address, except that it's size is 0x1000 instead of 0x100000

I don't have any G12A datasheet so it's hard for me to ACK / NACK this
patch, here are some clues why I'm asking:
- GXM's public datasheet lists the "RTI" region at 0xC8100000 -
0xC81FFFFF, we call it "aobus" in our .dtsi
- buildroot_openlinux_kernel_4.9_fbdev_20180706/kernel/aml-4.9/arch/arm64/boot/dts/amlogic/mesong12a.dtsi
also uses an aobus node as well as an io_aobus_base sub-node for the
codec_io node (the latter is obviously not upstream)


Regards
Martin


[0] https://lore.kernel.org/patchwork/patch/1032981/
