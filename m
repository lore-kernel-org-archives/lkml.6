Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A09C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BED720858
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tjader-xyz.20150623.gappssmtp.com header.i=@tjader-xyz.20150623.gappssmtp.com header.b="mTILBKTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BED720858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tjader.xyz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeIYX4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:56:48 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46684 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeIYX4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:56:48 -0400
Received: by mail-oi1-f196.google.com with SMTP id k64-v6so2243549oia.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tjader-xyz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nHJOgS5UkB/JjYXibo5BEWpqR2SXyDLBgI9BDDg1K7c=;
        b=mTILBKTPB5b6lGpKEhNudu6YPac/3dSJ+MDgvAXyjSyE+xEWm4I+vZSQma5PyOrL44
         IQeUffJmBaiuzR2nQtj0jbr4UlaA1GVQtCP0cPNcDoVV0RQfva0g2SW88S5BrlH2e9Tr
         OKh6dR5UJh3YAnQDSo9ns+iyeGEWnyntTqI0W3iywBWtIyEDDfHjAsJAtxkFWDQwvz4y
         3AY3wRN6xnoFuJLIydxrNadhashpjM/xQcwHX/OpUFUKLAqqQQ7gf2U4sCaSiPAR2zTe
         CtN6S0BYh8k9AKmLFjNnTSZwce7XdY+voSHitRxzW03/rsB8mncVikjFT2RQbbXc52zK
         HDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHJOgS5UkB/JjYXibo5BEWpqR2SXyDLBgI9BDDg1K7c=;
        b=jfLaYl81v45N1Svr0Cr29iOmzz3Mli4u6b58pjzEcDieG9J97TAQbuKfdIr62xiCc8
         oxweDT/mOceChnx3Q7mfLFUcBUn1EEYBZ4i1oGzV2Qbkbjc0QFoECdYnAj2EtIC+Ac1W
         iaKQF9ry6kDcW6uzX2dmcL0f0tB36Zy1bLq+gZEF0uEiQ75Uv6BrPt/cYZsLPBCeXkxQ
         YdXsBzGip5zD1K4Oxf5Cd1E+6aZoBzvoodshkM3sGguJUvIXbQldHGycqZgipMZFzOuG
         FLHHFQ0lsRxZ4kzODmlxW0e8xlCBeTXo7Ooj0Yd0VlBxtkjcQGvcJ/phg4l4uaxxrDT/
         WBcw==
X-Gm-Message-State: ABuFfogsw3Nurx9BNr50pwhNYJ02S8ifRSFJ3EA3nJ0DMEz9XM/NW/lE
        fPkmgK6cXQwrjTQ/SI6/vY4+eas/Aa/aBjrgzHz1Lg==
X-Google-Smtp-Source: ACcGV63GaztUF78Ri+3sUQIBlGxOsYJ0v1IxP9uNvOY9el381Rs0XIdBWsMw62Xi+2i450a6vf2Slghm0uiaNSWA+Pc=
X-Received: by 2002:aca:180b:: with SMTP id h11-v6mr1222387oih.91.1537897691250;
 Tue, 25 Sep 2018 10:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180919141815.18737-1-rodrigo@tjader.xyz> <20180921142811.h5jraemk565alh3i@flea>
 <CAG7TQgE_KU_cK_4E+NG8Qcw-QB2=C6YoqBYR2svmWxywFyySCw@mail.gmail.com> <20180925090139.qbu6tqav5oth7zkw@flea>
In-Reply-To: <20180925090139.qbu6tqav5oth7zkw@flea>
From:   =?UTF-8?Q?Rodrigo_Exterck=C3=B6tter_Tj=C3=A4der?= 
        <rodrigo@tjader.xyz>
Date:   Tue, 25 Sep 2018 14:47:59 -0300
Message-ID: <CAG7TQgFTsR4pf4jAcWMFoOmiP7AXYqjts60RP2kuJGU44AcQJQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: allwinner: Olimex A64-OLinuXino: enable eMMC.
To:     maxime.ripard@bootlin.com
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 6:01 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> We can't really do that, unfortunately. If the device tree name was to
> change for a given board, we'd break all the build systems, boot
> scripts and distros out there.

What if we keep the device tree for the version without WiFi and eMMC
with the current name and create new device trees for the other two
versions?
