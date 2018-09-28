Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1658AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABE821733
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="otL/vCqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABE821733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbeI1Hch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 03:32:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbeI1Hcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 03:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RQTIFlhiAbF14gcWHKH9T8TTV28V1GiSODEwWQGimms=; b=otL/vCqLRigPh+AGVOkK3ZVIA
        JVFuAGQ0IiZsCe/rKr6Zs/GdoDPOSrat8LW4LTuhDDsFiscHsnF3uTmU6o/6gqvHtj++eefCl2pdb
        AAyod6bmlnMi4vWhfjB1XRQGc/8HtvH9ch5NgsjPBIoSw4qkmFsOp8sZdnVyeEu1tW887UuOOb+Pz
        lkuRGCVRJX6/rcllUViHF4KZX85zApHaLr6nkUr4x5+c0NAGpgwHhRj/cH6X8AuHJFVo+qRC4xAGv
        fr/TB4HHyYlyQI5LVa14p8D9Ex09Y7QrAKehmQVmL/38nX0Hpo/5NWHq6mD5VCvEyDRsjyjfgOEB9
        EHgm/5Kbg==;
Received: from 177.41.129.251.dynamic.adsl.gvt.net.br ([177.41.129.251] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5hJ7-0003t2-K0; Fri, 28 Sep 2018 01:11:23 +0000
Date:   Thu, 27 Sep 2018 22:10:54 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Russ Anderson <rja@hpe.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Justin Ernst <justin.ernst@hpe.com>, russ.anderson@hpe.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: Re: [PATCH] Raise maximum number of memory controllers
Message-ID: <20180927221054.580220e5@coco.lan>
In-Reply-To: <20180927220355.GF19687@zn.tnic>
References: <20180925180458.GG23986@zn.tnic>
        <20180926093510.GA5584@zn.tnic>
        <20180926152752.GG5584@zn.tnic>
        <20180926130340.6b22918b@coco.lan>
        <20180926161749.GI5584@zn.tnic>
        <20180926181035.GA1132@agluck-desk>
        <20180926182317.patqjso7nzw2oxiz@hpe.com>
        <20180926230257.GA5666@agluck-desk>
        <20180927045244.GA30912@zn.tnic>
        <20180927214400.GA2249@agluck-desk>
        <20180927220355.GF19687@zn.tnic>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 28 Sep 2018 00:03:55 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Thu, Sep 27, 2018 at 02:44:01PM -0700, Luck, Tony wrote:
> > The problem with your patch that gets rid of EDAC_MAX_MCS is making
> > device links under /sys/bus/edac.  Which is hinted at in some of the
> > code your patch deleted:
> > 
> > -       /*
> > -        * The memory controller needs its own bus, in order to avoid
> > -        * namespace conflicts at /sys/bus/edac.
> > -        */
> > -       name = kasprintf(GFP_KERNEL, "mc%d", mci->mc_idx);
> > -       if (!name)
> > -               return -ENOMEM;
> > -
> > -       mci->bus->name = name;  
> 
> Yes, and that needed to go because I am using a single bus. Which kinda
> makes sense because you want to have a single bus and multiple devices
> on it. I mean, if we *have* to have a bus.
> 
> I think this whole /sys/bus/edac thing is crap and needs to go. We
> have a perfectly fine hierarchy under /sys/devices/system/edac and
> duplicating it under /sys/bus/edac is just bollocks. IMHO. Feel free to
> correct me with, but but, this is useful for...
> 
> > which seemed to work.  
> 
> Right.
> 
> > But then I began wondering what are ABI expectations
> > from applications that read the EDAC /sys files?
> > 
> > Is this this current source repository?  https://github.com/grondo/edac-utils
> > 
> > This code doesn't seem to know about the "dimm*" directories below the
> > "mc*" level. It just looks for the csrow* entries.  
> 
> I guess this is a question for Mauro. I never really needed any special
> edac tool to get info and if you ask me, we probably should try to keep
> it simple and grep sysfs. So that you can always get the info without
> having to install any special tools. Like ftrace works on every system
> with just a shell and basic tools. I think this is very powerful. But
> this is old spartan me only thinking out loud.
> 
> In any case, I'm more than fine with dropping the bus hierarchy if
> nothing uses it.

I don't remember about any rationale behind /sys/bus/edac. It was
there already before I start working on EDAC about 10 years ago.
I guess it was used in the past by edac-utils (or maybe it is just a
side effect of the need to create a bus on some past).

Btw, The documented EDAC ABI is /sys/devices/system/edac, as
described at Documentation/ABI/testing/sysfs-devices-edac.

So, I suspect it should be safe to get rid of /sys/bus/edac,
provided that it won't cause side effects at /sys/devices/system/edac.

Why I think it is safe to get rid of /sys/bus/edac?
---------------------------------------------------

As far as I can tell, there are only two toolsets: the legacy edac-utils
and the rasdaemon. At least on Fedora 28, both applications are 
packaged (meaning that there are probably people using both).

The edac-utils uses the old sysfs entries (the ones whose entries
are dated up to 2007). I don't see any changes upstream for it
since 2008:

	https://sourceforge.net/projects/edac-utils/

I did a grep on its source code (on its version 0.16, from 2018). It seems
that it uses only /sys/devices/system/edac.

The rasdaemon uses also the new sysfs entries (the ones dated as
2012 and 2016). I'm maintaining it. Rastool not only receive traces,
but it can also store them on a database and even generate ABRT events.
It also uses only /sys/devices/system/edac.

On both toolsets, the sysfs entries there are important, in order to 
not only list the memory layout and error counts, but also to store
the dimm labels.

The rasdaemon itself uses perf trace events, although Aris added
support for it to work on non-daemon mode, where it just reads
the counters via sysfs, at /sys/devices/system/edac.

Thanks,
Mauro
