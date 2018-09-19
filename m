Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5D2ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32592150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1QQ1LxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32592150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbeISS0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:26:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39401 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbeISSZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:25:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so5661920wrw.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oCu9gxaUphtyz73SGUIh7pjMKBG4uy8QKBUQ0ASWWCM=;
        b=G1QQ1LxNufgUFcKsYVElMIk+rTL3RtNgXUm93ea/R2GNSgMhxwL5jQjPryfhhP+gmm
         Nc564LUckn+yuS6dmIp+TJZMChjZEOrhDHfNkyahcWYkAZ2ppXPSEO+Wvap2lkcTVB92
         4K3iDL9q56+RNjZAPg0jb7KnqINt/AOTPmEnVZBQzE/hsOnLSWetUbOEGc6RYl7rFBu/
         /N0WBJhoWgE+gVAsxWUk792W+0QnsshnEq8Z6g9rLvSl0lmhDHx0BLpTtIfXX48q3Jcz
         JrxshxxtTuxplIqA7lbzQ1y8o5Fp1k+Wh46R80lY8sFe4BzPD146hxN+pG4mOGeP0XMC
         Gg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oCu9gxaUphtyz73SGUIh7pjMKBG4uy8QKBUQ0ASWWCM=;
        b=GNZDTBaggEl2Oq7VLDi+btKXLcw36yYOqSl1wynwv4lhADSrco/zTmiRXU3dw+RecC
         wUiulKEMipk6dk69kcZiWXiFwr8Ti8XkI6CQ3FvwEkKR7yz74WsrKl+oQNnZ4e3Dy1dP
         IQLhMSaGbl9/NTiQMNWOHSAF5dag41NXijakOu7LrOTXsvxK35XhMPFrPZ9rGCPD4Vnq
         rkQUE+Py96Grf41Xkf/ojyxesEX2xE4TQc1LxiotdgIuJZSq/gCKJHQHbnEkeAQ4ATxu
         g7aAbxzJHhmQxvRnX0R5gi+PzY5qTa2qm4A+91maHkZrDf9fMK9eFPvNiyMMZmD/xQRA
         vMAw==
X-Gm-Message-State: APzg51DpnsZgGZ0lJDA3eMl+rcKIIYqePOfcxBzWh+/vnJZMYbR7ebi3
        PcK8lxFib2rVXnDH8xgLoEM=
X-Google-Smtp-Source: ANB0VdZvE0piivY1dl7QTnMXUCemexMs7an49KW5KkxO6Lrfb0HFIysZKtW0OPhMqlp3p4M6Hur49w==
X-Received: by 2002:adf:a789:: with SMTP id j9-v6mr29090196wrc.277.1537361290031;
        Wed, 19 Sep 2018 05:48:10 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b10-v6sm17005787wrr.88.2018.09.19.05.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 05:48:09 -0700 (PDT)
Date:   Wed, 19 Sep 2018 14:48:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, mike.travis@hpe.com, sivanich@hpe.com
Subject: Re: [PATCH v3 1/2] x86/mm: Add an option to change the padding used
 for the physical memory mapping
Message-ID: <20180919124806.GA48413@gmail.com>
References: <20180904151141.20264-1-msys.mizuma@gmail.com>
 <20180918133026.gzyix3oyrfcsrdcx@gabell>
 <20180919121720.GA47424@gmail.com>
 <alpine.DEB.2.21.1809191421500.18945@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809191421500.18945@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 19 Sep 2018, Ingo Molnar wrote:
> > * Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> > 
> > > Ping...
> > > I would appreciate if someone could review it because this patch
> > > fixes the real memory hotplug issue...
> > 
> > Yeah, so I generally try to resist random new boot options that
> > work around real bugs, so please convince me that this patch
> > is the best option:
> > 
> > > 
> > > On Tue, Sep 04, 2018 at 11:11:40AM -0400, Masayoshi Mizuma wrote:
> > > > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > > > 
> > > > If each node of physical memory layout has huge space for hotplug,
> > > > the padding used for the physical memory mapping section is not enough.
> > > > For exapmle of the layout:
> > > >   SRAT: Node 6 PXM 4 [mem 0x100000000000-0x13ffffffffff] hotplug
> > > >   SRAT: Node 7 PXM 5 [mem 0x140000000000-0x17ffffffffff] hotplug
> > > >   SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
> > > >   SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug
> > > > 
> > > > We can increase the padding by CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING,
> > > > however, the needed padding size depends on the system environment.
> > > > The kernel option is better than changing the config.
> > > > 
> > > > Change log from v2:
> > > >  - Simplify the description. As Baoquan said, this is simillar SGI UV issue,
> > > >    but a little different. Remove SGI UV description.
> > 
> > Could you please explain it a bit better where the higher padding requirement comes from?
> > 
> > 'system environment' is very opaque.
> 
> As I understand it, it's depending on the actual physical characteristics
> of the machine. So setting a fixed value in Kconfig might work for one, but
> not for others and having a command line option allows to tweak that at
> boot time and having a common kernel image.
> 
> Ideally we would calculate that from SRAT, but AFAICT SRAT is not available
> at the point where this needs to be done.

Yeah, so could we at least do something like this:

 - See whether using the maximum padding as the new default padding would work for everyone?
   A bit more virtual memory used, or are there other costs as well?

 - Add checking code to the later SRAT case to at least _detect_ bad padding after the fact.
   We don't utilize RAM with bad padding until that, right?

 - Add 'quirk' to the name of the boot parameter, to make it clear that this is really due to 
   suboptimal communication between the firmware and the kernel.

Hm?

Thanks,

	Ingo
