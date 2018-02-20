Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2549902-1519120678-2-11877654939227282340
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='be',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519120678; b=KE5dHZXbOiSGlE6yYMfWw5fSVSJJqeW0yG/xMZePl7YYqx3
    IFdBNK3PqIbcRblHGU2/NTE160S6eYWYAB9y4eIDttXf8L10O6tSTYpPc65xnuOk
    D9/pHZQZlxSMiDG1SCOOBdUljQI+xvzvlTPFp167FCv89MpKZJXLDa9vxvf/GWgo
    Qd+ZB7FyKEZvXBZSH7cV5jwmVsnOCPxcxtc/T+jle9erkhozD0+XrVNbfy/tm4Op
    vjqmD9HLa22fC8CpVd3/DdrJJkV4eggsZFOwjbXFR8aIHoYKYqeQ+h0n1gUrh4AY
    Tlba51ic799tDY+h/V+NhTfsirTcIqXfS4BOgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519120678;
    bh=JTg2H9D8YDfjvYeKXgteLCdfvZCMKhCk8sXcD0FA1oI=; b=ez/+DWUjFQ9u
    tDbj87Fia0F/J0MzTQ4r0lV1E7Hv2juD/EfHtEbBkuRLcCdH0VUrLhSq8NWqyLTt
    ObzG3VZ9sxu5GdHnoJhda0QeivwtydjPjLhFGy865jwjPtP0kVzM6wnJXZo1WI1V
    8v+kpj8qDuz3tXuCS4TR4EaFfUk1CxSeOELC/YXIsrwQ4iTsd9EPudn+3V0ZYvcp
    wQSwmFGgat3KYPmHkAWL8xo5VhFhkmtrAGFLKlvCZXir5yScyViRFRJuJIWp++Yl
    UcJjPlcvfn/dirJNkdL/wWSSr2N/mSCajs55N/rBXjcRXt/oBqrSdimOV/VbJ//o
    Pn4A+1LofA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=glider.be header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=glider.be header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbeBTJ5a (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 04:57:30 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:60194 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbeBTJ5Z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Feb 2018 04:57:25 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Barry Song <baohua@kernel.org>, Vineet Gupta <vgupta@synopsys.com>,
        Jiri Slaby <jslaby@suse.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 7/9] serial: sh-sci: Fix out-of-bounds access through DT alias
Date: Tue, 20 Feb 2018 10:40:22 +0100
Message-Id: <1519119624-1268-8-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The sci_ports[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Note that the array size is defined by a Kconfig symbol
(CONFIG_SERIAL_SH_SCI_NR_UARTS), so this can even be triggered using a
legitimate DTB.

Fixes: f650cdf1c115498e ("serial: sh-sci: Fix out-of-bounds access through DT alias")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4d14f321cbec95e0..0fb4784860da6188 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3620,6 +3620,10 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 		dev_err(&pdev->dev, "failed to get alias id (%d)\n", id);
 		return NULL;
 	}
+	if (id >= SCI_NPORTS) {
+		dev_err(&pdev->dev, "serial%d out of range\n", id);
+		return NULL;
+	}
 
 	sp = &sci_ports[id];
 	*dev_id = id;
-- 
2.7.4

