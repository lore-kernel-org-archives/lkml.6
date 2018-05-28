Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933776AbeE1KHy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933456AbeE1KHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:07:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Opasiak <k.opasiak@samsung.com>,
        John Keeping <john@metanate.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 051/185] usb: gadget: f_uac2: fix bFirstInterface in composite gadget
Date: Mon, 28 May 2018 12:01:32 +0200
Message-Id: <20180528100055.233358702@linuxfoundation.org>
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

From: John Keeping <john@metanate.com>

[ Upstream commit 8813a59ed892305b5ac1b5b901740b1ad4b5fefa ]

If there are multiple functions associated with a configuration, then
the UAC2 interfaces may not start at zero.  Set the correct first
interface number in the association descriptor so that the audio
interfaces are enumerated correctly in this case.

Reviewed-by: Krzysztof Opasiak <k.opasiak@samsung.com>
Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_uac2.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -1029,6 +1029,8 @@ afunc_bind(struct usb_configuration *cfg
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 		return ret;
 	}
+	iad_desc.bFirstInterface = ret;
+
 	std_ac_if_desc.bInterfaceNumber = ret;
 	agdev->ac_intf = ret;
 	agdev->ac_alt = 0;
