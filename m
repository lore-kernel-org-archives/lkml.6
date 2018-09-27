Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D17C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F44216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="b7AvRdV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F44216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeI1ATd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:19:33 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17993 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbeI1ATc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:19:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bad1a7c0003>; Thu, 27 Sep 2018 10:59:24 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 27 Sep 2018 11:00:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 27 Sep 2018 11:00:05 -0700
Received: from [10.26.11.251] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 27 Sep
 2018 18:00:03 +0000
Subject: Re: [PATCH 4.14 49/64] drm/atomic: Use drm_drv_uses_atomic_modeset()
 for debugfs creation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <stable@vger.kernel.org>, Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20180927090249.801943776@linuxfoundation.org>
 <20180927090256.844688689@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <222254a2-b33c-f6d3-8bc0-0069c5c0a55c@nvidia.com>
Date:   Thu, 27 Sep 2018 19:00:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927090256.844688689@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538071164; bh=zcb/DQHKTqk4pjjrc0H/VcITx3f9lUaJCNanUJZoGkg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=b7AvRdV2K/Y4XU3Js9Xk94GDHFWnE0eNKQC8TtSB3l9GafWhQD61wPy3RvdscQKPw
         0pR+iuFGwfDCWSGcrAi6m7mwRCEmHkwXqQq/22mPFb8CIhhv+xcwfVATF5kj7Cy5LB
         vcDBtLTBlIPSLQKRNJZ+zt+4DNet1N22Lma/gTPMfSnFL9prv6rxZg0KQTn0gag90P
         i0K0v5T95C/IrWfpu0rX0ZTuZwnnC3y8Nv+qy0QAee2MhDRz20+Cx04JpeDNBkV3LY
         f238D2mIZSbuUikI8IFfHnhWTeWThogs4cYDs9cPO7jaGuhlT6t/9OQ2dRPS9uSqZ0
         tDRAMUolijfqg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Lyude,

On 27/09/18 10:04, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Lyude Paul <lyude@redhat.com>
> 
> commit 3c499ea0c662e2f38aafbd4f516b08aab8cfa0e5 upstream.
> 
> As pointed out by Daniel Vetter, we should be usinng
> drm_drv_uses_atomic_modeset() for determining whether or not we want to
> make the debugfs nodes for atomic instead of checking DRIVER_ATOMIC, as
> the former isn't an accurate representation of whether or not the driver
> is actually using atomic modesetting internally (even though it might
> not be exposing atomic capabilities).
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: stable@vger.kernel.org
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> Link: https://patchwork.freedesktop.org/patch/msgid/20180917173733.21293-1-lyude@redhat.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  drivers/gpu/drm/drm_atomic.c  |    2 +-
>  drivers/gpu/drm/drm_debugfs.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1748,7 +1748,7 @@ static void __drm_state_dump(struct drm_
>  	struct drm_connector *connector;
>  	struct drm_connector_list_iter conn_iter;
>  
> -	if (!drm_core_check_feature(dev, DRIVER_ATOMIC))
> +	if (!drm_drv_uses_atomic_modeset(dev))
>  		return;
>  
>  	list_for_each_entry(plane, &config->plane_list, head) {
> --- a/drivers/gpu/drm/drm_debugfs.c
> +++ b/drivers/gpu/drm/drm_debugfs.c
> @@ -150,7 +150,7 @@ int drm_debugfs_init(struct drm_minor *m
>  		return ret;
>  	}
>  
> -	if (drm_core_check_feature(dev, DRIVER_ATOMIC)) {
> +	if (drm_drv_uses_atomic_modeset(dev)) {
>  		ret = drm_atomic_debugfs_init(minor);
>  		if (ret) {
>  			DRM_ERROR("Failed to create atomic debugfs files\n");
> 
> 

This is causing a boot regression on some Tegra devices. For
completeness I have included the stack trace below.

Jon

[    4.115829] Unable to handle kernel NULL pointer dereference at virtual address 00000010
[    4.123912] pgd = c0204000
[    4.126661] [00000010] *pgd=00000000
[    4.130245] Internal error: Oops: 5 [#1] SMP ARM
[    4.134857] Modules linked in:
[    4.137917] CPU: 0 PID: 28 Comm: kworker/0:1 Not tainted 4.14.73-rc1-g1e2fd38 #1
[    4.145301] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[    4.151569] Workqueue: events deferred_probe_work_func
[    4.156704] task: ee0fae00 task.stack: ee1de000
[    4.161235] PC is at drm_debugfs_init+0x88/0x178
[    4.165850] LR is at drm_debugfs_create_files+0xf0/0x148
[    4.171152] pc : [<c0831ccc>]    lr : [<c0831984>]    psr: 60000113
[    4.177410] sp : ee1dfcd0  ip : 00000000  fp : ee1de000
[    4.182625] r10: 00000017  r9 : 00000000  r8 : c163a884
[    4.187841] r7 : 00000080  r6 : 00000000  r5 : ed12b000  r4 : ed15fe00
[    4.194357] r3 : 00000000  r2 : 00000000  r1 : c0831984  r0 : 00000000
[    4.200884] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    4.208013] Control: 10c5387d  Table: 8020406a  DAC: 00000051
[    4.213753] Process kworker/0:1 (pid: 28, stack limit = 0xee1de220)
[    4.220011] Stack: (0xee1dfcd0 to 0xee1e0000)
[    4.224365] fcc0:                                     00383231 ffffffff 014080c0 c0815a14
[    4.232534] fce0: ffffffff 00000000 ffffffff ee452858 00000004 c04591c4 ee452848 00000000
[    4.240702] fd00: 00000004 ed15ffc0 c117438c ee655810 c163a778 ed15fe00 c16d7ef4 00000000
[    4.248869] fd20: c163a778 c0813ca4 ee0fae00 ed12b000 00000000 00000000 c163a778 c0814268
[    4.257036] fd40: c1685a8c ee655810 c163a778 ed12b000 00000000 ed12b000 ee655800 c16d8088
[    4.265205] fd60: 00000000 c163a884 00000000 c08643b8 c0864388 ee655810 c16d8084 c07ef578
[    4.273372] fd80: c07ef558 c08a2cc4 00000000 ee1dfdc0 c08a2e7c 00000001 c16d8060 00000000
[    4.281539] fda0: 00000000 c08a11f8 ee64616c ee64b338 ee655810 ee655810 ee655844 c08a29c4
[    4.289707] fdc0: ee655810 00000001 00000000 ee655818 ee655810 c1638c80 ee228010 c08a1fa8
[    4.297875] fde0: ee655818 ee655810 00000000 c08a04c8 c0877720 ee407010 00000000 ee213600
[    4.306044] fe00: ee655800 ee407010 ee6484c0 ee655810 ee6559b0 ee663810 00000017 c07efb30
[    4.314211] fe20: c1638c64 c1638cfc ee655804 ee663c28 ee407010 c07f0058 c0f6044c ee407010
[    4.322378] fe40: ee228610 00000000 ee228600 00000000 00000000 c088177c 00000000 ee211ac0
[    4.330545] fe60: ee407010 ee228610 ee228610 fffffdfb c163a9e8 00000000 c163a9e8 c08a4914
[    4.338713] fe80: c08a48c8 ee228610 c16d8084 c16d8088 00000000 c08a2cc4 00000000 ee1dfed0
[    4.346881] fea0: c08a2e7c 00000001 c163b320 c1691be0 c16d8084 c08a11f8 ee0ab66c ee64b438
[    4.355049] fec0: ee228610 ee228610 ee228644 c08a29c4 ee228610 00000001 ee0fae00 c163b328
[    4.363217] fee0: ee228610 c163b518 c163b304 c08a1fa8 c163b328 ee1cef80 ee228610 c08a2404
[    4.371384] ff00: c08a23c0 c163b328 ee1cef80 eef8ac40 ee1de018 eef8dc00 00000000 00000000
[    4.379551] ff20: c1684e34 c035ba70 eef8ac40 eef8ac58 ee1de018 ee1cef80 eef8ac40 eef8ac58
[    4.387719] ff40: ee1de018 c1684975 ee1cef98 c1502d00 00000008 c035bf90 ee1d501c ee1de000
[    4.395887] ff60: 00000000 c1502d00 ee1d501c ee1d5000 00000000 ee1c6d00 ee1d501c ee1cef80
[    4.404056] ff80: c035bd68 ee0cbed0 00000000 c03611fc ee1c6d00 c03610d0 00000000 00000000
[    4.412235] ffa0: 00000000 00000000 00000000 c03080c8 00000000 00000000 00000000 00000000
[    4.420404] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.428572] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    4.436759] [<c0831ccc>] (drm_debugfs_init) from [<c0813ca4>] (drm_minor_register+0x68/0x110)
[    4.445277] [<c0813ca4>] (drm_minor_register) from [<c0814268>] (drm_dev_register+0x8c/0x1cc)
[    4.453798] [<c0814268>] (drm_dev_register) from [<c08643b8>] (host1x_drm_probe+0x30/0x54)
[    4.462061] [<c08643b8>] (host1x_drm_probe) from [<c07ef578>] (host1x_device_probe+0x20/0x2c)
[    4.470583] [<c07ef578>] (host1x_device_probe) from [<c08a2cc4>] (driver_probe_device+0x224/0x2f8)
[    4.479536] [<c08a2cc4>] (driver_probe_device) from [<c08a11f8>] (bus_for_each_drv+0x58/0x8c)
[    4.488055] [<c08a11f8>] (bus_for_each_drv) from [<c08a29c4>] (__device_attach+0xb0/0x110)
[    4.496313] [<c08a29c4>] (__device_attach) from [<c08a1fa8>] (bus_probe_device+0x84/0x8c)
[    4.504484] [<c08a1fa8>] (bus_probe_device) from [<c08a04c8>] (device_add+0x3f0/0x570)
[    4.512397] [<c08a04c8>] (device_add) from [<c07efb30>] (host1x_subdev_register+0xac/0xd0)
[    4.520655] [<c07efb30>] (host1x_subdev_register) from [<c07f0058>] (host1x_client_register+0x10c/0x12c)
[    4.530129] [<c07f0058>] (host1x_client_register) from [<c088177c>] (tegra_hdmi_probe+0x1e4/0x2f0)
[    4.539080] [<c088177c>] (tegra_hdmi_probe) from [<c08a4914>] (platform_drv_probe+0x4c/0xac)
[    4.547511] [<c08a4914>] (platform_drv_probe) from [<c08a2cc4>] (driver_probe_device+0x224/0x2f8)
[    4.556375] [<c08a2cc4>] (driver_probe_device) from [<c08a11f8>] (bus_for_each_drv+0x58/0x8c)
[    4.564892] [<c08a11f8>] (bus_for_each_drv) from [<c08a29c4>] (__device_attach+0xb0/0x110)
[    4.573149] [<c08a29c4>] (__device_attach) from [<c08a1fa8>] (bus_probe_device+0x84/0x8c)
[    4.581319] [<c08a1fa8>] (bus_probe_device) from [<c08a2404>] (deferred_probe_work_func+0x44/0x13c)
[    4.590361] [<c08a2404>] (deferred_probe_work_func) from [<c035ba70>] (process_one_work+0x14c/0x444)
[    4.599486] [<c035ba70>] (process_one_work) from [<c035bf90>] (worker_thread+0x228/0x538)
[    4.607658] [<c035bf90>] (worker_thread) from [<c03611fc>] (kthread+0x12c/0x15c)
[    4.615049] [<c03611fc>] (kthread) from [<c03080c8>] (ret_from_fork+0x14/0x2c)
[    4.622266] Code: ebfffef4 e2506000 1a00001c e5953200 (e5933010) 
[    4.628417] ---[ end trace d346994bfc0c1628 ]---

-- 
nvpublic
