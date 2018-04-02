Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4134317-1522710012-2-7014138073315133277
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522710012; b=VEVfgcGhxUswTs5I1wsPJWNkDUbg07X7WHUkZXaa+Ui62096FZ
    c1+/chkY2wH8PLY13pke/2XtVhtTyIXDY2SsZcQ1tdQ4TtW/jAhzoN3mwPqzkSat
    6Ns4UESyayZete+pLHWQgVq+Da9T3DwrOdg0QIh0nQ0ZhM1jOdOZtrSbLuOQqMYv
    gRWIn4FWvPTBqyMNpg/gJEELOy8sGd95jAi4miFxPVuCEL9HL1X2om4etMX0bhou
    1cP8NaHhnbbjHkKzbtKuxrodyaItdNSh0nsBkHk6WzhFz8/HmuX8SDLmqEsX/HcW
    p30MGHZznr8GyopcFA7hpx402lx5ARA8dL5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522710012; bh=+k0u2OI2sWvkFRVdr3ZvmjrQtVjJtS
    8lXj+C9Qj+bwI=; b=qxds6Uarua/KszwuJVx5+5jfXmbCYUC2iyQICsoMNBWhu8
    X8SZLyp0CQuenOhGKEv+fH2shvrMRRAbvJIZNgLhfiwAiL4hgkjvlIifjAN2PyMS
    QVEGFoW6HD9guaQb5n5V/t4RMsm/fFTIim984BAuBLfyWYHRlpYNAHC4rbvveA5i
    L0T3h4Doxd9n0HlTpPK6zF47GE/eHGdq/rhi9SMML9mM5+WlCfL97Dvbrdgnv7pE
    IcjpK+habVieLC4eDIAZVGNqdQphCe0/69Abmee7gLteZJ9OOFmE0qAnQbIcOVFf
    8jjn93+NcoFxsje4OX8exSyR4TRhF9Ijee/I7pEg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b=b0xIL9FC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=osandov.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OhFe2k18;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osandov.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b=b0xIL9FC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=osandov.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OhFe2k18;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osandov.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNnFecRz30EFdE4jOfNoVLj3DCLziQslNG4Nk1XZHxcKEL29va36bPAvDNr/QG/ZQoX2Xxh0G5kQTsbjWVw4GDVX9qAW8vcRwsNLMbtcBsxyqcIopUr1
    jue+X06qWM+jCIBhdshpEXZjX/ec8R6gyObHvfuNYk+4BMCtG1DY073zK+EQ3Lyn9fULusYVT2X15b298wun+4FYaR+1BuJ0xdL1jVTjKJ6c1/H3PqIbn2/N
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=FOH2dFAWAAAA:8 a=VwQbUJbxAAAA:8 a=vTFSaEdR8a_UT8r-xNIA:9
    a=7Dj4G_VWTJxy9BLD:21 a=y9f-Y-QWXHojT-F0:21 a=CjuIK1q_8ugA:10
    a=i3VuKzQdj-NEYjvDI-p3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754599AbeDBXAJ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 19:00:09 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40704 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754522AbeDBXAI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 2 Apr 2018 19:00:08 -0400
X-Google-Smtp-Source: AIpwx4/dnVNxit/KaAagr5NQqhtslCO4b60+gDZYAwGUGMgTO2s0RnDMCM7ZP2pR6rbY88q1FkWBcg==
Date: Mon, 2 Apr 2018 16:00:06 -0700
From: Omar Sandoval <osandov@osandov.com>
To: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com, Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] bitmap: fix memset optimization on big-endian systems
Message-ID: <20180402230006.GB18049@vader>
References: <817147544aa3ecc2b78d6cadeab713869d8805e6.1522709616.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <817147544aa3ecc2b78d6cadeab713869d8805e6.1522709616.git.osandov@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 02, 2018 at 03:58:31PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Commit 2a98dc028f91 introduced an optimization to bitmap_{set,clear}()
> which uses memset() when the start and length are constants aligned to a
> byte. This is wrong on big-endian systems; our bitmaps are arrays of
> unsigned long, so bit n is not at byte n / 8 in memory. This was caught
> by the Btrfs selftests, but the bitmap selftests also fail when run on a
> big-endian machine.
> 
> We can still use memset if the start and length are aligned to an
> unsigned long, so do that on big-endian. The same problem applies to the
> memcmp in bitmap_equal(), so fix it there, too.
> 
> Fixes: 2a98dc028f91 ("include/linux/bitmap.h: turn bitmap_set and bitmap_clear into memset when possible")
> Fixes: 2c6deb01525a ("bitmap: use memcmp optimisation in more situations")
> Cc: stable@kernel.org

This should be stable@vger.kernel.org, of course
