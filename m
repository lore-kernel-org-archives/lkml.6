Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3447179-1520954867-2-1560729548250028460
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520954867; b=N7jy65+kgpBU3u+sDmdjJfZSdtCOJdu2OTHP7Wo3/4//0kE
    lMeBOR1nRUHDHqjzU4v4eNV+5r/qt/cdXpgKm2dSKiOWDKvc/H2gZb0CQC/dNQc/
    L0UVsB347yMVan+qHl05dl89VXN4mZLUmju2Y+eIgVpwI9psRhBQ/3nVxR5QEumu
    /epMJb1urX4G8JXNF9u+fXd0l7ph/Dbq+JH8ZASsvNvQTm8LGONeaKOzyytyUvjQ
    UyqDrYJ3dGg0zpcU+2u74Cl/GQNIWZT7xDBNgSsIXm/TTvm9IwuTMdqf6YXMfhyI
    usu1O8FMbAi7h70DUhMq3KOFzEQxmUw/6flF//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520954867; bh=2qXlx6umLFNkmH2X4Ud1qQLZ1R
    /auvVZp19FkiS+Eao=; b=Kprs8ataQmufa4vvvob1Kd7IkCas27gk0DJ783zegw
    o3x4sNWnNBOgYrdD2uRPJeHcx4JqpGPYHER1ve2EgSPUrZLno81r6lYcr6hAaTYm
    bxgaPmNFpRMRnIA/0ih0n4WyJiO11pxDcagZz1pIalVTL7DqMy8LmcorBlzq/HN3
    +lV9sICwugei55hA+HKyjuwXmngZ7YhIowRyUwenxbn2rTbkUI1S0MI8A8RnKxPP
    72qMr8lSaX9fljfiwUvHMM2ZmqdeTOFe1or9H/LLNCE62N8CJdSSG/gvI65uLwM+
    MDIZZxmZue2IcutJpcIHCiepTBE+O2zztK7h68GxLpRw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932376AbeCMP1n (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:27:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932277AbeCMP1m (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:27:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a38b0e9f694c379ca7ce@syzkaller.appspotmail.com,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.15 001/146] RDMA/ucma: Limit possible option size
Date: Tue, 13 Mar 2018 16:22:48 +0100
Message-Id: <20180313152320.681030850@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit 6a21dfc0d0db7b7e0acedce67ca533a6eb19283c upstream.

Users of ucma are supposed to provide size of option level,
in most paths it is supposed to be equal to u8 or u16, but
it is not the case for the IB path record, where it can be
multiple of struct ib_path_rec_data.

This patch takes simplest possible approach and prevents providing
values more than possible to allocate.

Reported-by: syzbot+a38b0e9f694c379ca7ce@syzkaller.appspotmail.com
Fixes: 7ce86409adcd ("RDMA/ucma: Allow user space to set service type")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/ucma.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1293,6 +1293,9 @@ static ssize_t ucma_set_option(struct uc
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
+	if (unlikely(cmd.optval > KMALLOC_MAX_SIZE))
+		return -EINVAL;
+
 	optval = memdup_user((void __user *) (unsigned long) cmd.optval,
 			     cmd.optlen);
 	if (IS_ERR(optval)) {
