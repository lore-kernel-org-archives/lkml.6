Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519832802-2-11249162590898328790
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
    t=1519832801; b=HcSfiAOTD42C/fq5vf9/27WkyNWKft8G1hwxf/IE7N+hV/v
    NlG9Dp/qsl49FRU3MWYFHx9Kps2dSZirq8LDAv5Ea/HjMTFJHgS7w/HuyWh9XUDP
    ybRacRJ1NLIgAVElYLzH8Zg8ZRG5TOPFrW2ldx14wkzshQ2/3LKR0ct6KX316OUS
    LdybueOiLOL+NJOFJUZHBpODI45ZmdF6I7KQlJNHy69ILhMsVYHfOnvaeLVbCLZf
    wWhYruncLFhrI8kR9MqAmLsVCYJdDaw83JSXu/VahmLqxg+S8O9F6Rx0/5S2nj7+
    zy7v6u6WektjjgSaK2nESoUHfi4eFnbYnx8M+nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832801; bh=KY7Z9wFwsgYR46RPXIv
    yuLEeT7LHAPtFgW2fKEEx8Fs=; b=s6nCtR12AxAdUDgPjukluipxaQRDyW89AWm
    6NmFolQTO8zIL704rIC66ldRIWW+bxqMUSDmP3+I89xqkpwXD/97Kt9n1db74dA3
    ht0t/j0vOybmrveEvBUaKDxdKXCATmiUvHAqLTswcPxL9AbPW+Xbq6KLtUeVc2rl
    Biqs4C8lh+I97C20skcMxXnflG3bTnJg58ryNpILTWLFHDyK5ZUnNn/eigU2jmzC
    kbml+MXcf+Ondzv4Y+PH6igup3smLO/vNcLSHtAioO2Ob0vXnu/+AfwoWdLyBw7D
    2FkWth1xaMkDYLNSB3MQZCF4PXzJShzNhPwQ75pcp1bFfRgsDug==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932672AbeB1PpW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:45:22 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33328 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932644AbeB1PWQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:16 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Arnd Bergmann" <arnd@arndb.de>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.592855177@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 078/140] mmc: s3mci: mark debug_regs[] as static
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

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

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index f7f157a62a4a..555c7f133eb8 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1424,7 +1424,9 @@ static const struct file_operations s3cmci_fops_state = {
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
@@ -1446,7 +1448,7 @@ struct s3cmci_reg {
 static int s3cmci_regs_show(struct seq_file *seq, void *v)
 {
 	struct s3cmci_host *host = seq->private;
-	struct s3cmci_reg *rptr = debug_regs;
+	const struct s3cmci_reg *rptr = debug_regs;
 
 	for (; rptr->name; rptr++)
 		seq_printf(seq, "SDI%s\t=0x%08x\n", rptr->name,
