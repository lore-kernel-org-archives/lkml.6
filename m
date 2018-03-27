Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133288-1522172405-2-9310378674825174856
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522172404; b=ciYbQA+jIaVVE44JyHgDCa+4u2GkfTdnQ6qPTzBSbl1fNCV
    1uiqsBALbH63G7rJb78rsAvsrMjMSmExVfu4TgkowiHkZ1xTCP0CGttKo/EVKgDu
    Kildfeif/9SvuQU/eSM8XQS9VRSG6SayRqhiKlovYy0ELHo2gzB9Bw1PRBWNZJ81
    7tBPxQqG/R6UsD5t4fZM4GNd6e2qVTAP80JempI87QXDaFJWL7+CQfFswH8WtPm8
    qMaNjNgLSTPZLNPbTX1z2Ygh5PAlMRUShVs03YBbq4sh5T+sns8pl8urKizQukdG
    26yiIQvuZwV+26giwdJxqtyu78Hfe2X5/KDhhbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522172404; bh=zLB1pe7uTOG8xY1yemv3EXuA1z
    q3wslZMy63eR4xCvI=; b=hV43mBsYZrZQ9ZXjoTtg8JbgbNGGxhHfQn8nKf5DkF
    dl8HLrx/ID5Zi8AL922Vp4x/iR5Fo4gyKZ9tMrg2zCbigQeGKhCbqpjHB/BMhC6u
    GJ8hHGuRScaqwUJXPjRP/Hq23DrAUVpQebjabYqNTE3CyGJAl0EUgnz6PLg7uDFC
    N15vIAEVoKaB/mHzPE5KzpEALoLp4ln6R7DbfHC3hsQ9quH7BgpsGN23HbkUcgpx
    jDD8b7AqVjsqpjKw+Yo5SqF0FMdP6YXT5HI9tg1/FB9okSP3PrAjVPIcjL6mSmrB
    O8UtMrwoNsmjkk0evljCqBvYxalHDZtip+X2dkJsdFPw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIPVG29/5KC3mc0BAG38H7qPdEeyQLAEPlLanBEQCns5dEnXP5wqD1GMIoJCOmnt0PNcJn4oxebAZWJrhF69EIDLFg/79kmmdxPWQA5nIftVYQzTETh4
    zEI+OWKc9rBNHN4Hej+3tpPqnRlcWJnOJsWAuGbeOqUotmeuj3X+03bJAh2ZG4B24BX9H8wVgI6K7JRjIE9GZVd2lbPOD5BX+IQAU6fT/FNwjWW8i0aRpNsY
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=gPJu0pBYAAAA:8 a=Vxy2kpnnAAAA:8 a=WPyIoOwQAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=aPybxlVnr8FfNYOFDaoA:9 a=QEXdDO2ut3YA:10
    a=AlIIF0cMT2hfDT4axODj:22 a=mQL3ssppXrSh16SuiSjD:22 a=S-HzPIwwDS8t1QcwSuWs:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754044AbeC0Rjs (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 13:39:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44336 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754207AbeC0QeT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:34:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neil@brown.name>,
        Matt Redfearn <matt.redfearn@mips.com>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.14 002/101] MIPS: ralink: Fix booting on MT7621
Date: Tue, 27 Mar 2018 18:26:34 +0200
Message-Id: <20180327162750.137919079@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neil@brown.name>

commit a63d706ea719190a79a6c769e898f70680044d3e upstream.

Since commit 3af5a67c86a3 ("MIPS: Fix early CM probing") the MT7621 has
not been able to boot.

This commit caused mips_cm_probe() to be called before
mt7621.c::proc_soc_init().

prom_soc_init() has a comment explaining that mips_cm_probe() "wipes out
the bootloader config" and means that configuration registers are no
longer available. It has some code to re-enable this config.

Before this re-enable code is run, the sysc register cannot be read, so
when SYSC_REG_CHIP_NAME0 is read, a garbage value is returned and
panic() is called.

If we move the config-repair code to the top of prom_soc_init(), the
registers can be read and boot can proceed.

Very occasionally, the first register read after the reconfiguration
returns garbage, so add a call to __sync().

Fixes: 3af5a67c86a3 ("MIPS: Fix early CM probing")
Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.5+
Patchwork: https://patchwork.linux-mips.org/patch/18859/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ralink/mt7621.c |   42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -170,6 +170,28 @@ void prom_soc_init(struct ralink_soc_inf
 	u32 n1;
 	u32 rev;
 
+	/* Early detection of CMP support */
+	mips_cm_probe();
+	mips_cpc_probe();
+
+	if (mips_cps_numiocu(0)) {
+		/*
+		 * mips_cm_probe() wipes out bootloader
+		 * config for CM regions and we have to configure them
+		 * again. This SoC cannot talk to pamlbus devices
+		 * witout proper iocu region set up.
+		 *
+		 * FIXME: it would be better to do this with values
+		 * from DT, but we need this very early because
+		 * without this we cannot talk to pretty much anything
+		 * including serial.
+		 */
+		write_gcr_reg0_base(MT7621_PALMBUS_BASE);
+		write_gcr_reg0_mask(~MT7621_PALMBUS_SIZE |
+				    CM_GCR_REGn_MASK_CMTGT_IOCU0);
+		__sync();
+	}
+
 	n0 = __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
 	n1 = __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
 
@@ -194,26 +216,6 @@ void prom_soc_init(struct ralink_soc_inf
 
 	rt2880_pinmux_data = mt7621_pinmux_data;
 
-	/* Early detection of CMP support */
-	mips_cm_probe();
-	mips_cpc_probe();
-
-	if (mips_cps_numiocu(0)) {
-		/*
-		 * mips_cm_probe() wipes out bootloader
-		 * config for CM regions and we have to configure them
-		 * again. This SoC cannot talk to pamlbus devices
-		 * witout proper iocu region set up.
-		 *
-		 * FIXME: it would be better to do this with values
-		 * from DT, but we need this very early because
-		 * without this we cannot talk to pretty much anything
-		 * including serial.
-		 */
-		write_gcr_reg0_base(MT7621_PALMBUS_BASE);
-		write_gcr_reg0_mask(~MT7621_PALMBUS_SIZE |
-				    CM_GCR_REGn_MASK_CMTGT_IOCU0);
-	}
 
 	if (!register_cps_smp_ops())
 		return;
