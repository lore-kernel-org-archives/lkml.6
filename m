Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723F0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D1B21848
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="j2gYtUn3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="whHcDSd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbeLRINz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:13:55 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:57063 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbeLRINy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:13:54 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id ED45C1199;
        Tue, 18 Dec 2018 03:13:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 18 Dec 2018 03:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=oEDn4BHFT7oXk5FuKxZWoA9UUkb
        iQMdy3mV2/mo0F8E=; b=j2gYtUn3wE+43CVzILdbZCJLfLyzGhfcFF6GRm3BzZn
        xPLtSp+B+RMLCptJktikUeq3LIg5+VDmLd6f179o6NjnQdN0qP5wf8YhLxE85m7o
        RL1YY60xq5s5VbC2gCNLMjMad6NTR8i4wpIwRoL0bZCTnRuvu9EhI4UsewIo0ai4
        LFx6mvjCUFc6Z5vkZh60VUEpw1K1Uw57CwIIDXlQ0XM7yDapIqDdNXOr0LXnbpZM
        wyIF08UoKxHQkb8xLK08VWQAXwC4OgG9adO2B4HY7CLaa4RYrqQxgfN8c/m4T5zg
        B52ZCJcvTe488hgXWD/MAXOsnWLicEjkTUlCoPtveNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=oEDn4B
        HFT7oXk5FuKxZWoA9UUkbiQMdy3mV2/mo0F8E=; b=whHcDSd2GUH5CEJBbjsh6N
        eHM7UUhOqixEY5DpkP4+NClE+Jn2RHx253t++9u378kVD9AIzUGrck3WCJPSa86L
        EKNoKgA2sV80vjak5N9htUv9DuT1FHh7DKQ6NMfmNyC/b7LlKYcDcwNO/LciIB9o
        v1DJjT+s8A6VysCxMDtGM6FUAgGELqqFoGDx1rFSLBlk1MApdug75Oij0pPIXVty
        2QIv3NUDAR8mnuGJggk4kPb90qYSCh2lqzGF+abEOqQpbzXSKypmLgeFC544qBD6
        WHiY0q1wLET4yl+qyuRqd3sDnRqFv5xPTTJNQocBngCulAVk7A90TUinOI6hCGPw
        ==
X-ME-Sender: <xms:PawYXAsQIqxukZfxyMbMjx2ABE3ufVrtr6-1H0mF6gl7wFkXfUvfSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudeigedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukf
    hfgggtuggjfgesthdtredttdervdenucfhrhhomheprfgvthgvrhcujfhuthhtvghrvghr
    uceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvghtqeenucffohhmrghinh
    eplhgruhhntghhphgrugdrnhgvthdprghrtghhlhhinhhugidrohhrghenucfkphepudei
    jedrudejledrudeiiedrvdelnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpvghtvghrrd
    hhuhhtthgvrhgvrhesfihhohdqthdrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:PawYXBtTCQeHNVAYW6BcD9xcPjij3dHNVxpZ6dCvI3fHSazyEGRHpg>
    <xmx:PawYXPWX12hJVTfilFwZxMu4ywhjiNWgmSBy6QG-UN37bebEnTQxAg>
    <xmx:PawYXCXiWTr1vmjNfRmGqXMAMdIf44jaERXDtKOJl8Hh9i96X839Xw>
    <xmx:PqwYXO4HoUlhqluKeLGOwSD8CucToY89f4FZ6F7E3usSj-FGTBbsJA>
Received: from jelly (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 22CA1E436E;
        Tue, 18 Dec 2018 03:13:46 -0500 (EST)
Date:   Tue, 18 Dec 2018 18:13:43 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>, kt.liao@emc.com.tw,
        Aaron Ma <aaron.ma@canonical.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] Input: elantech - Disable elan-i2c for P52 and P72
Message-ID: <20181218081343.GA4701@jelly>
References: <20181212154205.24025-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212154205.24025-1-benjamin.tissoires@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 04:42:05PM +0100, Benjamin Tissoires wrote:
> The current implementation of elan_i2c is known to not support those
> 2 laptops.
> 
> A proper fix is to tweak both elantech and elan_i2c to transmit the
> correct information from PS/2, which would make a bad candidate for
> stable.
> 
> So to give us some time for fixing the root of the problem, disable
> elan_i2c for the devices we know are not behaving properly.
> 
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1803600
> Link: https://bugs.archlinux.org/task/59714
> Fixes: df077237cf55 Input: elantech - detect new ICs and setup Host Notify for them
> 
> Cc: stable@vger.kernel.org  # v4.18+
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
   Peter

> ---
>  drivers/input/mouse/elantech.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 2d95e8d93cc7..830ae9f07045 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1767,6 +1767,18 @@ static int elantech_smbus = IS_ENABLED(CONFIG_MOUSE_ELAN_I2C_SMBUS) ?
>  module_param_named(elantech_smbus, elantech_smbus, int, 0644);
>  MODULE_PARM_DESC(elantech_smbus, "Use a secondary bus for the Elantech device.");
>  
> +static const char * const i2c_blacklist_pnp_ids[] = {
> +	/*
> +	 * these are known to not be working properly as bits are missing
> +	 * in elan_i2c
> +	 */
> +	"LEN2131", /* ThinkPad P52 w/ NFC */
> +	"LEN2132", /* ThinkPad P52 */
> +	"LEN2133", /* ThinkPad P72 w/ NFC */
> +	"LEN2134", /* ThinkPad P72 */
> +	NULL
> +};
> +
>  static int elantech_create_smbus(struct psmouse *psmouse,
>  				 struct elantech_device_info *info,
>  				 bool leave_breadcrumbs)
> @@ -1802,10 +1814,12 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
>  
>  	if (elantech_smbus == ELANTECH_SMBUS_NOT_SET) {
>  		/*
> -		 * New ICs are enabled by default.
> +		 * New ICs are enabled by default, unless mentioned in
> +		 * i2c_blacklist_pnp_ids.
>  		 * Old ICs are up to the user to decide.
>  		 */
> -		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
> +		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
> +		    psmouse_matches_pnp_id(psmouse, i2c_blacklist_pnp_ids))
>  			return -ENXIO;
>  	}
>  
> -- 
> 2.19.2
> 
