Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA3EC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE922184C
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfn5qRrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfAZTQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 14:16:28 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46600 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfAZTQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 14:16:27 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so5492079pgp.13;
        Sat, 26 Jan 2019 11:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ev9mQTBqWUBKnCAFBoQZN6sPF0s2rTPDZrar6OxT+XU=;
        b=pfn5qRrdA17EJsZyF1rvu6AHDD1upj2Sz15lJzELfe1Y81hBvEuwHM4ruOakmIoIOr
         XMZ37HmXYPVpcBIitzRlmPEdGEmAx1Z4SvvQcPfpUSXmq5tbRq/ChsD13StJ7811NQqG
         uyXqMjo/bs/23jxmHcNLfpgEJzBnHQ5Bn3mQ1V1cRIT8EuugfAREfJ4sr2qnora+WJbz
         oLc2xQwkefW+vgkeFCe/DA23S5Jce+aauEE6n41nVKMH75CBGJY1EV43ZGs+iTer9xV8
         R/WGl8xOcy7m3sh/tiY5B0kxsqI+nTQPQZGXiRuFJkGDu6TDYSxypmBSz6KkCsL66gI+
         lF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ev9mQTBqWUBKnCAFBoQZN6sPF0s2rTPDZrar6OxT+XU=;
        b=OoTP0yF+xCndJitu1wAa2ZXTtIKP2ZGprri/kKPpsU1tU6/toGm49iWfAhIBlA65CA
         7qZKpRqyF+VIB6/OukcHdyU5X1XjsvpyoNVCJr+hkcPUkQfkLjO4Ry/ziKcptsdV2Zq1
         tE1E084KCvBfS/tFhRzINUrX7GGT0NK0WEOe/fh1LESIIEEZ8DVcERVtiCEOXdmFxb/A
         jf0o2pMbY98gZ3KT1ktteEOyn4DlBWWJTUMHMssjqzdtj4YEI1fotNKS/ivQac9mvsgs
         JQomRmJLJpSppN34EUOIa82I/2d4aWLocjL3qYYi4+SBB5YoOQxCPNZqTClswUHF3f2w
         +1jg==
X-Gm-Message-State: AJcUukfi2OIThdWyuE9+pAWkorJBzBhOBmwzHGVjFJwNWFqFAgvSr8FZ
        t4ul/ia/9giKdsLGRPipu4E=
X-Google-Smtp-Source: ALg8bN4pm41/MvhKqdqtt1lwgaKqeV1BpFbZ0HCAxAuh07kkJ4dTRzV9+KamNktWArLzt/fvpmpOlA==
X-Received: by 2002:a63:1258:: with SMTP id 24mr14098013pgs.114.1548530186584;
        Sat, 26 Jan 2019 11:16:26 -0800 (PST)
Received: from bobby.localdomain ([2601:1c0:5501:37e2::745a])
        by smtp.gmail.com with ESMTPSA id y1sm41083683pfe.9.2019.01.26.11.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 11:16:26 -0800 (PST)
Date:   Sat, 26 Jan 2019 11:16:21 -0800
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     bobbyeshleman@gmail.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Add device tree binding documentation for MAX44009
Message-ID: <7201ee3e0e1c119fa521ed33793be96eaa0eb159.1548529751.git.bobbyeshleman@gmail.com>
References: <3de73cb366285113e0e7c2e1938d15b7c3981891.1548529751.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3de73cb366285113e0e7c2e1938d15b7c3981891.1548529751.git.bobbyeshleman@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
 .../bindings/iio/light/max44009.txt           | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/max44009.txt

diff --git a/Documentation/devicetree/bindings/iio/light/max44009.txt b/Documentation/devicetree/bindings/iio/light/max44009.txt
new file mode 100644
index 000000000000..b287d7732e37
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/max44009.txt
@@ -0,0 +1,25 @@
+* MAX44009 Ambient Light Sensor
+
+Required properties:
+
+- compatible: should be "maxim,max44009"
+- reg: the I2C address of the device (default is <0x4a>)
+
+Optional properties:
+
+- interrupts: interrupt mapping for GPIO IRQ. Should be configured with
+  IRQ_TYPE_EDGE_FALLING.
+
+Refer to interrupt-controller/interrupts.txt for generic interrupt client
+node bindings.
+
+Example:
+
+max44009: max44009@4a {
+	compatible = "maxim,max44009";
+	reg = <0x4a>;
+
+	interrupt-parent = <&gpio1>;
+	interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
+};
+
-- 
2.20.1

