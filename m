Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162587-2-8815440078473752049
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162587; b=lMLOod2OaNVRh4JbLt9nEc6UjP1XRXWfeSJs8GT7UF/JX91u84
    BqgHVyeDrtDOcNCWJlAv0jc0NjwTElssie65Zo8vlyRk2AXY5O/0YK/ZBe+9nMdt
    XS7z1T0/mU6hGiwklfhH8marppbBcqdIQd/oQcCSWyK/4z6jirY4w1r0u/WWH3Us
    aXqvXzvvL9iczuW06Xuk1ypi66G5mnLxfIqXnoqFfFbDuPode7+Jv63wAx9p8TND
    Fyzu2r1yrz7fq22Hij/yt1p5R9Ceae2pGIJOq/3QM+AOHA0DfO6JTTYsJWlq1G8m
    2Uq5LYHHkeOvQya30s06qjkYUMYHebhCJlyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162587; bh=SieXmFKD3FJU97Zpi/fSL2eE8HJAkJ
    mw2cDnMscT6ko=; b=nsZ5tOoMX93N3cJsM43mCHhiYGevE9g2gULFLFUNVXhK7E
    5Ne0dqg2R+fa3LYdMxWGdwArGH/OAdg372HcLWbSPi1qn/knzzl7vH3H/WrrIQui
    AbmKC7hRxm6Ie0wEfywJrqBcVhHAe5C2giEP18NH2B7c75Zdq+/pT10q2O8UdxCC
    lIWCX/L0pCB1IBhW8bU8X3/uIu+swU7TmXWlXP3SVnehtYU31r0HhzxwmiHHOonO
    JBf/yeLrFMA1Ip+fxhQFYSuKy/QIATUFhjWWVLvQergAztXX9s1zBG+DGNH2Kqb8
    wbAEuD8PxBDYGJfUXP5MEsGoxk/BHCyDd0wi/Vgg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=DQwFM0q2 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=DQwFM0q2 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFgXAkMcJ8Y2M7DbyvZGvKhH16r0Md8agNf090X+ewjZlUsAwH8EfgDgbvvmg2iul2+imeosRitVCqVDNt6N3I2CuxEMgjCmNlYhfZs4ULtHAwGzGUrF
    vUUZ7+a/szxDpKzxG2zQASEYFTuQD0qvptZGwg9p1ydu+3xW5bD3rh5w3az40BNGwICPeeBYMJsTILcbJwL7tX3uc4PV/82aDWH3LfDm8jX4u4lGFAGHWd4Z
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=CbDCq_QkAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=-66xd70nerPzEY_yfasA:9 a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967073AbeEXLtV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:49:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967008AbeEXJrG (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:47:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tarick Bedeir <tarick@google.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 01/96] net/mlx4_core: Fix error handling in mlx4_init_port_info.
Date: Thu, 24 May 2018 11:37:44 +0200
Message-Id: <20180524093605.702786478@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tarick Bedeir <tarick@google.com>

[ Upstream commit 57f6f99fdad9984801cde05c1db68fe39b474a10 ]

Avoid exiting the function with a lingering sysfs file (if the first
call to device_create_file() fails while the second succeeds), and avoid
calling devlink_port_unregister() twice.

In other words, either mlx4_init_port_info() succeeds and returns zero, or
it fails, returns non-zero, and requires no cleanup.

Fixes: 096335b3f983 ("mlx4_core: Allow dynamic MTU configuration for IB ports")
Signed-off-by: Tarick Bedeir <tarick@google.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -2983,6 +2983,7 @@ static int mlx4_init_port_info(struct ml
 		mlx4_err(dev, "Failed to create file for port %d\n", port);
 		devlink_port_unregister(&info->devlink_port);
 		info->port = -1;
+		return err;
 	}
 
 	sprintf(info->dev_mtu_name, "mlx4_port%d_mtu", port);
@@ -3004,9 +3005,10 @@ static int mlx4_init_port_info(struct ml
 				   &info->port_attr);
 		devlink_port_unregister(&info->devlink_port);
 		info->port = -1;
+		return err;
 	}
 
-	return err;
+	return 0;
 }
 
 static void mlx4_cleanup_port_info(struct mlx4_port_info *info)
