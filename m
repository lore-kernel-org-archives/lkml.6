Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518325609-2-1971769492808835099
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325609; b=TBrH7ZnF4lY9ImB09WR4KyRf1axKNNYaoIasb0OwxYJEzt4
    NiImPJxtu838bOcd1qxNeq7+6iSkTGnkMlySJe6w68lvhYNQZ825vNMjG02JBKBC
    DEGvNImgf88lcnU0n2WaIqgH5Zv3my+KVXMqMOh+Rx/Uu7Dhceb6VagY4/OvweVD
    IfUUq8dgliZt2rjmSRjdvnO5fXAIwZmEZdhBmB+E71IVTxibwN4qxX3rtqDWANIX
    3OTeC8U4Dylbaex7rFYnGIh7S0v+kzQ8uUs7JCsN4RE7nmW3Tw1RekcTKKByEs1z
    BOmRgmsxDIAjr3r1LJrxMh9ygDI4GurJXGOeQnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325609; bh=Zl2wq5lc1I3zopNre/f
    UbDcIfcccfpQfGGGDCCZ8/wU=; b=XUhAos6cR97AbmvleJ4TgPKvwTY4B+jHii4
    OYNiwcsF8zEaNWoT2BSKgjxHYE2z2ICRVNDVEf36SQvax5IaEkEATaURwHr0HgVx
    iLSUngUwMmm4Icg76nd6fYGxiPvouXNiKIGM+DMA53pDhplyTcb5IYpnAYwR/4hx
    jUYCR9MAcKvVVXSNvlzYz7hKubfS/HaYGlprG94m4L/TuEazWTCy6OVuaGJdKy+4
    5gJulUc6uq6HvlBU/95gebbwFQyak4AhWsGlYZ31PUyrWdFvS51qsioBrC4YfaAE
    eqx7+CKxkonHPKyFCi9htlvdbd3ZJn7vTH3Tl5506/jEL6NF3Mg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753609AbeBKFFl (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:05:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41489 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752674AbeBKEdn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:43 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Mark Bloch" <markb@mellanox.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        "Majd Dibbiny" <majd@mellanox.com>,
        "Doug Ledford" <dledford@redhat.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.736811003@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 37/79] IB/mlx4: Increase maximal message size under UD QP
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Bloch <markb@mellanox.com>

commit 5f22a1d87c5315a98981ecf93cd8de226cffe6ca upstream.

Maximal message should be used as a limit to the max message payload allowed,
without the headers. The ConnectX-3 check is done against this value includes
the headers. When the payload is 4K this will cause the NIC to drop packets.

Increase maximal message to 8K as workaround, this shouldn't change current
behaviour because we continue to set the MTU to 4k.

To reproduce;
set MTU to 4296 on the corresponding interface, for example:
ifconfig eth0 mtu 4296 (both server and client)

On server:
ib_send_bw -c UD -d mlx4_0 -s 4096 -n 1000000 -i1 -m 4096

On client:
ib_send_bw -d mlx4_0 -c UD <server_ip> -s 4096 -n 1000000 -i 1 -m 4096

Fixes: 6e0d733d9215 ("IB/mlx4: Allow 4K messages for UD QPs")
Signed-off-by: Mark Bloch <markb@mellanox.com>
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/hw/mlx4/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -1047,7 +1047,7 @@ static int __mlx4_ib_modify_qp(struct ib
 			context->mtu_msgmax = (IB_MTU_4096 << 5) |
 					      ilog2(dev->dev->caps.max_gso_sz);
 		else
-			context->mtu_msgmax = (IB_MTU_4096 << 5) | 12;
+			context->mtu_msgmax = (IB_MTU_4096 << 5) | 13;
 	} else if (attr_mask & IB_QP_PATH_MTU) {
 		if (attr->path_mtu < IB_MTU_256 || attr->path_mtu > IB_MTU_4096) {
 			printk(KERN_ERR "path MTU (%u) is invalid\n",
