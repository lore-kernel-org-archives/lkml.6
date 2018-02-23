Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413796-2-14706316334702569670
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519413795; b=DY2TfWo4jmomTOTRoMeWiSnZRYUgjuj15+Q8ecJ4h0q12Q4
    xerWoXpQKH2YxbRceC0oBb2+KG5Xs7raz5DbMUzVEAHv5uuqoLW2mvYjWnOspAnf
    w4xMFOBwImZdo1DEsOKxX0Uli5c8g2ASK8vX+LuSLYfybd6UEWZgQlBEAOceFn/t
    VMzsxeSz51UJuT9s3h+jiWgaAeVLE969MPmgqKegG86qZBNtSVbRWGY/IL8Lq0vK
    uKdCVv7q9ImsmedTTakifjNjaoONhKChCxcGHq0nlKka5a9dh1hJyPjPpP0j0Psm
    hwR0x3Nct/y7dWov3iDRGoplbc1euH1lfJVJjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413795; bh=FAKu+I+zuZZVwGO/H/kxABJMZd
    SpBSTLEhbMf6PcCHs=; b=bfE6wRR7KJWWhaJGGnJRbFxfZgL84UpMYczMcjP93S
    BKbuIABZ9pVxl72b9jgcU81QFjwN6JzxmUFmSo0JiPFTQViFZ3oyYt06CYjGb9lp
    TbJRGuAScCKPiR62l4R8BdrufGr96R6mF3LS7gsKKbNajRqvGtMHTp2LWyPG5LPd
    jnUUF4OvV+Lm11tEKZ0rmsRE2FEl4ioBON5B6QdSJsyAoDm3T98AIpFNlkAYY2aH
    87FgUDWASbBLK/FBHfbf7SWslyoysM3/FHl8BfjU114pZm1jAeDd7BGHZvi6Hl7M
    hcDtBSGj6ittxKy3nN/NjbfQ/LacXV9xUjBQt2yLCN+Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935014AbeBWSxb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:53:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47364 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935345AbeBWSxa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:53:30 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Monakhov <dmonakhov@openvz.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 093/159] IB/core: Init subsys if compiled to vmlinuz-core
Date: Fri, 23 Feb 2018 19:26:41 +0100
Message-Id: <20180223170754.770331866@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Dmitry Monakhov <dmonakhov@openvz.org>


[ Upstream commit a9cd1a673737dd81332fce1145801bfacfb90d90 ]

Once infiniband is compiled as a core component its subsystem must be
enabled before device initialization. Otherwise there is a NULL pointer
dereference during mlx4_core init, calltrace:
->device_add
  if (dev->class) {
     deref  dev->class->p =>NULLPTR

#Config
CONFIG_NET_DEVLINK=y
CONFIG_MAY_USE_DEVLINK=y
CONFIG_MLX4_EN=y

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/device.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1261,5 +1261,5 @@ static void __exit ib_core_cleanup(void)
 
 MODULE_ALIAS_RDMA_NETLINK(RDMA_NL_LS, 4);
 
-module_init(ib_core_init);
+subsys_initcall(ib_core_init);
 module_exit(ib_core_cleanup);
