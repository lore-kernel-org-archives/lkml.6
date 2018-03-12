Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3441149-1520826865-2-3094863657025935474
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826865; b=Mch5b2rb8jAj5C5wyC0FSTqloy7eHitxFSxiyJ8eefRvkY9
    r4+IrHgm7bL0ewXvQny0THBIfBDOErC9IwDG4A5zV7v1hi9DJKw6peWTdhf1l7Md
    vXLxhQD9Z3HVnP6bYM+8HJ+P1COwSs6jQjy9OKx/3rj5WPnfmrValSAi2vfzSchL
    1AmthzafBC4jvo/wXQyyuTgEN8eS0fwbyWD9EaTqOPMXvm8KWuMap7Hyl+plnDhf
    R1q7ZojpwkOn3gXqiHpks/SrEE6eXY4HPva/LhgxRh+/FKsN9iHc/UPzAbSGqZY+
    /Z5HVmZSe+m9pl2Z0nKoYdjv/PMM4C3pTIXsuxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826865; bh=cEAJVpYTwmM4HbskOhj
    qKmVxofKXbQvOnAl8+lRHMQ0=; b=A+jjRLwNUHwmbGL7cxX0wmsFT6vRbP1R0th
    +fWgOLpCbwAVn7juT9ytrmFUvib8lTIhRfXMdZkXzvNF4gG0rnkrKz9EO8yXdqpT
    wS2lsEi3sQhhN58yjGIRoFUHBr7VajftV9u9/3WQhoUZpkQotfqOXt9kGC2Qr2W/
    wDbNwFLX+48uc35B7ai/sxe9D0F5PxErdJWOnWFHTsX0vChLlo8cUmvFGbXWrr1X
    YO22/rUX/yfx1OT6FTpCO/HOyz8vxvCL0OepDOvf5YWSV8XoER6exKB4psOLRidg
    ttywnfXboRs45oZjop2pxUBRwAGQ+x13hUZA9sHKMFUNlKxDVlQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932750AbeCLDxD (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:53:03 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41030 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932560AbeCLDHi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:38 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Andi Kleen" <andi@firstfloor.org>,
        "Kalle Valo" <kvalo@qca.qualcomm.com>,
        "Andi Kleen" <ak@linux.intel.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.928386766@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 005/104] ath6kl: fix uninitialized variable in
 ath6kl_sdio_enable_scatter()
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <andi@firstfloor.org>

commit 527f6570300980251e818e80865b437eefb4e5d3 upstream.

gcc 4.8 warns

/backup/lsrc/git/linux-lto-2.6/drivers/net/wireless/ath/ath6kl/sdio.c:
In function 'ath6kl_sdio_enable_scatter':
/backup/lsrc/git/linux-lto-2.6/drivers/net/wireless/ath/ath6kl/sdio.c:748:16:
warning: 'ret' may be used uninitialized in this function
[-Wmaybe-uninitialized]
  if (virt_scat || ret) {
                ^

The variable can indeed be uninitialized when the previous if branch is
skipped. I just set it to zero for now. I'm not fully sure the fix is
correct, maybe the || should be an && ?

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wireless/ath/ath6kl/sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ath6kl/sdio.c
+++ b/drivers/net/wireless/ath/ath6kl/sdio.c
@@ -670,7 +670,7 @@ static int ath6kl_sdio_enable_scatter(st
 {
 	struct ath6kl_sdio *ar_sdio = ath6kl_sdio_priv(ar);
 	struct htc_target *target = ar->htc_target;
-	int ret;
+	int ret = 0;
 	bool virt_scat = false;
 
 	/* check if host supports scatter and it meets our requirements */
