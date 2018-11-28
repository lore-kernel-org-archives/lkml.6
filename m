Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA734C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BC220873
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="fVq48ArF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L1WCgWZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63BC220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeK1Ora (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:47:30 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44817 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbeK1Ora (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 09:47:30 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DBF2A22108;
        Tue, 27 Nov 2018 22:47:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 27 Nov 2018 22:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=qXtzAgKTOkx6ZaAJui3EENBBBmA
        UnL7I4XhhNAYYwgo=; b=fVq48ArFhE+bnswkYJunURTKelKLlEDyFlSFhSG7c51
        l0azX8hwa9d3AKmF1G4nQrDCEtBm+bjT1uiiWYdsJEIWTlJmNVsIiGtTX9pBenGc
        RuyiMSTjDiRadWjWmQG+GAlujNGwCOQYqRYFhNVESJaJCM8OvGfzPDrGLNwmHJGO
        7mAkltLkdckZwAyjKYBLK3uRfyLND8HvnBYMapXuoZVRjgI/1rYWoqqDbx22zr7Y
        u3Q4hkLeccPGQqooFfawxqoOSgZPLrqmjletsD4/7RVr54DYTDP1Ubi3lXlkTdSr
        +PKCW4NnbN4goWY5NylnYPicvaPlhsDFoPWZ/dmLwtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=qXtzAg
        KTOkx6ZaAJui3EENBBBmAUnL7I4XhhNAYYwgo=; b=L1WCgWZ3HGVbdcaTYExuNp
        p0jOw0tWwME4WDqS6UozXv+bPg8Yc880a8rrgWddr4ZlclVtg+LX0vNXoYTTeg/q
        oi0AWy0Uh5/Ggt+tgkuEw1Y6cB0q8i0tTBQyLRrJnAV2hh1qbf2oGAPT/MN2sVTR
        w5U5+eVO7S6RLu/UBlT/wtp0VkrqCBHid33qHC1BuVK6Bp4PAabwKEfO0YmhuN94
        0rrJU7vzgK2tBVzwqe7GC6HbAonhbiJVskKIEiOaKDLSTVnFhgiRLEpu6LJA21lb
        GuqmpfF2nS5G7wv5sLmDO+l4lmRcmcdzuG9SX8V1bnuXi6MDnrPGtFhifO+ROv/Q
        ==
X-ME-Sender: <xms:yg_-WwjJe6yDbM9mT6iEqPbRX1X1m8OXuXZS3jCcMLx9J1y8BTp5yw>
X-ME-Proxy: <xmx:yg_-WwyRwhUwKHUX_Oi6GSy-jqv2DXmUKHPYSZdV1xon_TxuSPcjJQ>
    <xmx:yg_-W_qod0_x5q7Z3E0k3FFNF0Cd8q_EeNjKMfpT1ZHMM_zteoZ50Q>
    <xmx:yg_-W7uU7BbpjFRNMphC2RMa_mAn_CP_6UfeEp1GpQ9Jq4L-DM3_NQ>
    <xmx:yg_-W2SdKgr4wjQ0oY7EC-RtTAeK4p9iEcgGN11hW1vvX7KKOCGUow>
    <xmx:yg_-W9nGZXOE54kVJOJubQBXwg9IZtYS41biJ4RhU-vEYVtpufx-2g>
    <xmx:yw_-W68TmSXKzC0L8UhR-x8sWmZOzgSvcndjcAF68PvkWvQzas04kw>
Received: from jelly (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id E5E00E4122;
        Tue, 27 Nov 2018 22:47:19 -0500 (EST)
Date:   Wed, 28 Nov 2018 13:47:20 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Lyude Paul <lyude@redhat.com>
Cc:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        KT Liao <kt.liao@emc.com.tw>,
        Edvard Holst <edvard.holst@gmail.com>,
        Arkadiusz Hiler <arkadiusz.hiler@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics - Add PNP ID for ThinkPad P50 to SMBus
Message-ID: <20181128034720.GB21318@jelly>
References: <20181121201622.20815-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121201622.20815-1-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 03:16:20PM -0500, Lyude Paul wrote:
> Noticed the other day the trackpoint felt different on my P50, then
> realized it was because rmi4 wasn't loading for this machine
> automatically. Suspend/resume, hibernate, and everything else seem to
> work perfectly fine on here.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
   Peter

> ---
>  drivers/input/mouse/synaptics.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 5e85f3cca867..c42813d50591 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -170,6 +170,7 @@ static const char * const smbus_pnp_ids[] = {
>  	"LEN0048", /* X1 Carbon 3 */
>  	"LEN0046", /* X250 */
>  	"LEN004a", /* W541 */
> +	"LEN005b", /* P50 */
>  	"LEN0071", /* T480 */
>  	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
>  	"LEN0073", /* X1 Carbon G5 (Elantech) */
> -- 
> 2.19.1
> 
