Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519834882-2-15929914447083576989
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834881; b=GfoRdC0oOZ8awHVSOrDzKlmZWzYWcnLDhy6k7gB2O2ByS60
    TdAHz28DNqv6Wy2A415L95JL62QA709o6ebbPITIic9eAFUdCexY1TdD2Y5HlEk5
    TTrXrJdmwE9e9v0cRwYeaz+h0mq9/WOVHBXoTSkcgsDN71yeGtl3rZ3n4hMxPpJz
    /TK42/QCKamQm4PYUvdoQCoYXnK/+DYsDq4OlEijDsMicrxc1F9/WBlIyUY36g9d
    XIhbY2XOulMta460haj1oEVmdi/iBUEmmJ246ezfKJdXYySxQOcEX9layBfuLlBf
    RgmtdylmX8GHygXQb7FMweYbHhtMuL5bXL1XBRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834881; bh=VSwY4BBIrJGRVgBLgfI
    X7oeQqXKxvgdURxdw0xiFfWI=; b=IV8R8NoW8TYJbc3CchiW58r8xxBOgU50bDE
    a81hrW7+EeNI7eddW6N/hBzcB4dBDL6sNSKZSb1lU4qgF/6lWx5zxS43m/ekHng5
    7pAIJ1ebrQWbFio5pzLIFwl+X25xbdVQkUIib5aDLJtA+dAnbC+SFtl59aBs42du
    M+3vgGACsM3BSawZVSbR8NFgu/n0z3gJhywS+hI7U6bDBHL5VlfOxDxUgwAYgPij
    h7frcW7e4K48LGAyY7/Du8fxzTvGARJN/PB3+r22z7L7njp5e/2VX/ypBTeWl5Zm
    Hovzhg2Fnhe+22flQ4Da8yGuZY1j0vH4eKnJiIFkIklu0PsGZ/g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935278AbeB1QVD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:21:03 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35406 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935236AbeB1QU7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:20:59 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Arnd Bergmann" <arnd@arndb.de>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.978797534@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 160/254] mmc: s3mci: mark debug_regs[] as static
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 2bd7b4aacdb6efa5ccd4749c365c171b884791d2 upstream.

The global array clashes with a newly added symbol of the same name:

drivers/staging/ccree/cc_debugfs.o:(.data+0x0): multiple definition of `debug_regs'
drivers/mmc/host/s3cmci.o:(.data+0x70): first defined here

We should fix both, this one addresses the s3cmci driver by removing
the symbol from the global namespace. While at it, this separates
the declaration from the type definition and makes the variable const.

Fixes: 9bdd203b4dc8 ("s3cmci: add debugfs support for examining driver and hardware state")
Fixes: b3ec9a6736f2 ("staging: ccree: staging: ccree: replace sysfs by debugfs interface")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mmc/host/s3cmci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1537,7 +1537,9 @@ static const struct file_operations s3cm
 struct s3cmci_reg {
 	unsigned short	addr;
 	unsigned char	*name;
-} debug_regs[] = {
+};
+
+static const struct s3cmci_reg debug_regs[] = {
 	DBG_REG(CON),
 	DBG_REG(PRE),
 	DBG_REG(CMDARG),
@@ -1559,7 +1561,7 @@ struct s3cmci_reg {
 static int s3cmci_regs_show(struct seq_file *seq, void *v)
 {
 	struct s3cmci_host *host = seq->private;
-	struct s3cmci_reg *rptr = debug_regs;
+	const struct s3cmci_reg *rptr = debug_regs;
 
 	for (; rptr->name; rptr++)
 		seq_printf(seq, "SDI%s\t=0x%08x\n", rptr->name,
