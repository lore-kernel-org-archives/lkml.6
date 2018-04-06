Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1404550-1523021398-5-10093209245841492660
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021397; b=fYVdZXAE5oOiSagW6EqAzrz2m8ns/BGtLu/sf8ulKyyJ8qaIT8
    a8/Ld/oz/zyy0y90vYJs0PrcO8SKS3Bx/66iuDFy2S8JRx8B++utkd+GiGr1x6zo
    kYD1W/YaeRTdb6i/ou3U6jf4W2wVTwkqkpL6/BQX+nzOJkcvH7BCT+5u+GoOsFv3
    lgrB+Y9cK+pZuswpyvkRgsm3Yi+duFMZulTM2PDb/TJWb4K4Z8PDDtVQ4UOh2zB6
    s0HjQ7Ke9JAky0XqIvifuxFh1GMJkxA6pmt65XcI2K22dZ/mbBE1s3iF7fVstZ03
    gWDlyQKCU4QJcwMBbzYH2WOveTqxNOQdnTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021397; bh=gERd8NggBxbTQjMNtFXUiQ+RtALiax
    6epwn+cgZY7aA=; b=rltBR6kPal5C0Wdj8MMwY7mjM5Pnl8FFFvNC5H2sGm97e1
    WmtOPPOHs69/IiQoU4si5UI90vA8oXeGOczGh638seAIhGCLOoiWfzbI/mcYeYgq
    zzulWFJvLpJM451jyw5BCB94ZjVISv0HjuBO97jpUC4k3C7sbZGFRao9MJvHclyy
    PDOhEKfKv3PUSxae+oOJcjPl+Zw2T2nJ7ovkw2c1dXh+SaXWC2+arCjkFXJAlswm
    VJ02Snp698D+hlak7E6kcP60K2aXrPtAfEjWzNzMUqZN1424ftUv54P2CF/ban5y
    6dMJRVbAzBVNrECsi2FEIRYqzdmSNsEOLtD5BbJQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfLt0dMHBaRRYaiVTPhWGugHjgwetA9wYBDs3sn4Rn3rG+FlThgS1P+6I+C7lx4TsYikTn5ellhUYZtM9hqOPzLiizuBks309DTulKbPYS7+nPV18OF2O
    J287QfYXxHEHmLrzOxd7wK2VvO+QLFPexR5Y2GDlzgYzq68hrzfsco0aSMlUyqCaV5hKo3UPzq8p1p4E0hjmPA5l63Hp2eyqZJmQ2ERqCZyFs01k5DNb70Lk
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8
    a=nSvfKe7DoOpTu0Az2xwA:9 a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754439AbeDFN3z (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:29:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55948 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754693AbeDFN3w (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:29:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 12/72] ACPI, PCI, irq: remove redundant check for null string pointer
Date: Fri,  6 Apr 2018 15:23:13 +0200
Message-Id: <20180406084306.075727193@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 45288978859119c019eff93f0cb838a0de100bcc upstream.

source is decleared as a 4 byte char array in struct acpi_pci_routing_table
so !prt->source is a redundant null string pointer check. Detected with
smatch:

drivers/acpi/pci_irq.c:134 do_prt_fixups() warn: this array is probably
  non-NULL. 'prt->source'

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/pci_irq.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -131,9 +131,6 @@ static void do_prt_fixups(struct acpi_pr
 		quirk = &prt_quirks[i];
 
 		/* All current quirks involve link devices, not GSIs */
-		if (!prt->source)
-			continue;
-
 		if (dmi_check_system(quirk->system) &&
 		    entry->id.segment == quirk->segment &&
 		    entry->id.bus == quirk->bus &&
