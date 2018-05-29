Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934733AbeE2NMQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:12:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55360 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934083AbeE2NLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:11:01 -0400
X-Google-Smtp-Source: AB8JxZp2e6bGBzu/LWBeo9cjXzWCIkgHVKtY7I48IRg4/rMFKjoDctJnF6vY4X24+rpl14ypOTiBDw==
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 17/19] serdev: Mark controllers compatible with ttyport
Date: Tue, 29 May 2018 15:10:12 +0200
Message-Id: <20180529131014.18641-18-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to treat differently this controllers, by creating a tty
compatibility layer.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/serdev-ttyport.c | 1 +
 include/linux/serdev.h              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 4acc5f41dc67..ae961260e4a4 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -276,6 +276,7 @@ struct device *serdev_tty_port_register(struct tty_port *port,
 	serport->tty_drv = drv;
 
 	ctrl->ops = &ctrl_ops;
+	ctrl->is_ttyport = true;
 
 	old_ops = port->client_ops;
 	port->client_ops = &client_ops;
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index bb3b9599c652..07d63933bdb9 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -116,6 +116,7 @@ struct serdev_controller {
 	unsigned int		nr;
 	struct serdev_device	*serdev;
 	const struct serdev_controller_ops *ops;
+	bool			is_ttyport;
 };
 
 static inline struct serdev_controller *to_serdev_controller(struct device *d)
-- 
2.17.0
