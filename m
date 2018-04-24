Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524591077; cv=none;
        d=google.com; s=arc-20160816;
        b=LbjvS5UNmb2jCNN3Kb2cVMHnEsSU5uKGbWwN4RiOAFdD/lx6Z5WTnWI19b4IqSK4Wq
         0R1iHij/vIK/5aGbEOv/MkbvvSYIEkDnqvUyMKR4P7izHMxeRCmVbQfZVFbtz7b+OcRr
         avxxPW03Gusu2o9goYzjf1De13TsPHzMLl50ZLMdNdQTJWxWvRzGZDH77Cae6G8l28Dm
         lZxSDU6Q4uPiKLce4W75Wd9vkwlodM0AzAReruSB9Y6zDez6JHEaX1cyOhTf9oQS8ha6
         jegdMPmat86QmKu2zPlH/aQ9b9sCWVY0n1yPl5Zml1VLACbpY0M+Sjch3WarhZGBV0eF
         zFzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=rOhxYnOz8qoV04RE1s5FyrBNURNK0WGZd6JfAutNZLU=;
        b=S9YYjGbExhUVr0n3vbC8zLr3lMTf1tzyzItESI6XLPxs1jPxB5w4XNEw2d48SmzMjd
         4xeF1kAP2J/jUYiQh7DGk8FFqb7JW07aJQPipAH/oxX1/t2tLlsoRJ+IaQfleQHL+w99
         BN7Xm19WhFyBNMj4tyJ8rRmfEufKxCgJALhuadtNFliu/cNnNynZyN16dpTzhmIBKgeI
         5JIt9tsQaMSRdSDblmZda9fYhYlJhxN1FXYS33U07ob59toYz4utIYImUtgL7NGTQ/Ce
         sKeZEpcJ7sdhu09IwivlCOw2wz8sOSt30ykbkbFU9UKXe24OX5f9UJFAdlV0IiahGk4s
         jQWw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=DkWmcWHq;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=DkWmcWHq;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AB8JxZphaoSCFtIZ0Rj9JpfCat/B9bqFYu99L1yvfR1uqUDee1aCerSXgxp1OP4ZaQbkhlT4iFcZoA==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arend van Spriel <aspriel@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Michal Suchanek <msuchanek@suse.de>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 04/11] of: platform: use pdev as name for vars of type struct platform_device
Date: Tue, 24 Apr 2018 19:30:44 +0200
Message-Id: <20180424173051.15099-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598649613043968033?=
X-GMAIL-MSGID: =?utf-8?q?1598649613043968033?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

It's a good convention to name struct device local variables 'dev'
and reserve 'pdev' for struct platform_device. Otherwise the code
sometimes becomes confusing to read. Rename all such instances in
of/platform.c

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/of/platform.c | 50 +++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index c00d81dfac0b..60342209fbd8 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -109,12 +109,12 @@ struct platform_device *of_device_alloc(struct device_node *np,
 				  const char *bus_id,
 				  struct device *parent)
 {
-	struct platform_device *dev;
+	struct platform_device *pdev;
 	int rc, i, num_reg = 0, num_irq;
 	struct resource *res, temp_res;
 
-	dev = platform_device_alloc("", PLATFORM_DEVID_NONE);
-	if (!dev)
+	pdev = platform_device_alloc("", PLATFORM_DEVID_NONE);
+	if (!pdev)
 		return NULL;
 
 	/* count the io and irq resources */
@@ -126,12 +126,12 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	if (num_irq || num_reg) {
 		res = kzalloc(sizeof(*res) * (num_irq + num_reg), GFP_KERNEL);
 		if (!res) {
-			platform_device_put(dev);
+			platform_device_put(pdev);
 			return NULL;
 		}
 
-		dev->num_resources = num_reg + num_irq;
-		dev->resource = res;
+		pdev->num_resources = num_reg + num_irq;
+		pdev->resource = res;
 		for (i = 0; i < num_reg; i++, res++) {
 			rc = of_address_to_resource(np, i, res);
 			WARN_ON(rc);
@@ -141,16 +141,16 @@ struct platform_device *of_device_alloc(struct device_node *np,
 				 np->name);
 	}
 
-	dev->dev.of_node = of_node_get(np);
-	dev->dev.fwnode = &np->fwnode;
-	dev->dev.parent = parent ? : &platform_bus;
+	pdev->dev.of_node = of_node_get(np);
+	pdev->dev.fwnode = &np->fwnode;
+	pdev->dev.parent = parent ? : &platform_bus;
 
 	if (bus_id)
-		dev_set_name(&dev->dev, "%s", bus_id);
+		dev_set_name(&pdev->dev, "%s", bus_id);
 	else
-		of_device_make_bus_id(&dev->dev);
+		of_device_make_bus_id(&pdev->dev);
 
-	return dev;
+	return pdev;
 }
 EXPORT_SYMBOL(of_device_alloc);
 
@@ -170,26 +170,26 @@ static struct platform_device *of_platform_device_create_pdata(
 					void *platform_data,
 					struct device *parent)
 {
-	struct platform_device *dev;
+	struct platform_device *pdev;
 
 	if (!of_device_is_available(np) ||
 	    of_node_test_and_set_flag(np, OF_POPULATED))
 		return NULL;
 
-	dev = of_device_alloc(np, bus_id, parent);
-	if (!dev)
+	pdev = of_device_alloc(np, bus_id, parent);
+	if (!pdev)
 		goto err_clear_flag;
 
-	dev->dev.bus = &platform_bus_type;
-	dev->dev.platform_data = platform_data;
-	of_msi_configure(&dev->dev, dev->dev.of_node);
+	pdev->dev.bus = &platform_bus_type;
+	pdev->dev.platform_data = platform_data;
+	of_msi_configure(&pdev->dev, pdev->dev.of_node);
 
-	if (of_device_add(dev) != 0) {
-		platform_device_put(dev);
+	if (of_device_add(pdev) != 0) {
+		platform_device_put(pdev);
 		goto err_clear_flag;
 	}
 
-	return dev;
+	return pdev;
 
 err_clear_flag:
 	of_node_clear_flag(np, OF_POPULATED);
@@ -344,7 +344,7 @@ static int of_platform_bus_create(struct device_node *bus,
 {
 	const struct of_dev_auxdata *auxdata;
 	struct device_node *child;
-	struct platform_device *dev;
+	struct platform_device *pdev;
 	const char *bus_id = NULL;
 	void *platform_data = NULL;
 	int rc = 0;
@@ -377,13 +377,13 @@ static int of_platform_bus_create(struct device_node *bus,
 		return 0;
 	}
 
-	dev = of_platform_device_create_pdata(bus, bus_id, platform_data, parent);
-	if (!dev || !of_match_node(matches, bus))
+	pdev = of_platform_device_create_pdata(bus, bus_id, platform_data, parent);
+	if (!pdev || !of_match_node(matches, bus))
 		return 0;
 
 	for_each_child_of_node(bus, child) {
 		pr_debug("   create child: %pOF\n", child);
-		rc = of_platform_bus_create(child, matches, lookup, &dev->dev, strict);
+		rc = of_platform_bus_create(child, matches, lookup, &pdev->dev, strict);
 		if (rc) {
 			of_node_put(child);
 			break;
-- 
2.17.0
