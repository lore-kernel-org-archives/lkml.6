Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3150701-1523474089-2-5529316543398050732
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523474089; b=BPFjvcbXdWi/24Sz9wsiR1p7eIY63IM100qRuF0KIDyrXU1RZC
    Rn1E9sTiY6PI9zfWAAupZUfUTJit5EoOiIWNEOLpjamXr7VQ2jn8hx/oe/Qv8aUi
    HntnfsGONXzGSwKyUAyDD++/M17D4aAu6/2joTdgZfiNChkg+gaaDmSRrFkbVYe9
    10stabOTlSVGJC686paDfv+2ScUMvautHhrcbOSv9RWNqzLV5wzAUSiBixBUi0sd
    Q5VtYQRi5a9OrVBARNABMQhc1vr79eq6zBa+T7IzwGhitswWRzRO2m6TQUYoJOkX
    SIQpRZwl6edlJ9GrbLoxSXzfXdWgX35M0Nqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523474089; bh=EpRMFgMbx9sj4xd05iqAPBjY9nQb5K
    Y6TA3QEsgUxRA=; b=raBVjowSCJVGq4NmXhJx+QiHAZWpyvWlgHfS5y4XsOVY/F
    4THt8OTuv5Y5vrNfodZfFFopaK1ZaKNHDY29swk6RsfK/RFvzfSRQRCrDVkGqY2A
    WbXD+NXQ7HYE3g8Z8Gbl8kMDCsbWaevoxw5VZBq11qQolHzwnOTy7XB+xYh80Epn
    OE7TP94lcqz/BJEINDvme4LynyLlrYMSUI7N7q0IVeczBUj9VnsOYazWbcmDqDMD
    eW+E7vLTD3I+vkTKzVI+HGEQtqg2B+ORVp0mG7SAU5OaGib5+ZmjlGDuZZiNkS3f
    TWCM9iRpA7Dqxqzoqiqzn8iw38T0thwh91Jmi90Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfE2Tw5mD860dB9yfxGyjm/HhWMUU5UrMvgGlEumfHYvGM16Z7UKOHryElg7x6N5qH6Mq+d4+04lf3XP0bSYLjBXl+CrU9zAu/uaWyPLhchvq5wJXp07M
    dYysjXRai1Pi9TMaGaZOY5VMLQV4I96EI+pQD6fTPsMk8vxMAB/PKkP1oAwkvgfM0wgDkr3ufkezqWR0BLmu+gIbYunQgRWWJf6MEq5/UFrxlhI2rG+97ssj
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=WVfum9TogFa7DQqzukUA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757053AbeDKTOc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:14:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40532 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935069AbeDKTFi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:05:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Moore <robert.moore@intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 251/310] ACPICA: Disassembler: Abort on an invalid/unknown AML opcode
Date: Wed, 11 Apr 2018 20:36:30 +0200
Message-Id: <20180411183633.239977484@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Bob Moore <robert.moore@intel.com>


[ Upstream commit 6f0527b77d9e0129dd8e50945b0d610ed943d6b2 ]

ACPICA commit ed0389cb11a61e63c568ac1f67948fc6a7bd1aeb

An invalid opcode indicates something seriously wrong with the
input AML file. The AML parser is immediately confused and lost,
causing the resulting parse tree to be ill-formed. The actual
disassembly can then cause numerous unrelated errors and faults.

This change aborts the disassembly upon discovery of such an
opcode during the AML parse phase.

Link: https://github.com/acpica/acpica/commit/ed0389cb
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpica/psobject.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -121,6 +121,9 @@ static acpi_status acpi_ps_get_aml_opcod
 			     (u32)(aml_offset +
 				   sizeof(struct acpi_table_header)));
 
+			ACPI_ERROR((AE_INFO,
+				    "Aborting disassembly, AML byte code is corrupt"));
+
 			/* Dump the context surrounding the invalid opcode */
 
 			acpi_ut_dump_buffer(((u8 *)walk_state->parser_state.
@@ -129,6 +132,14 @@ static acpi_status acpi_ps_get_aml_opcod
 					     sizeof(struct acpi_table_header) -
 					     16));
 			acpi_os_printf(" */\n");
+
+			/*
+			 * Just abort the disassembly, cannot continue because the
+			 * parser is essentially lost. The disassembler can then
+			 * randomly fail because an ill-constructed parse tree
+			 * can result.
+			 */
+			return_ACPI_STATUS(AE_AML_BAD_OPCODE);
 #endif
 		}
 
@@ -293,6 +304,9 @@ acpi_ps_create_op(struct acpi_walk_state
 	if (status == AE_CTRL_PARSE_CONTINUE) {
 		return_ACPI_STATUS(AE_CTRL_PARSE_CONTINUE);
 	}
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
 
 	/* Create Op structure and append to parent's argument list */
 
