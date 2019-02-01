Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53637C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDADA218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KKasaLgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbfBAPP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:15:28 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60948 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbfBAPP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cKK+c+B9ZTXCDk6Rg2n+M2JkgnsFAfUSNf2OukrqO2U=; b=KKasaLgzHgZjlKi/BsQAj/+D9
        Bj3IDipCOMTu4giZopvD7xqg2bJupIz2vNt3bXl0woSC6Ds1RUNSidqMpyWeKVPR+f1aCCFXm3ngK
        8Ci0j+wsXLsEm2Qa6zbqACRxqgeCHO71dWqkaPrvcuH7Ae9mpOWR+WaQzvk693uED/DtI=;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:36446)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gpaXF-0007JU-1S; Fri, 01 Feb 2019 15:15:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gpaXA-0000s7-3R; Fri, 01 Feb 2019 15:15:12 +0000
Date:   Fri, 1 Feb 2019 15:15:11 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        linux-kernel@vger.kernel.org, rppt@linux.vnet.ibm.com,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re:
Message-ID: <20190201151511.ywwem3bd65n7n37e@e5254000004ec.dyn.armlinux.org.uk>
References: <20190107172805.GA8462@jordon-HP-15-Notebook-PC>
 <CAFqt6zbbXvpEEH2rNnLCBpNxEjK3YwNS1kYkyFPBhG7uvsHE1A@mail.gmail.com>
 <20190117112803.GC3710@rapoport-lnx>
 <CAFqt6zb-+hmF-zOrs-_J=m+YZO-R-VdwWKErYVHqtNcShk7sPA@mail.gmail.com>
 <10982a2f-8ff0-50f4-cdce-d028808d188f@arm.com>
 <CAFqt6zYE9Mv0Y+pfOtbOWeT5+AxPaJWB9_pkD5VO+pZVs-dF3w@mail.gmail.com>
 <001c1195-fe06-fc78-b8a9-ec96f44aef32@arm.com>
 <CAFqt6zae+8-TLaWEmgyLEVCbsy2cbeFg35SxH5r1kHYu6rrybw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zae+8-TLaWEmgyLEVCbsy2cbeFg35SxH5r1kHYu6rrybw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 06:11:21PM +0530, Souptick Joarder wrote:
> On Fri, Feb 1, 2019 at 6:06 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> >
> > On 2/1/19 12:32 PM, Souptick Joarder wrote:
> > > On Thu, Jan 31, 2019 at 6:28 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> > >>
> > >> Hi Souptick,
> > >>
> > >> On 1/31/19 5:54 AM, Souptick Joarder wrote:
> > >>> On Thu, Jan 17, 2019 at 4:58 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >>>>
> > >>>> On Thu, Jan 17, 2019 at 04:53:44PM +0530, Souptick Joarder wrote:
> > >>>>> On Mon, Jan 7, 2019 at 10:54 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > >>>>>>
> > >>>>>> Remove duplicate headers which are included twice.
> > >>>>>>
> > >>>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > >>>>
> > >>>> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> > >>>>
> > >>>>> Any comment on this patch ?
> > >>>
> > >>> If no further comment, can we get this patch in queue for 5.1 ?
> > >>
> > >> I'd be nice to use proper tags in subject
> > >> line. I'd suggest
> > >>
> > >> [PATCH] ARM: mm: Remove duplicate header
> > >>
> > >> but you can get some inspiration form
> > >>
> > >> git log --oneline --no-merges arch/arm/mm/
> > >>
> > >> In case you want to route it via ARM tree you need to drop it into
> > >> Russell's patch system [1].
> > >
> > > How to drop it to Russell's patch system other than posting it to
> > > mailing list ? I don't know.
> >
> > https://www.armlinux.org.uk/developer/patches/info.php
> 
> This link is not reachable.

In what way?  The site is certainly getting hits over ipv4 and ipv6.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
