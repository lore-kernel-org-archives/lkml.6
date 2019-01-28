Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A627C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588A921741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="qCdqiXCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbfA1RAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:00:45 -0500
Received: from one.firstfloor.org ([193.170.194.197]:50820 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730755AbfA1RAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:00:40 -0500
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 8459086858; Mon, 28 Jan 2019 18:00:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1548694837;
        bh=xYq4k4x/a6XRP87mvQEHdTQcZ18hEwCkIb8KHZKvcqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qCdqiXCWACikkdBO5qPE09/35Pe8XZVeklxMd7ortNOc/KphhUa2WbFyohGKgMJ0M
         t1pAV6j7kvaLhWsW7NsiLmUfIV/bh2Xqkyi7xiT6yBc2YG/3uS1L4R9BW4dRH/hy2W
         z9/BLH6HoD+4o1VRW+SypW/U15Lqh1Omw4KBc7oU=
Date:   Mon, 28 Jan 2019 09:00:37 -0800
From:   Andi Kleen <andi@firstfloor.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC] Don't print sample_type bits in non-group events not set
 in the group's was Re: [PATCH] perf, script: Fix crash with printing mixed
 trace point and other events
Message-ID: <20190128170037.sbayc3mve66krzzd@two.firstfloor.org>
References: <20190117194834.21940-1-andi@firstfloor.org>
 <20190118094919.GA28346@krava>
 <20190118125920.GG5823@kernel.org>
 <20190118130106.GH5823@kernel.org>
 <20190118134205.GI5823@kernel.org>
 <20190118161000.GC28346@krava>
 <20190118161140.z45vl3milw2vk4hy@two.firstfloor.org>
 <20190119153745.GA19542@krava>
 <20190128141301.GA26788@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128141301.GA26788@krava>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > also now it won't make sample for slave events
> > with zero value/period read
> > 
> > note the patch needs to be split into more patches,
> > sending it all together for discussion over the solution
> 
> any feedback on this one?

Looks good to me.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
-Andi
