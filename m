Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4A8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5731A2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Puj1bOI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfAJIkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:40:39 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34950 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbfAJIki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:40:38 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so9546229edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 00:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=98FL2Mc+pZhWlIkCB3cJghJefXL3nIxx18oqEaDCE7w=;
        b=Puj1bOI4tAfCnMbXzPgOoWP7cTyT0iJVjgdoNzkKcDX2LNBPB4Fwp2eexOzfmX5wG3
         EEHVM7ME//8ZGNxiA/rhc38VIrzQRp+SrL4ExvSrbrWVULbQf10kf457OdLkJdmZGP7o
         FS/x/88Kd+O7+xwsCIahCAC5wXS9Fjn+l7ovk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=98FL2Mc+pZhWlIkCB3cJghJefXL3nIxx18oqEaDCE7w=;
        b=F6Xy4gQ1g3jlTNvIBAbMEpJWLms84OfeK9N4T292zPkcXnLdmuW2FtYJO4Q+q0DXom
         nJG/x4rpZwCIWh8hxKkGuSgi/rg4uCtIkzbVfM5+8Da/qGih+ALLf8QPV1fw/c8UGavM
         2DNqiDMpZDmssmw9hcfBx/B/wz1GyPlp+bSM5RXoVmC+OkZah/u1Cbbq7/0sf0d1aE2h
         chS6ZpI9E/ZseQUVKl/omsPsb3MIsLiw5iQlH8m7X0PkDVHkWG/OPojN4eFZqvcBCNm4
         hYVTxM0LIzSJ/Nc4J5JGrdKArFn33e0/9bFVhcM4O5YNj652dNuV4wkObcYZfd9wpejm
         pwfg==
X-Gm-Message-State: AJcUuketykHyQMYchjDYzwx0tFNicc8jh0ghn9XGzlaOIbg9p3AxTSaJ
        gLwHds5/cxaBkm1VHF7HU2vOLQ==
X-Google-Smtp-Source: ALg8bN5hR3EOSlGJiwU2X5Ex+tqu4CPfU4YxdGZbRtSA3c5HpxK6MFmPwVfki/JHjiCWtmWaKBiY/w==
X-Received: by 2002:a50:999b:: with SMTP id m27mr8980396edb.10.1547109636558;
        Thu, 10 Jan 2019 00:40:36 -0800 (PST)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id r7-v6sm995408ejs.36.2019.01.10.00.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 00:40:35 -0800 (PST)
Date:   Thu, 10 Jan 2019 09:40:24 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        willy@infradead.org
Subject: Re: [PATCH RFC memory-model 0/6] LKMM updates
Message-ID: <20190110084024.GA10280@andrea>
References: <20190109210706.GA27268@linux.ibm.com>
 <20190109231852.GA4494@andrea>
 <20190109234043.GD1215@linux.ibm.com>
 <20190110003952.GA4354@andrea>
 <20190110042027.GG1215@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110042027.GG1215@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > It seems that
> > > > 
> > > >   1b52d0186177 ("tools/memory-model: Model smp_mb__after_unlock_lock()")
> > > >   
> > > > from linux-rcu/dev got lost; this also needs an ack (probably yours! ;D,
> > > > considered that, IIRC, you introduced the primitive and RCU is currently
> > > > its only user.)
> > > 
> > > That commit is in -tip:
> > > 
> > > 4607abbcf464 ("tools/memory-model: Model smp_mb__after_unlock_lock()")
> > > 
> > > So it has already left my -rcu tree.  ;-)
> > 
> > Oh, you're right: now I see the commit (e.g., with "git show"), but I
> > don't see the corresponding changes applied to the tree.
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=locking/core&id=4607abbcf464ea2be14da444215d05c73025cf6e
> >   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/tools/memory-model/linux-kernel.bell?h=locking/core
> > 
> > Is this expected?
> 
> Are you asking why it is in -tip but not in mainline?  I am not sure,
> but given that the merge window was over the holiday season and that
> the length of the merge window proved to be shorter than many people
> expected it to be, I am not too surprised.  ;-)

Mmh, let me try again:

  $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
  $ cd tip
  $ git checkout -b locking/core origin/locking/core

  $ git show 4607abbcf464
  commit 4607abbcf464ea2be14da444215d05c73025cf6e
  Author: Andrea Parri <andrea.parri@amarulasolutions.com>
  Date:   Mon Dec 3 15:04:49 2018 -0800

      tools/memory-model: Model smp_mb__after_unlock_lock()

  $ cd tools/memory-model
  $ herd7 -conf linux-kernel.cfg after-unlock-lock-same-cpu.litmus
  File "after-unlock-lock-same-cpu.litmus": Unknown macro smp_mb__after_unlock_lock (User error)

  [aka, linux-kernel.def in tip:locking/core does not have the
   smp_mb__after_unlock_lock() added by 4607abbcf464]

  Andrea


> 
> 							Thanx, Paul
> 
