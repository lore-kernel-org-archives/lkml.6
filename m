Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC8FECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF0B20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lkcl.net header.i=@lkcl.net header.b="IhcC8YTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF0B20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lkcl.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeIRHlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:41:10 -0400
Received: from lkcl.net ([217.147.94.29]:34000 "EHLO lkcl.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbeIRHlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 03:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lkcl.net; s=201607131;
        h=Content-Type:To:Subject:Message-ID:Date:From:References:In-Reply-To:MIME-Version; bh=3IWMnUUSxpCgXmfIHcAv2MALAw9Hl43Robt+HPNoFfM=;
        b=IhcC8YThNcE9r9lffP9Emv0+/1A0oyt7Gv1yg9mYyWpQ7ElgH5jdkRLCm3HG6AVNVQctp4pVmeL7FrWgGBxB1s0sd+XwNJhIE8DNno+vKOWKc4EWu8eM/qc3yc15vxNf20Io235q3I7t7PwuOwOioNG5n/4edJPz/gpZov0j5Bo=;
Received: from mail-it0-f47.google.com ([209.85.214.47])
        by lkcl.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <lkcl@lkcl.net>)
        id 1g25Te-0002TT-3x
        for linux-kernel@vger.kernel.org; Tue, 18 Sep 2018 02:10:58 +0000
Received: by mail-it0-f47.google.com with SMTP id h1-v6so1039729itj.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 19:10:41 -0700 (PDT)
X-Gm-Message-State: APzg51B1WvlW2e6otPBzpn8qFYx9rq5tpYaknPpPyi3x2ASvIcgx1Y3n
        YoQN9YAEprag+NAh9ckCCgqR/Hb9Pir3eBuobLc=
X-Google-Smtp-Source: ANB0VdYOY5WM1n6mIeScsVNfZBxwiUgIXFmAHNK5KL+/WyUY6Wxd5Jh1WBTpg6xsDsZg6eP2zXotSG4o4j/yAxymTP8=
X-Received: by 2002:a24:ccc6:: with SMTP id x189-v6mr13262655itf.110.1537236635684;
 Mon, 17 Sep 2018 19:10:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1543:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 19:10:35
 -0700 (PDT)
In-Reply-To: <CAPweEDwKzoxoVFSNbSnsHtqNhxB+AbdjD9XMXW0MEwNPGdr3Xg@mail.gmail.com>
References: <CAPweEDwKzoxoVFSNbSnsHtqNhxB+AbdjD9XMXW0MEwNPGdr3Xg@mail.gmail.com>
From:   Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Date:   Tue, 18 Sep 2018 03:10:35 +0100
X-Gmail-Original-Message-ID: <CAPweEDxGEi-Nz1yMiLVW2FDm+iSqH_0SKOK6o4zO=KNaG2=XNw@mail.gmail.com>
Message-ID: <CAPweEDxGEi-Nz1yMiLVW2FDm+iSqH_0SKOK6o4zO=KNaG2=XNw@mail.gmail.com>
Subject: Re: Linux 4.19-rc4 released, an apology, and a maintainership note
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clm@fb.com, dan.j.williams@intel.com, corbet@lwn.net,
        olof@lxom.net, rostedt@goodmis.org,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8a104f8b5867c682d994ffa7a74093c54469c11f

ahh, guys?  ah... i'm going to try *really* hard to follow the advice
that's listed here ok?
http://www.pndc.com/documents/_PDF%20Text-PNDC%20WORKS.pdf  it's a
little challenging to do so in email, as it's specifically designed
(page 6) for face-to-face conversations.

 following point (1) on page 6, i believe that the question i should
be asking is best phrased as follows:

 * what was the intent behind the change to a "code of conduct"?

 following point (4) on page 7, a second question i believe should be
phrased as follows:

 * whilst the "positive" list of behaviours look good on first glance,
we've witnessed what happened with freebsd when they adopted a "code
of conduct": would a (public) reasonable and rational discussion with
a view to removing the "proscribed" list of negative behaviours be
welcome? [1]

l.

[1] it's a little more complex than that, you get the general idea.
