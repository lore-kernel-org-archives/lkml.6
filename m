Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8594ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A6820C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E3Rgf+5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A6820C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbeIRXdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:33:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38939 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730630AbeIRXdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:33:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id w14-v6so1365680plp.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 10:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1YMjL0m5gI9+orTo/OOX3+zgXOrquTY1uAnK0Nmj0X8=;
        b=E3Rgf+5sKCJp1fIwWFUfNju4uKOnff5EOQeNwaH0ETHNvTAci+jRKPVdjKM7fsRQ4N
         Myp32cNDPYvGvVcuVG+HbdJ8V91GmCtgDZJdn8tWaEoAJOvk3laiDPcFrvaXHIT2o85m
         NVzttkabmhQ3wrnYpnGYY8pj7zLJWMtEbMgfznWqHF5CDboEupglSDXywtxE2/CXcLB4
         3HvGYqSmgCL7Dkqd67PxVs7G2wK7TvnqjqMvkBMVN6Y38q8MzwemPI78BGVLq0Z4lBLL
         mZx5hu5h0fAUGDX9Lggqih1FyuXOxA6/Z/t9HU8zVFu3c9ITSeknG1I9/S1TE1OTTVl2
         FVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1YMjL0m5gI9+orTo/OOX3+zgXOrquTY1uAnK0Nmj0X8=;
        b=HNPOQnTSA3xA5A0dXDZtf8eu1bFnJdtMlBi4Z4NBJwblNfHe/8wpv+ABYbUIRtwqLC
         xCXC4PjYXvHY8Eu9+IVVZx5WvNKxph7KxHSj73utQ+9AhvMlaahd6P/nahzS2JsOAelc
         eHOOA1wKwxw6JpvV26/fT0BtNcLpWqLgSmc9/MbzJyOCqFi5icu4+PFVCh14FSSiRnz7
         0o9w8RG1g3kV7Y+eY2+fFhiYFDB5UHDLbNzQ992HoCfXevKvucSQ9KVoYr5n4e+hBdP9
         zQNYlasFu9qq/XBs2tQbLYnpvGxZTR3Rdxii6YnjwLo1l+JBWbjXziXBNoRAEZJcsjn6
         paCA==
X-Gm-Message-State: APzg51B48kiWFWsGweZZS1Dny7YLNPDDerYYruH2hihRZO4rDzDU99n7
        rjoBuG9N6Vobp2rLdb9/P7digw==
X-Google-Smtp-Source: ANB0Vdb0e4zsZHPF3tmkCzY19yo4JxJCIYO51BgGh1fEvYcazOvN/QDcJTjboCJnsLgv9ICK3z0hzg==
X-Received: by 2002:a17:902:b947:: with SMTP id h7-v6mr30970195pls.157.1537293594224;
        Tue, 18 Sep 2018 10:59:54 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id z11-v6sm31052475pfi.4.2018.09.18.10.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 10:59:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g2KHw-000695-Lv; Tue, 18 Sep 2018 11:59:52 -0600
Date:   Tue, 18 Sep 2018 11:59:52 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Darren Hart <dvhart@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, linux-crypto@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 05/17] compat_ioctl: move more drivers to
 generic_compat_ioctl_ptrarg
Message-ID: <20180918175952.GJ11367@ziepe.ca>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912151134.436719-1-arnd@arndb.de>
 <20180914203506.GE35251@wrath>
 <20180914205748.GC19965@ZenIV.linux.org.uk>
 <20180918175108.GF35251@wrath>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918175108.GF35251@wrath>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 10:51:08AM -0700, Darren Hart wrote:
> On Fri, Sep 14, 2018 at 09:57:48PM +0100, Al Viro wrote:
> > On Fri, Sep 14, 2018 at 01:35:06PM -0700, Darren Hart wrote:
> >  
> > > Acked-by: Darren Hart (VMware) <dvhart@infradead.org>
> > > 
> > > As for a longer term solution, would it be possible to init fops in such
> > > a way that the compat_ioctl call defaults to generic_compat_ioctl_ptrarg
> > > so we don't have to duplicate this boilerplate for every ioctl fops
> > > structure?
> > 
> > 	Bad idea, that...  Because several years down the road somebody will add
> > an ioctl that takes an unsigned int for argument.  Without so much as looking
> > at your magical mystery macro being used to initialize file_operations.
> 
> Fair, being explicit in the declaration as it is currently may be
> preferable then.

It would be much cleaner and safer if you could arrange things to add
something like this to struct file_operations:

  long (*ptr_ioctl) (struct file *, unsigned int, void __user *);

Where the core code automatically converts the unsigned long to the
void __user * as appropriate.

Then it just works right always and the compiler will help address
Al's concern down the road.

Cheers,
Jason
