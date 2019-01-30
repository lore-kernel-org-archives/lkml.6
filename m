Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C6AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15AC121848
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6BvxeSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfA3CQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:16:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46863 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfA3CQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:16:43 -0500
Received: by mail-qt1-f193.google.com with SMTP id y20so24605458qtm.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 18:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kVeK2UYY64OtAaLVdJw3/+jH5KxxkNwDEq/USDWjX2w=;
        b=W6BvxeSIPx93Rii/lcRJWVtL80InLzKRXG4Pbwvy+6LfeGeimifsaGnA3Q7Y5axhx8
         Saiz05RabqdZrYbHJzfiCAA5CfQTUtYNNVZn8Xd5sKY6AftaZ+I6MZDazlcVLQlSDh6E
         51R1K/5S1C/ybZxLVU1bpMWUcmirH1b+AOXbmubGqLAe7i0/iiusILxzPGN2X0mVvaFk
         zXRdV62yjjsDi5ZEAUGnZu+Clk6DLNLQ2243u7NhIWyKIb0v5hPqAZnrh8K37DJdDoRu
         RKt4ZN2s2hY81vhE08RQNrLv5iaBQhmU9w0LqTuh5OqYgMxALkapX1dTDoWNP7P4duxG
         1PhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kVeK2UYY64OtAaLVdJw3/+jH5KxxkNwDEq/USDWjX2w=;
        b=po1zsFm6iG762wJ0cq+QhdpWBR+Ozn/pw8SzQqZf9bL0N1aPvyK9TJOrWzvpX5hCvN
         OepS54aCwcq4ELPRtxhtCpJ/uOkQzUA5fR/gkvE1fYMO1GWnqe05mrH8jGh6Oj4V/ltU
         KWXP8RExb8OwssuxhUTGfE6oha5KaDEJw7u4zFuRr+LUSAwtgIuYtrbLNhWjCOuun9eF
         Y1ad/KRWwSABkm4M96k6TWWXiGsQoKFH2zzrrk/NyzaQlr3IvB7S1ivOwl4xr6Ak3Poi
         OMR1+JcGoyas6Z+7oZjShwnc8W5Jal0eCJlkLVpWHeX3s2Zh8FLG34taRBPR7kEcQ3d5
         Vw2g==
X-Gm-Message-State: AJcUukc/K4IxwIV+YifUxKBtqLauFtaAXrFLXzXzTq+9ADB0eD10TCbZ
        wrl+LWWdfQfo+TnPMYIT9/HO2Tgu
X-Google-Smtp-Source: ALg8bN5MEgD/RjNEh05W8ubStgoMtzKZMjJw4i9gSawIluJvqXeYPcgBXyanl12pG6sY0es1ixhh5Q==
X-Received: by 2002:ac8:90c:: with SMTP id t12mr27727704qth.335.1548814602133;
        Tue, 29 Jan 2019 18:16:42 -0800 (PST)
Received: from x3200.lan ([2601:152:4302:ae1f::16e])
        by smtp.gmail.com with ESMTPSA id c48sm370394qtd.9.2019.01.29.18.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 18:16:41 -0800 (PST)
From:   George Amanakis <gamanakis@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     sdf@google.com, George Amanakis <gamanakis@gmail.com>
Subject: BUG: vnet0 selects TX queue 11, but real number of TX queues is 11
Date:   Tue, 29 Jan 2019 21:16:21 -0500
Message-Id: <20190130021621.17250-1-gamanakis@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 4.20.4 when running a KVM with vhost_net I am seeing in dmesg:
vnet0 selects TX queue 11, but real number of TX queues is 11

The corresponding part in the xml definition of the virtual machine is:
-------8<-------
<interface type='bridge'>
  <mac address='xx:xx:xx:xx:xx:xx'/>
  <source bridge='br0'/>
  <model type='virtio'/>
  <driver name='vhost' queues='12'>
  </driver>
  <address type='pci' domain='0x0000' bus='0x01' slot='0x00' function='0x0'/>
</interface>
-------8<-------

Doing a git-bisect with 4.20.3 last known good, and 4.20.4 as bad, this
commit turned up:
-------8<-------
commit 9ff0436e2c3575ffe64d359fb3b67aee237dc519
Author: Stanislav Fomichev <sdf@google.com>
Date:   Mon Jan 7 13:38:38 2019 -0800

    tun: publish tfile after it's fully initialized

    [ Upstream commit 0b7959b6257322f7693b08a459c505d4938646f2 ]

    BUG: unable to handle kernel NULL pointer dereference at
00000000000000d1
-------8<-------


Applying the following patch corrects it in 4.20.5. Would this be the
correct thing to do?
---
 drivers/net/tun.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 6658658246d2..e0dc004c6483 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -862,8 +862,6 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 	if (rtnl_dereference(tun->xdp_prog))
 		sock_set_flag(&tfile->sk, SOCK_XDP);
 
-	tun_set_real_num_queues(tun);
-
 	/* device is allowed to go away first, so no need to hold extra
 	 * refcnt.
 	 */
@@ -875,6 +873,9 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 	rcu_assign_pointer(tfile->tun, tun);
 	rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
 	tun->numqueues++;
+
+	tun_set_real_num_queues(tun);
+
 out:
 	return err;
 }
-- 
2.20.1

