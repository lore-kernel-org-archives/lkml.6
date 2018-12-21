Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1879C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9D82192C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VYl3Jawv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390268AbeLUR0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:26:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52946 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731522AbeLUR0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+3FktsJOJTNaMqn+vtD75TNpAwQ+ag3XXFwS3qmotkk=; b=VYl3Jawv6+FWzScaNKAlt2Vjb
        ISm04/+GeXOoMtkW7qhYLCcgaMWYRq3NEwGVZhQpFlRCjDCxANEXjuHM703O3dsngWaM+uesh1tJg
        TEQLvwiAJ5O0Hh0OgpM921r9BZ/CAkM7M1ChJSAWTcgOruDV59x5YcfqFKmnefHrGcNP+SrLkyW6I
        kFcUTkiP+dZ5krq5WvDVWoqg4hvVUl6JdO9kPvXm3r8VQpE+cxeYKJpR4WecymNRghuTADm+eNKoa
        /9Rqp/Z3FcJDuI0+DCcAjoEyRCg3V6KbXjXkae4iaD31XjShe3FoO0zKeTZhb6VNYE0oaNtqes8lI
        D4qo1/miw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gaOZM-0005WE-FM; Fri, 21 Dec 2018 17:26:40 +0000
Subject: Re: linux-next: Tree for Dec 21 (acpi without CONFIG_PCI)
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
References: <20181221193244.3a6ed685@canb.auug.org.au>
 <6d1dca14-f0e7-7866-cb97-b3bbc57cdc8e@infradead.org>
 <CAK9iUCO_Pk3eYH+hyMuqU6weDsbzC9Sg1Z719fm8u_3Oh7s-iQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9cdc8072-101f-b683-02a1-8d57fda57b7e@infradead.org>
Date:   Fri, 21 Dec 2018 09:26:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAK9iUCO_Pk3eYH+hyMuqU6weDsbzC9Sg1Z719fm8u_3Oh7s-iQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/18 9:23 AM, Sinan Kaya wrote:
> 
> 
> On Friday, December 21, 2018, Randy Dunlap <rdunlap@infradead.org <mailto:rdunlap@infradead.org>> wrote:
> 
>     On 12/21/18 12:32 AM, Stephen Rothwell wrote:
>     > Hi all,
>     >
>     > News: there will be no linux-next release until Jan 2.  Have a good break.
>     >
>     > Changes since 20181220:
>     >
> 
>     on i386 or x86_64:
> 
>     ../drivers/acpi/acpi_lpss.c: In function 'acpi_lpss_find_device':
>     ../drivers/acpi/acpi_lpss.c:538:26: error: 'pci_bus_type' undeclared (first use in this function)
>       return bus_find_device(&pci_bus_type, NULL, &data, match_hid_uid);
>                               ^
> 
> 
> This needs to be closed by #ifdef CONFIG_PCI
> 
> Any other issues? 
> 

I saw a few others but I am still trying to see if they are real or not. ;)

>  
> 
>     ../drivers/acpi/acpi_lpss.c:538:26: note: each undeclared identifier is reported only once for each function it appears in
>     ../drivers/acpi/acpi_lpss.c:539:1: warning: control reaches end of non-void function [-Wreturn-type]
>      }
>      ^
> 
>     when CONFIG_PCI is not set/enabled.
> 
> 
> 
>     -- 
>     ~Randy
> 


-- 
~Randy
