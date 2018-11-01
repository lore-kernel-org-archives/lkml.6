Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C79C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB40820821
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5/impSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB40820821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeKAMc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 08:32:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43804 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbeKAMc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 08:32:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id q41-v6so19665046qtq.10;
        Wed, 31 Oct 2018 20:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lWf37p3dhx7nWeWFHqzSLi9W8b8nayEV+RYUolXDX/Y=;
        b=P5/impSgtyzVMe9u7MCYJ5rBkDGYafY70KPQXDnyNbH+O9msr1esswl3PKdyYMtGOs
         4mJAZzDnnTFCZ6PHrQpO40qR565vRPAW64euajyGpjRHlMmyVUJC8u/GCF8PCCNWDz4T
         U+rr7j4CehdGgIeSpuxkTjhevSj/7phIe4PLaoEkopxOmcmHpMZ4jMoh9SbdwYCSO9zP
         6rVk/dH9cwHhFA2z/ASksW7iYmQnzSqty1aO1U/m3sH9fyfdd9Mh2tRlU3PBDBNDY15h
         DTDqzulQEkhV6q/2FT55XJqDc0+edB4Az68gtxeXxZYbCfFWQbaR30A0kzhuBPYGouAP
         hfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lWf37p3dhx7nWeWFHqzSLi9W8b8nayEV+RYUolXDX/Y=;
        b=SStJHR4pVzZs3XgG0OeYbTBK7cW7Xm1sJwCi4r1+yZ/8+I/URRzCqrqzKvPomR4zqb
         EA6/5GfXK9M5oP7fskDklJaNnNySjk9A5uZElZWp0Xf7JF9oMCOgNi5m0SKf+wfx1s+k
         FtOoTDj8Uk4gisBIK4ggn64rpgZxn2G0EjZogRCPpi93DjK7zlYpS+2KkAvyRr3zaAgS
         aL62Sy5+c5NuR3qHf1qpBwYXRVx8V2F6itKRJuQIJH+8dG4RwtY/NHzw49FbUu+V9iX8
         6oDbhbfSKnCky7XjkZFqSxDtGza9kNR8RP2xPm+/zaZn68Xkzc2ISup+CwjnPY1Byk3d
         PCzg==
X-Gm-Message-State: AGRZ1gJ3fTBG89pamMmhc0DSbqG9sH5jauCZJiGoLzX7zkru5ArcVARr
        9u9Fxz5jcDUlcmzDYQC6yus=
X-Google-Smtp-Source: AJdET5eyHyUwKSLQA51TjzjNW7nLjuVK1OHeNAO/4BT6CP8kyGJXQuQXkIlPMBQJWGjADpb/t+4HrA==
X-Received: by 2002:aed:2663:: with SMTP id z90-v6mr5231900qtc.301.1541043109386;
        Wed, 31 Oct 2018 20:31:49 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id d8-v6sm1859164qtd.34.2018.10.31.20.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 20:31:48 -0700 (PDT)
Message-ID: <0c600eb1a48f7ad1b903a9497b1104b172607dc3.camel@gmail.com>
Subject: Re: [PATCH v3 4/5] modpost: Changes parameter name to avoid
 shadowing.
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     lkcamp@lists.libreplanetbr.org, Borislav Petkov <bp@alien8.de>,
        David.Laight@aculab.com, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, helen@koikeco.de,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 01 Nov 2018 00:31:44 -0300
In-Reply-To: <16b6518d7b36787e1813d62336b661bf603d54b2.camel@gmail.com>
References: <20181024040354.24879-1-leobras.c@gmail.com>
         <20181024040354.24879-5-leobras.c@gmail.com>
         <CAK7LNAQzgdFPpwHEtfDazLd2jAhNy8=f_4mvOQMWfOWCb07E1Q@mail.gmail.com>
         <16b6518d7b36787e1813d62336b661bf603d54b2.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em qua, 2018-10-31 às 20:24 -0300, Leonardo Bras escreveu:
> Em seg, 2018-10-29 às 01:42 +0900, Masahiro Yamada escreveu:
> > On Wed, Oct 24, 2018 at 1:05 PM Leonardo Bras <leobras.c@gmail.com>
> > wrote:
> > > Changes the parameter name to avoid shadowing a variable.
> > > 
> > > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > 
> > For this one, I'd rather like to see code refactoring
> > than renaming the variable.
> > 
> > I will take a closer look.
> 
> What do you suggest to refactor?
> I volunteer for this work.
> 
> Leonardo Bras
> 

I refactored the code to move the global variable *modules to a local
context at function main, and changed the functions to accept *modules
as a parameter.

Is that what you had in mind?

https://lkml.org/lkml/2018/11/1/725

Thanks for reading,

Leonardo Bras

