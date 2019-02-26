Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC544C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF11E2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTQwFOpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfBZRpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:45:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36397 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfBZRpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:45:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id n22so6591834pfa.3;
        Tue, 26 Feb 2019 09:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gWgd9sjucpWTZD4J6vTFeDqquWqoHyz6+IL077UU6r8=;
        b=DTQwFOpCmvAwEV/Cof5aFF98O2xbonAeIurhgLWc9dFS4GgE5l875fhufeXADggawL
         tr+zDr7ivCFWwwKOY2y63LbMEMv3Rjj8VkXnfJ/me44WdZgUBU+R4rAQOnj3XGgy0Ngk
         VL+yHceJS0LnCsggD8+IaSnvGAGENeX+lmTBnquWRrWxVmHNrIbScsV/nYH1f/qfxHhC
         ZdNaioEA4MM1tBy5CXWmzHmLolUV7RMqTcmt2olmE4t+K+J4ca5DMAKSn3Ojg2VKKkX9
         P1H13wgoAIeDLwaQiPRPqzHbj9v+6bjsyE+XNf8eX3z4VwxWVKYDGoY1YOLTMVb9fhka
         VxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=gWgd9sjucpWTZD4J6vTFeDqquWqoHyz6+IL077UU6r8=;
        b=ByHq4ZiWbRUkxB80zw+Nb/7m3KZGQtTuxp8HKo+ySRpWqbJejDIUjQuK+twPtAf6GN
         MjBYoD3FGMJPRXUwLz1FeefqEXOFH+6ViSdCyazUJdqutEioyACN4vqLahkGyl34p4pT
         qVXU9gTAnh1cWdqEZPJgg93MQ+cv6uh1l8MunVlOZ/pPPMTkEgRRZVw4+4PrralHda7b
         RoPMiXMfy9q93PVfnRByFve4oAlcUC5SbwDnMFzoujOLEB7tuHDNyp5TO02WDa06Z1Gb
         UVJp7HbEMbDe8rBSDzCqHBAMKLgRY1ZWEMjt/+06ufJr8B1Qi0cxKvpQBNANJJPAO6IE
         ipNQ==
X-Gm-Message-State: AHQUAua6oVm3TrXITkXz1EMoRkeI6tsxGCpO0E5c2ZCbW408VkEj74aZ
        /u4ODuGsbnWLRZvxZIV1UlSo3LUK
X-Google-Smtp-Source: AHgI3Ia2TJI7uBijaekUOZwrpTziG6bkFLeqBhY7dBfXsIKa8hXzBv3j1PE+FMkAbz9kb0Y7QmanHA==
X-Received: by 2002:a63:1947:: with SMTP id 7mr5627006pgz.279.1551203108847;
        Tue, 26 Feb 2019 09:45:08 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f2sm14080046pgn.43.2019.02.26.09.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 09:45:08 -0800 (PST)
Date:   Tue, 26 Feb 2019 09:45:07 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] watchdog: smsc37b787_wdt: Mark expected switch
 fall-through
Message-ID: <20190226174507.GC8682@roeck-us.net>
References: <20190214201601.GA13098@embeddedor>
 <b914131b-fd1d-2a99-4903-856e2808034d@roeck-us.net>
 <a9aad06b-7917-328d-30fb-1c3e873bbe35@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9aad06b-7917-328d-30fb-1c3e873bbe35@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 11:42:06AM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 2/18/19 10:08 AM, Guenter Roeck wrote:
> > On 2/14/19 12:16 PM, Gustavo A. R. Silva wrote:
> >> In preparation to enabling -Wimplicit-fallthrough, mark switch
> >> cases where we are expecting to fall through.
> >>
> >> This patch fixes the following warning:
> >>
> >> drivers/watchdog/smsc37b787_wdt.c: In function ‘wb_smsc_wdt_ioctl’:
> >> drivers/watchdog/smsc37b787_wdt.c:480:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>     wb_smsc_wdt_set_timeout(timeout);
> >>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/watchdog/smsc37b787_wdt.c:482:2: note: here
> >>    case WDIOC_GETTIMEOUT:
> >>    ^~~~
> >>
> >> Warning level 3 was used: -Wimplicit-fallthrough=3
> >>
> >> Notice that, in this particular case, the code comment is modified
> >> in accordance with what GCC is expecting to find.
> >>
> >> This patch is part of the ongoing efforts to enable
> >> -Wimplicit-fallthrough.
> >>
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > 
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > 
> 
> Thank you, Guenter.
> 
> 
> Friendly ping:
> 
> Who can take this?
> 

It is queued in my watchdog-next branch. Usually Wim will pick it up from there.

Guenter
