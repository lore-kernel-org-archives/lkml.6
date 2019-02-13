Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735E6C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F23C222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KHjbVsFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390657AbfBMI2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:28:10 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33952 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389393AbfBMI2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:28:09 -0500
Received: by mail-it1-f195.google.com with SMTP id j17so1015406ita.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 00:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oUOESfCs2JKUr06HFwqaqcZEgGAvtw6Ga9RJAY0/XVE=;
        b=KHjbVsFAGe5kL0whgNUj4yJGoi7INyUg6kBDyLeHO84YWt6mjXcl2Ua6UdwpF0ImDa
         TmO6TCrS2cet7UmS/bIjmjKe++9vRqniwRMvZiEM1fbWweydJRgITpQxZCzsLeEIFEAi
         QLi77/9h38BHmZgME7i6nWwUIOOvPKCX/znOnra5zZ8vh5S02jamn9mxRVGyG73R4n1E
         zAArHuHuywkIzJJGNRaxEutnIE40TYP8PaojudQfD5HxsJQu4RmVRBIXYHe695TwNfRS
         hPeYeIUAzREvvdkm/7KBPC+T+Z810e3sqFR7Y2plB8wZ/knvolewANmm2cEC7J1MSF5Y
         f9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUOESfCs2JKUr06HFwqaqcZEgGAvtw6Ga9RJAY0/XVE=;
        b=T6T6IikWctMwh/pGK72mJn1KsIDPABD5wVD4Uh0e9lvJ4X6LKFXKUqg7TfJXblzSww
         dIvCixYDPmdKliHpl4oOS7iUuXo9Q6PM1fPgqZO1ryDNRDF2vC557DEVRoCAgBtmHRLn
         Fwrpu5NboVFen1VDm5lUSPhGEKv21mx4nqhmV+xgKwOxtNmUCO9DxuAukdwum5SOLaEQ
         /Sw73T+7xFhXuCEQuCPfxoT0tbBaICF8SzLds/Uv5JepKGSMUG7k6dIFd2wrIhe4JVvi
         fl5iPrla3NyvhmIAXk0BgVLkK080NjSQyqPhr3cALS5y1LJ/hs5XMcIAasmWXPkSva1j
         PCMA==
X-Gm-Message-State: AHQUAuYn9QxuMlQ/W24M7Qn9WCRWsJHz6JsMR84msOe9IQqjzomx0TzC
        Ytcnf5Hu6dQq17Bp4ZyvymsV/fLKozhGcWu1/kLyHA==
X-Google-Smtp-Source: AHgI3IaxpYbHG2FxCIUkjtqeJfxg92cycDUtEq1CI8jWo2tSKkz7wFzY+UdA7+FyS/cgzNKsjBZKFPV6kbMC1EUtBBA=
X-Received: by 2002:a24:5052:: with SMTP id m79mr1408387itb.166.1550046488924;
 Wed, 13 Feb 2019 00:28:08 -0800 (PST)
MIME-Version: 1.0
References: <0000000000002015db0581b71858@google.com> <20190212191920.GI10665@localhost.localdomain>
In-Reply-To: <20190212191920.GI10665@localhost.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 13 Feb 2019 09:27:56 +0100
Message-ID: <CACT4Y+ZLEPummCf==B30ucY8cdoOx8FWohnUn_UMoWmwwTL87g@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in sctp_outq_tail
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     syzbot <syzbot+7823fa3f3e2d69341ea8@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-sctp@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladislav Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 8:19 PM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> On Tue, Feb 12, 2019 at 11:04:27AM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    d4104460aec1 Add linux-next specific files for 20190211
> > git tree:       linux-next
>
> I can't find this commit. How can I know for sure which commits are in?
> Recent patches are involved with this code, but not sure what was
> included on the test.

Hi Marcelo,

linux-next is weird. Not sure why a so recent commit is not in
linux-next, maybe one needs to fetch tags or something. Fetching
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git
helped me to get this commit:

$ git show d4104460aec1
commit d4104460aec152e23cf80ab1f950f414bf94f4ea (HEAD, tag: next-20190211)
Author: Stephen Rothwell
Date:   Mon Feb 11 18:37:26 2019 +1100
    Add linux-next specific files for 20190211
