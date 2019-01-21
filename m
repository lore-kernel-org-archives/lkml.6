Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E03C37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0234520844
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Ay0TVwke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfAUUXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:23:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53717 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfAUUXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:23:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so12054480wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 12:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rnfi6FhOzAfyBxqYRd6zljSxPBFdBOX6GJFmQN4hMhU=;
        b=Ay0TVwke7xtwJhAzANL3INYkZ7/yq2ix7aOJ5INJjDsGn8KfH18JOzHkafqaw1ZRSB
         /l8T5Xe2ZEOiTeACvCQrYo8R/i5vrcN0Q+ihvPsbfu2T3Yilf4ccD57jrnIHheTKjS2D
         kMxAhlYxo/WHDbSDt9e8YBMx3cDOgVM4vcerUKkE5wQXJUNW6ptgmFwR5+7NSzorV7Rh
         3vr9Ix5dVaGouRe2RPvLBQgPnIYslpLK4p/tNO4fUG1XEpFu6DV4Lg/KPNx3ByTrGW1l
         WBwEZPW1WvA+RbPPWzuYiGfO62o2kwLk4DVX62eHElaR16Jm1yZWMIGIAkv+lVpdnFrT
         L6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rnfi6FhOzAfyBxqYRd6zljSxPBFdBOX6GJFmQN4hMhU=;
        b=U1c8hyshKvZpIbN4Hkqk9hfUNnMRYmeuh1j1MWVLdsieU3/nifkGaZLcDhMrsJ6T9i
         Xy3s1+ut1H+zYpRAUdlpqLlw7qsBlPphnKS4D7UxaCrAlb+RSBM4pOpf0SF+rXcLmCXu
         azosyFXU0MGo5TIOUSp3m35IkkrGEWBl+U1T9glT+8ewN/Gc3WqcrtI1B8D36SJEslNq
         aoJgJwUDFEueCtY8ewjYN4KAZh0uzp4BDk49IBq+AvJDhvr2WHlujOlY6f56iFtvs2g7
         VK/Wd4EDsvvsX4xqg4P9MKAAtxnK0CACFUszzWBCHcyz5QHffyGuPUhwGidodf1MQGz9
         XSsA==
X-Gm-Message-State: AJcUukdaIQSqI6UYm8bhNPjqacbpfdWbsVzpwrb25cKbxNFByhW6lDcu
        pqN905nbztwj+ERizeO37xFnvA==
X-Google-Smtp-Source: ALg8bN6otZVk7Ia5C2oYRefCZ07cY1dejrVEEVSjpSh6bnHuTz0DiwdqdJMQvzAKdUNs3CeSN/JmTQ==
X-Received: by 2002:a1c:b10a:: with SMTP id a10mr783797wmf.148.1548102211189;
        Mon, 21 Jan 2019 12:23:31 -0800 (PST)
Received: from brauner.io (p200300EA6F1466E194736B39AFAF14D4.dip0.t-ipconnect.de. [2003:ea:6f14:66e1:9473:6b39:afaf:14d4])
        by smtp.gmail.com with ESMTPSA id c1sm40828045wmb.14.2019.01.21.12.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 12:23:30 -0800 (PST)
Date:   Mon, 21 Jan 2019 21:23:29 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
Message-ID: <20190121202328.rgrv54lybilsvitu@brauner.io>
References: <20190121143951.68956db3@canb.auug.org.au>
 <CAK8P3a0Yth+f8AANE6g8c_zE0Zt1CvCdzMDFK=pr8eNqmrBV0Q@mail.gmail.com>
 <20190121191306.ifga5aw5atu2vvb7@brauner.io>
 <CAK8P3a2CkXJ=giXQgxEcQAeH1Wt8jKc_P+YTOLJpUPVKYU8m9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2CkXJ=giXQgxEcQAeH1Wt8jKc_P+YTOLJpUPVKYU8m9g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 09:15:27PM +0100, Arnd Bergmann wrote:
> On Mon, Jan 21, 2019 at 8:13 PM Christian Brauner <christian@brauner.io> wrote:
> > On Mon, Jan 21, 2019 at 06:16:22PM +0100, Arnd Bergmann wrote:
> > > On Mon, Jan 21, 2019 at 4:40 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > I plan on sending the pidfd branch with the new pidfd_send_signal()
> > syscall for the 5.1 window. Should we somehow coordinate so that our
> > branches don't conflict? Any suggestions?
> 
> A conflict can't be avoided, but if you pick system call number 427
> for pidfd_send_signal, and Jens picks numbers 424 through 426 for

That sounds good to me. Since it's only one syscall for the pidfd branch
is there anything that speaks against me using 424? Given that the other
patchset has 4 new syscalls. :)
Jens, any objections?

Christian
