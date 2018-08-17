Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A6AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41BF2152C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WfTdCP/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41BF2152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeHQWfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 18:35:50 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:35169 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbeHQWft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 18:35:49 -0400
Received: by mail-io0-f173.google.com with SMTP id w11-v6so7810675iob.2;
        Fri, 17 Aug 2018 12:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VbgrAHl7SsnzT6orsNWJmORk92cpKtA8U2mF5UE40/w=;
        b=WfTdCP/xqVPhu3dTu8K8tKG2ztkFrNpbNKLNfInIIvSIZNcO7o6Rj8Wq8W6cXFAzHX
         1oEbsbf9AK/5cb3FnrAurxnr2e5iM9/ff8InyvI9LBvCFtsFJVB3QAd+/JJGXE9sABob
         L6Sv4c2dDx/XqwH5721jHbrxtUkT/rdEkg2pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VbgrAHl7SsnzT6orsNWJmORk92cpKtA8U2mF5UE40/w=;
        b=pETeim01Gls0yw27aYskGS6o6ttRXNnCAKPHHmJMD0TY6Y7mGLG1A/ZaoG/fSPqw0D
         RsC/4Be770dn+mu621+JYZTCRA7OwcFtzHjCKnTt2A1VU3Vgpd7DQZIdjMhAIWDl6mVW
         dYIYjCiRXqx2+A3uBvJhGlYkGFesZokvjXfNmnoF4MOvfsLOoawamAsI9ZREeq+XwWt7
         bD1LuaR03r5+krS3/Fplud85NIFsceqOxpa59vdo2/GV7nD+pO99FTVlU3b9P9ATpQyc
         p61Oi1TacvTXwKsADwfASmAAOfgXrS5O6esARCdHSrXDB6dc1MpTTOF2dzXv6XOr+4mq
         Mh5g==
X-Gm-Message-State: AOUpUlGbfWGhSY+VISy3PLYxpqVzsWm/r0XVIgu8ErF3kHnak7JBOmBg
        6t1R4DrPtISP7L51gOwdi+++aSNp0r4VLPTK+4o=
X-Google-Smtp-Source: AA+uWPxqtODZHGjnISVSAyd0bWMJXQjaWr+02+JEDt2VpFl/4zFgW4I06srSsHk3qwkxEnAu9iQRns0YgBX9XC4me8g=
X-Received: by 2002:a6b:f815:: with SMTP id o21-v6mr18238737ioh.203.1534534271299;
 Fri, 17 Aug 2018 12:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180816215726.GA20526@ziepe.ca>
In-Reply-To: <20180816215726.GA20526@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Aug 2018 12:31:00 -0700
Message-ID: <CA+55aFxgT8Hipm6bDrHMZ-nmdk3KZTP=J6D5k10UHTcajXAEHA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 2:57 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> This time there are many merge conflicts, all due to various tree-wide or RDMA
> subystem wide changes done by various people. The resolution is tricky, as git
> does not highlight two areas that need revision.

I was confused by this, because there were no merge conflicts.

Then I looked at the history, and the reason is that you actually
pushed the for-next branch into the for-linus branch, and so I got the
pre-merged version.

Oh well. I'll look at what the conflicts were, but may end up just
taking your resolution.

           Linus
