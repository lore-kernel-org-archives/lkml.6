Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A4AC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B51B222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550044096;
	bh=J5+YQZNHiUEsQpHZYR1XGrqUK1eplI2fDOdYxwyTkQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bD2O2rqvdqPDQEWqULRlIECznFTvMe9VKUoJVq12lKuZh9BxEKLUfa3ylkbQb92KF
	 FjszeXKmPQpevhZ8lRVEx7YodD4l7nAzY3OhQQiwr4XrNpgzxCnXTGOVDOVa/9M34P
	 4iPM98DubsWxJNZsG2hhUAXpnGNG/WCX1S/kbPUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388874AbfBMHsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:48:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730851AbfBMHsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:48:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84F65222BA;
        Wed, 13 Feb 2019 07:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550044094;
        bh=J5+YQZNHiUEsQpHZYR1XGrqUK1eplI2fDOdYxwyTkQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GaPxl0eDIVu4dquSj+xW46FFESRNb7AOmZaUiO3/QIn56xNuR+hhlSwU4AspqnE8J
         8RdcnhVyECH4OU200pc6LMmxNG1QluXPzKtlrLDpnBq47hAMDxHWQsP6s2EQcqamWq
         2pg5boNAxgVuFEr59xtFv1SaDyDRmiKKjkrmFBEM=
Date:   Wed, 13 Feb 2019 08:48:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark D Rustad <mrustad@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.4.174
Message-ID: <20190213074811.GC3246@kroah.com>
References: <20190208105422.GA32328@kroah.com>
 <20190208105431.GB32328@kroah.com>
 <870EE9C6-3748-498C-B6E8-33724168C605@gmail.com>
 <20190209081301.GB30034@kroah.com>
 <B6967E84-6DCE-4390-B2D1-E3B4A0146DD6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B6967E84-6DCE-4390-B2D1-E3B4A0146DD6@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 08:13:11PM -0800, Mark D Rustad wrote:
> On Feb 9, 2019, at 12:13 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Feb 08, 2019 at 08:44:32PM -0800, Mark D Rustad wrote:
> > > On Feb 8, 2019, at 2:54 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > 
> > > > diff --git a/Documentation/networking/ip-sysctl.txt
> > > > b/Documentation/networking/ip-sysctl.txt
> > > > index 2ea4c45cf1c8..7c229f59016f 100644
> > > > --- a/Documentation/networking/ip-sysctl.txt
> > > > +++ b/Documentation/networking/ip-sysctl.txt
> > > > @@ -112,14 +112,11 @@ min_adv_mss - INTEGER
> > > > 
> > > >  IP Fragmentation:
> > > > 
> > > > -ipfrag_high_thresh - INTEGER
> > > > -	Maximum memory used to reassemble IP fragments. When
> > > > -	ipfrag_high_thresh bytes of memory is allocated for this purpose,
> > > > -	the fragment handler will toss packets until ipfrag_low_thresh
> > > > -	is reached. This also serves as a maximum limit to namespaces
> > > > -	different from the initial one.
> > > > -
> > > > -ipfrag_low_thresh - INTEGER
> > > > +ipfrag_high_thresh - LONG INTEGER
> > > > +	Maximum memory used to reassemble IP fragments.
> > > > +
> > > > +ipfrag_low_thresh - LONG INTEGER
> > > > +	(Obsolete since linux-4.17)
> > > 
> > > It seems very strange to say that it is obsolete since 4.17 in a 4.4
> > > kernel.
> > 
> > 4.17 is a point in time :)
> 
> Of course I understand, but some random non-kernel-developer tuning a kernel
> may be pretty puzzled. I don't know right off the top something brief that
> would be more generally meaningful, but maybe someone might. What does
> obsolete mean in this context? It exists but does nothing? It exists and
> does something but will eventually go away?

Fair enough, want to provide a patch with the real kernel version this
happened in?

thanks,

greg k-h
