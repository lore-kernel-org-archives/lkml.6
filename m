Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E58C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9339E2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwJecEBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9339E2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJICyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbeJICyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:54:18 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0230520835;
        Mon,  8 Oct 2018 19:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539027657;
        bh=eAjO3p6jhg5ZsfaL88dj+akFikfq54JzSLFtcpbEJPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwJecEBMHAdNW3GD8OyyRqVKEc38ZxMRjj3bhxfYXyaF5AXoKACeW6+iRtSVSUGYJ
         MmaDxnejEz3Rwb9RA1b9YSc35M28/oksxzvKxsaH843OidjggGZN4NxuX/7AXdXABk
         dlTh1I810ilBZF+KuIDrXbdtYT7BG0A8WwcFk2M8=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 9B88F142C5E; Mon,  8 Oct 2018 16:40:54 -0300 (-03)
Date:   Mon, 8 Oct 2018 16:40:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/5] tools, perf, script: Add --insn-trace for
 instruction decoding
Message-ID: <20181008194054.GA27612@kernel.org>
References: <20180920180540.14039-1-andi@firstfloor.org>
 <20180920180540.14039-2-andi@firstfloor.org>
 <20181008180314.GT3541@kernel.org>
 <20181008184115.GJ32651@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008184115.GJ32651@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 08, 2018 at 11:41:15AM -0700, Andi Kleen escreveu:
> > > +> git clone https://github.com/intelxed/mbuild.git mbuild                                                                                        
> > > +> git clone https://github.com/intelxed/xed                                                                                                      
> > > +> cd xed                                                                                                                                         
> > > +> mkdir obj                                                                                                                                      
> > > +> cd obj                                                                                                                                         
> > > +> ../mfile.py                                                                                                                                    
> > > +> sudo ../mfile.py --prefix=/usr/local install    
> 
> 
> Need 
> 
> ../mfile.py examples
> sudo ../mfile.py --prefix=/usr/local examples install

Will try that now.
