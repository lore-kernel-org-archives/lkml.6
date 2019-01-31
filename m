Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDC8C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309F32184D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HQJV3FpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfAaD42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:56:28 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38850 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfAaD42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:56:28 -0500
Received: by mail-lf1-f67.google.com with SMTP id a8so1248193lfk.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 19:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1rSOZFe0IVQ29cPDe7C9Tb4xEwVzgUS1kUmg4l1E80=;
        b=HQJV3FpXhjd5ovtLv0YQv8vwPAA0UrWIyj+HQ8oEroEHLURWJsZG4QALnBqsFAVwA0
         IkFiwWvGraCJiYay6OlcrxxzsD+SfAPL/dMP8ybaYAjhipVQMv9NbIyf4FAv/uNaw9xv
         uryDJ2lKsHsocb2GsWU7Ri2q7amnwiB8yDw/xbpa6qTX2o1860ARNvGa+JS1bdeU7NH3
         aFFB/obmar8tAkU6cIDIlRWfm6+fl9J6d7mxYLuhugq6J3YK9NP5tKkJNa7M9CUXlZ5/
         q7PFk6ydWKC7lNPNJM3LSeTmJEuG4VC9wJeA9indTTUJZk0kU//L6StAVBrTY2GzwAuA
         LofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1rSOZFe0IVQ29cPDe7C9Tb4xEwVzgUS1kUmg4l1E80=;
        b=O6ig8WBgv+wNQXEEIHUrGlroRSAMAiLxtRCgwcpPIPMpsLks4+7by/RmNGYw7a6wp/
         HNPFHuVOghZpxMhRJhipOlK7iRNf+296JypEMVvTPntdA3hJM6kZeazd2jTddHT9TGTm
         shL1eQnOpd5RvDOnvu8VM/UPUIe4N7QSa9xtMwCxKL+psKU94ceJ6aD5W+mh4FmodiaT
         Cc8Z8eyXvRlGwYzCcu7Ptbg2v7CoOESjg660ouuUsDBby+ECu31Fv6D3QYVDL/c5nJvi
         VbxVBIKBCZyT5YgI//SjxURbqVcpFMDZBEkor42RYQq9We4NvK/KGkziEmjtHRLinKlZ
         IM+w==
X-Gm-Message-State: AHQUAuZIMGEM6yqUm5TJhAGGi55myOrEo5/lZOCdxw9frlz/w5yslrs5
        Pf3wo8Gd9eDrChCzf4qi6V35eXOraTr2h+oGU//K3w==
X-Google-Smtp-Source: AHgI3Ia6dJATz43T/B41K1CgNW0ArboXcHvHAAa2uc9hltnpkb1C0oAbrPReF7iDVrzLjUl7pKV9FJz1mEqUpbb6qzw=
X-Received: by 2002:a19:750a:: with SMTP id y10mr8289223lfe.157.1548906985687;
 Wed, 30 Jan 2019 19:56:25 -0800 (PST)
MIME-Version: 1.0
References: <20190109021112.5836-1-rkir@google.com> <20190109021112.5836-2-rkir@google.com>
 <20190122110712.GA1004@kroah.com> <CAOGAQeo1Kv55EUn2sYPOt9EgBMfN=+o_A4KOPVgqbJHo+HN-Sw@mail.gmail.com>
 <20190130144414.GA8357@kroah.com>
In-Reply-To: <20190130144414.GA8357@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Wed, 30 Jan 2019 19:56:14 -0800
Message-ID: <CAOGAQeo6zr=FYFPHt3NUajdStWyQe3oPZYNEn+o2GxXwXWd14g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drivers: platform: goldfish: goldfish_address_space:
 add a driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Lingfeng Yang <lfy@google.com>,
        Alistair Strachan <astrachan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, why does the other Android "emulator", cuttlefish, not need
> special drivers like this and the other goldfish drivers?  Shouldn't you
> be using the same interfaces that they use that are already merged
> upstream?
> Actually, now that cuttlefish works on a mainline kernel, can't we just
> delete the existing goldfish code?

cuttlefish is a separate emulator with different assumptions which do
not work for us.

Our emulator runs on Linux, Mac and Windows, it uses host's GPU
directly for rendering.

I am not sure how cuttlefish accesses host's GPU memory (it might not
support this),
but we need it to support coherent memory access for Vulcan. We also
might use it to access
host's camera pixels to avoid copying them.

Please keep goldfish drivers.
