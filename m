Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76152C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FA020874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4Knyoes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfAKHFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:05:54 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33329 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfAKHFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:05:54 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so17483621qtp.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 23:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drVmu7u72mZbwPZTv+YQ+a/m5Rp18iSQS+LmOtoNQQU=;
        b=K4Knyoes6ht3uJSIxVILfe/dnrW0sxQZGdCrPcunQf9Pe7FN84/BRJYzF0y/T4JkFl
         OhrxWusujuqRZ2VMqUIiCelpq6gWI3VlWYJW+GK2DaAoXAEnZlukDKGqpm0I4LL+6hIx
         wnGcNePg5DFrcclztf6Rygiabxvl+bUtMT0DCMF59/9agHMmNw2A3SiYAfhxAiTq3S45
         CwLnEkR8exRIu201xPd4T/fO8pJ4IU4dk3N/NstXwd5SnMvrkJSedosU24cCpNNCB69U
         eidp+LeSK2BFCtLgBDIgk+dhgtXG2WETqlKas2XDsHKclBIStff0ajHWJOj67ENyRDID
         0bLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drVmu7u72mZbwPZTv+YQ+a/m5Rp18iSQS+LmOtoNQQU=;
        b=im8Hnkq0nkOOEyxHmtw0LEZNASNXaccQYJKTAja6WqD9A2Ku6iggToqes/TfEtGUNV
         d2598fWtRHOo/FvZiBFAb//LsNEXQVUIVYTZNlAhhj+WbRWZAvzJMxkXgJFA592La2j5
         21SWwbCvW7iijMOt+EuqkCCsnHzK/9Ra7iQnDR9PFsRAPPTzmBm/ZyiqkQRWjV5tZ25f
         Jr5rnIWR4PiHCnLto385/1/DiSqgiAQMIONBNUb97WnUZTmrluLozUrdQtfq3Vgi2POM
         lWScG0ainGo+udbUYQ6QpT7FJb4FSdY+HIiaJsjQHcMThBYp2NzBqj4pEOA66rCcZXkp
         bmeA==
X-Gm-Message-State: AJcUuke9X78lC6NLAJC49mEATsyrGGZORPZO0SXlGNNtK2lAyGuG95+w
        IvnDraZEUd57+lDxmcaSuEQKgvxns785rmpXC6A=
X-Google-Smtp-Source: ALg8bN5SAk3FvSLxqPowB5liDVEVMzJdukOTNoc7PVhwrSZCYfeIvi3Smv8jo+XBecjY7EgWwF4xrO+3w9CduhPQIKc=
X-Received: by 2002:ac8:1:: with SMTP id a1mr12531257qtg.366.1547190352721;
 Thu, 10 Jan 2019 23:05:52 -0800 (PST)
MIME-Version: 1.0
References: <CALaQ_hpCKoLxp-0cgxw9TqPGBSzY7RhrnFZ0jGAQ11HbOZkZ3w@mail.gmail.com>
 <20190107095229.uvfuxpglreibxlo4@mbp>
In-Reply-To: <20190107095229.uvfuxpglreibxlo4@mbp>
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Fri, 11 Jan 2019 01:05:41 -0600
Message-ID: <CALaQ_hraox3anhupk_psorbAwyWK5wN-dHyp6bbGvQteyVWZsg@mail.gmail.com>
Subject: Re: kmemleak: Cannot allocate a kmemleak_object structure - Kernel 4.19.13
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One more thought that may be nothing, but when kmemleak crashed,
SUnreclaim was at 932552 kB, and after reclaimed/cleared 299840 kB.
There weren't any performance issues like when I had a leak of 5.5 gB
in the 4.18 kernel.

On Mon, Jan 7, 2019 at 3:52 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Under memory pressure, kmemleak may fail to allocate memory. See this
> patch for an attempt to slightly improve things but it's not a proper
> solution:
>
> http://lkml.kernel.org/r/20190102180619.12392-1-cai@lca.pw
>
> --
> Catalin
