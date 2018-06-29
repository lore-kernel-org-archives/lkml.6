Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5709C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C78428036
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PfwxACUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C78428036
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934814AbeF2VkZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:40:25 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42111 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934530AbeF2VkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:40:24 -0400
Received: by mail-pl0-f66.google.com with SMTP id y15-v6so3170295pll.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 14:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Xt8OMAGI7P6HVYuKVun/oB2q5KgWBVRoA3RutgV8pys=;
        b=PfwxACUQ9jsSHasb1+y1ajERtJM7JOmwdphIkoer6tLljSkSAny1IWUPegkdFrFf9+
         fp4+pf10qnosV8/EJzLXQhcR5sePAlaVWIr5PMEp2ryZJ9llQ6Npu2d65BsL9FO1/cfA
         rwvJEEnoWIk9X+Ut6Ea40Mu4qUdZnzyGDun7PEFlDCB0wrQBd3B3hitcTgxM2G6zQTG0
         26gi1/SPj1yZeerlBbgBDGgEG8imFWZBoJHDrvdEznwxCp29BraPynRlsOrlx/0Wn4LY
         c86K8cGFQ/oxiEFqOE9zNX9nksO+2n8ebvIlHC+L+4eSfGW9wx5o+1rt1bcgv3cozUAe
         zW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Xt8OMAGI7P6HVYuKVun/oB2q5KgWBVRoA3RutgV8pys=;
        b=SLfCVBxIB0uyEfxLGC2wclttRbQtY8teMlhKWxwbpPZKUA9GOewJ7wEw/vSiarPGoc
         q2MCovT1Q3GmDnZ3UQIEjaPhQAmjdydLf/23jS/jezJnWPxtAqVFnW4ulshlppWSFusk
         RI5DgjFVBvw9hpRrMIeqFLA4lLJARM5zo0pt4PvLpWMpmfT92iw4Y/hY5lckrOId3Mrd
         P5FDmBL0JDGowz9UO3E+h6vKMNk/N7bCaEQpLxat1T/GKqdcn704QlBCWppuWs8DBht3
         rHf7e8MJRDk5IKc6AKWJ07MWm3DqYL/uGUGh/t853+rStdD5CY3mVPbCDTSkLTTIO/pG
         4+Gw==
X-Gm-Message-State: APt69E031pwVP0+5SJm/Aiqxs4mAhyx34VDEsHjHd6ZOXWfUUH/foPGW
        KC3Cx/9lGw81dtbNnqEenkk3Aw==
X-Google-Smtp-Source: ADUXVKJsRNl6irJGUEfvZT58Qr/iy9fJtAbHNxygHqVz+7PEeiVNHg11ETE0SDvH3ueRUR6IFUs/XQ==
X-Received: by 2002:a17:902:1007:: with SMTP id b7-v6mr16299842pla.277.1530308423720;
        Fri, 29 Jun 2018 14:40:23 -0700 (PDT)
Received: from localhost ([98.237.141.101])
        by smtp.googlemail.com with ESMTPSA id m5-v6sm15428952pgn.45.2018.06.29.14.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 14:40:23 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM64: dts: meson-gxbb-nanopi-k2: Add HDMI, CEC and CVBS nodes
Organization: BayLibre
References: <1529998855-8098-1-git-send-email-narmstrong@baylibre.com>
Date:   Fri, 29 Jun 2018 14:40:22 -0700
In-Reply-To: <1529998855-8098-1-git-send-email-narmstrong@baylibre.com> (Neil
        Armstrong's message of "Tue, 26 Jun 2018 09:40:55 +0200")
Message-ID: <7h36x5e0ft.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Amlogic Meson GXBB based Nanopi-K2 board has an HDMI connector
> with CEC and CVBS available on the 40pin header.
> This patch adds the nodes to enable HDMI, CEC and CVBS functionnalities.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.19/dt64,

Kevin
