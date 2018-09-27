Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B7CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB3F21708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="trgf/oKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB3F21708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbeI1Bb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:31:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbeI1Bb6 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:31:58 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B89B6215F0;
        Thu, 27 Sep 2018 19:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538075533;
        bh=tC5m4dI7S/kbBSCPJznOAX8S85vV+EJoVnvYZyuPpYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=trgf/oKdA0rie4XgfK+Ebj2gtzkYXx54F9a4B2Ns5saCmYkpVyIRTaDmqT43597+D
         vQcwXIuttY9vOz4nAFWDx6+D3g8SpbaMuzEa6o+hsrx3pUATX5UqeEcMJzizjeJXfZ
         dOukb91fgXTRrP8ravQN6Jl9bwOE/3amMYH+OGZo=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id ABE391401A1; Thu, 27 Sep 2018 16:12:11 -0300 (-03)
Date:   Thu, 27 Sep 2018 16:12:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Milian Wolff <milian.wolff@kdab.com>, jolsa@kernel.org,
        yao.jin@linux.intel.com, namhyung@kernel.org,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [PATCH 2/3] perf report: use the offset address to find inline
 frames
Message-ID: <20180927191211.GI25764@kernel.org>
References: <20180926135207.30263-1-milian.wolff@kdab.com>
 <20180926135207.30263-2-milian.wolff@kdab.com>
 <20180927160042.GA6916@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927160042.GA6916@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 27, 2018 at 06:00:42PM +0200, Jiri Olsa escreveu:
> On Wed, Sep 26, 2018 at 03:52:06PM +0200, Milian Wolff wrote:
> > To correctly find inlined frames, we have to use the file offset
> > instead of the virtual memory address. This was already fixed for
> > displaying srcline information while displaying in commit
> > 2a9d5050dc84fa20 ("perf script: Show correct offsets for DWARF-based
> > unwinding"). We just need to use the same corrected address also when
> > trying to find inline frames.
> > 
> > This is another follow-up to commit 19610184693c ("perf script: Show
> > virtual addresses instead of offsets").
> > 
> > Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> > Cc: Sandipan Das <sandipan@linux.ibm.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
