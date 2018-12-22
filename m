Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA1FC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 00:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875F621903
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 00:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ru/7k8K1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393024AbeLVX76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 18:59:58 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33780 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389283AbeLVX76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 18:59:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so4301424pfb.0;
        Sat, 22 Dec 2018 15:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CzrEQumzCPoflqB+cpr3eZYEGbewZkL+R4oCy7Et6Po=;
        b=ru/7k8K1mvqqDX/eeAR4dHlH8IR8I176bAm1XNrZ1Tm+9EdfBe21UQWP3JFIoEiM5R
         mMG5SH8EELudYfYJQuzme2y7W3HBA0qQ+9FPL1iJq1A3Mh/ZJHs03aLXZFHIesvW3988
         IT2tKUyGqNY94NHKiKJFcacA7r8dBNZGOmRsPwg0Iwg7jmZbzXn3sEcJRQ83yBoV66+d
         r2c+jviw7vHinaU/uv9gyievCmJ1exBvMlUJG3rXDLdfUOvMO4cotCgCPAxncE11Zwyx
         p1DDzQE32uwTioHw+nMM9+WDzfW1ctMzh1FjSN7P7ZILbSOlJAkow3G1dhgRAzVNcaN+
         yOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CzrEQumzCPoflqB+cpr3eZYEGbewZkL+R4oCy7Et6Po=;
        b=a1PQawIPvHcui2LJdfoK1Byxk+VjHyM+tpVHPkwD28OhoDlf5fJZ8e43ts+Y5yBuJd
         IJmJzPijIzY+oMFjl+/mxqC4ddhSjoJ2ft4VazOud5w0tmLswR5bwU6UaUDAw6YtO49x
         roQrQsnH3K4FMRrEGk3+2egGZ8l4p0lDkx14uDRPQ0b/idvqMvAp5y+gH4E9FwdL1I7d
         uiak9lBoRjCKFc3gCWJZ1lMMOYVLJEJ+BPz6Muz+CTfR+pZ/7Lo3JPWP9A+bbIkCjYWx
         N5SEkQbgPWHRXJjfCRE9iqeAYFuPIJ/v3HWT+ttnEowsGboj96yNnjGihF2gFbF/Y90W
         yFOQ==
X-Gm-Message-State: AJcUukeW0t/iH+idjRjTWz7x0j4PPljik9GDOcGTnds1z18YQYt684EO
        tBT/pT44V6VC/7wbM3/Pe2Q=
X-Google-Smtp-Source: ALg8bN6nHWNPCUKxkmI6XONOnCv9UCFx9hSJpb/bs7bGQSVjnybMVtWsg7ysz5/LIQyWQgXw7HBQsQ==
X-Received: by 2002:a65:6684:: with SMTP id b4mr7693572pgw.55.1545523197203;
        Sat, 22 Dec 2018 15:59:57 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:5663])
        by smtp.gmail.com with ESMTPSA id l64sm32448093pge.73.2018.12.22.15.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 15:59:56 -0800 (PST)
Date:   Sat, 22 Dec 2018 15:59:54 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Miller <davem@davemloft.net>
Cc:     gustavo@embeddedor.com, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: core: Fix Spectre v1 vulnerability
Message-ID: <20181222235952.keue7a336sg7jfim@ast-mbp.dhcp.thefacebook.com>
References: <20181221204901.GA30045@embeddedor>
 <20181222.150722.1493687829239836271.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222.150722.1493687829239836271.davem@davemloft.net>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 03:07:22PM -0800, David Miller wrote:
> From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> Date: Fri, 21 Dec 2018 14:49:01 -0600
> 
> > flen is indirectly controlled by user-space, hence leading to
> > a potential exploitation of the Spectre variant 1 vulnerability.
> > 
> > This issue was detected with the help of Smatch:
> > 
> > net/core/filter.c:1101 bpf_check_classic() warn: potential spectre issue 'filter' [w]
> > 
> > Fix this by sanitizing flen before using it to index filter at line 1101:
> > 
> > 	switch (filter[flen - 1].code) {
> > 
> > and through pc at line 1040:
> > 	
> > 	const struct sock_filter *ftest = &filter[pc];
> > 
> > Notice that given that speculation windows are large, the policy is
> > to kill the speculation on the first load and not worry if it can be
> > completed with a dependent load/store [1].
> > 
> > [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> BPF folks, I'll take this directly.
> 
> Applied and queued up for -stable, thanks.

hmm. what was the rush?
I think it is unnecessary change.
Though fp is passed initially from user space
it's copied into kernel struct first.
There is no way user space can force kernel to mispredict
branch in for (pc = 0; pc < flen; pc++) loop.
The change doesn't harm, but I don't think it's a good idea
to sprinkle kernel with array_index_nospec() just because some tool
produced a warning.

