Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B8DC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 19:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8F82082C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 19:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HTHu0Liy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfBBTMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 14:12:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40624 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfBBTMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 14:12:53 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so8544134lji.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 11:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BRV4AVujGB836NZz3uyEy93lPYkFrIFXKDMkyalEMa0=;
        b=HTHu0LiymFwG/Msy8d5G7CgdBuB+M3S1E/6ttvYzaGVsjtowwR+Ttxm1eXEpkV0u/Y
         yz3GuZ4Q/CsZllNtC1KDORSvhFDn43Tx2pyVpNFr2euTkoZnyhVBsWfaEMC2519UzykW
         dIC97r36zXrOB754f8uoTeeZBJiLEOGre97qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRV4AVujGB836NZz3uyEy93lPYkFrIFXKDMkyalEMa0=;
        b=p1vDWjPAMO6w/Itl1Yi27OoNOZJqWnWajxsrxsk+6hYc1044wKb4s5ZpuQPv6afx5g
         muX6uWrjLaBA6hsvq6qJIJyQMg+wvxWvG15b2wczRndU2qzx3j/YqNk4ldeJ1ZTyqCBG
         zApwxEUgTvcXZR1U5MCGjJaoij2hH4CHOdhqw1FqKWPxoPPFD9FSrxB74dSo3xrjtGIR
         bzld3k11Gh7ZibUsnnFwqm/5yEEcBpopL+6SEGjP6UYmRRT2giKsLd8NodSYW+pMMiBt
         OGZoTgffxXEz+UU9T2uMxBj1FJoRQ5DwwV3EsfLQfCTtNHrUPzmr+i+K/1Dg2gJ2xjPt
         Usqg==
X-Gm-Message-State: AJcUukdcAuw2Fl38KWt/hFWWfhG4NsXYURZfgM418n3V4MCRiknbERd0
        THXOMXdJfdJrvjxnEWaz9EZsOtzl7Fs=
X-Google-Smtp-Source: ALg8bN4WkeHzwBeD9FWipPCmDRVU5rJUZMB1SXLnHpeDuDlnP5NLs6wh+zCU2Rkw1EJzVZ0E2Tq68A==
X-Received: by 2002:a2e:9b84:: with SMTP id z4-v6mr26605488lji.93.1549134771253;
        Sat, 02 Feb 2019 11:12:51 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id l195sm22479lfe.95.2019.02.02.11.12.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 11:12:50 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id t9-v6so8565434ljh.6
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 11:12:50 -0800 (PST)
X-Received: by 2002:a2e:3509:: with SMTP id z9-v6mr36927021ljz.54.1549134769857;
 Sat, 02 Feb 2019 11:12:49 -0800 (PST)
MIME-Version: 1.0
References: <f0086a11a40fb97503fb559b53dcc94c9f873e32.camel@intel.com>
In-Reply-To: <f0086a11a40fb97503fb559b53dcc94c9f873e32.camel@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Feb 2019 11:12:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgXh57rgtmSEvbKd69QYtBTRzU3QH36rKcFGiETRj45Sg@mail.gmail.com>
Message-ID: <CAHk-=wgXh57rgtmSEvbKd69QYtBTRzU3QH36rKcFGiETRj45Sg@mail.gmail.com>
Subject: Re: [GIT PULL] libnvdimm fixes for v5.0-rc4
To:     "Williams, Dan J" <dan.j.williams@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 3:31 PM Williams, Dan J
<dan.j.williams@intel.com> wrote:
>
> Hi Linus, please pull from:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.0-rc4

Hmm. One more pr-tracker-bot note: going through the pull requests
from the last week, I notice that this one didn't get a pr-tracker
response.

It looks like lkml still hates you, so your pull request email never
made it to the list despite being cc'd. And thus it never makes it to
the lore and pr-tracker-bot infrastructure either.

Have you tried looking into why lkml has that red-hot hatred of your emails?

Because it does seem to be personal - you have pissed off the email
gods some way. Did you get a bounce?

           Linus
