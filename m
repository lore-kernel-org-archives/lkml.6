Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5C5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC1A2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391919AbfAPKXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:23:42 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:32841 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731497AbfAPKXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:23:41 -0500
Received: by mail-qk1-f193.google.com with SMTP id d15so3457142qkj.0;
        Wed, 16 Jan 2019 02:23:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qENPHBLa3vkY2Rz1BSdZsiSdrZs10EHyo4tEcmR96hw=;
        b=FeOmnB/TyGFKNq835D/JtP2OO9x2q6kH0RPtGPmc2I7Q96deH0UuT3S+MoFqJ7ee2b
         dniFOv6kYYnSTfj/fa68cXJfRcovqUwcCCT71G+X1laJ0I7LSKfPa7alx+vBWG+SnqBD
         SK86YRrTFCaxRv4nJudRB4+itIr5cGhnTlGStkpyvSaG+LnBESXWzaHUIXTIW5cmo1U5
         CtbJPiecKiL/Y6k1YpYO3+l3QkZ6wQz/vd66eAWtNwvcRgQO/lNI8+ocgIv7mm6yE+nt
         lPHlUqUhlliJBJzWTYODBkuxW7wbViLLDtQg6mD1FUx371wzKvTE7EjHLlXAKUJNnRYb
         azvw==
X-Gm-Message-State: AJcUukcaOGIsGZ5q0jqSzjZZ7M6WsY5Z9IdQ/Gq2USnEcKRsk5R6iP6R
        4CoeqHvVPS3cB63Ng19oxbGy3qQa/lMf0eONWYA=
X-Google-Smtp-Source: ALg8bN7mvaGILjS6suKt8bGD4h5kdv5zMwhrIuJ2BgRGXw3yy49rbCLkwlSkJZnl9lox0+Li7yynjmFdR5M/X1zVzMc=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr5972882qkf.330.1547634220697;
 Wed, 16 Jan 2019 02:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20190115230613.28334-1-f.fainelli@gmail.com>
In-Reply-To: <20190115230613.28334-1-f.fainelli@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Jan 2019 11:23:24 +0100
Message-ID: <CAK8P3a2NHvWq=tNURuScDHLx7qT0RaBAsjewaf6T24HLJ68NkQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] net: dsa: Split platform data to header file
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Marvell Dove/MV78xx0/Orion SOC support" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 12:06 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Hi all,
>
> This patch series decouples the DSA platform data structures from
> net/dsa.h which was getting used for all sorts of DSA related
> structures.

Nice cleanup!

> It would probably make sense for this series to go via David's net-next
> tree to avoid conflicts on the ARM part, since we cannot obviously
> include a header that does not yet exist.

Agreed,

Acked-by: Arnd Bergmann <arnd@arndb.de>
