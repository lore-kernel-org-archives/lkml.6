Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2292AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D625D20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dYY7AyDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfANQWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:22:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42116 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANQWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:22:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so10343696plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=9MNFaxqH3CflbZ5s7rpd0ZeUglDZvdpg5vhBirm0J7I=;
        b=dYY7AyDBhVtl5De8HJ67C5ln+wkPa5dMlPrHtdHMdagrxvhVy8Nj1DcH7dkV0hMvnA
         5idJFRZZJuxktoG/GXp7VrxaVsZ14uaJRhbCEAAZJIN/Kgaq0WHay9pJxMcLyjiOsvgT
         SjLqAdGSJAU84Mk/5SQZerbJE3mnpEoNyw3NJG/emOoKuB4/++gpg1T2F4BBXSWTPlSK
         kcR6tsdsGbvpVH4xwVcC49ByJ/dI/0ekcyi9+SjTV5PHxr70olNw/ZFqO++0EYW6+UH+
         yJe+Epf3onCwIFsj1lek0nQ5GySrh4fURgP5valnCp83D8I0QH1rcaV1KDf4O7UnK0ik
         3VBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9MNFaxqH3CflbZ5s7rpd0ZeUglDZvdpg5vhBirm0J7I=;
        b=Qv4jMBzyESfnubOG6EaXb3wAzuFGWckGY1exO7uHfhRliI5eZFncR15MmRa1f2ETE/
         7LbiRK44YCKP6zQk6nMdFCt8vtgbQGxgH5QWYFdsS7PWSbr3VMk56RqvkS7gRp3RTloJ
         NAYEq/YzNaFsaK8jLcCj+GM/U84r3kBLbZvSV7QlMrsFBrUuVtjxfYRIsXrXxa7/dsaR
         sgHfqC0qctXKVUksiO3UWT1UuI08PnBBwvVqdsikXO3zHVbumYU6R7af/99jq0NK4jFL
         taAn4RukHO4u+bdfiZehZzoZ1elzm5mmL4y+S5SoMgAey+tMxWhaCe2qg//yTJe8yfVD
         GGjA==
X-Gm-Message-State: AJcUukfCTOoEBjw397OJZLOFwcer5achDUxpFuvQVc5p2AP7XXwimU58
        9r2gqo0D9XDdkoflvApaW/5ncs8GP6wkww==
X-Google-Smtp-Source: ALg8bN7b2KXmWUuHduwsMpk0kpHnttA2FrmcLXWEuFvtF14vQPFByulI97ZKCgEgwzxI9in10JWp8A==
X-Received: by 2002:a17:902:c05:: with SMTP id 5mr26349611pls.155.1547482929716;
        Mon, 14 Jan 2019 08:22:09 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:55a3:6ea4:4b91:28a5])
        by smtp.googlemail.com with ESMTPSA id 196sm3864854pfc.77.2019.01.14.08.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 08:22:09 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PatchV2 2/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset warning
In-Reply-To: <20190113153022.5040-2-linux.amoon@gmail.com>
References: <20190113153022.5040-1-linux.amoon@gmail.com> <20190113153022.5040-2-linux.amoon@gmail.com>
Date:   Mon, 14 Jan 2019 08:22:08 -0800
Message-ID: <7hy37nky4v.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

Anand Moon <linux.amoon@gmail.com> writes:

> Add missing vin-supply node 5.0V regulator setting to power
> to usb ports, changes help fix the usb reset warning.
>
> [  795.380156] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  798.356073] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  801.331999] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  804.307919] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  807.283844] usb 1-1.2: reset high-speed USB device number 3 using dwc2
>
> Fixes: 5a0803bd5ae (ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes)
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Rebased on Kevin's amlogic/v5.0/fixes branch
> Changes from patch v1 [0] https://lore.kernel.org/patchwork/patch/1031243/
> - Split the patch into two part: new patch
> - Fix the commit message
> - Added Tested by Kevin Hilman

Queued as fixes for v5.0-rc (branch: v5.0/fixes) with Neil's reviewed-by tags.

Thanks for breaking up into two patches, and as Neil said, please add a
cover letter to multi-patch series in the future.

Thanks,

Kevin
