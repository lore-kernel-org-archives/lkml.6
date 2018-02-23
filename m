Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415464-2-270470399518917580
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415464; b=Bj4A4/mWw/HisrE9wpRC+Zjcq1taWdwUEku5eraOwZjxEhj
    Ng67eL1z5dlYrS049cGKL3UOlVWfuhGhBZ8HvU7INWH7TJeeoXLn9uUcckjtLACc
    LaTU90s9m5+dCSQQ8RJEpDpZLdLAntWCXzbFV1cvVWypdu1ofu6Fx7JvfWwIFWDI
    yrT3in06XzKyS1tupMAVy+EcUEHveeIbG3G0f85BRDI6Vr5zzcWtqjCj884agzt8
    k1wG15Qbsun2gWfqoeTRw69YBOZy0916WsnPRiVELPxEIFQaheSdZYe6uDyAi06S
    V/DFzWCf4DAtYeq7IK7ebcy6+HZjlxC7P5ssgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415464; bh=Py976YnixjDPziNTJ77NFCYnVo
    ZKCIBYWHGEeUQbGmY=; b=ERTi85kwsVsZ+ftp15EX8yJtx/H5McShK217u+WCyg
    DdpRrQsLaZt81CWJIq9Uv81Fu7LfUIQGbfenCdYis6cukGtYZY4Kvu0morXv/Pyw
    wRTxYEHwNDCyKECUg3L0WPhUQj+hUck//FHW/Vx7u7e4Ur92ajj3JwoBhgyM2CUv
    NLLa5LQXPfbDzHHnRtqYnuVXvA2/Tm8pSIBCknvw1RJYYnYgixxUgpDdRBLLe26f
    Azb8L4W9e8t831zobygtxnPvXjV74r51k54LCz+mGCogf2PCTahPh5PYbv1LxeeP
    ebKtFSlQq2iVr1Crh8eWofzWRT/YiJhpr2ej7zha3b/Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754586AbeBWTun (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:50:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43582 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933587AbeBWSqH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:46:07 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 049/145] ARM: dts: am437x-cm-t43: Correct the dmas property of spi0
Date: Fri, 23 Feb 2018 19:25:55 +0100
Message-Id: <20180223170731.239671368@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@ti.com>


[ Upstream commit ca41e244517d6d3f1600c229ff7ca615049c1e9c ]

The DMA binding for eDMA needs 2 parameters, not 1.
The second, missing parameter is the tptc to be used for the channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/am437x-cm-t43.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -301,8 +301,8 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi0_pins>;
-	dmas = <&edma 16
-		&edma 17>;
+	dmas = <&edma 16 0
+		&edma 17 0>;
 	dma-names = "tx0", "rx0";
 
 	flash: w25q64cvzpig@0 {
