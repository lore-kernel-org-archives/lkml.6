Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936471AbeE1KKR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933629AbeE1KKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:10:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 072/185] media: dmxdev: fix error code for invalid ioctls
Date: Mon, 28 May 2018 12:01:53 +0200
Message-Id: <20180528100056.912837070@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

[ Upstream commit a145f64c6107d3aa5a7cec9f8977d04ac2a896c9 ]

Returning -EINVAL when an ioctl is not implemented is a very
bad idea, as it is hard to distinguish from other error
contitions that an ioctl could lead. Replace it by its
right error code: -ENOTTY.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-core/dmxdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/dvb-core/dmxdev.c
+++ b/drivers/media/dvb-core/dmxdev.c
@@ -1069,7 +1069,7 @@ static int dvb_demux_do_ioctl(struct fil
 		break;
 
 	default:
-		ret = -EINVAL;
+		ret = -ENOTTY;
 		break;
 	}
 	mutex_unlock(&dmxdev->mutex);
