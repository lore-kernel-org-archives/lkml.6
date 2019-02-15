Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BBFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B662192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rXpOhQ/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbfBOOiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:38:07 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38352 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbfBOOiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:38:06 -0500
Received: by mail-vk1-f196.google.com with SMTP id x140so2276502vke.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 06:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJHQ2FurCtuTJLkPxi5192L8GxeFs8MeKxFgyYj0yrw=;
        b=rXpOhQ/gIAFHs2d0uI+saOWjnYBEK0uxH3giP/LGRW4Th6lLuvO0e16PRYYdpIuJ3K
         pETiwX+Nr6gcZKa7rN6M4gd0LSV4e5np5hHm+R7/if4ZCBLUp68QAM0VRLZClJ9wwAfK
         PqeT46Ifl3HWerODkJ2CPyCXRzY4svA4WScg+AAsdB53tj7evLyQTQ7HowWvyNQGiYmt
         08oKI/3bJBcYjgb9niiauqiQFxCXSD18LYt/AUkkNPriBTEmKXnw+3NJN9qiENAMS7BY
         XEW4/7GdYfIUXUoc/pWO8MSXkojIBipcJ4Nv7Mr+GboAW5sK7Np9DdGBoXmTugZc8Ken
         PgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJHQ2FurCtuTJLkPxi5192L8GxeFs8MeKxFgyYj0yrw=;
        b=pqJ4SipjFlZ4K+/FT9XtOp5mCbrFhv20Y8E2MYJY9VdyJqreKuApTrFEnm+K0PgndG
         SD0pfRFea9U7HjZKo4dt9quyy2Jch+x5a24I3Ij8fx1YO2ZdsyIJ3YkCMbDtmf1o+EvR
         GhbEGCm4wgmclXShRP6aR7y06TU40gAHymwZw+uTUfE0QS9K4CKkOBUz8ZqoLfJUKD2u
         IBGnj2DLfgQndlr6u089z5tiLNRDORM/zXO3rEvwwisW93DjmmaDCYimm3qjkKIpsyCZ
         HpQ8QvcUVPnCyiC3Bbtievc55zbsr9jK9KVXHIo28lqDd73z8JsRPelx+92fTWp37DPX
         PMHw==
X-Gm-Message-State: AHQUAuZSALD+LFMFzQs3RgFO3df59qZ4wQiHyArHLwfzmfDxRox3yrV2
        j4fUPn6uyKLUNsJin7JIMCWnrEfAGXczhattg4G+YQ==
X-Google-Smtp-Source: AHgI3IYOjqbeh/mb9Fc0L8YtynZD5nNnHKa+dT8Mt+L2Wgm4TRmq7yPMRj03NRT0fGlfYlSKtSidI/C2q1o76UGHims=
X-Received: by 2002:a1f:9042:: with SMTP id s63mr4966461vkd.17.1550241484954;
 Fri, 15 Feb 2019 06:38:04 -0800 (PST)
MIME-Version: 1.0
References: <5510642.nRbR3bcduN@aspire.rjw.lan> <9351473.C2nPJoyFsE@aspire.rjw.lan>
 <2ed95b05-317c-59bb-498a-b5481e54bcf6@nvidia.com>
In-Reply-To: <2ed95b05-317c-59bb-498a-b5481e54bcf6@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Feb 2019 15:37:28 +0100
Message-ID: <CAPDyKFoAtviRYuFxJLNrD_J0bGbMTca3O8EN8THg6+d3BNq3vQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] driver core: Fix possible supplier PM-usage counter imbalance
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 at 12:00, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> Hi Rafael,
>
> On 12/02/2019 12:08, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If a stateless device link to a certain supplier with
> > DL_FLAG_PM_RUNTIME set in the flags is added and then removed by the
> > consumer driver's probe callback, the supplier's PM-runtime usage
> > counter will be nonzero after that which effectively causes the
> > supplier to remain "always on" going forward.
> >
> > Namely, device_link_add() called to add the link invokes
> > device_link_rpm_prepare() which notices that the consumer driver is
> > probing, so it increments the supplier's PM-runtime usage counter
> > with the assumption that the link will stay around until
> > pm_runtime_put_suppliers() is called by driver_probe_device(),
> > but if the link goes away before that point, the supplier's
> > PM-runtime usage counter will remain nonzero.
> >
> > To prevent that from happening, first rework pm_runtime_get_suppliers()
> > and pm_runtime_put_suppliers() to use the rpm_active refounts of device
> > links and make the latter only drop rpm_active and the supplier's
> > PM-runtime usage counter for each link by one, unless rpm_active is
> > one already for it.  Next, modify device_link_add() to bump up the
> > new link's rpm_active refcount and the suppliers PM-runtime usage
> > counter by two, to prevent pm_runtime_put_suppliers(), if it is
> > called subsequently, from suspending the supplier prematurely (in
> > case its PM-runtime usage counter goes down to 0 in there).
> >
> > Due to the way rpm_put_suppliers() works, this change does not
> > affect runtime suspend of the consumer ends of new device links (or,
> > generally, device links for which DL_FLAG_PM_RUNTIME has just been
> > set).
> >
> > Fixes: e2f3cd831a28 ("driver core: Fix handling of runtime PM flags in device_link_add()")
> > Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Note that the issue had been there before commit e2f3cd831a28, but it was
> > overlooked by that commit and this change is a fix on top of it, so make
> > the Fixes: tag point to commit e2f3cd831a28 (instead of an earlier one
> > that the patch will not be applicable to).
> I noticed that yesterday's and today's -next were no longer booting on
> one of our Tegra boards (Tegra210 Jetson TX2) because networking is
> failing. The ethernet chip is a USB device and looking at the bootlogs I
> can see that the Tegra XHCI driver is failing ...
>
>  tegra-xusb 70090000.usb: xHCI host controller not responding, assume dead
>  tegra-xusb 70090000.usb: HC died; cleaning up
>
> The Tegra XHCI driver uses multiple power-domains and uses
> device_link_add() to attach them. So now I am wondering if there is
> something that we have got wrong in our implementation. However, I don't
> see the device being probed deferred on boot or anything like that.
>
> The driver in question is drivers/usb/host/xhci-tegra.c and we add the
> links in the function tegra_xusb_powerdomain_init() which is before RPM
> is enabled. Let me know if you have any thoughts.

If you are willing to help debugging then I am offering my assistance.

I would start by enabling CONFIG_PM_ADVANCED_DEBUG, which gives you
some more information about the runtime PM state of the device, like
the usage count for example.
I would also add a couple of prints in
tegra_xusb_runtime_suspend|resume() and in the ->power_on|off()
callbacks for the corresponding genpds, to see when those gets called.

While I was testing $subject patch I also used a local debug patch,
which adds a sysfs node that can be used to get the state of linked
suppliers for a consumer device. Feel free to use it, attached below.

Of course, the interesting part is the comparison of what happens with
and without $subject patch.

From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 Feb 2019 15:37:44 +0100
Subject: [PATCH] PM / Runtime: Add sysfs for runtime counting of suppliers

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/sysfs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index d713738ce796..ce5c188cdf54 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -537,6 +537,25 @@ static ssize_t runtime_enabled_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(runtime_enabled);

+static ssize_t runtime_suppliers_show(struct device *dev,
+                                 struct device_attribute *attr, char *buf)
+{
+       struct device_link *link;
+       int chars = 0;
+
+       list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
+
+               if (!(link->flags & DL_FLAG_PM_RUNTIME))
+                       continue;
+
+               chars += sprintf(buf + chars, "%s %d\n",
+                               dev_name(link->supplier),
+                               refcount_read(&link->rpm_active));
+       }
+       return chars;
+}
+static DEVICE_ATTR_RO(runtime_suppliers);
+
 #ifdef CONFIG_PM_SLEEP
 static ssize_t async_show(struct device *dev, struct device_attribute *attr,
                          char *buf)
@@ -572,6 +591,7 @@ static struct attribute *power_attrs[] = {
        &dev_attr_runtime_usage.attr,
        &dev_attr_runtime_active_kids.attr,
        &dev_attr_runtime_enabled.attr,
+       &dev_attr_runtime_suppliers.attr,
 #endif /* CONFIG_PM_ADVANCED_DEBUG */
        NULL,
 };
-- 
2.17.1

Kind regards
Uffe
