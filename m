Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415822-2-476506844520575146
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415822; b=WOe6jCMFC6khRUndXX7/WKKjDf7Vd2ZCKLHCmw+LG3n1yrB
    PmBEaLKfgLsCJuWm/3rhS7Af4zcuwJmx3qLWGpRuHIJHX7MQqPBPJsAA/Ce1lSnb
    Xeo4rmOWKAlHpB1Ov7PhmM2e9LKhczQfLH3diQ/FykIG8IS12PPegEBH39QeIdSP
    Zi5yfoXoo2Dou0R+17gFaMzExLl46E9cNKBfYQLwnOT2hxeDKzLrFDvLCR4/pbeU
    4oIftjmPtoFdPdn2ps8cTuCMXZJP0f5ZLVQxap0SRhUeiYt/Vml8KUV+cufxvbs+
    NvlNBTVAMUxeUqvu3nxNvxXaxdjFtN5P6Fnm80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415822; bh=bOeywt1aP2VIAJBbwNxns5GpJL
    HW0RhCOnqWDBcFTxE=; b=p6Ru9f4B1awKKvbbND10NWCULCsogurIJzQirLF7B9
    kVkg59GT5zNo6YThuBzJUKJGk9Rpp/qXgKo9PFseoOByXVS+vtQki1pU8kY45uHD
    e4iellNJYzsZ16FOb6fg4D/VltdanJZ9EFlOM8dwpIvuyVwQE+sGhGDWVBiy9ySw
    s1R+qviwapQiTN2uW8hgbA5gchNV7UvkXPQjlulY5FhYhhK4FKTKNZTs61mIZflc
    V6yLYZ81wIHcqI5/tbKLkNSoDGty4KC+yhld2jUH9aSBbrVxW0Y5XBOjrkDEdlTX
    e6DBIynwaAIuMZGeqIMgYppGktHf2Q48ehyFX2hti6Bg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933612AbeBWSoh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:44:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42586 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933575AbeBWSof (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:44:35 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moni Shoua <monis@mellanox.com>,
        Mukesh Kacker <mukesh.kacker@oracle.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 056/145] RDMA/cma: Make sure that PSN is not over max allowed
Date: Fri, 23 Feb 2018 19:26:02 +0100
Message-Id: <20180223170732.099643452@linuxfoundation.org>
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

From: Moni Shoua <monis@mellanox.com>


[ Upstream commit 23a9cd2ad90543e9da3786878d2b2729c095439d ]

This patch limits the initial value for PSN to 24 bits as
spec requires.

Signed-off-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Mukesh Kacker <mukesh.kacker@oracle.com>
Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/cma.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -744,6 +744,7 @@ struct rdma_cm_id *rdma_create_id(struct
 	INIT_LIST_HEAD(&id_priv->mc_list);
 	get_random_bytes(&id_priv->seq_num, sizeof id_priv->seq_num);
 	id_priv->id.route.addr.dev_addr.net = get_net(net);
+	id_priv->seq_num &= 0x00ffffff;
 
 	return &id_priv->id;
 }
