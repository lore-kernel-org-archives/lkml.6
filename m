Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521214876-2-14060875865947305827
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521214875; b=Lj8d22Olgcq1OgBtfhToshYlo3h3lkgKNuoMjpjxhvoJfxu
    /kxwrVPTJHZ5SdVaMyCyvpGYus7voy71MgbllAdZSA3S1U67cNL8OhC7nr6IR7cI
    iHbJbQpC3GfXi7YMB+IWeLs9UySEnZpmf5OvMOn+cGkZAhHKQN+a1Sb/Q3OkxsAs
    CtPbaoLH87sW4BUvGh5yb4DUooa8Aeh7cfqWdBNfHUwUG8gCSD473vhzOcSILw67
    7wphep0QSJJyHlahfLFd23xvw7WV0ZeOaUjQLwh6Kt08PL6AnkE/0PtL4HgCdt0z
    R5s65iUVuvtW+B1xg7bnKFFilYYTwbEqK1XMbXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214875; bh=CXrccDbiFMDQ4QxnyIa7C+fr46
    YI8J6v8PjyJkoDZVM=; b=pdtqs70uPqXolissQITSDB9dre3CuKueQ1sIUEFO+k
    jOjdTSV4NgZMUzT+5fj/KcBWtDZqgSs3G1+Jv/voasDcV3t4lLxki/JAyRPA02U1
    RZfloLP0jLz4sHfafJL7gLySZxd4fuxO0JVMpQQrhR+U0QKxqcCqc77lMVmLqx0A
    t/fqIonD0mfRO+VRAy9Bfy/YkSSENoOwPU9vBWdzqNCfTOKDTcqZhH2d6mW3yEej
    bVDE4U3N4CBl/W8ba3jUtisBuMTRngydm9TuOaOXo7RP9xCv1xNxADS+JFBuen6w
    8JcHJ8nJGCnIWFsdRnw6P5ZCeInc7jxXO5Pc+m/rX3xw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965148AbeCPPlH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:41:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43850 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964834AbeCPPlF (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:41:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 038/128] ARM: dts: koelsch: Move cec_clock to root node
Date: Fri, 16 Mar 2018 16:22:59 +0100
Message-Id: <20180316152338.584297883@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Horman <horms+renesas@verge.net.au>


[ Upstream commit d72f4f03854d1225c72d682bf0e01377e7016419 ]

cec-clock is a fixed clock generator that is not controlled by i2c5 and
thus should not be a child of the i2c5 bus node. Rather, it should be
a child of the root node of the DT.

Fixes: 02a5ab18d366 ("ARM: dts: koelsch: Add CEC clock for HDMI transmitter")
Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -278,6 +278,12 @@
 		};
 	};
 
+	cec_clock: cec-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12000000>;
+	};
+
 	hdmi-out {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -640,12 +646,6 @@
 		};
 	};
 
-	cec_clock: cec-clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <12000000>;
-	};
-
 	hdmi@39 {
 		compatible = "adi,adv7511w";
 		reg = <0x39>;
