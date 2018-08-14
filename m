Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC51FC4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F01E21756
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnu/11Lv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F01E21756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbeHND62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 23:58:28 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38160 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729346AbeHND62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 23:58:28 -0400
Received: by mail-io0-f194.google.com with SMTP id v26-v6so16771957iog.5;
        Mon, 13 Aug 2018 18:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8ZHbZoSz/V/fI/bIWjt9pAWMqysvv1orl9lMal7XlYs=;
        b=rnu/11LvN/6+PEaZDL9mdcUVRqIGkDxUPLuAFV79s90H2YO+2xBGeuP7cmjCbdzseM
         5NiU8/ImzQpb+/udihEzSY2hsxUifHV8vv/YreCXWjS/a7Dun0TCw1GVPr6Kr/KT6ntx
         /TqVIsXoWNvHFJ8xcjhruPPntm1Lo5gURejdxgAiFVOWd9hA8EQtiGRx6X5GyL/nLQR7
         vm+Uxy6re8gUMV9OwcpsdatyWyixFVmq09zd0F0U+2hS6n0BhuhsG+pWVE8Y0kGLSynd
         cuRrN337DMgmeqlbhMjZ5kUIjzpcPk6XHEX0L3SbQQUQm75PCteBSu5zqhjJ+MkRl0Z5
         IpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8ZHbZoSz/V/fI/bIWjt9pAWMqysvv1orl9lMal7XlYs=;
        b=eTnvj8uaks6J6ugs1ahWusoxGBgct9Tdgly74eqLLWpPXfrsfpsrGmO0Yw4E3Fhi3c
         pN3hhXqkFt8aUnUqBtxAYVG9F0LSyySCBoUDLX64Jcf7YNrTZdyeWCk+0cPnTk5IFMix
         NCroQSTT22uP/V02EBdfglkDYaMGyur6Jrp2S4+RIp6U8JpppgJa1eeBg4NLenEjbHT0
         NQEMM+wbmifashkBjiTbENng807sWh487nqBIxscV9HoPWzBJ7vMkPYWjxcrf7f4DtZG
         l8wZvqOeO2eJ8YZHHEO4OWowWVdkG9qnWG7B7wxLIE5tnHaj7FI+mGfnYAdkWUxEipVz
         W02g==
X-Gm-Message-State: AOUpUlHaURm+9jsh5eSQyr5K9AL1Lidr78dZ7Rs9pHKgUwN0iouGVtQW
        Br+R/V7kuxG1qp1DzZOS7K0pKRscBt1M/AVGS5s=
X-Google-Smtp-Source: AA+uWPy+YmkMMtZJz32HjXcoz11cQRBxUNLrbvVqsgP4GIah3K825wwYNvXu+xraox5UyOOsc4VLgA3m9chBlCD9mEo=
X-Received: by 2002:a6b:3b8e:: with SMTP id i136-v6mr12745990ioa.63.1534209222964;
 Mon, 13 Aug 2018 18:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <1534127212-13186-1-git-send-email-zong@andestech.com> <e9697bf5-11eb-68ec-238f-aedb724c8c17@gmail.com>
In-Reply-To: <e9697bf5-11eb-68ec-238f-aedb724c8c17@gmail.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Tue, 14 Aug 2018 09:13:31 +0800
Message-ID: <CA+ZOyajhm=Tmz5t5GVThuFGHu0zJczt=7VO5r9qdmQnN3b_EEA@mail.gmail.com>
Subject: Re: [PATCH] net: Change the layout of structure trace_event_raw_fib_table_lookup
To:     David Ahern <dsahern@gmail.com>
Cc:     Zong Li <zong@andestech.com>, Steven Rostedt <rostedt@goodmis.org>,
        mingo@redhat.com, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greentime@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Ahern <dsahern@gmail.com> =E6=96=BC 2018=E5=B9=B48=E6=9C=8813=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8810:40=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 8/12/18 8:26 PM, Zong Li wrote:
> > There is an unalignment access about the structure
> > 'trace_event_raw_fib_table_lookup'.
> >
> > In include/trace/events/fib.h, there is a memory operation which castin=
g
> > the 'src' data member to a pointer, and then store a value to this
> > pointer point to.
> >
> > p32 =3D (__be32 *) __entry->src;
> > *p32 =3D flp->saddr;
> >
> > The offset of 'src' in structure trace_event_raw_fib_table_lookup is no=
t
> > four bytes alignment. On some architectures, they don't permit the
> > unalignment access, it need to pay the price to handle this situation i=
n
> > exception handler.
> >
> > Adjust the layout of structure to avoid this case.
> >
> > Signed-off-by: Zong Li <zong@andestech.com>
> > ---
> >  include/trace/events/fib.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Fixes: 9f323973c915 ("net/ipv4: Udate fib_table_lookup tracepoint")
> Acked-by: David Ahern <dsahern@gmail.com>
>
> Do you also need a similar change to fib6_table_lookup in
> include/trace/events/fib6.h?

Hi David,

Though I don't encounter difficulties on it for now, but I think it
has the same situation,
How do you think that also change the layout in include/trace/events/fib6.h=
?
