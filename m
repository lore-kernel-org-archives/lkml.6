Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB7AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC02F2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548751736;
	bh=Ig2D8V5JtjRJdmtfchTseqmuLTKIW4SJHekGAx7X8fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G8R7IfCyZfFT5eBL/rgnSgN1MTjq0Rcpzp+2a06jsMzcqvqqODlduKBEg/+YI7brz
	 d4xzAcSi6ytLbb4FgAWgx004LCdXqWuOTEJUqIyDu1c+tWoQ7ySRf1O5SGPAGcrUIZ
	 hNtXP/j9+78aqNKd0Ch5gCalu7Y3O/MchbXrb7Ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfA2Isz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:48:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfA2Isy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:48:54 -0500
Received: from quaco.ghostprotocols.net (ovpn-brq.redhat.com [213.175.37.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0361520856;
        Tue, 29 Jan 2019 08:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548751734;
        bh=Ig2D8V5JtjRJdmtfchTseqmuLTKIW4SJHekGAx7X8fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2T9NhTP63aW8TSws9CiGLgAM/ZzeDtLqr9SupYbWklT77srF9BPxPuelDETK2ameP
         57LcIXlmpwLxK/ES/zzD4IzpCcInbVlt5d/IMdc862K5ZdPCylduwaFHTv7kWGPygY
         k1WIZGMC/Hx0rcJVaSACP7DeW5PcxSswkyW383+4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CE3674034F; Tue, 29 Jan 2019 09:48:51 +0100 (CET)
Date:   Tue, 29 Jan 2019 09:48:51 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC] Don't print sample_type bits in non-group events not set
 in the group's was Re: [PATCH] perf, script: Fix crash with printing mixed
 trace point and other events
Message-ID: <20190129084851.GC4344@kernel.org>
References: <20190117194834.21940-1-andi@firstfloor.org>
 <20190118094919.GA28346@krava>
 <20190118125920.GG5823@kernel.org>
 <20190118130106.GH5823@kernel.org>
 <20190118134205.GI5823@kernel.org>
 <20190118161000.GC28346@krava>
 <20190118161140.z45vl3milw2vk4hy@two.firstfloor.org>
 <20190119153745.GA19542@krava>
 <20190128141301.GA26788@krava>
 <20190128170037.sbayc3mve66krzzd@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128170037.sbayc3mve66krzzd@two.firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 28, 2019 at 09:00:37AM -0800, Andi Kleen escreveu:
> > > also now it won't make sample for slave events
> > > with zero value/period read
> > > 
> > > note the patch needs to be split into more patches,
> > > sending it all together for discussion over the solution
> > 
> > any feedback on this one?
> 
> Looks good to me.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> -Andi

Jiri, can you repost with a proper Subject line, Andi's reviewed-by,
etc?

- Arnaldo
