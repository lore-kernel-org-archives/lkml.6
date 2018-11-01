Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80A9C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B18420657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQlOMPqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B18420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbeKAWH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:07:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbeKAWH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:07:29 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 933A020657;
        Thu,  1 Nov 2018 13:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541077475;
        bh=leojSy+BpVcFQaIpobqAy1ZG0k9zUUdHdDtvYuux8Ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQlOMPqrw8JoeufgLCehp1sRit5rXtVfxARfQ/GhmsOoSx0S1UZx8BBDTaNWZlv5W
         T7Og8VT4Sl5OX5rSHkgfonYVPduPhVML08du+ZnUY3lbcNq4VpKiwHUnpFhdNl+TdG
         cEhVB3bt5OL8VPTFrBR4mZpEEtaCL39wmtqxQEAc=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id A4195142D18; Thu,  1 Nov 2018 10:04:31 -0300 (-03)
Date:   Thu, 1 Nov 2018 10:04:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Perches <joe@perches.com>, Takashi Iwai <tiwai@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 17/28] tools include uapi: Update asound.h copy
Message-ID: <20181101130431.GA10588@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
 <20181031164508.4784-18-acme@kernel.org>
 <s5hlg6ehwzk.wl-tiwai@suse.de>
 <97ff58b75de70d2b9dd8524f7899063d563a6a71.camel@perches.com>
 <20181031192951.GE6669@redhat.com>
 <68477e3f-695f-b269-c44d-dbca4295ad05@sakamocchi.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68477e3f-695f-b269-c44d-dbca4295ad05@sakamocchi.jp>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 01, 2018 at 08:54:45PM +0900, Takashi Sakamoto escreveu:
> Hi Arnaldo,
> 
> On Nov 1 2018 4:29, Arnaldo Carvalho de Melo wrote:
> > > Wouldn't a symlink be simpler?
> > 
> > That would be equivalent to using it directly, see my response to
> > Takashi for a few of the reasons this is done this way.
> 
> I have a plan to add changes to 'include/uapi/sound/asound.h' in a
> development period for Linux kernel v4.21[1]. Would I need to add you to
> C.C list of the future patch to notify the change, or things go well
> without such special care for your side?

Don't worry, the system was designed not to create any extra work for
kernel developers.

The CC messages is just informative. :-)

- Arnaldo
 
> [1]
> https://github.com/takaswie/presentations/blob/master/20181021/contents.md
> 
> 
> Regards
> 
> Takashi Sakamoto
