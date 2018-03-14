Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeCNR0U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:26:20 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35755 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbeCNR0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:26:17 -0400
X-Google-Smtp-Source: AG47ELvzsWogZcMiPIQP+s+a4dSyeYWetnAmdaUZL5EsNk8mUImr8ApO+ZuzGQejFtaiWq859T6GAA==
From: Sonny Rao <sonnyrao@chromium.org>
To: kvm@vger.kernel.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vhost: add vsock compat ioctl
Date: Wed, 14 Mar 2018 10:26:05 -0700
Message-Id: <20180314172605.130483-1-sonnyrao@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow usage of vsock from 32-bit binaries on a 64-bit
kernel.

Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
---
 drivers/vhost/vsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 0d14e2ff19f16..d0e65e92110e5 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -705,6 +705,7 @@ static const struct file_operations vhost_vsock_fops = {
 	.release        = vhost_vsock_dev_release,
 	.llseek		= noop_llseek,
 	.unlocked_ioctl = vhost_vsock_dev_ioctl,
+	.compat_ioctl   = vhost_vsock_dev_ioctl,
 };
 
 static struct miscdevice vhost_vsock_misc = {
-- 
2.13.5
