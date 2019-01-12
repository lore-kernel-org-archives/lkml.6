Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E481C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C51E2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYzLVgU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfALBrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 20:47:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34736 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfALBra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 20:47:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so7539172plz.1;
        Fri, 11 Jan 2019 17:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7ahfG1fhpR6sKoLe8rUEuXte8fjAZS1mXKqHwDqjHMg=;
        b=WYzLVgU8oBXcQo2B6b9lAcpdxWbsXRirXq7/3gD2JzyUdXUFVDwraJ3G27Pz+Jpb8R
         HsPKszhjQgH3Sud71P2uY22aqYWdDAqpQr58M5wsQKnuQZSyzeGeYyFx43uq+J67O7uM
         whIEonanS+Zxc5yJAPFsnlnNHaXSg6gvujSfDgIj11lybCSmIQkUds8TtAY3p+VbZRvV
         wjaU3azlyCpFBV9S50OE65EDT3Atecm9EqcSbD5T0j0aR9+H56N2LkFhYfZtxkswRRnP
         DQp2gmaPkNSXccoRxaU21vzocMt5N8Lov7BmQBb5vnzIHVDpSQtKygbedrqLATMMFrez
         nu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7ahfG1fhpR6sKoLe8rUEuXte8fjAZS1mXKqHwDqjHMg=;
        b=uepV6NqhsLLrW2ES4P6FT1/UT2uZ99qMIYByA2N7+zF6V/q14B5PMpU26QTcI/bqvh
         aZzMt4ZZ7SQHx32xRzXvs5ExITurjixElxsqN04/sVmAJgJc12f7DvgGBqj92JOD2rJ/
         fxY7WgBJiL76pRo8qQM7LUdni7MMhXBl5Cfi3jPmLr1QcsMNamY9ETEWDyR1jot18lTR
         t518q69fvjWDk07uzEKNZWmygcEsZCLSkB1Cbu6KK1Upd/3idmWY6BV+Q4XbSx4nqZzz
         sWiwFz6Z7AQicUslj4cSHyBKf77soLaVcbOFrE/Q5228s2tK3bKwgparZecEo3pBxNQx
         8Faw==
X-Gm-Message-State: AJcUukcCz6j6yy3DNUxtPDCCuo191R2o0LDqNW14Mlf81ogtGtgm/jVl
        XY8fuRJsjZw0lewvlcAh7z6FYDrP
X-Google-Smtp-Source: ALg8bN6qAXLqsdEgK51q8VJo/bgY26A5oGfQGYey7fW1d+FVxZaGCPXXnC+gBKekDs/9fkS4s5dN2A==
X-Received: by 2002:a17:902:108a:: with SMTP id c10mr17134232pla.131.1547257649279;
        Fri, 11 Jan 2019 17:47:29 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id t29sm122649661pfa.158.2019.01.11.17.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 17:47:28 -0800 (PST)
Date:   Fri, 11 Jan 2019 17:47:26 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: tca6416-keypad: use struct_size() in kzalloc()
Message-ID: <20190112014726.GB122403@dtor-ws>
References: <20190108152816.GA7486@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108152816.GA7486@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 09:28:16AM -0600, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/tca6416-keypad.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
> index dc983ab6c0ad..cdeef180aead 100644
> --- a/drivers/input/keyboard/tca6416-keypad.c
> +++ b/drivers/input/keyboard/tca6416-keypad.c
> @@ -219,9 +219,7 @@ static int tca6416_keypad_probe(struct i2c_client *client,
>  		return -EINVAL;
>  	}
>  
> -	chip = kzalloc(sizeof(struct tca6416_keypad_chip) +
> -		       pdata->nbuttons * sizeof(struct tca6416_button),
> -		       GFP_KERNEL);
> +	chip = kzalloc(struct_size(chip, buttons, pdata->nbuttons), GFP_KERNEL);
>  	input = input_allocate_device();
>  	if (!chip || !input) {
>  		error = -ENOMEM;
> -- 
> 2.20.1
> 

-- 
Dmitry
