Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBA0C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D538D2082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D538D2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeJDVcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:32:46 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40611 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeJDVcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:32:46 -0400
Received: by mail-qt1-f194.google.com with SMTP id b4-v6so2047195qtc.7;
        Thu, 04 Oct 2018 07:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S8kY2KZcv5clBm6IljvPQOeVp2ZgUbugkxxstMi9iu4=;
        b=LteK12j7+1ovzWLhcudq8dzCfbqFNeSv94ZLe+pBTae2uDitXV4kN0ySnBHoVGRQlw
         f0LDAPfa74T/dIWKHc7QrhGEp/FIkauUpLYdr1gqDACD34LN4hcZBgP9x4iioUn3VchP
         3+/rPm2h3lCSDYXMVKPkZ6y48PF/Z9XkyngUdt9Fka8vHSU3QUJPCr0BRd98O2qMxt2W
         9VW3UnO2hNEdV3Lny9lk+T4Wy0y4NyFkCklJRyD7f36lFm5iOuKQKz+eUltBdbIeACEH
         dHSYFoERl66B94cEyW1GOaVmGG5UwAzKJXM9WR4DrnkdGGl/FodsY4RBK/ipIQyMHG6D
         Y59A==
X-Gm-Message-State: ABuFfoivFbN0Q9cb8jbuHXsI0DxrTzXUirZE3qGLt/fRJspOIdxedjyl
        OYsBum26xzD9gWrXhj604tOwe6o1shvph9WMvtQ=
X-Google-Smtp-Source: ACcGV60oO5m0XqX6FPxBekVW7eerkvmCEC6HjFj34/sHDJNjrdMvNlCdyjPQ3KjX/uGLJpHpVjzkmH25wJM+hHrSfjU=
X-Received: by 2002:aed:3f08:: with SMTP id p8-v6mr5532329qtf.185.1538663949960;
 Thu, 04 Oct 2018 07:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180810080526.27207-1-brgl@bgdev.pl> <20180831194643.GA62862@ban.mtv.corp.google.com>
 <CAMRc=MejZLV1EQ7uAddsxLY0MTUF8WyiBn=F0ZhkWQJpET0EDQ@mail.gmail.com>
 <a4c2e6cf-749a-83a1-0bda-43ddb7e744cd@gmail.com> <CAMRc=MfwM7vODsnuV9eKS4Uf7M5ac59u7ao7KvyaxKzPv5FRvw@mail.gmail.com>
 <CAK8P3a1LufzR1_6mXH=1zDb34VQStLywGM1w5x5CDAMh_7uMyA@mail.gmail.com> <20181004143508.GG13299@oracle.com>
In-Reply-To: <20181004143508.GG13299@oracle.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Oct 2018 16:38:51 +0200
Message-ID: <CAK8P3a3Z7CT3tV=mMB-qZFJfyamP0kTHK2PPCbqzh-WXDNdPZA@mail.gmail.com>
Subject: Re: [PATCH v2 00/29] at24: remove at24_platform_data
To:     Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        gregkh <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        naren.kernel@gmail.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        ivan.khoronzhuk@linaro.org, svendev@arcx.com, pabeni@redhat.com,
        Alban Bedel <albeu@free.fr>, Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 4:36 PM Sowmini Varadhan
<sowmini.varadhan@oracle.com> wrote:
>
> Just catching up on this thread, so please excuse any unintentional
> misquotes here.
>
> > > > > David: I couldn't find a place in sparc code where any ethernet device
> > > > > would be registered, so is there a chance that nobody is using it?
> > > >
> > > > SPARC uses a true Open Firmware implementation, so it would register
> > > > drivers through the CONFIG_OF infrastructure.
>
> correct
>
> > The calls are not even that old, and clearly added intentionally for sparc,
> > see commit ba94272d08a7 ("i40e: use eth_platform_get_mac_address()")
> > which added the first one.
>
> Yes, correct again. Wouldn't PPC also end up doing the same thing?
>
> See also commit c762dff24c06 (for ixgbe) - without this fix sparc systems
> will come up with a bogus mac address and then you end up having to
> manually fix this in ugly ways.

The of_get_mac_address() portion is not controversial at all I think,
the question was whether we need the fallback to
arch_get_platform_mac_address() in any of the drivers that
call eth_platform_get_mac_address().

      Arnd
