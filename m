Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93846C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B8D2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544388421;
	bh=sh7dVfzoIbVd5gjZKnUOx1M+twYUZifmNnjKJTieU4E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=q603RiWesfc8bt0TVFKjcIiiBrDfWffhZyDSIeRrVC5EFYAw7Rrz4TVEVg7LPuxDR
	 ImYdMisBwtwxzBB2bCVmP3AErbI/CgEHrR3ujZusQrKrwPUiukXFSLewzVfkDla3Vz
	 z/LeC8n59xP9tKEAFc28tAjJpZG+ixA3zRMacMWc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B8D2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbeLIUrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:47:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:41986 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbeLIUq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:46:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1C060ADE3;
        Sun,  9 Dec 2018 20:46:58 +0000 (UTC)
Date:   Sun, 9 Dec 2018 21:46:57 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] l1tf: drop the swap storage limit restriction when
 l1tf=off
In-Reply-To: <20181119135149.GN22247@dhcp22.suse.cz>
Message-ID: <nycvar.YFH.7.76.1812092145510.17216@cbobk.fhfr.pm>
References: <20181113184910.26697-1-mhocko@kernel.org> <nycvar.YFH.7.76.1811132054521.19754@cbobk.fhfr.pm> <20181114073229.GC23419@dhcp22.suse.cz> <nycvar.YFH.7.76.1811191436140.21108@cbobk.fhfr.pm> <20181119135149.GN22247@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018, Michal Hocko wrote:

> > > > > +				It also drops the swap size and available
> > > > > +				RAM limit restriction.
> > > > 
> > > > Minor nit: I think this should explicitly mention that those two things 
> > > > are related to bare metal mitigation, to avoid any confusion (as otherwise 
> > > > the l1tf cmdline parameter is purely about hypervisor mitigations).
> > > 
> > > Do you have any specific wording in mind?
> > > 
> > > It also drops the swap size and available RAM limit restrictions on both
> > > hypervisor and bare metal.
> > > 
> > > Sounds better?
> > > 
> > > > With that
> > > > 
> > > > 	Acked-by: Jiri Kosina <jkosina@suse.cz>
> > > 
> > > Thanks!
> > 
> > Yes, I think that makes it absolutely clear. Thanks,
> 
> OK. Here is the incremental diff on top of the patch. I will fold and
> repost later this week. I assume people are still catching up after LPC
> and I do not want to spam them even more.

Is this queued anywhere in the meantime please?

Thanks,

-- 
Jiri Kosina
SUSE Labs

