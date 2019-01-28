Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093ABC282CC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 02:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF9020856
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 02:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="Vc3zXRw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfA1Cg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 21:36:28 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:47058 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfA1Cg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 21:36:28 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so6553833pgp.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 18:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ETp5nWmStm2Uk3wtEtCFcdmfGesajHy+Vdnq1gFLSl8=;
        b=Vc3zXRw9f/iZ96INbwVz/HL74Ih5rxMvkIwXUYNJS039hM8cxmihcFYuhfg0q69Z6h
         YgCJavjVbYgyJRSwFpIiFKk1tVvv2u+79EiTxFC9VpX6IRltxyX3e6+FC73xOPmteABV
         eNvq/rcWZ6ssmrAvp+fDFS2OhLskhQDSEn16dsU84yHFdUgP05IwvescJNdCTGatamU+
         JJRtjxoaNw8KDDekmPwHVyNPDQWoL20eauszexzraDveimQl6wxWnBpa88izLLbcvgxo
         WR92voHlRxueCiI1t4diRZuvMhMMcmpGGVl+gwL/Ip4cqSeYX6fMd3+ipZ62eq9jYLT8
         7iRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ETp5nWmStm2Uk3wtEtCFcdmfGesajHy+Vdnq1gFLSl8=;
        b=b6GOffwhWdoEvz52RdFnyqOcmTi72NEd0y7KJUdXwOEoaKfA1Zno465g0x+uMb1sCc
         KvXiWVnNPnSzlZ+rdS3tQerAL+MZv2Dkabzz/iUp0EiBwxfwPzYNDlcrXJJLycknk2wl
         8OY8egaXymU5ztmqrm7HPUwo5Ir+qrfKpzNcuI7EDCA6z9P9igG6TxlSdHsfUaK9Bmvc
         pK6bf4OwCwowG4tl5XudTfd4YERL1LYuni0BVQPX+rrQzlynL+F53hKUeUH6Dx8u60xa
         cvlPz8JCdpxIOd9e5qzomhGQiD8ikoY0SqbpmIUqGCGUlMiXW228SWS5AThWJ2xyolLc
         Od+A==
X-Gm-Message-State: AJcUukdLO0sJCoDFNAtsvG7Zs28GMB2Rk7rkU28itvtCF0A3AY7MHHTA
        YtTyl00Yitei8mD/FietQzoCgQ==
X-Google-Smtp-Source: ALg8bN5xA2M0FEsfff2o1Lm8F20N0KytLy6MAfdHF6gJ0cddLt9DnboybthQDqdqc2PhnVRX8zZhCg==
X-Received: by 2002:a62:2c81:: with SMTP id s123mr20085383pfs.174.1548642986870;
        Sun, 27 Jan 2019 18:36:26 -0800 (PST)
Received: from minyard.net ([2001:470:b8f6:1b:2494:1989:377c:bd77])
        by smtp.gmail.com with ESMTPSA id m65sm71933739pfg.180.2019.01.27.18.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 18:36:25 -0800 (PST)
Date:   Sun, 27 Jan 2019 20:36:23 -0600
From:   Corey Minyard <cminyard@mvista.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net, qiaonuohan@huawei.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [Openipmi-developer] [PATCH v2] ipmi_si: fix use-after-free of
 resource->name
Message-ID: <20190128023623.GA4979@minyard.net>
Reply-To: cminyard@mvista.com
References: <1548494094-14356-1-git-send-email-yangyingliang@huawei.com>
 <20190126150809.GA11354@minyard.net>
 <5C4E609A.7050609@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C4E609A.7050609@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 09:53:30AM +0800, Yang Yingliang wrote:
> 
> 
> On 2019/1/26 23:08, Corey Minyard wrote:
> > On Sat, Jan 26, 2019 at 05:14:54PM +0800, Yang Yingliang wrote:
> > > When we excute the following commands, we got oops
> > > rmmod ipmi_si
> > > cat /proc/ioports
> > > 
> > snip..
> > 
> > > If io_setup is called successful in try_smi_init() but try_smi_init()
> > > goes out_err before calling ipmi_register_smi(), so ipmi_unregister_smi()
> > > will not be called while removing module. It leads to the resource that
> > > allocated in io_setup() can not be freed, but the name(DEVICE_NAME) of
> > > resource is freed while removing the module. It causes use-after-free
> > > when cat /proc/ioports.
> > > 
> > > Fix this by calling io_cleanup() while try_smi_init() goes to out_err
> > > and don't call release_region() if request_region() is not called to
> > > avoid error prints.
> > > 
> > > Fixes: 93c303d2045b ("ipmi_si: Clean up shutdown a bit")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: NuoHan Qiao <qiaonuohan@huawei.com>
> > > Suggested-by: Corey Minyard <cminyard@mvista.com>
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > ---
> > >   drivers/char/ipmi/ipmi_si_intf.c    | 5 +++++
> > >   drivers/char/ipmi/ipmi_si_port_io.c | 3 +++
> > >   2 files changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> > > index dc8603d..f1b9fda 100644
> > > --- a/drivers/char/ipmi/ipmi_si_intf.c
> > > +++ b/drivers/char/ipmi/ipmi_si_intf.c
> > > @@ -2085,6 +2085,11 @@ static int try_smi_init(struct smi_info *new_smi)
> > >   	WARN_ON(new_smi->io.dev->init_name != NULL);
> > >    out_err:
> > > +	if (rv && new_smi->io.io_cleanup) {
> > > +		new_smi->io.io_cleanup(&new_smi->io);
> > > +		new_smi->io.io_cleanup = NULL;
> > > +	}
> > > +
> > >   	kfree(init_name);
> > >   	return rv;
> > >   }
> > > diff --git a/drivers/char/ipmi/ipmi_si_port_io.c b/drivers/char/ipmi/ipmi_si_port_io.c
> > > index ef6dffc..0c46a3f 100644
> > > --- a/drivers/char/ipmi/ipmi_si_port_io.c
> > > +++ b/drivers/char/ipmi/ipmi_si_port_io.c
> > > @@ -53,6 +53,9 @@ static void port_cleanup(struct si_sm_io *io)
> > >   	unsigned int addr = io->addr_data;
> > >   	int          idx;
> > > +	if (io->regsize != 1 && io->regsize != 2 && io->regsize != 4)
> > > +		return;
> > > +
> > Why do you need this part?  I can't see the reason for it.  The addr
> > part below should handle that, especially with the above change.
> > 
> > -corey
> If ipmi_si_port_setup() returns in default case, request_region() won't be
> called,
> so we don't need to call release_region() or it will prints some warning
> messages like
> this "Trying to free nonexistent resource...".
> 
> We don't need call io_cleanup() until the io_setup() returns successful.
> How about change this part like this:
> 
> diff --git a/drivers/char/ipmi/ipmi_si_port_io.c
> b/drivers/char/ipmi/ipmi_si_port_io.c
> index ef6dffc..03924c3 100644
> --- a/drivers/char/ipmi/ipmi_si_port_io.c
> +++ b/drivers/char/ipmi/ipmi_si_port_io.c
> @@ -68,8 +68,6 @@ int ipmi_si_port_setup(struct si_sm_io *io)
>         if (!addr)
>                 return -ENODEV;
> 
> -       io->io_cleanup = port_cleanup;
> -
>         /*
>          * Figure out the actual inb/inw/inl/etc routine to use based
>          * upon the register size.
> @@ -109,5 +107,8 @@ int ipmi_si_port_setup(struct si_sm_io *io)
>                         return -EIO;
>                 }
>         }
> +
> +       io->io_cleanup = port_cleanup;
> +
>         return 0;
>  }
> 
> Thanks,
> Yang

That, I believe, is the right fix.  Same thing for memory I/O, too.

Thanks,

-corey

> > 
> > >   	if (addr) {
> > >   		for (idx = 0; idx < io->io_size; idx++)
> > >   			release_region(addr + idx * io->regspacing,
> > > -- 
> > > 1.8.3
> > > 
> > > 
> > > 
> > > 
> > > _______________________________________________
> > > Openipmi-developer mailing list
> > > Openipmi-developer@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/openipmi-developer
> > .
> > 
> 
> 
