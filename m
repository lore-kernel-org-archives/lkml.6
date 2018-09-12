Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BD5C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3E220880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qReiIYQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3E220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeILOuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:50:44 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:38132 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeILOuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:50:44 -0400
Received: by mail-qt0-f182.google.com with SMTP id x7-v6so1154111qtk.5;
        Wed, 12 Sep 2018 02:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cksJPg08EOXv6uzJNb2eGqIgCg7663s9WIT5ti70YBk=;
        b=qReiIYQ8ZaqN2CXmG+xY0ravvvY6lE3MSGMBc1daV3friLlpznrV2YkTXjbkLnodD7
         P8xSa9N+ImqzrbPWPfvziQA2J5iBWqLPHqBCr1uyhwGP2nkrMQISpF6G4MsWzTn6VWTK
         IS48KDwj21ICPnakHdq5yyeLJEypFYZc6hd21cOrxJDHUyY56i7e8fvPP4f0LWCvYUpQ
         pSOkygKR0qBLHGzMIlLjkw8VQh1KfNGgdPdEyQzQncN9Gc0apDz0wccUshjTc/lZwQGb
         SPOvES1sUZZr9G4p1lAXdiZLYaWdnSBFLM7GxAuBOYj+JIxqwGlOTddLACouoXwJfNnK
         Ex+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cksJPg08EOXv6uzJNb2eGqIgCg7663s9WIT5ti70YBk=;
        b=W2JqsZpk3CV2b6+cAeTJPrZLOW8OpzcS1Ny+qRNZQlWSq61u6DeVkU4f1I53YG5ici
         RUXKwpdMuN7xdObDRHSqJRpd36teX8IFuI8T3l2RbwwMXBI1bfqkZoXTSM25RF/98tNG
         p44N0y5I0Lcsl5trl1DIC0Cg9FYPOWTCkIohpTd1dItoVtk92iRGG181HuUPFjXGD9x3
         x/2XHTzrhWAkjEzdnzWdRV1CjTehC2QVMkh8VZLO2dBefOPBr8JKwDRvTM7PTrXpQ82N
         N0JPZLTwaivFGS1SpvGsOwbceB4cNd8+LOPW+t1vaKjhgdYmmKmUEE1+ti0A5hAFkLHy
         z96A==
X-Gm-Message-State: APzg51BLJwxmOB8I4fOgvskuBqQiCBENmLS48uLCEo4DGuheHBylSlQc
        pvyqyS5owPFUjvsYAmlav5+bmv6Te6paGT8vjg==
X-Google-Smtp-Source: ANB0Vdba/VsM9uaNP6tjUHFtqiJ1rtMKTJPLBr8cNnKnWF3+Ig6icCdsV6wcTn24cCeOo6Uj1QTEI4wDUNoczigrgR8=
X-Received: by 2002:a67:3c13:: with SMTP id j19-v6mr403467vsa.104.1536745618867;
 Wed, 12 Sep 2018 02:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvb4hOY_Hew-jEUtpyhkGbmh4Tgb0doPC6EaGtz_rMGt7A@mail.gmail.com>
 <ed2459210f8043999f1197e8c063601d@SOC-EX01V.e01.socionext.com>
In-Reply-To: <ed2459210f8043999f1197e8c063601d@SOC-EX01V.e01.socionext.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 12 Sep 2018 10:46:47 +0100
Message-ID: <CALjTZvYRkhbazB4BAMF-cmmDS4rKtGqH=+CkNmFaaRDUg+zHJg@mail.gmail.com>
Subject: Re: 4.19-rc3: bindeb-pkg target is failing on ppc64
To:     yamada.masahiro@socionext.com
Cc:     michal.lkml@markovi.net, ben@decadent.org.uk,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 at 10:32, <yamada.masahiro@socionext.com> wrote:
>
> Hi, Rui,
>
>
>
> Could you cater to =E2=80=98git bisect=E2=80=99 ?
>
>
>
> Thanks
>
>
>
>
>
> Greetings! I'm having trouble building the kernel on my ppc64 machine (Po=
wer Mac G5) running Debian Sid. The make bindeb-pkg target is failing ever =
since 4.19-rc1. Is this a known issue? If not, let me know if you need anyt=
hing else in order to help debug this. Thanks in advance!

Hi! I never did a git bisection before, but I'll try that and get back
to you. Thanks!
