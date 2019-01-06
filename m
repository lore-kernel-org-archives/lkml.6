Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C31AC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 09:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1F120449
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 09:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfAFJop convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 04:44:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45875 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfAFJoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 04:44:44 -0500
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gg4z4-0005LX-DM
        for linux-kernel@vger.kernel.org; Sun, 06 Jan 2019 09:44:42 +0000
Received: by mail-pl1-f198.google.com with SMTP id m13so29869286pls.15
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 01:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PIdwDI7hMhCDVYB+vz1k0S/GSCZQwrhC1k0MoDM1rQI=;
        b=FLkzBcY73kIW9OpkGdiBm0f2+L4t9KOycwmqb+vE9IEHEAeOVrCIa9TMfqeGyBGAg3
         FEq2Loxvs5HMtPyqOlO+CafXHKIUeIP/ctkCXM5fgB86dfHzUbpRJHz+dXd2nhiMvfjL
         M7QK+nhNohhJ4QbNuMkEZf1CBFDYoW3f2owXLD5dr7SZe+jIRdHqpT4qZMgNdFzj0T+6
         6yym4NP1r6eHGcOAhd7u2TMugdJehkI30A21IjGnb3H3z0IbNrcgWGxJBOsDkJ0/V0bU
         AFgEL79bOTfDPPZNJUIs1/kriAPfxKJmTARoAEg2UZXh++QDVuexip5BOBAlCeyzw8bd
         C2lw==
X-Gm-Message-State: AJcUukfMo05jxCACbwEOlgfQRpLOsCicX6tHii+Vsi6cWPXe8t9pDThg
        IZ+64LUvNngC5plpGYYrm9Q6gBnP3yPkfOMB+AITOKgZWtZxQeyWJG50YLvVMixmKRgxxgZB6bP
        SlspcrxPRsG/SxtbB+R9AynwY7rS53yR/TimmsuKq4g==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr57493971plr.128.1546767880540;
        Sun, 06 Jan 2019 01:44:40 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6GytVQf1cF97yN272ZwPkjWsbr+dHpJVO885funEiCsJWAcxgrNZK5iKzctjCpRPhFjxTgjA==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr57493959plr.128.1546767880146;
        Sun, 06 Jan 2019 01:44:40 -0800 (PST)
Received: from [192.168.1.215] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id r12sm78871730pgv.83.2019.01.06.01.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 01:44:39 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Elantech Touchpad: Fix Elantech touchpad and trackpoint
 for Lenovo ThinkPad notebooks.
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20181228175327.14863-1-kaelinphilipp@gmail.com>
Date:   Sun, 6 Jan 2019 17:44:35 +0800
Cc:     Philipp Kaelin <kaelinphilipp@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <F09EA46C-73C3-48A8-9105-F4DE55D7FBB6@canonical.com>
References: <20181228175327.14863-1-kaelinphilipp@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

> On Dec 29, 2018, at 1:53 AM, Philipp Kaelin <kaelinphilipp@gmail.com> wrote:
> 
> Initial situation:
> - The touchpad of a Lenovo ThinkPad L580 doesn't work with newer kernel versions eg. 4.20
> - It used to work on earlier versions eg. 4.14
> 
> Cause:
> - The elantech driver was adapted in to support SMBus wich not all firmware versions
>  of the elantech firmware support. The SMBus is used as default.
> 
> Solution:
> - Previously a blacklist was introduced for devices which doesn't support the access using SMBus.
>  The ThinkPad P52 and P72 have already been fixed by adding it to such a blacklist in a prevois patch.
>  The exact same solution fixed also the issue on the mentioned ThinkPad L580.
> 
> Change:
> 1) The firmware id of the ThinkPad L580 was added to this blacklist.
> 2) To not have a half baked solution the information which firmware versions are using the same driver
>   and therefore most probably have all the same issue was extracted from the Lenovo Windows driver package.
>   All these firmware versions are now also added to the blacklist.

I actually have a reversed situation: 
I’d like to make Elantech touchpad defaults to SMBus on some platforms, but the firmware version does not match to ETP_NEW_IC_SMBUS_HOST_NOTIFY().

Use whitelist is obviously a bad idea so I’d like to know do you have any better approach in mind?

Kai-Heng

> 
> Risk assesment:
> As in prevois versions of the kernel eg. 4.14 none of the devices used to be accessed via SMBus
> (and they are reported to work at this time) it's quite safe that this blaklisting doesn't cause
> any harm on devices which have not been testes but included in the blacklist.
> 
> Signed-off-by: Philipp Kaelin <kaelinphilipp@gmail.com>
> ---
> drivers/input/mouse/elantech.c | 23 +++++++++++++++++++----
> 1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 9fe075c137dc..e5fa8cfd8393 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1772,10 +1772,25 @@ static const char * const i2c_blacklist_pnp_ids[] = {
> 	 * These are known to not be working properly as bits are missing
> 	 * in elan_i2c.
> 	 */
> -	"LEN2131", /* ThinkPad P52 w/ NFC */
> -	"LEN2132", /* ThinkPad P52 */
> -	"LEN2133", /* ThinkPad P72 w/ NFC */
> -	"LEN2134", /* ThinkPad P72 */
> +	"LEN2131", /* Walter-3	w/ NFC		ThinkPad P52 w/ NFC	*/
> +	"LEN2132", /* Walter-3	w/o/ NFC	ThinkPad P52		*/
> +	"LEN2133", /* Chiron	w/ NFC		ThinkPad P72 w/ NFC	*/
> +	"LEN2134", /* Chiron	w/o/ NFC	ThinkPad P72		*/
> +	"LEN2037", /* Lando	w/ NFC		ThinkPad L580 w/ NFC	*/
> +	"LEN2038", /* Lando	w/o/ NFC	ThinkPad L580		*/
> +	"LEN004F", /* Storm	w/o/ NFC				*/
> +	"LEN005C", /* Storm	w/ NFC					*/
> +	"LEN2030", /* Carling						*/
> +	"LEN2031", /* Bell						*/
> +	"LEN2032", /* Bell-2						*/
> +	"LEN2033", /* Storm-2						*/
> +	"LEN2034", /* Storm-3						*/
> +	"LEN2035", /* Solo	w/ NFC					*/
> +	"LEN2036", /* Solo	w/o/ NFC				*/
> +	"LEN2039", /* Leia						*/
> +	"LEN2130", /* Kylo	(Clamshell)				*/
> +	"LEN008F", /* Kolar	w/o/ NF					*/
> +	"LEN0090", /* Kolar	w/ NFC					*/
> 	NULL
> };
> 
> -- 
> 2.19.2
> 

