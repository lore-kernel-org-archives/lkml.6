Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4486CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114B02077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="x2Kx5Ym8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfBVIYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:24:49 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:19249 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVIYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:24:48 -0500
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x1M8OO9G009567;
        Fri, 22 Feb 2019 17:24:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x1M8OO9G009567
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550823865;
        bh=UPyBehQJua9MHnBkqI3Zksqv5MLaexmDr2NRzizwabo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x2Kx5Ym8qD4xqezebQtsTimpPlfy1DliXyVW7zxFK8UEXBAj8WcaaHYccCynLOQ9M
         HK+9paxQPBjsXc+ocxNbaptFR11h3ZA/3LEZ3+oQpPAtJsy3kpDM6OpWXkSW2Hl863
         1TlKvPpfVIL3mA1IyE7/R5A1KMnIKNraUAVGUVyLMXhKE+7kWrchJHsHAYEWRTes5t
         nfaMk0iShPshKlGYSR+AJ8Q9vuBZibhwDwg+vNtrAGmDTdYxKTDEMmzW68e9Vj0mxy
         tTTRcRRTY3voQ4jamXQAcj+m4viKrfPJMcyxuhlleUt6TH/rdI/ngyRk92ovZjlyul
         yn242+Qyf3OAg==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id p9so1235160uaa.5;
        Fri, 22 Feb 2019 00:24:25 -0800 (PST)
X-Gm-Message-State: AHQUAuadHSNv+ZqjG0cAY0QsCIkwQGtBKjh9i0ooXhpDm71gvWI+yFIk
        OEGgM3DFMVIr6oNdWCHKkh05m0HY4v+FzDpILSc=
X-Google-Smtp-Source: AHgI3Ib/VR6+pBN66n9zANsJ5RYnjen2c/PlCAVVGDfBC34S6YW5TSHWmlkcP5y+JuscCffA//mu40PjOcFpnHpqnkA=
X-Received: by 2002:a67:f107:: with SMTP id n7mr1626928vsk.54.1550823864398;
 Fri, 22 Feb 2019 00:24:24 -0800 (PST)
MIME-Version: 1.0
References: <1550805799-24572-1-git-send-email-yamada.masahiro@socionext.com> <80b08bfa-8052-aebb-db43-c7cbf3f5dd9d@roeck-us.net>
In-Reply-To: <80b08bfa-8052-aebb-db43-c7cbf3f5dd9d@roeck-us.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 22 Feb 2019 17:23:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNASvqCW9iK3MSYpjKnvYmaXdwrW+3E4S3pe0A_ugmUmQ2A@mail.gmail.com>
Message-ID: <CAK7LNASvqCW9iK3MSYpjKnvYmaXdwrW+3E4S3pe0A_ugmUmQ2A@mail.gmail.com>
Subject: Re: [PATCH] bpfilter: re-add header search paths to tools include to
 fix build error
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 2:55 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 2/21/19 7:23 PM, Masahiro Yamada wrote:
> > I thought header search paths to tools/include(/uapi) were unneeded,
> > but it looks like a build error occurs depending on the compiler.
> >
> > Commit 303a339f30a9 ("bpfilter: remove extra header search paths for
> > bpfilter_umh") reintroduced the build error fixed by commit ae40832e53c3
> > ("bpfilter: fix a build err").
> >
> > Apology for the breakage, and thanks to Guenter for reporting this.
> >
> > Fixes: 303a339f30a9 ("bpfilter: remove extra header search paths for bpfilter_umh")
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>


Thank you!


-- 
Best Regards
Masahiro Yamada
