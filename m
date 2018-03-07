Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754325AbeCGLfi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 06:35:38 -0500
Received: from mail-ve1eur01on0081.outbound.protection.outlook.com ([104.47.1.81]:58176
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751151AbeCGLff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 06:35:35 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexandru-Cosmin.Gheorghe@arm.com;
Date: Wed, 7 Mar 2018 11:35:29 +0000
From: Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Brian Starkey <brian.starkey@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        DRI devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, nd@arm.com
Subject: Re: [PATCH v3] drm/mali-dp: Fix malidp_atomic_commit_hw_done() for
 event sending.
Message-ID: <20180307113529.GA21042@e114479-lin.cambridge.arm.com>
References: <20180301174913.10875-1-Liviu.Dudau@arm.com>
 <20180305180316.12654-1-Liviu.Dudau@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305180316.12654-1-Liviu.Dudau@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR02CA0057.eurprd02.prod.outlook.com
 (2603:10a6:802:14::28) To DB6PR0801MB1253.eurprd08.prod.outlook.com
 (2603:10a6:4:a::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1e061634-e5c4-456d-9c44-08d5841f8955
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1253;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1253;3:/iLwWUHgil9tHwj4ukU3gAgTrscksSLWyu4+bzfUS2kr+JGPya6uWtOC5OEfDpFpCKEknuxhlZEzaX3MaRdRxRPYsOVL342v9PF2qH3vD+zx+mLspqFOSozBmeIPM9rKqOZwvMUARnYpcLu0I3lgEUc44qlehjhFmkzVlSx+2Qa3NCOZbmj283LnBP6qsHjw+L3sX80dtnhR3+gTrWZ+gkTX2DoeSik9q5hXX0ZTCqhLWvPcMSWth5Z/GevZXjCP;25:Quhaxl9fSv0ngMMUV/lQQU/83xSULVWExLGr7nE0Ymxr66u46JuWmm+b3wmi9oD1rqFSgTTGtMyh5DmDA1ENyfLb+4ZyPj9w0wwKvI0Ta89Si/EJ9ZkdngeF1MShEDGk1PDE34SBmUM94HY7P4tpFOHC4pZ33681x9/knykgzbtVz0jf5rWiyUKY3UQCLTTpi+dffyc9LEnmoOfo9P1F/ETtczvGl8gaxYB+BP0wVq3zQypLOwKnFIZiRWYMQKvk3meI5eGMHVSDNPdLviVGrQ87nFUeIxEfDoAt2PlewmnLnzdN+FB+WKBabSd2agwn1eayigcc/HLaBCsQwbl3Jw==;31:TXJSv5IbHs3ZmcwnIGKrkZzTK8FzRHCLdekhEKPxapQV95SCyWIMXYE7FGjrFSi3864egzmO7odRgBLKTppkD0mn9nTq7M412VZ3BYlo+nbw8NdZwB+H8FtrT9nIdIQluddfe9rY4JhfvZu1lJdX7n5YGIegrEw6ww4Dv9QdDGbC4+7HYFke4wrnFwRjdiCv2481y1LX5WE7kit9QJNi9FXyABAD8ZpGchsz1DyAtpk=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1253:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1253;20:If+OpGfARhBOi27AZ7TnqSJJiBK+nRHaRaplgw/b02XCzDowH74RSMA4O0JeaUOm7uOaFXmkZ5A53JGx+LiXpdQ9zjMUQu12ZvbyxJyo2N3xA+ua9EQ5kc2I1OiTS1Yzr/VjtuCdZLA42txiYwgzVR1rzv4y4ntTSCATnbQ+IMo=;4:W2/55FK26/WcbWcUdypSuyJkfWlu3RDCB7e3D7ygR/FSe/Z5L/mqgT/4U7g8qXtVUndvt4/3+90ZUQCFdTcnoXthIFP4+NWZvXS2GpSfgGHDz2t6CEBBLutyLBcy6gs0+LSWJ/7OIM1ewYnqOpnINZfzbavvcTMJ1EttXG+cpnb3790Se1wpXCmjHOt00nzcs0XDYWkBZE+W74xOEcRloaxjkzacHCQnTlsIvB4MNCJeuuFVdf4DrN6p+j4TyulGqWfKQ9LGRwEUjbI1V0soIXFIk9XkAisvemUFAcWj9QMf+627GXTN2to/0f7L8cewvVwWkoxwcSny9vt4H0szzzx78Wlbtf3F9NLm3ThlNag=
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1253651CEED7C5BC1ECAFF84BCD80@DB6PR0801MB1253.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443)(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DB6PR0801MB1253;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1253;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(39380400002)(39860400002)(346002)(366004)(376002)(189003)(199004)(66066001)(1076002)(23726003)(50466002)(2906002)(6116002)(8936002)(3846002)(47776003)(106356001)(229853002)(6862004)(25786009)(4326008)(2950100002)(6666003)(6636002)(8676002)(81156014)(33656002)(76176011)(81166006)(52116002)(16526019)(59450400001)(105586002)(6496006)(386003)(26005)(478600001)(72206003)(316002)(76506005)(86362001)(6486002)(7736002)(6246003)(53936002)(305945005)(575784001)(68736007)(97736004)(16586007)(5660300001)(54906003)(58126008)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1253;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0801MB1253;23:5TM1iHvlCRhnb+S9z4CR9mbDwM9mXyruEjhmHI9?=
 =?us-ascii?Q?JRMgcUom46NbanXn8BLnteCLYxNdabSopkCi5EUu6ohaynQv1ZmrvXhjMhUb?=
 =?us-ascii?Q?z3FGijks3ygsDOmVQ/Wp+HckjyMSdcQYqMp11WRqWlvnRWRyfzksUS2oxi1q?=
 =?us-ascii?Q?Je7VQH52p/coup2v+HJY0thDdSrrCsBoQzMM9KPn0XrdlLu+oCV6MIRGEN0y?=
 =?us-ascii?Q?Zn87UVxzYisyk84XLyejC+kT3yfGQ/tDlh2b2rXCp1Jo2H9fJkSdbxo/f7Zq?=
 =?us-ascii?Q?w8sRFggMJx98iZAcjxp/DnqiVOt3fh66EVMhB9bYfXuJegQAOVJB1upzb1od?=
 =?us-ascii?Q?aD6VgAfBs/uGI9Qr/sWa0jIyAQ+pbRMy7lsSd+OBN7Md4KJl76mfKqlNRGoJ?=
 =?us-ascii?Q?5WyIJNzBwshHHTAPfy5/eNuY8kOXYESnOxfnYnc3SHCN/aeJkmdCsoc0NUTY?=
 =?us-ascii?Q?lBgp8AGwECqb6GGOzCTpKwbH+BSgplxwH5I1JIRFbEl20akIWX14NEo/B16C?=
 =?us-ascii?Q?4WMUcTB8914+LSr3HBT/2Y6YyTUWADYXjMSPQG+ekWzb67Qv66cYjpTvgLsi?=
 =?us-ascii?Q?/IFwK+e51tLeFbc7FIFMALBk7JMc3jLHM9q6Hia3yd0ziR3VWkQ0dr6dUm6k?=
 =?us-ascii?Q?xiWcBSYHsx/1V76NG/xnlT/Hg0XLC7a2AnCBHovpqWP6Ky8a5/78HFznRpDu?=
 =?us-ascii?Q?uNTmjuguCE0nOaeDQqxUXKz8uDtNovAu9Z0+52AyISMdONRS0+JKLItIF2Fz?=
 =?us-ascii?Q?k7descuIYPiJkbgvCAOzEK1YVuqsHx3M/aTs/DzYWaCx2T+B9DzRCOi4sJWb?=
 =?us-ascii?Q?ULxFMBI0dT243teLnU5z5OVnyCBAwHktAQI+tDljVfoDCMt6zReP5xYC3p4+?=
 =?us-ascii?Q?sijrWTSimV0s2qbwGabqY+jGAw5/25vh+uHy1S7jgQQXunYm2PBA/5Z/mua4?=
 =?us-ascii?Q?Vbjz6GzGDoMf2OFMxGad4MqhXpQrN/kawoSRyKP7GbbnslrZA1BH4dsR3zNv?=
 =?us-ascii?Q?LY4cyrIOyadXwsydALMY1hh4wa/xdqXnTh7XWCrWudaalh99EDKEMArlzB17?=
 =?us-ascii?Q?plngCv1RbR5plI8mOmX7n8kkR6WEHIDNWuST5HCgFE12vcd6qmc6By/+Azzg?=
 =?us-ascii?Q?AKBBjmQm+rD3S04JgVUSrL/WCsFT424eoEHIyyWeMmfsfTAZ8kFgp0Ul3A57?=
 =?us-ascii?Q?4JbKswGmAGH7/2LfypR19X4m+Vm0fr0g9N154SE+Qp3RS4oBIZ3+0/r5QsYj?=
 =?us-ascii?Q?c0f3KEvRm54aeQWUovZwC39e8rErLHEG9xsKZr768VBr5N+sjvFzSChPF64U?=
 =?us-ascii?Q?4/Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5dxOvpHpZ7qxyW5R4dfuLOKDUMOnQUswO/ct1n1LIi/eO+c9O50sLMks/sR3qoQLuJz12ullTaF4APSj76c3ufYCXW0h5Qmf07YqjGfYVOIudxYBftfxzUZH/aSZJO9JB8VrRqVTOGn9VZ/ADP/5UWK7C0bzsQWA6ufHJkaoFOcT7hev+f0KH9nDE3ZQFRSI
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1253;6:lq9dORbriARxcTLUaCV1XJnrqG8HdMVDPljjK11O51kv2S+V8BT2aGHQuLv1h1UbcBIX5f8usRijdENdHGWh3lmpEThV32eiQqQDU+p+aDawbF9V9l5pjZzEF58dTzZ2gwosPbTI6cOZOpRtXyJJpsxcfhJOaKDLaOBmf72epnRbxbXd5UEyVzPqiDeL8m44sbdn6dH7+Rl+9/Cu8kY6iEkC2rYfod1zHS7ZHtsVlExi0yhTHWsU6lDImucUXwXkkcXaVPZKT32QGMjXj7/t6fzPucPlVGsOQ0hwEsOwsJrTzjcljCGMkCtG0p3P4QERI+XCPP4ikKW0pYFJUuAQ3KB3vkGQtCqPqMTX9Bp8LQI=;5:8RWEvRZPuzXDHA57kCH8o/2OW9JuxWVEbSLLLpxc1yhoV9M4YS4VBbEfP0N9V+tclTbpw3T6cDYWuKwghW9qiCp3sMHcOZjAPmAh3REC6ZJ1t1cmOveU2G7lH4ag8cM+0dTYNe3z+FB8VKVVGhKXg7+mf5M8PqSRQYZBlyyp8Hk=;24:2Tm+sOnrbccJoRaF2B74HTEXu6VGnPehRj054r1e9OWtQCVGimn0PRosvXP9xphUJgXpoRW5N/eg2HWXWxsQ8q1HuhjKVrk+i24QZo0Bsjw=;7:/vqDRFZwN6PNH9W1fCza/HS3BC/+Hld6tBq3RFgSz3W7081z6nZiFHMIeCF4kWSO5bLsS6sS6cIy7DvxEJrwxyWO6UOX0TFNIe0WmMa+7nR65jXKxDKKx1E7VzArDtlc0AYYrqbJuHHquA/iFKUudLX3Hmk5UMJfnTSlYfnPuPc87YpEQeFqB2o6KBnXiL9RahNE3Iype4+uNzGTwzP/hem8ZQDHYq3tYsH2m7U7yceEXKB+f23QJFVP5GJRB2ET
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 11:35:32.3547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e061634-e5c4-456d-9c44-08d5841f8955
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 06:03:16PM +0000, Liviu Dudau wrote:
> Mali DP hardware has a 'go' bit (config_valid) for making the new scene
> parameters active at the next page flip. The problem with the current
> code is that the driver first sets this bit and then proceeds to wait
> for confirmation from the hardware that the configuration has been
> updated before arming the vblank event. As config_valid is actually
> asserted by the hardware after the vblank event, during the prefetch
> phase, when we get to arming the vblank event we are going to send it
> at the next vblank, in effect halving the vblank rate from the userspace
> perspective.
> 
> Fix it by sending the userspace event from the IRQ handler, when we
> handle the config_valid interrupt, which syncs with the time when the
> hardware is active with the new parameters.
> 
> v2: Brian reminded me that interrupts won't fire when CRTC is off,
> so we need to do the sending ourselves.
> 
> v3: crtc->enabled is the wrong flag to use here, as when we get an
> atomic commit that turns off the CRTC it will still be enabled until
> after the commit is done. Use the crtc->state->active for test.
> 
> Reported-by: Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
Tested this with Mali DP-650, modetest is able to do page flipping at the
expected frequency. Also, I didn't observe any regressions in the
driver unit tests.

Tested-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>  

> ---
>  drivers/gpu/drm/arm/malidp_drv.c | 32 +++++++++++++++++---------------
>  drivers/gpu/drm/arm/malidp_drv.h |  1 +
>  drivers/gpu/drm/arm/malidp_hw.c  | 12 +++++++++---
>  3 files changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index d88a3b9d59cc..3c628e43bf25 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -185,25 +185,29 @@ static int malidp_set_and_wait_config_valid(struct drm_device *drm)
>  
>  static void malidp_atomic_commit_hw_done(struct drm_atomic_state *state)
>  {
> -	struct drm_pending_vblank_event *event;
>  	struct drm_device *drm = state->dev;
>  	struct malidp_drm *malidp = drm->dev_private;
>  
> -	if (malidp->crtc.enabled) {
> -		/* only set config_valid if the CRTC is enabled */
> -		if (malidp_set_and_wait_config_valid(drm))
> -			DRM_DEBUG_DRIVER("timed out waiting for updated configuration\n");
> -	}
> +	malidp->event = malidp->crtc.state->event;
> +	malidp->crtc.state->event = NULL;
>  
> -	event = malidp->crtc.state->event;
> -	if (event) {
> -		malidp->crtc.state->event = NULL;
> +	if (malidp->crtc.state->active) {
> +		/*
> +		 * if we have an event to deliver to userspace, make sure
> +		 * the vblank is enabled as we are sending it from the IRQ
> +		 * handler.
> +		 */
> +		if (malidp->event)
> +			drm_crtc_vblank_get(&malidp->crtc);
>  
> +		/* only set config_valid if the CRTC is enabled */
> +		if (malidp_set_and_wait_config_valid(drm) < 0)
> +			DRM_DEBUG_DRIVER("timed out waiting for updated configuration\n");
> +	} else if (malidp->event) {
> +		/* CRTC inactive means vblank IRQ is disabled, send event directly */
>  		spin_lock_irq(&drm->event_lock);
> -		if (drm_crtc_vblank_get(&malidp->crtc) == 0)
> -			drm_crtc_arm_vblank_event(&malidp->crtc, event);
> -		else
> -			drm_crtc_send_vblank_event(&malidp->crtc, event);
> +		drm_crtc_send_vblank_event(&malidp->crtc, malidp->event);
> +		malidp->event = NULL;
>  		spin_unlock_irq(&drm->event_lock);
>  	}
>  	drm_atomic_helper_commit_hw_done(state);
> @@ -232,8 +236,6 @@ static void malidp_atomic_commit_tail(struct drm_atomic_state *state)
>  
>  	malidp_atomic_commit_hw_done(state);
>  
> -	drm_atomic_helper_wait_for_vblanks(drm, state);
> -
>  	pm_runtime_put(drm->dev);
>  
>  	drm_atomic_helper_cleanup_planes(drm, state);
> diff --git a/drivers/gpu/drm/arm/malidp_drv.h b/drivers/gpu/drm/arm/malidp_drv.h
> index e0d12c9fc6b8..c2375bb49619 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.h
> +++ b/drivers/gpu/drm/arm/malidp_drv.h
> @@ -22,6 +22,7 @@ struct malidp_drm {
>  	struct malidp_hw_device *dev;
>  	struct drm_crtc crtc;
>  	wait_queue_head_t wq;
> +	struct drm_pending_vblank_event *event;
>  	atomic_t config_valid;
>  	u32 core_id;
>  };
> diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> index 2bfb542135ac..8abd335ec313 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.c
> +++ b/drivers/gpu/drm/arm/malidp_hw.c
> @@ -782,9 +782,15 @@ static irqreturn_t malidp_de_irq(int irq, void *arg)
>  	/* first handle the config valid IRQ */
>  	dc_status = malidp_hw_read(hwdev, hw->map.dc_base + MALIDP_REG_STATUS);
>  	if (dc_status & hw->map.dc_irq_map.vsync_irq) {
> -		/* we have a page flip event */
> -		atomic_set(&malidp->config_valid, 1);
>  		malidp_hw_clear_irq(hwdev, MALIDP_DC_BLOCK, dc_status);
> +		/* do we have a page flip event? */
> +		if (malidp->event != NULL) {
> +			spin_lock(&drm->event_lock);
> +			drm_crtc_send_vblank_event(&malidp->crtc, malidp->event);
> +			malidp->event = NULL;
> +			spin_unlock(&drm->event_lock);
> +		}
> +		atomic_set(&malidp->config_valid, 1);
>  		ret = IRQ_WAKE_THREAD;
>  	}
>  
> @@ -794,7 +800,7 @@ static irqreturn_t malidp_de_irq(int irq, void *arg)
>  
>  	mask = malidp_hw_read(hwdev, MALIDP_REG_MASKIRQ);
>  	status &= mask;
> -	if (status & de->vsync_irq)
> +	if ((status & de->vsync_irq) && malidp->crtc.enabled)
>  		drm_crtc_handle_vblank(&malidp->crtc);
>  
>  	malidp_hw_clear_irq(hwdev, MALIDP_DE_BLOCK, status);
> -- 
> 2.16.2
