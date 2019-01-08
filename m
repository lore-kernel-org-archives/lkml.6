Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3579FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0809820827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfAHOT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:19:57 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:38944 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfAHOT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:19:56 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43YvXp181Yz1qvvt;
        Tue,  8 Jan 2019 15:19:54 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43YvXp0gqBz1qsmq;
        Tue,  8 Jan 2019 15:19:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id U15Wt6_AOx7H; Tue,  8 Jan 2019 15:19:53 +0100 (CET)
X-Auth-Info: lZc5goRwx9bOQzAiT+W3PgNf3qSRy0dUZd8jAdMZeS2gSP/kIT2VXCU5sD6fsoKy
Received: from hawking (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  8 Jan 2019 15:19:53 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kars de Jong <jongk@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dio: Fix buffer overflow in case of unknown board
References: <20190108140606.12184-1-geert@linux-m68k.org>
X-Yow:  Does someone from PEORIA have a SHORTER ATTENTION span than me?
Date:   Tue, 08 Jan 2019 15:19:52 +0100
In-Reply-To: <20190108140606.12184-1-geert@linux-m68k.org> (Geert
        Uytterhoeven's message of "Tue, 8 Jan 2019 15:06:06 +0100")
Message-ID: <mvmo98rgrjr.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 08 2019, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> @@ -90,7 +90,7 @@ static struct dioname names[] =
>  #undef DIOFBNAME
>  
>  static const char *unknowndioname 
> -        = "unknown DIO board -- please email <linux-m68k@lists.linux-m68k.org>!";
> +	= "unknown DIO board, please email linux-m68k@lists.linux-m68k.org";

This could be declared as an array.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
