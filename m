Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D0EC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F4C2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfA0VgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 16:36:17 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:59978 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726861AbfA0VgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 16:36:17 -0500
Received: from mr1.cc.vt.edu (mr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x0RLaG5b009385
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 16:36:16 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x0RLaBvc027905
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 16:36:16 -0500
Received: by mail-qt1-f197.google.com with SMTP id n50so18579521qtb.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 13:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=EAe1EIRGxtFb7Q9xaiUoB3dA/Fi3w2Ys5PLl0FXMnG8=;
        b=JVGlvgyGedFFNHInOQXpLtgE5sekdFmMsbNlF7I4Ts+l+W9rs0KMBTHcO4GoghvD06
         vcDFT6n7dlmFGd1FWzI8Jp3rpTUSijRDMc5KCLu0XVkmMFcGsJFaOAKJuaXRfST/V7N0
         ZIuIZlpkcTVFbnAyEpe1Ed7qFCPS4Ma3fz28zD/xIliZocusBGCCWOsSmZD+ZNg+kNDg
         HlLRdTr+/u4Cvf6PSJproc/NMEO2rxxwCPsBvCiRD+Jr00ifQmxgN7ZjbSI12vFaxTBg
         T5Y52U2oyn9FZA6eBcg+FPpIAdvnRYRvkF61VD4mrTXS45EgdJ/M4R6C55CDYM1Zjtm3
         ZiVw==
X-Gm-Message-State: AJcUukcr0nJdw7ZtOpAtIkGCTzD6BV4ddipPQwzO1eIAOfIPNvN8WJIi
        Gs7YpIjKFRb04UKSwpU/PmY8RFyv1AR0HNEmIRFyuafuX61SNDjABpIXrym+YnncRbvc83YBLuW
        iag5BpcR+ZCklMBix8P6aq0ZUhs5O8NQUVKY=
X-Received: by 2002:a0c:ec50:: with SMTP id n16mr18623191qvq.105.1548624971483;
        Sun, 27 Jan 2019 13:36:11 -0800 (PST)
X-Google-Smtp-Source: ALg8bN40f34/V6BL2NdwNG3rUDeL97kBUujzGyE3xy5k4svlRyqeqwc/SOXpSFCbWE+EV+q84htDmg==
X-Received: by 2002:a0c:ec50:: with SMTP id n16mr18623176qvq.105.1548624971289;
        Sun, 27 Jan 2019 13:36:11 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id n67sm60358018qkd.95.2019.01.27.13.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 13:36:09 -0800 (PST)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Pavel Machek <pavel@ucw.cz>
cc:     Mel Gorman <mgorman@techsingularity.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, vbabka@suse.cz,
        aarcange@redhat.com, rientjes@google.com, mhocko@kernel.org,
        zi.yan@cs.rutgers.edu, hannes@cmpxchg.org, jack@suse.cz
Subject: Re: [regression -next0117] What is kcompactd and why is he eating 100% of my cpu?
In-reply-to: <20190127160027.GA9340@amd>
References: <20190126200005.GB27513@amd> <12171.1548557813@turing-police.cc.vt.edu> <20190127141556.GB9565@techsingularity.net>
 <20190127160027.GA9340@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sun, 27 Jan 2019 16:36:34 -0500
Message-ID: <13417.1548624994@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jan 2019 17:00:27 +0100, Pavel Machek said:
> > > I've noticed this as well on earlier kernels (next-20181224 to 20190115)
> > > Some more info:
> > > 1) echo 3 > /proc/sys/vm/drop_caches  unwedges kcompactd in 1-3 seconds.
> > This aspect is curious as it indicates that kcompactd could potentially
> > be infinite looping but it's not something I've experienced myself. By
> > any chance is there a preditable reproduction case for this?
>
> I seen it exactly once, so not sure how reproducible this is. x86-32
> machine, running chromium browser, so yes, there was some swapping
> involved.

I don't have a surefire replicator, but my laptop (x86_64, so it's not a 32-bit
only issue) triggers it fairly often, up to multiple times a day. Doesn't seem to
be just the Chrome browser that triggers it - usually I'm doing other stuff as
well, like a compile or similar.  The fact that 'drop_caches' clears it  makes me
wonder if we're hitting a corner case where cache data isn't being automatically
cleared and clogging something up.

Any particular diagnostic info you want me to get next time it hits?  (Am
currently on next-20190125, if that matters).

