Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB21C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3A0217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551139655;
	bh=XcfZxoyF1741C1XnA6YchOUdnu5dIJOPZnv9emuQMVc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TmiuHIQd4yKggoiQjLe6tH4Zbi0tjBtu0a/prRmL/8oOGiZ2AERjcKatcQuP4Sxhc
	 A5USogp2tS1beppNiFTfxcag7KO/GKJNL/uUZWOtqeDBkpD2JxqJ9wwGlMqdk0XQWt
	 x2QPew2KmzwnfeO4AjBNSaWvbY2CehVgUSGEyq8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfBZAHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:07:33 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38124 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbfBZAHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:07:33 -0500
Received: by mail-lf1-f67.google.com with SMTP id n15so8277175lfe.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0/RCL+H9yC/RWFMtaWm284KCaP64OOSmBn5G9YZ2KtA=;
        b=bNZr7nXI+nIktrAxf5ZjL1b7XP4SSnerSSU1J8dZOjk6LLGkSlefNh6KNOMaAxUP9u
         m2XpNxKf3eJLN3njAYmwKY0KuQSXY+s+ijf1ib1CUS3T6gjAfGM6JVVd9dZ6/Le/ISG6
         qF+2IPWv+qy16dnaD1+WDd7yY2DMNYpVUumbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/RCL+H9yC/RWFMtaWm284KCaP64OOSmBn5G9YZ2KtA=;
        b=X+aomWv2AQG7ivVcpUfrHfbSw8lWMwHx3dCtCOTPlAgcGJzU0ucI6rOWy/EAdyuJM9
         QvQwmoG6eFWlGAtiWCHnhhGxaxOcTt9bzn4jX7Lz9pKMybO+4Lb66xlRLEkUwMZYwAf1
         wYbbwbM3LP8AOsRzvquuZNrPQwWRe4rUR+SFGB6dO7TNhXrNsxGj300D+jF+hgEP7bhA
         USH6DX/XIWRB7suM75HfVSXdCXnValGLk9gqqjLR+MA8Iq5f3ByEL/rTLpVfgyz84sH4
         xnqti8xLgiNWgiEaj4RRfEXzXVFofR3Xg43EroGhfi92vYPwALPlEAsud8JEcLdM0b2O
         hM3w==
X-Gm-Message-State: AHQUAuaX00Ue1BsOQZrZAo0LiyS3xds/7wFhs96yABffPo8lgu8Mf97M
        EpS+HCIP736kJGTaQRf3AGAqMGA70Gc=
X-Google-Smtp-Source: AHgI3Ib5WXc7r/9bdf1rqLgJ+ro9xkcwZEPMbUFzKitvELvGsiUrPyH0Tpm/04uQEL/CfEtwTAK7Bw==
X-Received: by 2002:a19:384c:: with SMTP id d12mr11429140lfj.105.1551139650160;
        Mon, 25 Feb 2019 16:07:30 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 5sm2515144ljf.86.2019.02.25.16.07.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 16:07:29 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id w6so9110651ljd.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:07:28 -0800 (PST)
X-Received: by 2002:a2e:9786:: with SMTP id y6mr10251793lji.79.1551139648545;
 Mon, 25 Feb 2019 16:07:28 -0800 (PST)
MIME-Version: 1.0
References: <20190221222123.GC6474@magnolia> <alpine.LSU.2.11.1902222222570.1594@eggly.anvils>
 <CAHk-=wgO3MPjPpf_ARyW6zpwwPZtxXYQgMLbmj2bnbOLnR+6Cg@mail.gmail.com>
 <alpine.LSU.2.11.1902251214220.8973@eggly.anvils> <CAHk-=whP-9yPAWuJDwA6+rQ-9owuYZgmrMA9AqO3EGJVefe8vg@mail.gmail.com>
 <CAHk-=wiwAXaRXjHxasNMy5DHEMiui5XBTL3aO1i6Ja04qhY4gA@mail.gmail.com> <86649ee4-9794-77a3-502c-f4cd10019c36@lca.pw>
In-Reply-To: <86649ee4-9794-77a3-502c-f4cd10019c36@lca.pw>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Feb 2019 16:07:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wggjLsi-1BmDHqWAJPzBvTD_-MQNo5qQ9WCuncnyWPROg@mail.gmail.com>
Message-ID: <CAHk-=wggjLsi-1BmDHqWAJPzBvTD_-MQNo5qQ9WCuncnyWPROg@mail.gmail.com>
Subject: Re: [PATCH] tmpfs: fix uninitialized return value in shmem_link
To:     Qian Cai <cai@lca.pw>
Cc:     Hugh Dickins <hughd@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matej Kupljen <matej.kupljen@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 4:03 PM Qian Cai <cai@lca.pw> wrote:
> >
> > Of course, that's just gcc. I have no idea what llvm ends up doing.
>
> Clang 7.0:
>
> # clang  -O2 -S -Wall /tmp/test.c
> /tmp/test.c:46:6: warning: variable 'ret' is used uninitialized whenever 'if'
> condition is false [-Wsometimes-uninitialized]

Ok, good.

Do we have any clang builds in any of the zero-day robot
infrastructure or something? Should we?

And maybe this was how Dan noticed the problem in the first place? Or
is it just because of his eagle-eyes?

                  Linus
