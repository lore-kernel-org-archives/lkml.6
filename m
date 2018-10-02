Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15611C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA642064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="tXugR3Vy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA642064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbeJCEqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:46:30 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:35940 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeJCEqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:46:30 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id CA319B00A71
        for <linux-kernel@vger.kernel.org>; Wed,  3 Oct 2018 00:00:59 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1538517659; x=1539381660; bh=nIeZX8FyrUUJeg6cKoRUNRaw6EcZ7gBWU3n
        dN13D+zk=; b=tXugR3VyMgM8bp9o95s3VzXvNZIE2fD3+fpWqbKlrohGU/u20xf
        zLhzkBfWlJpO0z6+oLDQgpF/kOh/7fLgdjw9t4pfSMVjz7CN+lEihaTTB5jsCFp2
        EESbZYMmrf/b5BoeXGjvFTeSh9HOk6A61J1ZhIUdG2Q5mFuAYc1UYubg=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Iw9-biJEfpfl for <linux-kernel@vger.kernel.org>;
        Wed,  3 Oct 2018 00:00:59 +0200 (CEST)
Received: from [192.168.0.105] (146-241-101-147.dyn.eolo.it [146.241.101.147])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id B3527B00750;
        Wed,  3 Oct 2018 00:00:55 +0200 (CEST)
Subject: Re: [PATCH 1/2] drm/sun4i: tcon: fix check of tcon->panel null
 pointer
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20181001093612.GA13672@mwanda>
 <20181002215917.1849-1-giulio.benetti@micronovasrl.com>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <e8344f9e-54af-e287-c992-4494d8a54025@micronovasrl.com>
Date:   Wed, 3 Oct 2018 00:00:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002215917.1849-1-giulio.benetti@micronovasrl.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for sending twice(and top posting), but I was not subscribed to 
dri-devel ML, so patchwork was not aware of these 2 patches.

Best regards
-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ¤ 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642

Il 02/10/2018 23:59, Giulio Benetti ha scritto:
> At the moment, the check of tcon->panel to be valid is wrong. IS_ERR()
> has been used, but that macro doesn't check if tcon->panel pointer is
> null or not, but check if tcon->panel is between -1 and -4095(MAX_ERRNO).
> 
> Remove IS_ERR() from tcon->panel checking and let "if (tcon->panel)" as
> condition to check if it's a pointer not null.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>   drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index c78cd35a1294..e4b3bd0307ef 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -555,7 +555,7 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>   	 * Following code is a way to avoid quirks all around TCON
>   	 * and DOTCLOCK drivers.
>   	 */
> -	if (!IS_ERR(tcon->panel)) {
> +	if (tcon->panel) {
>   		struct drm_panel *panel = tcon->panel;
>   		struct drm_connector *connector = panel->connector;
>   		struct drm_display_info display_info = connector->display_info;
> 
