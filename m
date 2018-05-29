Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033539AbeE2C6T (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 22:58:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:7741 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032729AbeE2C6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 22:58:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,454,1520924400";
   d="scan'208";a="44949083"
Date: Tue, 29 May 2018 10:57:19 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Felipe Balbi <balbi@kernel.org>,
        davem@davemloft.net,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [RFC PATCH] usb: gadget: ccid: ccidg_start_ep() can be static
Message-ID: <20180529025719.GA102672@ivb43>
References: <20180526211940.25474-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180526211940.25474-1-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 0760b8dd303b ("usb: gadget: ccid: add support for USB CCID Gadget Device")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 f_ccid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_ccid.c b/drivers/usb/gadget/function/f_ccid.c
index 9ff8615..35b392c 100644
--- a/drivers/usb/gadget/function/f_ccid.c
+++ b/drivers/usb/gadget/function/f_ccid.c
@@ -478,7 +478,7 @@ static void ccidg_function_disable(struct usb_function *f)
 	wake_up(&bulk_dev->read_wq);
 }
 
-int ccidg_start_ep(struct f_ccidg *ccidg, struct usb_function *f,
+static int ccidg_start_ep(struct f_ccidg *ccidg, struct usb_function *f,
 			struct usb_ep *ep)
 {
 	struct usb_composite_dev *cdev = f->config->cdev;
