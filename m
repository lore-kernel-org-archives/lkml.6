Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59999C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B7020892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Lz9ICeRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B7020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbeKHBTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:19:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41266 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbeKHBTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:19:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id p16-v6so8035862plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 07:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=C3090pGuhpk/phm324RxnllFsyWN0pwLZP3cDNfrwmA=;
        b=Lz9ICeRTG/FayCFUf4ab5udQhvQN1NOtRDmuhwQSxjkLhsh7B3gY5Z6PYBqOgvj5ke
         m+610R+h7nx0a4QUICzDk/rjING29Zvc7Y/+fOI3ioNieonl9weHdVgnt2j7U42Bqmdw
         /2NtBGbZ6mFHC2su9mbmu0EfnyECkQbX1Frw5AYsN4ItA+g9xoNWvUr/PGE6WNud1t0F
         Drnn5EPhDTn2iL0PL0b3xzL/zOd2q49umsjl+FQDHNsQtyPWycXNH+ZVj0tvfbbSMopM
         VzV6NW/yar3YiTlnNJ6gDvgnhMLUbXU3gvGS+ZyFLzhK2N6xTPTutroZ1rXdZQ013jxb
         DX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=C3090pGuhpk/phm324RxnllFsyWN0pwLZP3cDNfrwmA=;
        b=b6YakSoqB9H9kQLei/HgHJWYIypYeGz011mYrufLrTLhBynSH9WwgaY+oF4hP20kAP
         gxJ2ig34RZneF4zPgH3DGusrvg/8h3y1sOWZk3yNOZX5RKonN1UMTerIwdf6OjscJzX6
         menKr7Dr4dAzq2VunfrINeMDzQsTrnBpjlbhWeizSa4aQYWCgYSQu3P1JX1V+B8H6C+B
         q2RQYQ9U2gvNSiFYz+IsSRk/4e9dQ9B3IghfJ58zSimlT6lGNz6ZvYWIrPhAGb49WB1+
         J6Y9SWOpv2OpJUEPVePBrv00gYc22+ie/mvpYr8Br7AlClBzh8Qt4VfnyvdaEBPl8iHb
         dj9w==
X-Gm-Message-State: AGRZ1gJlfrhy9s19bSuUYAaO9lBVcb0y8pv9++OE+AXTFsIqlnPxjH1Z
        5h0a92kufQxsAMIbcYGTaUzVLw==
X-Google-Smtp-Source: AJdET5evGg/0uGWPg1VVsgzUkQ5K+uQw2NXrF3mAGkyrBY2Xef0kNGUebwF3p5h8DTtacqOHT9l6VA==
X-Received: by 2002:a17:902:aa8d:: with SMTP id d13-v6mr770190plr.74.1541605727210;
        Wed, 07 Nov 2018 07:48:47 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id d126-v6sm1029534pgc.32.2018.11.07.07.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 07:48:46 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: mt7622: fix console output issue on rfb1
Organization: BayLibre
References: <8043d487e7bd20a11b14d832702bda214a9a694f.1541566473.git.ryder.lee@mediatek.com>
Date:   Wed, 07 Nov 2018 07:48:45 -0800
In-Reply-To: <8043d487e7bd20a11b14d832702bda214a9a694f.1541566473.git.ryder.lee@mediatek.com>
        (Ryder Lee's message of "Wed, 7 Nov 2018 12:59:43 +0800")
Message-ID: <7hr2fwevmq.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> The issue was introduced by Kernel CI:
> https://kernelci.org/boot/id/5bbdcbad59b5146fc5b43592/

The issue was *found* by kernelCI, not introduced by kernelCI. ;)

> Fix this by using a 'stdout-path' property that points to the device.
>
> Fixes: c0d9f9ad4f76 ("arm64: dts: mt7622: add earlycon to mt7622-rfb1 board")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Tested-by: Kevin Hilman <khilman@baylibre.com>

Note that this patch fixes the problem where there is no more console
output, but current mainline still doesn't boot as there's another
crash: http://termbin.com/zitb

Kevin
