Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D185CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C26421773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfBLIsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:48:37 -0500
Received: from mout.gmx.net ([212.227.15.15]:37213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbfBLIsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:48:37 -0500
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx001 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0MTSKd-1gU11q46Yp-00SO7U; Tue, 12 Feb 2019 09:48:34 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     gregkh@linuxfoundation.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH 2/2] chardev: showing minor range for chardev in the output of /proc/devices
Date:   Tue, 12 Feb 2019 16:47:39 +0800
Message-Id: <20190212084739.27602-2-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212084739.27602-1-cgxu519@gmx.com>
References: <20190212084739.27602-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZMFh0MXWjreN8cG/ZjyXA9hEVUevxgbiwYnBuoIAixfDhckumx1
 8Dru50++FFhCehRSdp2XdsC+JF8JDzTeZJt8R61cQeziQDUL38vYnDtrTOkdcBB3VtO6BUY
 k3G5lOAAhwRRCNmcRao3JzDTE08ZU2piNu6rlwMIVCwp4wWU8DTXwkttiL7AvIJ/nx35egT
 C2pfPUXzyNK6qOypktZTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:phu/BBAeqFo=:RVY833ZpIkFbD4/MQgaz3I
 Igo4zHrWAZLFiBjH98t7L61mFbNqx82yafcp3A+cf4kqgXvgYqpuxLmvFuCWv7c7oL8fJAv2U
 1mhQPYRuVWWI1aKRgJNjS+0jZ9ZPXUxXZNH2U0vQJaLLPK5OzlIHfLgjCKMJVW3RM9lwQMxGR
 RcW/o7EnzIBe7z/06ceDZ5zAdXXE/yhmbAtFCX5e87jLCNX1RoQdwFC/ydLcn/9n+I01OMiiN
 N+5rSALGz/JCsxWex/IgN5J1BAduV3GsHDUXwvp9/8rY4nWLnbGYhG9YVR5ldROYBdlc5HypH
 7AX3iK2E0NDKvjhGU0Tkmft7dEx3J3wewHd+CZu4NV+dvzrnESCh7orNhW5UfFZr/iQB5cKbD
 sETx19mthLOHEp7QgKl0citziK1Tekhgtw2mGmgPy8DvFcVOdbM7hug4X037cN/hXnrosfGlG
 IP5r0hYv8W3o0Es6t0KaWicfdNI6hp1Efm2hjYLCUHVuQIrLpyMD8+x9uXlxondYfsWXk5B75
 N2OMQ/7vckFSqk4WLiSqjTrnb8fwCWBYwsb2hV/xyBB5L9cSjpAmfkHVm0rXqpjWwKLafpEB/
 KclsoeWpO1yqmbIKt+mh5cZeYWUykiXbCblJA5BC5Pl2Wvr2J7a43/ek/4AcGUOIY8rBVT6n0
 o5oexMM6yOa4arNeSsgJkuqnjRA1Jp2gnuWtF/V3MYIM2YyFkTA7Ajbk7ud6P9FJdbaWNYplm
 LZVZLVh73vyukSKZXCNIAS4pv56fqsHPZE9bfey1fMAav/SBB5++m5PZoRupG+lrrU2n5MpwH
 4KJKekni4zZT05eq7znWDUz4xV1uMfXGHRQXM0ZM0u6NnsBBw100DqvtfGgfXG3yGDZAEIo8q
 QWqCMF+AdDWV6eKCN/5WR44qlYOVDPRlw669cF0/9sWUKq9qSlj3irY+r7IqDy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently chardev allows to share major, showing
major with minor range for chardev will be more
helpful.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/char_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index b25b1da097d5..6f00acdeb308 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -55,7 +55,9 @@ void chrdev_show(struct seq_file *f, off_t offset)
 	mutex_lock(&chrdevs_lock);
 	for (cd = chrdevs[major_to_index(offset)]; cd; cd = cd->next) {
 		if (cd->major == offset)
-			seq_printf(f, "%3d %s\n", cd->major, cd->name);
+			seq_printf(f, "%3d %s (%u-%u)\n", cd->major, cd->name,
+				   cd->baseminor,
+				   cd->baseminor + cd->minorct - 1);
 	}
 	mutex_unlock(&chrdevs_lock);
 }
-- 
2.20.1

