Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D492BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBB82151C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvmF5kkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBB82151C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbeISTtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:49:14 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43148 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeISTtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:49:14 -0400
Received: by mail-qt0-f194.google.com with SMTP id g53-v6so5165880qtg.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ntXdo5eR2qLskz19JgJe715P42c6FdZw3PuP30MwzSQ=;
        b=kvmF5kkd6/9lBOb8Ecl5OknWf3fJDDzxqs0lQkKaZh7xvNxqYVT+5GAxq4Ylqf4qLo
         Go3UxdnW4nm9Qw9F7c5mlN78lpBhReOG8OC1IwzvNRzxJ4Dmx53QnEQDjiSUPnrGgUqP
         p5Qggja+02xmrGIcUqUdcmpgCCzfQykqEgxOrCVeBvX/oOwr6OxrWoblscGA4xPDaNVD
         SJ+5od+fqQaBn2UtrX2qVIp/L/8HzZKFJMI0rbjrw7tS8wFObe8AXtYAnyxu3W2wFsmA
         mwdj+ec7fzyEkHHSAzYoIrUq+zAhkdBmeq+dPeROPDF9TJdUkKvjqjcz61a3c4qle3P7
         sBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ntXdo5eR2qLskz19JgJe715P42c6FdZw3PuP30MwzSQ=;
        b=leePikG91IBNgoiC+mB+vdZZGhCPZSh3N2jqpvH37kWDJEzHPj4wlKuQCHA8KqgNgW
         sAFBIiagBgMybSXWJbANsd+SDwMpaoogzCabd8eTul4ApLS1VDi+zzrwLj68iJiZ6MTh
         uIMDHat6MrGH+teJxoWo7mIIrq6tWJ220xF8xWTQ8HgSUuldYGW4mCjjA6/j8IzT5Vay
         AwABvGBrtUPcfw04+M83ZZcBa6TZSlfBs/70PVSBSAxWa1e5qarWlqexDP6Bo7Gcig91
         cyORs71MFP6BkFEw9lQGM/s39YeSL/4fq6tY3PQEfBeAad3tLxG2qzozLqgUyilJBsuE
         FK/g==
X-Gm-Message-State: APzg51DOqzuTmMcdvBqgA5Co00L8sypTxJizAYoU+sDj+7mBRSB59Qii
        TFC1EPT4DbUTpxZx/shHkg==
X-Google-Smtp-Source: ANB0Vdbo+BZ7kIqXbEPP1CjdyOoFV1PTal8AeepDDgtsTuphtIBHXHtWBdj8goYbB9vthHb5v4PlFA==
X-Received: by 2002:ac8:3759:: with SMTP id p25-v6mr24486438qtb.310.1537366267254;
        Wed, 19 Sep 2018 07:11:07 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v31-v6sm16587457qta.96.2018.09.19.07.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 07:11:06 -0700 (PDT)
Date:   Wed, 19 Sep 2018 10:10:59 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Baoquan He <bhe@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, mike.travis@hpe.com,
        sivanich@hpe.com, Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: Re: [PATCH v3 1/2] x86/mm: Add an option to change the padding used
 for the physical memory mapping
Message-ID: <20180919141058.krruhvsjkm6hqgmf@gabell>
References: <20180904151141.20264-1-msys.mizuma@gmail.com>
 <20180918133026.gzyix3oyrfcsrdcx@gabell>
 <20180919121720.GA47424@gmail.com>
 <alpine.DEB.2.21.1809191421500.18945@nanos.tec.linutronix.de>
 <20180919124806.GA48413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919124806.GA48413@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 02:48:06PM +0200, Ingo Molnar wrote:
> 
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Wed, 19 Sep 2018, Ingo Molnar wrote:
> > > * Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> > > 
> > > > Ping...
> > > > I would appreciate if someone could review it because this patch
> > > > fixes the real memory hotplug issue...
> > > 
> > > Yeah, so I generally try to resist random new boot options that
> > > work around real bugs, so please convince me that this patch
> > > is the best option:
> > > 
> > > > 
> > > > On Tue, Sep 04, 2018 at 11:11:40AM -0400, Masayoshi Mizuma wrote:
> > > > > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > > > > 
> > > > > If each node of physical memory layout has huge space for hotplug,
> > > > > the padding used for the physical memory mapping section is not enough.
> > > > > For exapmle of the layout:
> > > > >   SRAT: Node 6 PXM 4 [mem 0x100000000000-0x13ffffffffff] hotplug
> > > > >   SRAT: Node 7 PXM 5 [mem 0x140000000000-0x17ffffffffff] hotplug
> > > > >   SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
> > > > >   SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug
> > > > > 
> > > > > We can increase the padding by CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING,
> > > > > however, the needed padding size depends on the system environment.
> > > > > The kernel option is better than changing the config.
> > > > > 
> > > > > Change log from v2:
> > > > >  - Simplify the description. As Baoquan said, this is simillar SGI UV issue,
> > > > >    but a little different. Remove SGI UV description.
> > > 
> > > Could you please explain it a bit better where the higher padding requirement comes from?
> > > 
> > > 'system environment' is very opaque.
> > 
> > As I understand it, it's depending on the actual physical characteristics
> > of the machine. So setting a fixed value in Kconfig might work for one, but
> > not for others and having a command line option allows to tweak that at
> > boot time and having a common kernel image.
> > 
> > Ideally we would calculate that from SRAT, but AFAICT SRAT is not available
> > at the point where this needs to be done.

Yes, that's right. The KASLR initialization is early boot sequence,
so SRAT is not available at that time.

> 
> Yeah, so could we at least do something like this:
> 
>  - See whether using the maximum padding as the new default padding would work for everyone?
>    A bit more virtual memory used, or are there other costs as well?

The current default padding size if CONFIG_MEMORY_HOTPLUG set is 10TB.
IMO, it should not be increased because it gets the available entropy
decreased...

>  - Add checking code to the later SRAT case to at least _detect_ bad padding after the fact.
>    We don't utilize RAM with bad padding until that, right?

I have an idea as following. Does that make sense?

Add a warning message which shows the padding size is not enough
for the physical memory mapping and tell to the user about
recommended padding size. User can change the padding size in next
reboot to add the boot parameter.

> 
>  - Add 'quirk' to the name of the boot parameter, to make it clear that this is really due to 
>    suboptimal communication between the firmware and the kernel.

I'm ok if 'quirk' is added to the boot parameter.

Thanks,
Masa
