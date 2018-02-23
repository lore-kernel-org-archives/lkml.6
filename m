Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227Kw1khq8QVDn9hMWBWRqEhGI2GLUx8e8KfZlZJyokFKGcvp3KyM+tM2yiXl1FT66ZGXozT
ARC-Seal: i=1; a=rsa-sha256; t=1519410840; cv=none;
        d=google.com; s=arc-20160816;
        b=GIgLoiEmcIU+bVxew9Xie9vZfyDu68ANiduoZNIpV+mTBu7/Jtns+REEELMd3hBBrS
         wP4kWlA+L4KDsqwQfpxyAI6rNyE8zJRkXaRylbbqjL8tt4UcZ/hVYWFVyva89EwKUU2H
         Gz3bz9L/yhoi1lbR0kEYQ0+oUzWlTEBdDSHbgPrUWqKIDc3NGnfuh2YuF3O7SE8Fu8ru
         FIJ1NLNibc8lntb4z65Z18Ac+dU+h2wT9RieOMBmGgs8dMRGT5bQKz/3p5llu9D5+8LV
         zaIJISV1NbnfAvwUSL6smCX+nXT4/v1hX9XPYaHFqUQW9CUwboPyPkDO8VENLgR36Dmj
         y04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gyGhAW3OenUyqHFL9mK+0NAmpkNu8rTFrurti50tG9c=;
        b=zU62b/Lml3f8rq/YdGBHE0jO8l4XzlYU9sDc3XXCJt1qZpdFcSMnS5lx+SEmM0vifA
         yq7CxpxOhMkqdxIiy6UKGTpqlsHPpI0AYOC9yBNceb4C05JvyJxBf8xvYq9U70nK2gFu
         qLospM5zVcVrl4BKVrluU/IuL+VU3AXEZ2tcvmcEaxo9yeXPIFCDB0+h4pQScMgnO6NU
         emWZJhFWlwebSFyYqhT2b69O6E2w5xuKsStKfd8z6xXbFO+J8ylKIMXWigDef6Y89wcI
         JGSj87qs6OLrs3HkC3WQywqFWOEIKDLSOPtEcmROjr9jZG1jinWhMZmoR5ACApPIKxw9
         691Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 030/193] usb: build drivers/usb/common/ when USB_SUPPORT is set
Date: Fri, 23 Feb 2018 19:24:23 +0100
Message-Id: <20180223170330.781043957@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217575098453397?=
X-GMAIL-MSGID: =?utf-8?q?1593217741348168718?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>


[ Upstream commit c9d24f78268be444e803fb2bb138a2f598de9c23 ]

PHY drivers can use ULPI interfaces when CONFIG_USB (which is host side
support) is not enabled, so also build drivers/usb/ when CONFIG_USB_SUPPORT
is enabled so that drivers/usb/common/ is built.

ERROR: "ulpi_unregister_driver" [drivers/phy/ti/phy-tusb1210.ko] undefined!
ERROR: "__ulpi_register_driver" [drivers/phy/ti/phy-tusb1210.ko] undefined!
ERROR: "ulpi_read" [drivers/phy/ti/phy-tusb1210.ko] undefined!
ERROR: "ulpi_write" [drivers/phy/ti/phy-tusb1210.ko] undefined!
ERROR: "ulpi_unregister_driver" [drivers/phy/qualcomm/phy-qcom-usb-hs.ko] undefined!
ERROR: "__ulpi_register_driver" [drivers/phy/qualcomm/phy-qcom-usb-hs.ko] undefined!
ERROR: "ulpi_write" [drivers/phy/qualcomm/phy-qcom-usb-hs.ko] undefined!

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_TC)		+= tc/
 obj-$(CONFIG_UWB)		+= uwb/
 obj-$(CONFIG_USB_PHY)		+= usb/
 obj-$(CONFIG_USB)		+= usb/
+obj-$(CONFIG_USB_SUPPORT)	+= usb/
 obj-$(CONFIG_PCI)		+= usb/
 obj-$(CONFIG_USB_GADGET)	+= usb/
 obj-$(CONFIG_OF)		+= usb/
