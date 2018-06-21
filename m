Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F750C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED87121E97
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED87121E97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933047AbeFUUK7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:10:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45100 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932621AbeFUUK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:10:58 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8ONcq_zKPdbJ; Thu, 21 Jun 2018 22:10:56 +0200 (CEST)
Received: from zn.tnic (p200300EC2BD18C00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:8c00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B70291EC020C;
        Thu, 21 Jun 2018 22:10:56 +0200 (CEST)
Date:   Thu, 21 Jun 2018 22:10:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Do not overwrite MCi_STATUS in mce_no_way_out()
Message-ID: <20180621201055.GK12742@zn.tnic>
References: <20180621124020.6244-1-bp@alien8.de>
 <20180621181808.GA20097@agluck-desk>
 <20180621191710.GI12742@zn.tnic>
 <20180621200003.GA22562@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180621200003.GA22562@agluck-desk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 01:00:03PM -0700, Luck, Tony wrote:
> On Thu, Jun 21, 2018 at 09:17:11PM +0200, Borislav Petkov wrote:
> > On Thu, Jun 21, 2018 at 11:18:09AM -0700, Luck, Tony wrote:
> > > Counter proposal.  We don't need the temp mci_status because we exit the
> > > loop early.  Nor the "ret" variable.
> > > 
> > > 
> > > How does this look?
> > 
> > Yap, better. I'll test it later or tomorrow:
> > 
> 
> Or even better. Just adds the "mce_read_aux()" to check ADDRV and MISCV
> and populate more of the struct mce.

I thought about it but decided to leave it for another day. But ok, it
is a one more line and I guess it is ok to have it in the same patch,
I'll add it.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
