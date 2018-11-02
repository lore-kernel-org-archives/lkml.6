Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A781EC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2C420831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdxZEOCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2C420831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeKCBO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:14:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45291 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKCBO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:14:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id d135so3787359qkc.12;
        Fri, 02 Nov 2018 09:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZWTqfDdY/i3uglUqiNPkhJL7ZpYMnD30gkQpqwOUGk8=;
        b=IdxZEOCDbbX5eAu4et0jBaQtRLPJQoMrXnhl7LH0P/HHdvvSJbnpK7JGIs+ltYVi+l
         08TA9SAhhdK+B+cPyo112b39fBUWPl78JKP415enz2rL96uLQKNSg2yNJbqo1Eq+E/fD
         2AD84uuQZS227mu1BYyxe0qW5YhO2NTPNSee2kKcyR8ljP60TpxmmvWKCS9zKLkT29sk
         Rs7rCLoDRyo7VAvbRU0zdPVAOJB13wKs5cgjj7WGiaqWXhHP2wJLRb6WAftd0kll08yJ
         xBxF63fdinNglxHrK1uT8l+mETcyh4c6mofj5G/rJ9mVsnhLS0OVOSTeXFFwLfsM621J
         zCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZWTqfDdY/i3uglUqiNPkhJL7ZpYMnD30gkQpqwOUGk8=;
        b=XW6X3uAHE8GRL5GHnBUGOwOpvBdj2N6VEUsQ2c5bPgGYgnbpgOcKPP7Y0Lv7WI9137
         Y6Z9bu7wP3Z/RHkSosn8j9a3yE9rvYGiZlabPkHqYXGRoLlelOz+ssyhRl4FnXC+wcrK
         8Y+QMcpWZW15XvGhlMqYyOb4SiWO2SKpUHGpkNZPsZKi6g4lmga9O2eECQYf9lx+yv7Y
         X9p8B99L8n7AMGWAzXLmzA9LncC3nDArd6wjJmc8wybsBibomPqLRzB+SLYQ7+fiobLx
         ntnQG75797VQgmCrJbTN9J3lHyeMUdpM7jKh83WjiDZYUMWZnKxQiOLTYFWEGXhoLMdO
         hc4w==
X-Gm-Message-State: AGRZ1gJksQqgtfR0KZ+OT+IITEvvesiqhB26u4g7+y5UyxVb+c3KIp64
        XgVh6pUcweLWet8NwrakoN4=
X-Google-Smtp-Source: AJdET5c6MiAZ0MvRhUTqdkEqtlOEV0W9RVpRNTk1+qrqg6Z51zC/hDvh/3H/qLboQk7OEw7nS+x0yw==
X-Received: by 2002:aed:3024:: with SMTP id 33-v6mr11562409qte.29.1541174841134;
        Fri, 02 Nov 2018 09:07:21 -0700 (PDT)
Received: from u1804-ini.default ([76.224.89.164])
        by smtp.googlemail.com with ESMTPSA id j51-v6sm15507254qtj.26.2018.11.02.09.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 09:07:20 -0700 (PDT)
From:   Vitaly Mayatskikh <v.mayatskih@gmail.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitaly Mayatskikh <v.mayatskih@gmail.com>
Subject: [PATCH 0/1] vhost: parallel virtqueue handling
Date:   Fri,  2 Nov 2018 16:07:09 +0000
Message-Id: <20181102160710.3741-1-v.mayatskih@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I stumbled across poor performance of virtio-blk while working on a
high-performance network storage protocol. Moving virtio-blk's host
side to kernel did increase single queue IOPS, but multiqueue disk
still was not scaling well. It turned out that vhost handles events
from all virtio queues in one helper thread, and that's pretty much a
big serialization point.

The following patch enables events handling in per-queue thread and
increases IO concurrency, see IOPS numbers:

# num-queues
# bare metal
# virtio-blk
# vhost-blk

1  171k  148k 195k 
2  328k  249k 349k 
3  479k  179k 501k 
4  622k  143k 620k 
5  755k  136k 737k 
6  887k  131k 830k 
7  1004k 126k 926k 
8  1099k 117k 1001k
9  1194k 115k 1055k
10 1278k 109k 1130k
11 1345k 110k 1119k
12 1411k 104k 1201k
13 1466k 106k 1260k
14 1517k 103k 1296k
15 1552k 102k 1322k
16 1480k 101k 1346k

Vitaly Mayatskikh (1):
  vhost: add per-vq worker thread

 drivers/vhost/vhost.c | 123 +++++++++++++++++++++++++++++++-----------
 drivers/vhost/vhost.h |  11 +++-
 2 files changed, 100 insertions(+), 34 deletions(-)

-- 
2.17.1

