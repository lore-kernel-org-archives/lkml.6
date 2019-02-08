Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CF0C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5C42080F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hdPySCvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfBHJef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:34:35 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38893 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbfBHJee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:34:34 -0500
Received: by mail-it1-f196.google.com with SMTP id z20so7357802itc.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 01:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B51hzRtHxI8dz2WusjwLfXXJYO2Em0L5zJ4G84EilMQ=;
        b=hdPySCvxx39ovYMxMmZbtXMkgI77AjPt4lqj/J+Ca8L3yF1pkfmFNmM0o6N1jeqA6c
         qZJsvKY92DDlVrBfchOzB69WSVCos5ymscQU+jWpdJBzURFC6fPtDlQaFoGZ3qqu5WRO
         wgRXgMYr9rNqMmMcUjV1SVudEknTsFUaNPNgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B51hzRtHxI8dz2WusjwLfXXJYO2Em0L5zJ4G84EilMQ=;
        b=h0MEbTfWOLjk1FBLfq4O2kgn6A0akAv8+Xd7CbOuNR7aJQqZt0rqgrMyleOBhF15bG
         5YC8/qLN18GydsKQmMWQIicA8fAODBsYQYUtR/ATeodyCM9z+qudJ+0oT2mgAIw8Rd+x
         bZGoUvRjT3+TT8bFa/47R/o9DW3Cz3ZikrMltW9lTmK7EbWxGUSFdblIUNUUjhP1Tp+y
         2+ukfnvpScJP3D0S1te8gDodaCL0My99s5Js2Jldmdi+sb9DfgNsRuh1RMDZU2JagPpW
         eyOA/jhVshp56T6AiBv3zfPfg0ZLBRCYEYWSf4+UzYBlLCdyQnC9P12pMSucsoPglY7G
         29qw==
X-Gm-Message-State: AHQUAuZCukNl6fa2Ry8GeO6JdetEJhg4YXbXfPUjsk2aQnH2p2vZPPB6
        u0l3ZpNyJ+qwBtHMxrRsDAoYBWMvxIBkFpTOWyiasA==
X-Google-Smtp-Source: AHgI3IZ9UB5lLvVuz2T0d3ECrt8MEguDnBb72LTzzaAfy3AU0vhzHnlGZCK7RcDYvKdSrg8KdQfkzKGcJxqrTkW9m5g=
X-Received: by 2002:a24:94cb:: with SMTP id j194mr7463197ite.117.1549618473855;
 Fri, 08 Feb 2019 01:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20190208122744.4a63bec0@canb.auug.org.au> <20190208085333.GH23159@phenom.ffwll.local>
 <20190208202555.3aa6473c@canb.auug.org.au>
In-Reply-To: <20190208202555.3aa6473c@canb.auug.org.au>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 8 Feb 2019 10:34:22 +0100
Message-ID: <CAKMK7uGxXxFXLt2m5_3y2a2zi09WyUCkSMTnYQv7doswQZUbqg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drm-misc tree with the drm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 10:26 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Daniel,
>
> On Fri, 8 Feb 2019 09:53:33 +0100 Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > There isn't a "below" afaics ....
>
> Oops :-(  However the merge diff is not very enlightening in this case
> anyway.  It makes more sense to look at the final result when I finish
> up in a while.

Yeah conflict isn't too bad either, and we have it in the drm rr-cache
already. So not worried, just wanted to check whether there's more.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
