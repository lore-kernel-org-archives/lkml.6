Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF21C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5527B2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDOj07/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5527B2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeH1Tx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:53:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36502 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbeH1Tx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:53:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id d1-v6so953913pgo.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 09:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Oh0GfifA4i0ev1iszadGeqlJllSKMo/Ln/SDnmmybbk=;
        b=hDOj07/OikB26mp/yUnAokIgWQf/SryROwEXjftZn7e85XytEj5MAF14utyk2liYqK
         rR0GxxCWb51P2RIjIKcHgLJ5Hr7YrJRqT6k23XhQapelxlUNyLyKDQEBrJkyf0S553nZ
         BLuDTyDjuPhCZjNFpeMokRnVeb6zBky6PvuEcxbcEPU75Tw/p1/YVMVkHH7veIfRsBHY
         xP3WReCbQOeTPNNV8yAziOLFOsKhSISVeX3GiONOY22XZjMfPFdyyOJZn6UTrikU44ng
         zTHVbBeMBAL6WA88D4dpMI8okzCvwsZyy7usZ1gaycRqSVRrgJGSEEKcLHSPsaEiClwX
         1AAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Oh0GfifA4i0ev1iszadGeqlJllSKMo/Ln/SDnmmybbk=;
        b=sDLFXVdBb3tDfWz7+eu0rqCM7cr6G3Z1DRodZTDKUr1jUxA13OpXMejK6T9BTFL6xt
         eF1LhHUT0w8KKv9izyDhqvVrLU43gVA9ouYH1geSZuRgpdvIcvNnT/c/8ErIbk/rreeV
         nOd+cnDvYVYq4gakTzOkmh4QoU1PnugmnUa/8YfCVBCmX6BG2/A7zs8DhTw/4irVaCtV
         zCC5juwdlhxGVYPJWbTbZ4itoKq1o5qe7xFyx2hvdkAYXRvVlCk5lwj/YKStiKOCxZ2k
         Z5zkR86KXjQw5ZC+TxKNkx+4Z2JAMC4Qj6bKqft9T+k4FGi9bmAyw0IFtUVozb6GnzF3
         PLYg==
X-Gm-Message-State: APzg51BLNtDHShKFtQToeDjaX3CX5hT3WcRS7wtCAsXOu2ctmjPqjCrO
        HxUcjzxQhY4jsQGZ/Cw0UN1OxYxJ
X-Google-Smtp-Source: ANB0VdYFrKbSHf9okkpOgcnnQZPXCfe3v2C3g7DGcHFmF7OE0AnGpCe1tdhxCbkdnXygQ8XkDjqyOw==
X-Received: by 2002:a62:c699:: with SMTP id x25-v6mr2259099pfk.16.1535472096554;
        Tue, 28 Aug 2018 09:01:36 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x87-v6sm4725400pfa.143.2018.08.28.09.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 09:01:35 -0700 (PDT)
Date:   Tue, 28 Aug 2018 09:01:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 4.19-rc1
Message-ID: <20180828160134.GA17166@roeck-us.net>
References: <CA+55aFw9mxNPX6OtOp-aoUMdXSg=gBkQudGGamo__sh_ts_LdQ@mail.gmail.com>
 <20180827134459.GA16094@roeck-us.net>
 <CA+55aFwO72FivHHBdVky96wSgESNZza4A_g2QsovWfgxf7qH=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwO72FivHHBdVky96wSgESNZza4A_g2QsovWfgxf7qH=g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 02:56:32PM -0700, Linus Torvalds wrote:
> On Mon, Aug 27, 2018 at 6:45 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Build results:
> >         total: 132 pass: 129 fail: 3
> 
> Thanks for running these. Looks like everything but the sparc thing is
> under control, and the sparc thing might be one of those "big builds
> don't work on sparc" ;(
> 

In general I would agree. On the other side, someone who knows sparc
assembler should be able to fix the problem. sparc is notorious for
failing allmodconfig builds, mostly due to its separate devicetree
implementation. On top of that, many allmodconfig builds already fail,
often for minor reasons such as duplicate symbols or missing exports.
Dropping sparc:allmodconfig will cause sparc builds to deteriorate,
and we'll lose valuable build feedback. On the plus side,
sparc64:allmodconfig still builds, but that doesn't cover 32/64 bit
differences.

I'll monitor the situation for a while and stop building sparc:allmodconfig
if the problem isn't fixed around -rc7.

Guenter
