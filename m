Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885F7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578FA20855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578FA20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeKZIMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:12:39 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46032 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbeKZIMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:12:39 -0500
Received: by mail-qk1-f195.google.com with SMTP id y78so395416qka.12;
        Sun, 25 Nov 2018 13:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=WrZMaEwK+qqhej5rT5SCoYL2J82qPkRCdLSV10MBDsQ=;
        b=gMhLM8/XXI0eZPqreGZCGvcnfLR7vrhhDTbDKw3bHvP3Oak0qLopHRbcDU/mpPpNim
         HXli51px6bHIAr3RaskkCrCbdNINNamHMRi+fm/gj3cnygJny6ll+v6AJxGMEfAKWl+r
         TgcBpklLhs8uZ2Ts9CbaNahixRAh0FifAaTHHZYe5aZFrNP+j9gZqGFpdxcm+xZ40fKa
         cDdQVJMbTkdeImQJs4NpfXaqy4Yu/gcBv/85aMOTqcpakT8tNPSUFZNC4ohh8Jg1HjBR
         YovgRstYtNBSGr9BsrOA8K48oid2k8+l3exfba27X2tAQJus6/eWbq8Ppe8jZmIilrYQ
         vFog==
X-Gm-Message-State: AA+aEWatTdPxzbcC4GFJ955LXjyPeMywYSLKg1RfzKfsY3PMa1VnSk8R
        ASGprsbtaeRV2YbatEv54/Uf80aJ
X-Google-Smtp-Source: AFSGD/UMveYcdPGPJ2TjwxEIJ5rXOvQe69MSVlyFd1OPLEitqt4gZTsD9pACHv4PT7iBY3fpnlCjYA==
X-Received: by 2002:a37:aa91:: with SMTP id t139mr21948440qke.139.1543180839515;
        Sun, 25 Nov 2018 13:20:39 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id p75sm32514937qki.90.2018.11.25.13.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 13:20:38 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 19:20:33 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 13/13] ARM: dts: rv1108: Pass the 'clock-latency' property
Date:   Sun, 25 Nov 2018 19:19:07 -0200
Message-Id: <20181125211907.9895-13-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181125211907.9895-1-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like it is done on cpu nodes of other Rockchip SoCs, pass the
'clock-latency' property to the CPU node, so that cpufreq driver
can take the latency into account when switching frequencies.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index d96c58728b28..4e1ca13a1636 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -36,6 +36,7 @@
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <75>;
 			operating-points-v2 = <&cpu_opp_table>;
+			clock-latency = <40000>;
 		};
 	};
 
-- 
2.19.1

