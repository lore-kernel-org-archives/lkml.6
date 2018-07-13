Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29AFECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6227120858
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hlf2vxXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6227120858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeGMKfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:35:14 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37822 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbeGMKfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:35:13 -0400
Received: by mail-pf0-f195.google.com with SMTP id a26-v6so325639pfo.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 03:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aXhjnJjyxGwGBQNBVIUc3v+UOGe7/rz+EZPaPaMDsVg=;
        b=Hlf2vxXUu2zfHijJ59myu6FZyEr+73ReJbu5etoEU+q4UiI41W8mN2Ua3RX721Oak9
         q0+n7kAVKZYtIDaDbyEnYMR01wm9+C/kMbNEuJbXVlZMkY5+QArA4cTLVto9wKKkuS8w
         8AStlH2niUqhSQc+Hr45DDJQdaTWN1mYOqrRxq8EWgk6nX2A+n6iVYjq3i4r9nHUmuYY
         HNFpmG6jctKN94LL2ITW7nYn2PhYmX7n+qQ1PAdKylcQnlhG9L6kCF2FaGrx9LWoOBzh
         mYsQolEjEKgc01MU0S6zYyBFq3Xqtx5e6ptnGzHLGqZjv5UngOSczP+Z38+w9NMWkBGf
         7gFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aXhjnJjyxGwGBQNBVIUc3v+UOGe7/rz+EZPaPaMDsVg=;
        b=DAoqFJepAEsCIzth/iRgTGXyZHXn9n3+HAamFBHeGwajBXv9Xr1cQ5Uc5H4JRJcaoT
         OuSQi2QUrqCm0f27B865G8/O/NNXcShnbFE+oJ7MWmDBcW4XNCX3lWqoc3hFdFFnbzxp
         7qMgsLOlOJfKw5/vGJYwz/hEYAgG7Z+qkvhShYA7K4yGL9V0JuPZb0CI7ew3v8/uOWhG
         iDjKb1m5xjao5x/zbBzs+9HuZ3zUlAo838bQeQr2/LGUSwam4yVI+IJ8EbjjHGFbGxBr
         c2hl4vBKsKveR2YIUxwJNlqfIJNA26UD7tLr8+EJRgNdsvUX2oiVMaqzXT31Lvbnu31c
         SbLQ==
X-Gm-Message-State: AOUpUlFmkrewED3bWNH/2iU7b11Or1Bg88Ns2mv6ngElnQqqFyUiwuup
        ET3tZ4jWk+E5RlJ1mRenw/g=
X-Google-Smtp-Source: AAOMgpeKZwuHflBE6kTuuki4vcdWQo7uIzPtcVBBhrkHSlf3pKIN2VL0fS3NOkc8r4zlWSl4iPuwJw==
X-Received: by 2002:aa7:8298:: with SMTP id s24-v6mr6388270pfm.136.1531477271944;
        Fri, 13 Jul 2018 03:21:11 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id u17-v6sm84352022pfa.176.2018.07.13.03.21.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 03:21:11 -0700 (PDT)
Date:   Fri, 13 Jul 2018 15:51:03 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, yamada.masahiro@socionext.com,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 01/18] coccinelle: change strncpy+truncation to
 strlcpy
Message-ID: <20180713102103.GA12972@himanshu-Vostro-3559>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
 <20180713074455.GA6859@himanshu-Vostro-3559>
 <20180713080023.GB9638@nautica>
 <20180713091412.GA11250@himanshu-Vostro-3559>
 <alpine.DEB.2.20.1807130540270.3044@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1807130540270.3044@hadrien>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks Himanshu for the suggestions.
> 
> However, I'm not sure to follow the discussion.  The original problem was
> that Coccinelle was removing a comment that should be preserved.  I think
> that this occurs because the line just below the comment is completely
> removed.  Coccinelle considers that the comment belongs with that line and
> if the line is removed the comment won't make much sense.
> 
> In Himanshu's solution, the code is just not transformed at all, so as a
> side effect the comment stays too.  Is that what is wanted in this case?

Yes, there is no transformation with my solution which I advised to
prevent comment removal(which i thought was useful).

My rule is more narrower approach than the regular ones which used
"expression" metavariable.

Rest upto Dominique to choose whatever suits better :)

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
