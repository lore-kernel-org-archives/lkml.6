Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231C0C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34D72084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8LqMRnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfASTct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 14:32:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44700 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfASTct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 14:32:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so14320345lji.11
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 11:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kde2qvi26WkmJoBAALXidKBmfwW1soidypIrvHGZQhs=;
        b=V8LqMRnRRcL4bQ19ezgoTDNuJeRDKZU6sfumsMN/6YlXC6C4B/8kAbPrbvU72L2gAX
         pHJu1A0bmmZsA644L35Edi9wfg/cjF97zwddLeu5SzqAFseXDXKjFEsEYTzkt6q2Z6jH
         1rEHDi6dxx6smh+MyW9g2qGMOc3id+8ZlGOBWG+u82Jy1FpArPo8n/fC+2ub9N6+qLEE
         zU86zNCe5zNXKEcxqnJMTVdttkgvShMtjb44Bp2IJ7GnZXiZ8fcS3HYVET7sIq+4bcQ0
         cuEs17BhREgT/3SsjgF/NzTjuwLsXjo3N7m9kAW2uv6KYMsvTTScWyDwozcUYN0QSci9
         z1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kde2qvi26WkmJoBAALXidKBmfwW1soidypIrvHGZQhs=;
        b=ZBXST+A8wi3V+Di3a4PRX3C+e+RM48tASAGKS/P6MApNLAxxu2soZ138pA7bRpiJMC
         kWmMrRXpVshDoALP8CH0/Tk8uue4mSVbFGFTZbNIaHs/cqyj0Zz2wNb/ldLnztwgCs8V
         yLdG/h1xU7Y8EaIcSPmZK2gwOjvKr18pyOVum78MzTs1VNk5IroMt6r8BtyolsMfnGYH
         ihIw/Cf3uB1VdXB6WBRID8ETJDvxNbss0tMAJ+AcZ5opaZoKl8zkacmFZdzuvzwgznMr
         Sq4IvfAf3fZzPOEDTCZXJffXEfGQkAxl4LA0ACvnha0/AnFHuvkGOBBY1dn4ibvwlhFV
         LL7g==
X-Gm-Message-State: AJcUuke+CZyi1gRv7+p7wMfXmMf+cTN8olcHNUNmKH4HaQAn8KRNeSE3
        vmomsy3JtJBc00/Rbf6637wt+kqulWGoYWhNNTA6F4VsosM=
X-Google-Smtp-Source: ALg8bN4r7IvvGcyJx6vuslzF1BPYATL65eFj0gyhTACuEijNsaYr3hjbSe2V6JF4feS914HSjKjcxkP5mYuksco/HYg=
X-Received: by 2002:a2e:83d7:: with SMTP id s23-v6mr16241816ljh.139.1547926367193;
 Sat, 19 Jan 2019 11:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20190118225658.GA28312@ziepe.ca> <CANiq72=o_7d63MXJJn6dEnt76viF0YV4svp-5VBHk7JKyjXJDw@mail.gmail.com>
 <a5eab6ca68ee1eb837c8c86b69b4696846af719b.camel@perches.com>
In-Reply-To: <a5eab6ca68ee1eb837c8c86b69b4696846af719b.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 19 Jan 2019 20:32:36 +0100
Message-ID: <CANiq72nAX=UjAZnmh7zk+0PUnGBfAjTUfZ1YsXmkeVZ+eMJuHQ@mail.gmail.com>
Subject: Re: [PATCH] clang-format: Update .clang-format with the latest
 for_each macro list
To:     Joe Perches <joe@perches.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Sat, Jan 19, 2019 at 8:06 PM Joe Perches <joe@perches.com> wrote:
>
> This misses all the directory/file specific #defines
> outside of include/ with for_each

Indeed, the command only searches the include/ directory, but when
searching for the entire tree, it returns ~500 more entries (vs. the
~300 original ones). I cannot recall if there was a reason to search
only inside include/, though.

> $ git grep "#define.*for_each" | grep -v '^include' | wc -l
> 619
>
> Is it possible to make this generic somehow instead?
> Perhaps extend .clang_format with regexes?
>
> (?:[a-z0-9_]+_)?for_each(?:_[a-z_]+)
> [a-z0-9_]+_for_each

What do you mean?

Cheers,
Miguel
