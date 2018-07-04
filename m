Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD36C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A86246DE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnD2eelI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A86246DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932988AbeGDC1l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 22:27:41 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43631 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932109AbeGDC1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 22:27:39 -0400
Received: by mail-pl0-f68.google.com with SMTP id c41-v6so1902681plj.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 19:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vGrGWSaef8Er5LE0M975lNcBLCNbdhjN9yKgwC/4sVI=;
        b=nnD2eelIYnk50EA50fOKy3HM48cRASvxv50tEZWTYIeNGANHxWGufJjo2tAnW0dDZ5
         4Rt6HViDf52bqFFRB75jA5uK6eE8k3dRrc5Z1OJ9AgUEWBJQbNxaVBTKNvDM+vLOQFdr
         7WgvT825PWVOx5aHU53K5iN5EuJwHVf9fHAdf09/jvUPufJ8c3DxLWFP1ej1UG/aM3Vw
         EDxlNblL4M/8ZGIeu3RSPy+L+HUZ+c0gGIXsCTCwq/FSqeQS02owgQf18BN5CcfSShZs
         nazUx1vwyV5E2uVpgWAq0NMlyWZi3HNJcjHMWfcwbNVgGEEBEZzKo6uaS1aUlYxkzrHN
         yCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vGrGWSaef8Er5LE0M975lNcBLCNbdhjN9yKgwC/4sVI=;
        b=AIZqc0OcP/Smf1fNsTigUdZDIuKrRKlVIyKSEMBjNI0KlT5EMWJ1oVZUxC+SDaQMLS
         WC/aEeieBMZeCbE6jeExBKtwuC5fhEEd0qpJFMTWu479Q45TtCtfsvOSGLFVoIJ5rgHn
         gFr9QK84yyLlxW0oj7c0rKS6SG6glVcjV+APcHwF0CSqAOw4R5nMOym4+qBmi3ZU6oG9
         ga4RbVkridElkkUcsMQdOeEJalgdmn6VcShA9NLesn/Yj69IutCkSBhC+Vuk6ohCs25C
         ozg1nYRlXmZHBQwmOUtI/i/DnxBr+ElE2DKsmyPkpoGlQn+Szc+tT/eTcc6tfdDfTjBN
         kTmg==
X-Gm-Message-State: APt69E2HB3kC4HFM+5mABul+OgZx6hk0J235RYViLqxemEEHIGdNIhkL
        eSVup4azdeKLRlWHSS5WZgw=
X-Google-Smtp-Source: AAOMgpcH3cWA168JcMWjtQuwpr0PDMkCeUtZo2aY92e1khOGe8J/HbkPyMah6dxKmT90WppweEQ7Rg==
X-Received: by 2002:a17:902:64c2:: with SMTP id y2-v6mr179566pli.53.1530671259134;
        Tue, 03 Jul 2018 19:27:39 -0700 (PDT)
Received: from localhost ([175.223.14.150])
        by smtp.gmail.com with ESMTPSA id l8-v6sm5423653pfb.102.2018.07.03.19.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 19:27:37 -0700 (PDT)
Date:   Wed, 4 Jul 2018 11:27:34 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm -v4 00/21] mm, THP, swap: Swapout/swapin THP in one
 piece
Message-ID: <20180704022734.GB3346@jagdpanzerIV>
References: <20180622035151.6676-1-ying.huang@intel.com>
 <20180627215144.73e98b01099191da59bff28c@linux-foundation.org>
 <20180704021153.GA3346@jagdpanzerIV>
 <878t6rvj12.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878t6rvj12.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/04/18 10:20), Huang, Ying wrote:
> > On (06/27/18 21:51), Andrew Morton wrote:
> >> On Fri, 22 Jun 2018 11:51:30 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
> >> 
> >> > This is the final step of THP (Transparent Huge Page) swap
> >> > optimization.  After the first and second step, the splitting huge
> >> > page is delayed from almost the first step of swapout to after swapout
> >> > has been finished.  In this step, we avoid splitting THP for swapout
> >> > and swapout/swapin the THP in one piece.
> >> 
> >> It's a tremendously good performance improvement.  It's also a
> >> tremendously large patchset :(
> >
> > Will zswap gain a THP swap out/in support at some point?
> >
> >
> > mm/zswap.c: static int zswap_frontswap_store(...)
> > ...
> > 	/* THP isn't supported */
> > 	if (PageTransHuge(page)) {
> > 		ret = -EINVAL;
> > 		goto reject;
> > 	}
> 
> That's not on my TODO list.  Do you have interest to work on this?

I'd say I'm interested. Can't promise that I'll have enough spare time
any time soon, tho.

The numbers you posted do look fantastic indeed, embedded devices
[which normally use zswap/zram quite heavily] _probably_ should see
some performance improvement as well once zswap [and may be zram] can
handle THP.

	-ss
