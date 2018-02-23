Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415445-2-13955346688403290133
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415445; b=R9Va/GLqbn+Uu7ZTRj/a+7LkDlCPQPjMnDJQBVXDTDWZZ6l
    /uetmX+6Ubvm1cXJf1F3KSmePCJ39urH+ZPjf/bw5/7+R2OqCbpf2xT9bsaRH1KI
    9KnW4iCKkNZ4b5BJWOhi+TmO/pehEoC5fdQ3QKkF+Ywaf/dfFUl3BrD999b97HQ8
    OlIkO0qSJqk8us+5s9BmzTxhjjWADbqyDvO0lb3qa/VrSCmEWomPRkZuWT2BcSan
    HIZxW0d5x5JeBaZJOwPsQH5CkTBLslZeEDtJ9l9QHy+E5JH8QTbHqh1anYpoRqrv
    +Bh8XvrzdYLeK+33y+9mSK9YEsrD0mYuTocUf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415445; bh=YiipOLJcspKdOvkVFAsc9Z2d2i
    HYYCOI68NEDiYg/i8=; b=I5FrbTdaKcLzab/lmdUuo2QqX0mzTSPlHq4j7XiN7Y
    od0glHN9FFXxrEJLuGTEOwzGvkUT1JiTLmOkIC04qLrVB5Zc49GS4ppdwK7BZHqy
    XHen8nNOHYOdb4gUTKapMqRk9W0Jxryab+XY97zTfGVLMeoNSWVgr/bqQaiaWOyj
    mwZw7sPhWsgAHy3DkJV3QS6mgNG99imM+WUcNhwDUVbeoyFTn7JT1Jrm7LSo/jat
    qcYtaAkABThnZrPj/2O8GzJcVSOba9k02GZxOMFPrT41wEdHwBD/uhN3yLUXLpUF
    q93K6Gq5FEp/Iry1CLEJSJe7J/WipZrIMi0BKavhGM/w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933654AbeBWSqH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:46:07 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43572 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933930AbeBWSqE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:46:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 048/145] ARM: dts: am4372: Correct the interrupts_properties of McASP
Date: Fri, 23 Feb 2018 19:25:54 +0100
Message-Id: <20180223170731.124926742@linuxfoundation.org>
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


[ Upstream commit 627395a6f8091c0aa18f49dca7df59ba3ec147ef ]

Fixes the following warnings:

arch/arm/boot/dts/am437x-cm-t43.dtb: Warning (interrupts_property):
interrupts size is (8), expected multiple of 12 in
/ocp@44000000/mcasp@48038000

arch/arm/boot/dts/am437x-cm-t43.dtb: Warning (interrupts_property):
interrupts size is (8), expected multiple of 12 in
/ocp@44000000/mcasp@4803C000

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/am4372.dtsi |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -926,7 +926,8 @@
 			reg = <0x48038000 0x2000>,
 			      <0x46000000 0x400000>;
 			reg-names = "mpu", "dat";
-			interrupts = <80>, <81>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "tx", "rx";
 			status = "disabled";
 			dmas = <&edma 8 2>,
@@ -940,7 +941,8 @@
 			reg = <0x4803C000 0x2000>,
 			      <0x46400000 0x400000>;
 			reg-names = "mpu", "dat";
-			interrupts = <82>, <83>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "tx", "rx";
 			status = "disabled";
 			dmas = <&edma 10 2>,
