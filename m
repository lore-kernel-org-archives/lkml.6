Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445BFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034092146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oj/fyZrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034092146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbeKPAez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:34:55 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36488 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732953AbeKPAey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:34:54 -0500
Received: by mail-lf1-f67.google.com with SMTP id h192so14265132lfg.3;
        Thu, 15 Nov 2018 06:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WZAAC9TYbP9LoKYcjoCGMwY/6Utuj5QmWalwbC7J0m8=;
        b=oj/fyZrSMh4irLmDGL5nqJd0WLDR4lxpU2xfKDyayMqS/58LUjwwDh+1b+dJWf8is8
         +36ZYsklSEuaeSQJpa2sXw99GwBhQwyBQBbyxnj5z2kqUBUEc48jUCPXyaJmudsdwBFg
         0Wooi9ijLdKFV7pJMMqWyfhgeLRGGHhWGwxymsx4UKYGMXxIPhExs8y/KhaeTQ9nRv0D
         xWpdrFL3bXYD1tqa9nFnLsiNJHUTy9o/wC3hMmky+NjsESZ5QoX5viCmbTcL8DPwFxLL
         U/G+OGS+6GXdeG9zxHEcqHS/NodfKVBFwgCV4uoeKoP+WNKC3r4XiU2n0sz4TrZMzP3T
         lPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WZAAC9TYbP9LoKYcjoCGMwY/6Utuj5QmWalwbC7J0m8=;
        b=GxYK21+V1VzoOA13ksceyfDdvoGX3oGDB3PJ+PcJ3PpZOs2qBAHPFiHzcX8GjjB2cf
         tZRwo3lxupCaipZDklMpJM3CS67gU7xjgWozdp5IHYmHzDnPedVEV440ZXHpKJtFhuew
         TynPXCnwfeFVMHj4LioXCtHJhGRJutnIjEtBkfiSGbydzKPTy7ui0hf/Vn0PHzkPR+pO
         5cnu4RK3/iJaL4ZblXT8H4h6atJVUKSm3ijhqXUudnjwePypvFW6OgRXGb/7h/F3mrOe
         QkMl//TbK+UFLJR0jwGaduA5NVicB5XJkirqA1ByuawT3qcREq9w00322d0+5wmIsGUb
         48MQ==
X-Gm-Message-State: AGRZ1gJRpmbCx4frmkSELpFWkshx7H8AWsfSRc856AEngvEB4k+JtXZv
        ttK627lk8/pJw2ZlknO4PHY=
X-Google-Smtp-Source: AJdET5cFTWYWzVo8P+td/MY0JYPzmImY6H9iBoGVtkMLP6cAjBZ4eh2u7BGe3c6n21aZnOd4eaPifQ==
X-Received: by 2002:a19:3809:: with SMTP id f9mr3414053lfa.148.1542292009531;
        Thu, 15 Nov 2018 06:26:49 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id t81sm4332593lfe.84.2018.11.15.06.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 06:26:48 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gNIbY-0006br-MA; Thu, 15 Nov 2018 15:26:48 +0100
Date:   Thu, 15 Nov 2018 15:26:48 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>
Subject: Re: [PATCH v2 5/9] mtd: nand: atmel: fix OF child-node lookup
Message-ID: <20181115142648.GJ19900@localhost>
References: <20180827082153.22537-1-johan@kernel.org>
 <20180827082153.22537-6-johan@kernel.org>
 <20180827102820.3abf7291@bbrezillon>
 <20180827084414.GZ14967@localhost>
 <20180827104842.26bce912@bbrezillon>
 <20180827094423.GA14967@localhost>
 <CAL_Jsq+fiM8E-za-fKufgDuoDqu3DY5a4bgZOuF3Ssvj2=6ayg@mail.gmail.com>
 <20181023205117.745a8f97@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023205117.745a8f97@bbrezillon>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 08:51:17PM +0200, Boris Brezillon wrote:
> On Tue, 23 Oct 2018 13:28:09 -0500
> Rob Herring <robh+dt@kernel.org> wrote:
> 
> > On Mon, Aug 27, 2018 at 4:44 AM Johan Hovold <johan@kernel.org> wrote:
> > >
> > > On Mon, Aug 27, 2018 at 10:48:42AM +0200, Boris Brezillon wrote:  
> > > > On Mon, 27 Aug 2018 10:44:14 +0200
> > > > Johan Hovold <johan@kernel.org> wrote:
> > > >  
> > > > > On Mon, Aug 27, 2018 at 10:28:20AM +0200, Boris Brezillon wrote:  
> > > > > > Hi Johan
> > > > > >
> > > > > > On Mon, 27 Aug 2018 10:21:49 +0200
> > > > > > Johan Hovold <johan@kernel.org> wrote:
> > > > > >  
> > > > > > > Use the new of_get_compatible_child() helper to lookup the nfc child
> > > > > > > node instead of using of_find_compatible_node(), which searches the
> > > > > > > entire tree from a given start node and thus can return an unrelated
> > > > > > > (i.e. non-child) node.
> > > > > > >
> > > > > > > This also addresses a potential use-after-free (e.g. after probe
> > > > > > > deferral) as the tree-wide helper drops a reference to its first
> > > > > > > argument (i.e. the node of the device being probed).
> > > > > > >
> > > > > > > While at it, also fix a related nfc-node reference leak.
> > > > > > >
> > > > > > > Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> > > > > > > Cc: stable <stable@vger.kernel.org>     # 4.11
> > > > > > > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > > > > > > Cc: Josh Wu <rainyfeeling@outlook.com>
> > > > > > > Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> > > > > > > Signed-off-by: Johan Hovold <johan@kernel.org>  
> > > > > >
> > > > > > Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>  
> > > > >
> > > > > Thanks for the ack.
> > > > >  
> > > > > > I'll let Miquel queue this patch to the nand/next branch, unless you
> > > > > > want it to be merged in 4.19, in which case I'll queue it to the
> > > > > > mtd/fixes branch.  
> > > > >
> > > > > Note that there's a dependency on the first patch of the series which
> > > > > adds the new helper.  
> > > >
> > > > I was not Cc-ed on this patch :P.  
> > >
> > > Yeah, sorry about that. I made sure everyone was CCed on the
> > > cover letter, but guess I could have reused that list for the helper as
> > > well.
> > >  
> > > > > Rob can pick up the entire series if the various
> > > > > maintainers agree, otherwise I'll try to get at the least the helper
> > > > > into -rc2.  
> > > >
> > > > If everything goes in 4.19-rc2 through Rob's tree that's fine, but if
> > > > it's queued for 4.20 we might need an immutable tag just in case we
> > > > queue conflicting changes to the NAND tree.  
> > >
> > > Ok, thanks.  
> > 
> > Hi Boris, can you pick this one up. It conflicts with "mtd: rawnand:
> > atmel: Fix potential NULL pointer dereference"
> 
> Sure, I'll queue it for -rc2.

This one hasn't showed up in -next yet, so sending a reminder.

Johan
