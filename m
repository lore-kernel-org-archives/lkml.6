Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7C5C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C97021019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKj99PXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfAUT1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:27:54 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39856 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbfAUT1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:27:54 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so18495010ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 11:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxIAnT3ybjiiaGufi7mS0hJc0gHIFMhOGaf6933h1y4=;
        b=GKj99PXEv4t8OCEqc+cBUYAWDQVqf16ItuMI2v8HT5VNbVO/1q+twBm+ElsfTOwM9W
         J5ynMSVB251FkWto2+TEKFJ9L0Jm65UqbVqHHOp7v6nHZmKDijJtimr1TG/89oX+vyt4
         NiS0nIFbDCw0PIpBWH3OvdIv2rwLI7Bs4DyMymxec1wafk9J9GvRzBSbeWdmbkR/PQbB
         pqu5jGyz0ndQ/ayMoOmOQ4F/1DhudRDqfLuQSQMKIL6ZJCdMMOMdwMhijLsXPanas6A3
         Ly77oZ8jrPxfQVgHJdT7t18pFt9r04UJqJuZUjS/LyATctWwbfrq63XvGI1x5e0kNmqC
         Gy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxIAnT3ybjiiaGufi7mS0hJc0gHIFMhOGaf6933h1y4=;
        b=Naz44ACgZ26g06rH03vXTgheEUBCKjXU2SMniAZsGhHfY5RdB3pZZj6Nm5zklgR6CX
         J9Qid82aGaDSBHffhs1z1PG8W9hLMdYbMi57NBEssiQkW+VxBqO74pf/0T/ONu0xNuCk
         3hu8e/yIlfRWsuwSWbXZTm0Q8TJntmoQFpIdI7e1at6l7o+RDbnr/24tWcxMvM7x4K6F
         qcj1Yd2SRrRBga+EMBi2dbgCFAKzYp95hB6q3YfzQ+wg+s+CYTLYuKj7wa7nc9whDGSY
         F4J5NofV5vpawnFZMggDDNSjoeEjbrmuNfQyL6akn5qDE/T3jCB4KyKznxChAbzcgEPf
         3Osw==
X-Gm-Message-State: AJcUukc2fVvpzvsn+iMbBGM7xRk24dqmqKjUjnTeZOHyvu+Kj47Mzn6K
        cXTj2Mzr7l/AHko3O1+I5Tn2nkD5l6OSQh/syng6Vw==
X-Google-Smtp-Source: ALg8bN7z5pKs0jghB8MJVU1kf76CBP4/0ZpPSePMx3xuQDkd4ss52dLS/w9SN74chGUPm71ArH1+Sza1u0xXJOa84Nw=
X-Received: by 2002:a2e:9b84:: with SMTP id z4-v6mr18700961lji.93.1548098871595;
 Mon, 21 Jan 2019 11:27:51 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZum33M+1NRcfWkua+66CBTxM8ope+hoGASv6mR8NrwPTg@mail.gmail.com>
 <20190121151020.GB4717@kroah.com> <CAA85sZtizu_uvHhevg_B1Ok7K=O_J=agAmG5ic7M=1by5BCurw@mail.gmail.com>
 <20190121.104824.1888946069199769292.davem@davemloft.net>
In-Reply-To: <20190121.104824.1888946069199769292.davem@davemloft.net>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 21 Jan 2019 20:27:40 +0100
Message-ID: <CAA85sZuyL01pfHeQZtTjkmM5BG624eCV_R5FYtiU8j3ex4EUVg@mail.gmail.com>
Subject: Re: [PATCH 4.20 000/111] 4.20.4-stable review
To:     David Miller <davem@davemloft.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 7:48 PM David Miller <davem@davemloft.net> wrote:
>
> From: Ian Kumlien <ian.kumlien@gmail.com>
> Date: Mon, 21 Jan 2019 16:38:11 +0100
>
> > Hi David,
> >
> > could we have your blessing to add the following patch to -stable for 4.20.4:
> > commit 41d1c8839e5f8cb781cc635f12791decee8271b7
> > Author: Paolo Abeni <pabeni@redhat.com>
> > Date:   Tue Jan 8 18:45:05 2019 +0100
> >
> >     net: clear skb->tstamp in bridge forwarding path
>
> It is already in my -stable queue:
>
> https://patchwork.ozlabs.org/bundle/davem/stable/?series=&submitter=&state=*&q=&archive=
>
> I honestly don't know why I bother putting forth such an effort to publish
> what is in my -stable queue if people don't bother checking it. :-(

Sorry, I will check it in the future, the patch from Greg would
highlight it as well!

I was really hoping that this was pushed to -stable already,  which is
why I sent
my initial mail.

I haven't really followed kernel policies that closely since 2.5 or something =/
