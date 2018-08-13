Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9F0C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5D4217B7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+isxxnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5D4217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbeHMOBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:01:36 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52825 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbeHMOBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:01:36 -0400
Received: by mail-it0-f68.google.com with SMTP id d9-v6so12614794itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 04:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhC2GA2nb+wNTNJKhDbvjA4UdcetZkFm/vJHwDBji6M=;
        b=Y+isxxnP+0mbV2f8Q4Tp48nQE1KYSqcN2TdXCoNLUrxNzyKu4DMuDvSNWKCo1VCXEe
         q3iEAgixOUeXU3DNubtc3zem6fSa0MQC7Ap61g0RfxNADDCBOmtVpO7+dcR80WJjpD6S
         U8M+Bd4CFhpCeygTW02sBCGjwzdkojkLqY1LCbBuAvoTxvPeosfmJZ28PgwRlB93CkBI
         CfMgdJnimcEKmtfK4T6TYSiFXNbnsTD/2F35nTsLaAiH614Te9oIuK5/ss2YU2AiiL5u
         W8KJyeJjcdHUfnhxiqvRiMaVh1WSR+bXfFTapt94rXgTtkhKvfBJBnM5wHRIJyV6g0BY
         aWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhC2GA2nb+wNTNJKhDbvjA4UdcetZkFm/vJHwDBji6M=;
        b=N/KxjiaS0aAOMVx/JCQWUnCN3OS9S4bSnWrtDs6+3jpIC6vEBGxsWSVdRlWmeMztqK
         Q0dVbTiJYtk4RXuMH9G4QfwBSoXraOcU8wsuFOSO43G2RWwr5XjNM2cQwNZt44bLxWIa
         MN+XyxyzXIN/iJMcTu2UowlX3Vn4NqLawoUi/ZgdaNCNuJOOEo8VAr26zoN7ZDnjfc4f
         /ajuj6UWt66Lk/gVnVxvkkbgLT9xX1nWz8dEFdtA0NOe0w1lkzKkLRlSE5qPZpn0ob0d
         BFVqy6JaH5Zj/TCz1ptyJzSbouWIpC30rbCqU3KKkbAeS0MTWpTsW8lMA3FInJiJxBzq
         Eu+w==
X-Gm-Message-State: AOUpUlGqPmnQypRgqaZEGR43xw8nIAJAEdJUEPnoxuPtxGm1GyUE5sm/
        gMd9WhNfWVejreCBxijbjh2O1T0jo7LMSUwhWww=
X-Google-Smtp-Source: AA+uWPxa67dT4dm0k1xAfxB7Wdq0iQ6d6J9vNhkFIllA7JA4LDw+p/mwJ1oCPoMyLaAvbwQxkGF7IYnFGLCbNsNJNOw=
X-Received: by 2002:a24:dc07:: with SMTP id q7-v6mr10459781itg.147.1534159187164;
 Mon, 13 Aug 2018 04:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180723070145.GB7523@krava> <20180811083915.17471-1-alexander.kapshuk@gmail.com>
 <20180813111631.GA718@krava>
In-Reply-To: <20180813111631.GA718@krava>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Mon, 13 Aug 2018 14:19:10 +0300
Message-ID: <CAJ1xhMUfQ9GDEXgL-+R_vs1aoidbwj5LRsyb9K32MMUnR23whQ@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fix check-headers.sh AND list path of execution
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     jolsa@kernel.org, acme@kernel.org, mingo@kernel.org,
        namhyung@kernel.org, David Ahern <dsahern@gmail.com>,
        alexander.shishkin@linux.intel.com, a.p.zijlstra@chello.nl,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 2:16 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Sat, Aug 11, 2018 at 11:39:15AM +0300, Alexander Kapshuk wrote:
> > The '||' path of execution in the 'test' block of the check_2() function
> > may also be taken if file2 does not exist, in which case the warning
> > message about the ABI headers being different would still be printed
> > where it should not be.  See below.
> >
> > % file1=file1; file2=file2
> > % cmd="echo diff $file1 $file2"
> > % test -f $file2 &&
> > eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file1'
> > differs from latest version at '$file2'" >&2
> > Warning: Kernel ABI header at 'tools/file1' differs from latest
> > version at 'file2'
> >
> > The proposed patch converts the code following the '&&' operator into a
> > compound list to be executed in the current process environment only if
> > file2 does exist. Should the files being compared differ, a diff command
> > to compare the files concerned is printed on standard output. E.g.
> >
> > diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
> >
> > Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
>
> I posted follow up patches based on this one
> as a reply on this patch
>
> for this one:
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> thanks,
> jirka

Noted.
Thanks.


>
> > ---
> >  tools/perf/check-headers.sh | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> > index de28466c0186..ea48aa6f8d19 100755
> > --- a/tools/perf/check-headers.sh
> > +++ b/tools/perf/check-headers.sh
> > @@ -67,8 +67,12 @@ check_2 () {
> >
> >    cmd="diff $* $file1 $file2 > /dev/null"
> >
> > -  test -f $file2 &&
> > -  eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file' differs from latest version at '$file'" >&2
> > +  test -f $file2 && {
> > +    eval $cmd || {
> > +      echo "Warning: Kernel ABI header at 'tools/$file' differs from latest version at '$file'" >&2
> > +      echo diff -u tools/$file $file
> > +    }
> > +  }
> >  }
> >
> >  check () {
> > --
> > 2.18.0
> >
