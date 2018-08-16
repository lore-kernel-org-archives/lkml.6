Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68D7C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624C821480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvdQ0ujo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624C821480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391528AbeHPQAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 12:00:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37578 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeHPQAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 12:00:08 -0400
Received: by mail-lf1-f68.google.com with SMTP id j8-v6so3338489lfb.4;
        Thu, 16 Aug 2018 06:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=YBkkEzB991JIxBfC03qX0tPqpzD9juLQ2gm6AxY1L0c=;
        b=BvdQ0ujoWrml1D1kXTlGfxGjagJgp38sAiLUrYRm6O6ASuh5UuzQb6GhHkLAoInz6+
         OSO8ZQ7sMYo9rfbVs5ugoyaKUGEaDRsQ4oy30PKtzAtKtanVkx5WfRAW00m3Dadpk19y
         gHVBCyyTknDi3NRMHPerXO3D+lRGW3K4R2n3cPdG1A757qM3OBTrGfLOJkisnmXOYYqe
         TrUOGd730tZYy11SsHsQQTVJEM0DIWe076rmBByUcXzFQ0dvS10/u+c68jGG94NIReOK
         aoF5z9LlS9iOWKwvSDF+qv4JLRr9EeOIvA5o2EBTiAH3jssbkoHO+9KmbWSfIB+xoUn/
         bRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YBkkEzB991JIxBfC03qX0tPqpzD9juLQ2gm6AxY1L0c=;
        b=FgEcU+da/nQAGHYffyvJ+6KNYr3DssbkrdTTYzLnoxdaTZgyqB50vwl3YXZEtqRzs7
         +fQ/J8uZpeqQVUNnSv48VzYW3fgmtX+1137BykMmLYWZwZDvkaCnGUFyaW391EJhy+6V
         a26qo9DhzGB+K1Dr/lOFtMqSYzQj/psEeDN36zXw4zkuD5/i9w/MBnCLp4KT8u8uV6AF
         TqWHXu9IFGiEPGBsnM2k2loEa/5TotEDE8+EwG7sNUgWsTez0CtsG1MHBt5Z40ktIe6k
         AfqT3D5vu5o6kYUdZy7MpnmMFMLexp1LRTgUpoLGycJk4WSbnM15Vwp9hL5N5CuNl7al
         D18w==
X-Gm-Message-State: AOUpUlEV6GuhDgTXkRs5E/PLQtw5GTn/VmlrGRTMAxHDB8ct/vkOKTdu
        PJRn37h4mSE1v1I5SGBAMs6xZGteYsvSsqu7jqA=
X-Google-Smtp-Source: AA+uWPzA676jtqvmStkIDBQfiAxw0G0Zen1mvwXTa4t9MzuQyLzm98Qal50rEDfyVC+h/rZXaQcfORtrwrW0NPhy3bI=
X-Received: by 2002:a19:f50d:: with SMTP id j13-v6mr18790925lfb.127.1534424499047;
 Thu, 16 Aug 2018 06:01:39 -0700 (PDT)
MIME-Version: 1.0
From:   Wang Jian <jianjian.wang1@gmail.com>
Date:   Thu, 16 Aug 2018 21:01:27 +0800
Message-ID: <CAP4sYWUDb8wtNVvgPO+3a5MWoiBGuafQpvG6KR30RWinf36Msw@mail.gmail.com>
Subject: [PATCH 1/1] tap: comment fix
To:     "David S . Miller" <davem@davemloft.net>,
        Jason <jasowang@redhat.com>, girish.moodalbail@oracle.com,
        mst@redhat.com, Willem de Bruijn <willemb@google.com>,
        viro@zeniv.linux.org.uk, wexu@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tap_queue and the "tap_dev" are loosely coupled, not "macvlan_dev".

And I also change one rcu_read_lock's place, seems can reduce rcu
critical section a little.

Signed-off-by: Wang Jian <jianjian.wang1@gmail.com>
---
 drivers/net/tap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index f0f7cd9..e5e5a8e 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -125,7 +125,7 @@ static struct tap_dev *tap_dev_get_rcu(const
struct net_device *dev)

 /*
  * RCU usage:
- * The tap_queue and the macvlan_dev are loosely coupled, the
+ * The tap_queue and the tap_dev are loosely coupled, the
  * pointers from one to the other can only be read while rcu_read_lock
  * or rtnl is held.
  *
@@ -720,8 +720,6 @@ static ssize_t tap_get_user(struct tap_queue *q,
struct msghdr *m,
            __vlan_get_protocol(skb, skb->protocol, &depth) != 0)
                skb_set_network_header(skb, depth);

-       rcu_read_lock();
-       tap = rcu_dereference(q->tap);
        /* copy skb_ubuf_info for callback when skb has no error */
        if (zerocopy) {
                skb_shinfo(skb)->destructor_arg = m->msg_control;
@@ -732,6 +730,8 @@ static ssize_t tap_get_user(struct tap_queue *q,
struct msghdr *m,
                uarg->callback(uarg, false);
        }

+       rcu_read_lock();
+       tap = rcu_dereference(q->tap);
        if (tap) {
                skb->dev = tap->dev;
                dev_queue_xmit(skb);

-- 
Regards,
Wang Jian
