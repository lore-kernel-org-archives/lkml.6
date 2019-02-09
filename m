Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149EBC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 08:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FF820844
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 08:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549699985;
	bh=v3Lc96q1keNpO9788i9qRecdSsvI3G8N7o1O1ebncx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wA8vpwYlM3Ase98R+D/u8MWUswlEcscx/BksQMlPSfVuOStf0PbFoVonWx1F0mZgk
	 0Ikrc4sUWGlOWUlzLxR12e3zDw3cct6q21v7gSP0vDzfUU9Slyk6eqCK8KBbW59Wm5
	 6U1Vow61iJPbrOowCs+p2OPK0Thm0+Mfr5QHysyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfBIINE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 03:13:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfBIINE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 03:13:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E5EC20844;
        Sat,  9 Feb 2019 08:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549699983;
        bh=v3Lc96q1keNpO9788i9qRecdSsvI3G8N7o1O1ebncx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OoU3pIbSgqAyGvBubUCvOVSKO2lhTI7MYnH5aJqN8XDz4umfv/OCDrxBRNjrG7R78
         tbIdsHH7NEdmie/fR22F2EJlPfd+T+T4hNdANBNDvN824cOi7EN+vP+EPcOu04u1F2
         AB0/nzTJrtripCJjpyc6LzcGbToxERk/yLeTS+R0=
Date:   Sat, 9 Feb 2019 09:13:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark D Rustad <mrustad@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.4.174
Message-ID: <20190209081301.GB30034@kroah.com>
References: <20190208105422.GA32328@kroah.com>
 <20190208105431.GB32328@kroah.com>
 <870EE9C6-3748-498C-B6E8-33724168C605@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <870EE9C6-3748-498C-B6E8-33724168C605@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 08:44:32PM -0800, Mark D Rustad wrote:
> On Feb 8, 2019, at 2:54 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > diff --git a/Documentation/networking/ip-sysctl.txt
> > b/Documentation/networking/ip-sysctl.txt
> > index 2ea4c45cf1c8..7c229f59016f 100644
> > --- a/Documentation/networking/ip-sysctl.txt
> > +++ b/Documentation/networking/ip-sysctl.txt
> > @@ -112,14 +112,11 @@ min_adv_mss - INTEGER
> > 
> >  IP Fragmentation:
> > 
> > -ipfrag_high_thresh - INTEGER
> > -	Maximum memory used to reassemble IP fragments. When
> > -	ipfrag_high_thresh bytes of memory is allocated for this purpose,
> > -	the fragment handler will toss packets until ipfrag_low_thresh
> > -	is reached. This also serves as a maximum limit to namespaces
> > -	different from the initial one.
> > -
> > -ipfrag_low_thresh - INTEGER
> > +ipfrag_high_thresh - LONG INTEGER
> > +	Maximum memory used to reassemble IP fragments.
> > +
> > +ipfrag_low_thresh - LONG INTEGER
> > +	(Obsolete since linux-4.17)
> 
> It seems very strange to say that it is obsolete since 4.17 in a 4.4 kernel.

4.17 is a point in time :)

