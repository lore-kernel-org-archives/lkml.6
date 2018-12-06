Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F429C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35580208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ossystems-com-br.20150623.gappssmtp.com header.i=@ossystems-com-br.20150623.gappssmtp.com header.b="uzwrmUBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35580208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbeLFKod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:44:33 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39316 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFKoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:44:32 -0500
Received: by mail-ot1-f67.google.com with SMTP id n8so17705806otl.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 02:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:references:in-reply-to:date:message-id:subject:to
         :cc;
        bh=1wd87rhCZLQDwfoBNuXmrBkrnssjkjrBp2BHPROLvvI=;
        b=uzwrmUBlbS6XObOHAXQfe2ov3Rjl9+ejyv4Nn87PZk5++1AfhjHA2wrZ08HoJX/gfe
         KiD15rmtxQUPtMvAXmQ9RuVI1dixpD71wIrf2dVTwtcBB8qe4GPc0ovFA64ib7zESqup
         2OynjE4ppiAF67QUvmV6yjqF22lpM1uJr+cxEUj4aKFSDg+Tsx9gv48V6F2L4LblUTSP
         Fj2ZGu0g/r4xNxPojCvBTeXGNpoFe8xmO2OuxDfxrKMTq3nYtVJ7jhhClBtKf/GphBsY
         8xxhtpIvfuFpIQ107sl6gKSJU+WruNsXHmYB8OBGDqSDYx8bcg6Zil7y3rSDII5GuLWT
         3DWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:references:in-reply-to:date
         :message-id:subject:to:cc;
        bh=1wd87rhCZLQDwfoBNuXmrBkrnssjkjrBp2BHPROLvvI=;
        b=MPTpiKwbs1DqeIbLogSUaNOQC8ahZfOwp+snS9Nsl0gFQ6VDGFkFdyfLK+elLbBfyq
         FCoHbvabdbt1u/03D/NeufGArF15mNu2SzgVsnadBGSzcGrQ2I3Waa+VJzGGfuMY6kAU
         UVUHnsvUn83C4oAVNtjkqscA4s2MJUlWluYZ8O4N9mr6BEJIkdIRAyOqWUorzvLjjDmG
         j30ayPcy+RN7/Vka+s4BvDEQQLnJ21sZDU1EGA2/UC+Zuz0txXK1CqF154lJxrYrp9WC
         +kqBZX4upkkMbbY45XGue/TayAQ0bKqDWVxoTx+DPFOg4GnHM4Z5jm+9fWaDm0Rxxr86
         RQpg==
X-Gm-Message-State: AA+aEWbrQcfHaG47cUdGUHGjBh7AFpFZlt+I6JEaGEl/2k7deNIvUlCD
        IejwTH0gqZxX8H2FVzuQYIws5vuYWiEEHw==
X-Google-Smtp-Source: AFSGD/V+x2a3bNl3kwrygpRNkuD5gJlTk2j248IjlF/2jeTEMXVz/kLgvFnh2WsllW3po/ZwKdqb/w==
X-Received: by 2002:a9d:6297:: with SMTP id x23mr7441290otk.63.1544093071480;
        Thu, 06 Dec 2018 02:44:31 -0800 (PST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id l1sm2539oib.10.2018.12.06.02.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 02:44:30 -0800 (PST)
From:   Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-ot1-f47.google.com with SMTP id k98so21599078otk.3;
        Thu, 06 Dec 2018 02:44:29 -0800 (PST)
X-Received: by 2002:a9d:12f1:: with SMTP id g104mr17006676otg.22.1544093069163;
 Thu, 06 Dec 2018 02:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20181206100905.15053-1-otavio@ossystems.com.br>
In-Reply-To: <20181206100905.15053-1-otavio@ossystems.com.br>
Date:   Thu, 6 Dec 2018 08:44:16 -0200
X-Gmail-Original-Message-ID: <CAP9ODKoG-XRSOekKJWkD3Wg_dPsS2baRzPhuuJmmoT7-omBOtA@mail.gmail.com>
Message-ID: <CAP9ODKoG-XRSOekKJWkD3Wg_dPsS2baRzPhuuJmmoT7-omBOtA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Improvements for i.MX7D PICO SoM and its baseboards
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 8:09 AM Otavio Salvador <otavio@ossystems.com.br> wrote:
>
> This patchset rework the imx7d-pico SoM, its Pi baseboard
> and add the Hobbit baseboard support as well.
>
> Changes in v2:
> - replace fsl,uart-has-rtscts with uart-has-rtscts
>
> Fabio Estevam (8):
>   ARM: dts: imx7d-pico: Do not harcode the memory size
>   ARM: dts: imx7d-pico: Switch to SPDX identifier
>   ARM: dts: imx7d-pico-pi: Move SoM related part to imx7d-pico.dtsi

I did the rebase; one thing worth mentioning is that I have "ARM: dts:
imx7d-pico: Describe the Wifi clock" which is in your fixes tree.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
