Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166066AbeE1PMb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033482AbeE1KXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:23:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Grigor Tovmasyan <tovmasya@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 213/268] usb: dwc2: Fix interval type issue
Date: Mon, 28 May 2018 12:03:07 +0200
Message-Id: <20180528100226.303763640@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Grigor Tovmasyan <Grigor.Tovmasyan@synopsys.com>

[ Upstream commit 12814a3f8f9b247531d7863170cc82b3fe4218fd ]

The maximum value that unsigned char can hold is 255, meanwhile
the maximum value of interval is  2^(bIntervalMax-1)=2^15.

Signed-off-by: Grigor Tovmasyan <tovmasya@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/core.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -187,7 +187,7 @@ struct dwc2_hsotg_ep {
 	unsigned char           dir_in;
 	unsigned char           index;
 	unsigned char           mc;
-	unsigned char           interval;
+	u16                     interval;
 
 	unsigned int            halted:1;
 	unsigned int            periodic:1;
