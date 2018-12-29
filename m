Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A80EC43612
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 04:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDB021902
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 04:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N0fC7CQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbeL2EPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 23:15:32 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45520 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeL2EPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 23:15:32 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so20043613ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 20:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KmAnZj6zHaXNojG6OZsflTWqGMAp/1Un2CyCaQUoecY=;
        b=N0fC7CQ/LjciIsz2v0VuyNZipMGAC6cVpOrOOO+71F9fT7jBvaTRe2qsVO6fAe1vJm
         O8TSMU6f37fLBsij+1w3AwBap+/G1mN5sskMwRNn614b5TfKy5PHQksvWXlcRSlBdHIa
         LQCjNc21xW6c5oBTYdYgGhbkSAW2EWvlVbjwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KmAnZj6zHaXNojG6OZsflTWqGMAp/1Un2CyCaQUoecY=;
        b=jIKWjY80dz+A52pDnqeO+jI10Q0pwignJYjg14zvh2k8mMzwCXxFjlEH6u2opeHjld
         7ETVlU0D08fb7N7+0LH++3tjoZCbKUTX+oXMmHcRlMDwhoWShOcExqI8xSXX2DpmD+R5
         QINLeVliWBJWXCqfO0Wa9EJgCptTwKlihttf+1vG30ou6zIk48ys02LN5IyBxcHHp3H4
         VcQxXMBYuORVYFjXxvoCcMj7bqzqrJhLs3bg5gfT7Gnn9nu7Snyg5OFsZijQnRuRNhEp
         +pJ4eIW51s0NxPHI9T+lP5yGUrqvtOZloZKxNy/AZ4t/7e+n+OZIXibz+oCxatnsri8u
         DjEA==
X-Gm-Message-State: AJcUukc+Qt/X4/y+v3YYgLNP3P5DtvnS/yR1L/ZM4Fjy0mSE2k2U8by3
        isLFe6nGdxDCjBr7vicxXLeKznJQUPo=
X-Google-Smtp-Source: ALg8bN4AD0pV4hjZLyzXe2Ki3OgyL8a+bnj666rj9j1bnVO8E9/xRI3idbditSXRYk7VmSHHjjmrig==
X-Received: by 2002:a2e:20c3:: with SMTP id g64-v6mr19131664lji.101.1546056929941;
        Fri, 28 Dec 2018 20:15:29 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id x21sm8322262lfe.6.2018.12.28.20.15.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 20:15:28 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id l10so15591886lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 20:15:28 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr13983313lff.16.1546056928294;
 Fri, 28 Dec 2018 20:15:28 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1812250652420.2714@namei.org> <CAHk-=wiUaA4sZ=8UnT+q6eXE29K+XGVX=kZPR6gG-Z4UhO3p+Q@mail.gmail.com>
 <alpine.LRH.2.21.1812291406530.29722@namei.org> <CAHk-=wh4sL5mO1J+yzngonBvjO9ZwL_kA0a2e51rE9TzVjAA4g@mail.gmail.com>
 <alpine.LRH.2.21.1812291505480.31477@namei.org>
In-Reply-To: <alpine.LRH.2.21.1812291505480.31477@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Dec 2018 20:15:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh+6WrC_W7ZCjMDPaZm9SuuRjoTe8Buq123CfRvTyu0wA@mail.gmail.com>
Message-ID: <CAHk-=wh+6WrC_W7ZCjMDPaZm9SuuRjoTe8Buq123CfRvTyu0wA@mail.gmail.com>
Subject: Re: [GIT PULL] security: general updates for v4.21
To:     James Morris <jmorris@namei.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 8:09 PM James Morris <jmorris@namei.org> wrote:
>
> Yep, I understand what you mean. I can't find the discussion from several
> years ago, but developers asked to be able to work with more current
> kernels, and I recall you saying that if you want to do this, merge to a
> specific -rc tag at least.

If people really want it, maybe the merge can state that explicit
thing, as it is I'm trying to push back on empty merges that don't
explain why they even exist.

                  Linus
