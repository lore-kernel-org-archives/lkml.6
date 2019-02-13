Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCB5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC52E222A4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550099268;
	bh=FqPCMTyvKlLhxuNLDtZvTzXjvY5boR0ZJyy724fZ0L4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=i2fqPziOtCXEC8n8e0gR2KlkmsKNX+wxRCV+On47VLvVaMsPZMbd3MHBWYtd0f0W9
	 zM7/dYLkx2XnQBepSMAoQoNIhZUK9U74lBKkqjaRw+pg9aak2/+BgwXWDpssd+desx
	 aTrIPULCJZ15KGOvQ/BoAiJloDx32uLYmcgEyfwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393003AbfBMXHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:07:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389588AbfBMXHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:07:46 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 906A3222A1;
        Wed, 13 Feb 2019 23:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550099265;
        bh=FqPCMTyvKlLhxuNLDtZvTzXjvY5boR0ZJyy724fZ0L4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=IXGb+1YQwXeeM2SerB1H+GkKqlupHFc3LYib5M1N0lyFckqaFmehqG/7rjR56Xti7
         QxK1JDt3qxyVeQX1Zx+0F2Icq4oEUurl3VW9IcH8A1udrsMYOhHBD4Sfzp42ckVq8y
         /76Zi7UI+Fi2r7JSpsSdLnlZX1qRyO0Dqyo7gXIk=
Date:   Thu, 14 Feb 2019 00:07:42 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Jason Gerecke <killertofu@gmail.com>,
        Ping Cheng <ping.cheng@wacom.com>
Subject: Re: [PATCH] HID: wacom: Mark expected switch fall-through
In-Reply-To: <20190211220422.GA22137@embeddedor>
Message-ID: <nycvar.YFH.7.76.1902140006510.11598@cbobk.fhfr.pm>
References: <20190211220422.GA22137@embeddedor>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019, Gustavo A. R. Silva wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/hid/wacom_wac.c: In function ‘wacom_setup_pen_input_capabilities’:
> drivers/hid/wacom_wac.c:3506:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    __clear_bit(ABS_MISC, input_dev->absbit);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/hid/wacom_wac.c:3508:2: note: here
>   case WACOM_MO:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Let's CC Jason and Ping to make sure it's really intended :)

> ---
>  drivers/hid/wacom_wac.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 72477e872324..5ecda99bf431 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -3504,6 +3504,7 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
>  	switch (features->type) {
>  	case GRAPHIRE_BT:
>  		__clear_bit(ABS_MISC, input_dev->absbit);
> +		/* fall through */
>  
>  	case WACOM_MO:
>  	case WACOM_G4:
> -- 
> 2.20.1
> 

-- 
Jiri Kosina
SUSE Labs

