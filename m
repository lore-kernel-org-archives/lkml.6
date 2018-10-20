Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D45ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 00:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E389A20843
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 00:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E389A20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJTIqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 04:46:43 -0400
Received: from muru.com ([72.249.23.125]:52520 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbeJTIqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 04:46:42 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9FCAD80BF;
        Sat, 20 Oct 2018 00:38:13 +0000 (UTC)
Date:   Fri, 19 Oct 2018 17:38:12 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net,
        merlijn@wizzup.org
Subject: Re: omap4: support for manually updated display
Message-ID: <20181020003812.GE43338@atomide.com>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
 <3205865.8O8aibZXye@avalon>
 <20180910174453.GV5662@atomide.com>
 <20181018221549.GB6364@amd>
 <20181019164450.GD43338@atomide.com>
 <20181019225827.s76wapp3cxrmp5af@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019225827.s76wapp3cxrmp5af@earth.universe>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [181019 15:58]:
> I uploaded my current status here. It's not based on the newest
> -next, but contains the interesting patches from Laurent. Also
> the last few patches are not yet cleaned up, sorry for the mess.

Way to go, thanks :) Here's a quick fix for issues with loading
and unloading modules, seems like this should be fixed somewhere
else though?

Regards,

Tony

8< -----------------------
Unload of hdmi:

Unable to handle kernel NULL pointer dereference at virtual address 00000278
(hdmi_runtime_resume [omapdss]) from [<c060d944>] (__rpm_callback+0x144/0x1d8)
(__rpm_callback) from [<c060d9f8>] (rpm_callback+0x20/0x80)
(rpm_callback) from [<c060d580>] (rpm_resume+0x60c/0x828)
(rpm_resume) from [<c060d7e8>] (__pm_runtime_resume+0x4c/0x64)
(__pm_runtime_resume) from [<c06027ac>] (device_release_driver_internal+0x130/0x234)
(device_release_driver_internal) from [<c06028f4>] (driver_detach+0x38/0x6c)
(driver_detach) from [<c0601658>] (bus_remove_driver+0x4c/0xa4)
(bus_remove_driver) from [<c06041fc>] (platform_unregister_drivers+0x20/0x2c)
(platform_unregister_drivers) from [<c01f0ef8>] (sys_delete_module+0x1c0/0x230)
(sys_delete_module) from [<c0101000>] (ret_fast_syscall+0x0/0x28)


Unload of dsi:

Unable to handle kernel NULL pointer dereference at virtual address 00000278
(dsi_runtime_resume [omapdss]) from [<c060d944>] (__rpm_callback+0x144/0x1d8)
(__rpm_callback) from [<c060d9f8>] (rpm_callback+0x20/0x80)
(rpm_callback) from [<c060d580>] (rpm_resume+0x60c/0x828)
(rpm_resume) from [<c060d7e8>] (__pm_runtime_resume+0x4c/0x64)
(__pm_runtime_resume) from [<c0602364>] (driver_probe_device+0x38/0x164)
(driver_probe_device) from [<c0602574>] (__driver_attach+0xe4/0xe8)
(__driver_attach) from [<c0600418>] (bus_for_each_dev+0x70/0xb4)
(bus_for_each_dev) from [<c06015a8>] (bus_add_driver+0x198/0x1fc)
(bus_add_driver) from [<c06032ec>] (driver_register+0x74/0x108)
(driver_register) from [<c0102fe4>] (do_one_initcall+0x80/0x31c)
(do_one_initcall) from [<c01f0fc4>] (do_init_module+0x5c/0x1f8)
(do_init_module) from [<c01f2e0c>] (load_module+0x1360/0x16c0)
(load_module) from [<c01f33d4>] (sys_finit_module+0xbc/0xdc)
(sys_finit_module) from [<c0101000>] (ret_fast_syscall+0x0/0x28)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -5484,6 +5484,9 @@ static int dsi_runtime_resume(struct device *dev)
 	struct dsi_data *dsi = dev_get_drvdata(dev);
 	int r;
 
+	if (!dsi || !dsi->dss || !dsi->dss->dispc)
+		return -ENODEV;
+
 	r = dispc_runtime_get(dsi->dss->dispc);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -847,6 +847,9 @@ static int hdmi_runtime_resume(struct device *dev)
 	struct omap_hdmi *hdmi = dev_get_drvdata(dev);
 	int r;
 
+	if (!hdmi || !hdmi->dss || !hdmi->dss->dispc)
+		return -ENODEV;
+
 	r = dispc_runtime_get(hdmi->dss->dispc);
 	if (r < 0)
 		return r;
-- 
2.19.1
