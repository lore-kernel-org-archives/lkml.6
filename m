Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3150701-1523473777-2-8334421157140899109
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523473776; b=N2qX0uVBRPu8cF6eQDggx8kRYyY7+VsLl2MbiZuwj/4qjfcYS/
    jTgodmcZ89XvQGD+XfIWMc8K+qa0JwlpTuQYk5Lc4wAwUFvOc/2CgHDMfyF/d/jy
    gm97mRMzbfsS5cmq5e9z56AxqLaudC8tZz5ziP8y98A86Lui1cZ8D7zER0I6YqdJ
    wON7k4QRjmBjwyMIlsnRApATmKF83CulyBDlE2AAjb20+cKH/fpqZmPo1FaUKApG
    5occYcY80hVi8DGF21ocbgC8LaWaL/atdo71ozZKrVr6NNWDizK9eCVhr82gfRiG
    essjhPFaBqhPLmSo1TjM6Iv94szI5z8FogwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473776; bh=wxYWjG/ogr2IyQp8cw3gqEXLEOFH7d
    ku/08UwMpK1wE=; b=n30QmFHoHyGTQi7f45u7hm2y/f9lelJQoRQaNdvBNyu/aH
    97o8m6Su2hV3M3cLizwe03tlsMTCronwqxeoJZcpPlXuK7HiIrJiZxoZ8OpJ5rVC
    CIBqv3nJbNJLHVx5K/lZ0gOfPlUSpWZqYKegzqbGRuAriIMqzcCntUgA0ADkmh1A
    69UZYo/zUFNZ1zEUwbtWy2xuVViB9gVRka6QdYrbiMDeGVl8iACvZQUKhzKcTuis
    RvKZQLHcyUFyux4AfdS0GI1lqj6AUxqBhzfrYlLL1sG6c7Up/3j7vZpUz4taT7br
    MFc49PKa3WrZyHaPh/m9/cF+MIX8ybpHxBdSyYgQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfCnCX1prJa7aioTeGtiNV6Dp53+JLbn4T1wQ+JvEyMIl1PuGzfh7dmfwrI+GHqDvJqQddu3trnOv5qtxxCFHfDP27piogQV4H8QAIz9LxNjq33mFRHhq
    bC8q6ePV5vo7OXK9srbhLFU7am+WGZjupANtn+qLoa2xzFL36Mwkl0nksfk6am94K+RdARXqFdZDtyRQuHYwM2AsdP/g02Rk5Nx1ihdDqBCdSghpyzsPC91z
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CbDCq_QkAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=jKXu83aJfUeL4nnnRXAA:9
    a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935285AbeDKTGn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:06:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40878 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935281AbeDKTGl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:06:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 307/310] net/mlx4_core: Fix memory leak while delete slaves resources
Date: Wed, 11 Apr 2018 20:37:26 +0200
Message-Id: <20180411183635.743472851@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Moshe Shemesh <moshe@mellanox.com>


[ Upstream commit 461d5f1b59490ce0096dfda45e10038c122a7892 ]

mlx4_delete_all_resources_for_slave in resource tracker should free all
memory allocated for a slave.
While releasing memory of fs_rule, it misses releasing memory of
fs_rule->mirr_mbox.

Fixes: 78efed275117 ('net/mlx4_core: Support mirroring VF DMFS rules on both ports')
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
+++ b/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
@@ -5048,6 +5048,7 @@ static void rem_slave_fs_rule(struct mlx
 						 &tracker->res_tree[RES_FS_RULE]);
 					list_del(&fs_rule->com.list);
 					spin_unlock_irq(mlx4_tlock(dev));
+					kfree(fs_rule->mirr_mbox);
 					kfree(fs_rule);
 					state = 0;
 					break;
