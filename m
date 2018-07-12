Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E69ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AD8208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUK21JiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AD8208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbeGLT15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbeGLT15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:27:57 -0400
Received: from mail-it0-f44.google.com (mail-it0-f44.google.com [209.85.214.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 697492147C;
        Thu, 12 Jul 2018 19:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531423023;
        bh=5Q9vcoD+ACP4FeHJy86v/jm/k94etCLZCjTbEeObI/E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nUK21JiUCNMACh20IXEQtXD+s/0GbHB5m9Kp0qaU2pJN00vHBnBBiCL4vjwdKeRE3
         j/zkFsOwAvqKUc9oE3hzQBRbm0wsMIKbnya20i4Oy7woZ0FsDb3RZLOTxO/J4sR4kW
         7xoTiyLSTO6EoNQfCOLOkvlFb8uLC4AUbTXDKMhc=
Received: by mail-it0-f44.google.com with SMTP id p17-v6so8303620itc.2;
        Thu, 12 Jul 2018 12:17:03 -0700 (PDT)
X-Gm-Message-State: AOUpUlFXU7GxozPm/aI6pSH4F/psr9Jom/A+8Lo4gP0JOGiJHGlJ2fLv
        KN4tBSL45AskpjBHWqaRibzeAuxsvB0kZMAYJg==
X-Google-Smtp-Source: AAOMgpe3WhwnvQyklRIu+UtbfnpCV0Sl65e89of0VHchWvRYZO4dYqCbK4ZgsHxU47OdLoQwcNIhOc7h9MpFM2LmKo8=
X-Received: by 2002:a02:986d:: with SMTP id x42-v6mr2752808jaj.131.1531423022864;
 Thu, 12 Jul 2018 12:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <1530832288-8156-1-git-send-email-stanley.chu@mediatek.com>
 <1530832288-8156-2-git-send-email-stanley.chu@mediatek.com> <a4c1a9cf-4d48-a9a7-e7ac-d94685c30619@linaro.org>
In-Reply-To: <a4c1a9cf-4d48-a9a7-e7ac-d94685c30619@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 12 Jul 2018 13:16:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLz0txawAP3BuQ2H4NyzFsKGkTVZ_kp8toDNRC0eJEC7g@mail.gmail.com>
Message-ID: <CAL_JsqLz0txawAP3BuQ2H4NyzFsKGkTVZ_kp8toDNRC0eJEC7g@mail.gmail.com>
Subject: Re: [PATCH v9 1/5] clocksource/drivers/timer-mediatek: Add system
 timer bindings
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Stanley Chu <stanley.chu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 9:02 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Rob ? Are you fine with this change ?

Yes, I added my R-by on Fri.

Rob
