Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbeCVVfB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 17:35:01 -0400
Received: from smtprelay0120.hostedemail.com ([216.40.44.120]:35093 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751548AbeCVVfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 17:35:00 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:152:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3872:4225:4250:4321:5007:6119:7903:8660:10004:10400:10848:11026:11232:11473:11658:11914:12296:12740:12895:13069:13148:13230:13311:13357:13894:14181:14659:14721:21080:21433:21627:30046:30054:30090:30091,0,RBL:172.56.30.185:@perches.com:.lbl8.mailshell.net-62.8.0.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: hate49_484e8e5893a34
X-Filterd-Recvd-Size: 2050
Message-ID: <1521754493.7999.49.camel@perches.com>
Subject: Re: [PATCH 2/2] fpga: lattice machxo2: Add Lattice MachXO2 support
From: Joe Perches <joe@perches.com>
To: Alan Tull <atull@kernel.org>
Cc: Paolo Pisati <p.pisati@gmail.com>, Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-fpga@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date: Thu, 22 Mar 2018 14:34:53 -0700
In-Reply-To: <CANk1AXT6TY5N+gR=tBNuvhQMnOpuaWKWVoUSjB+Vfof2=GAM6w@mail.gmail.com>
References: <1521653726-24625-1-git-send-email-p.pisati@gmail.com>
         <1521653726-24625-3-git-send-email-p.pisati@gmail.com>
         <1521655492.7999.13.camel@perches.com>
         <CANk1AXT6TY5N+gR=tBNuvhQMnOpuaWKWVoUSjB+Vfof2=GAM6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-22 at 16:32 -0500, Alan Tull wrote:
> On Wed, Mar 21, 2018 at 1:04 PM, Joe Perches <joe@perches.com> wrote:
> > On Wed, 2018-03-21 at 18:35 +0100, Paolo Pisati wrote:
> > > This patch adds support to the FPGA manager for programming
> > > MachXO2 device’s internal flash memory, via slave SPI.
> > 
> > style trivia:
> > 
> > > diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
> > 
> > []
> > > +static int get_status(struct spi_device *spi, unsigned long *status)
> > > +{
> > > +     struct spi_message msg;
> > > +     struct spi_transfer rx, tx;
> > > +     u8 cmd[] = LSC_READ_STATUS;
> > 
> > static const u8 cmd[]
> > here and everywhere else as all the tx_buf assignments
> > of cmd are to const void *
> 
> Why *static* const u8 cmd[]?

So various compilers don't reload it on each call.
