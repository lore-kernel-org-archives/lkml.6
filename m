Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1413175-1524695232-2-3323122181917425524
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524695232; b=RmMXZrlxlgkJc6eIDGVJh1DICcr9kcF/lb67iakgTqVnjX2o6z
    WEoQlYfPrQzW1TOvUAnEvZqyZTssJzVnSZOVs4zXIb/z6w4iQ2yiEkP4BjZw8Act
    nNctm/khgRjLKhY2PTb1Xd19D6Om/8aV5KmsYp9EKKAbjjs5wTyv9jS8r8PE+6MG
    C0mPHQ19M+90JuqiyJJX/kvQrOYzYrDl/CXR1LvQCjfm5eHNgZZta4JjJXUvhVov
    lIxtbVzqHNa1W4W/DEdcQ+Nwmw/DYdFKT9EvijznMR5FJ3lVhquUAlhVcErofxsb
    503/nL4lKObvv/Jm/mpC/M0n/KHrOuUhGvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524695232; bh=0uZW8QWA0atfoBJWqzvTL9UsV7zZHh
    jQJBOC7oQL800=; b=j3vSiqHsQlxkygAORaMJIhlCBbVJSNPJ9ZCWnZv+hi66Bz
    qTLNgpUX5OcexQErRCFTu4Dr27moHyl+qN/z+B1GHKRyHDfrQ5DhwUr48l5z7Qr0
    tpNJPGuOhesXJJfhxEYzqj+FvaVIYmz3hTZgqQafejxDGikjBFaUHeHmGIyig/Jv
    /oxh6d8zhGhU56+JdcA+fvG45no1wTQLFm5R8TvgyGaej5XURuMeHm+PfBuGegoU
    FtfRb2UF/wW29K/FP9MSXPio3YH55zAmXhtu8kxVdRyclbXbtXXAnbJNLaJdrbtl
    5bpTT9YoCn7BA6uJWC5xQS7WTY7BY22kBxCttabQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fxC7Hs2b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YDhoG1Rw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fxC7Hs2b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YDhoG1Rw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGtNHOz/rV/SEHSZ3LvRY5hhxvcsWzyPTCkj1MVX/i9oePKmaKoakUI3g6a8HwvPcoC2ochHglest0jv/jBRbp9NnkRh6lKJs7FiBss9GUhsmbSQUQTm
    hhx2t/3o+dSxQxzAlAqECzo+b64Obcc3C5uzbmpp4oY26sCJ1V1opyAnvxWlzERGYlMVlu0mrAn8nE2qmpRri7/CZcUbHSbCV2/mcl3ArNiIOilLemg3cjRg
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=uNphubBhQK8A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=rEqvwrX8AAAA:8 a=nx57h0buAAAA:8 a=YWqwkbMXWZnkjELTUmEA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=2B8fXRCmRxTqFPaLtVU6:22 a=YtO9EDU9lxz8Tya6zqt4:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbeDYW0z (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 18:26:55 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41487 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbeDYW0y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 18:26:54 -0400
X-Google-Smtp-Source: AIpwx4/Y2vqiK7US3kkvTNjIK9E3Zr9xDIlRbyQBK9evhR5srOlYRjxnMoeF7uC9kDqwm71sEUnNAg==
Date: Wed, 25 Apr 2018 15:26:50 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Vittorio Gambaletta (VittGam)" <linuxbugs@vittgam.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        stable@vger.kernel.org, nick@shmanahar.org, bleung@chromium.org,
        Salvatore Bellizzi <lkml@seppia.net>, groeck@chromium.org
Subject: Re: [PATCH v2] input/touchscreen: atmel_mxt_ts: Add correct touchpad
 button mapping for the Caroline Chromebook.
Message-ID: <20180425222650.GC200812@dtor-ws>
References: <201804251232.w3PCWweA028076@mail.vittgam.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804251232.w3PCWweA028076@mail.vittgam.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 02:32:58PM +0200, Vittorio Gambaletta (VittGam) wrote:
> This patch adds the correct platform data information for the Caroline
> Chromebook, so that the mouse button does not get stuck in pressed state
> after the first click.
> 
> The Samus button keymap and platform data definition are the correct
> ones for Caroline, so they have been reused here.
> 
> v2: updated patch offset after 20180409 changes.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
> Signed-off-by: Salvatore Bellizzi <lkml@seppia.net>
> 

Applied, thank you.

> ---
> 
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -3035,6 +3035,15 @@
>  		.driver_data = samus_platform_data,
>  	},
>  	{
> +		/* Samsung Chromebook Pro */
> +		.ident = "Samsung Chromebook Pro",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Caroline"),
> +		},
> +		.driver_data = samus_platform_data,
> +	},
> +	{
>  		/* Other Google Chromebooks */
>  		.ident = "Chromebook",
>  		.matches = {

-- 
Dmitry
