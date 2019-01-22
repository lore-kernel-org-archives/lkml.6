Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE42C37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591AE21721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="v6EsnPuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfAVA3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:29:21 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44453 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfAVA3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 19:29:21 -0500
Received: by mail-ot1-f66.google.com with SMTP id f18so22099339otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 16:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ParTT2wvy8/2g4XMgKE4wg3TCRVhMdNQ49X488sZEX8=;
        b=v6EsnPujYLp6DaDxnMx8cmn7DjA/AnzBhnovQYCyAhZzVjr1VyDh4ZMtmjrsyGmOcn
         r2ZN0DMvRjsoByH71MLpit+sWYQmarhxzceMKgX2oEpveccl9u298sXLWdhJ4V4fyeGI
         3JdaWbxZQm8J9Js0zcp4lXJUKOxkPIJjqAjtJxU5spfdXD4p9YHEHi66/6rOB5X5cOOP
         r5ycTkU+N4m4zTz7xQ03ZCM+g6Lev1+4n5cUHvjkEfOybY2khh4C66DwoNj7n2Jo1OsI
         8PyG8P9QvrwmCLFQTd3C4MW/IOfzaQHlCI05DIKxmJm6e24GauK7+mqXK4k5m0jPLtkN
         gEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ParTT2wvy8/2g4XMgKE4wg3TCRVhMdNQ49X488sZEX8=;
        b=BshY286tWLW9go9p3AlLvJt2y4AhASFcf4Jevvy5Rr2H60NxMQArJPU9U437aK/IHH
         rv/ISt30MHpLFQG4MGAybxLr1sOG+nJKGNMkRwNLHjxXvjvqLES5ffpsdwIuIQKqApzo
         mY/c6e+iVgjL0mJRoy9ETqryaubc1p/bsaYUhXbI2orYXQdrHxo1n5Kt5QVOb95yCvxz
         CGsonpLyVMY1GG9C5puYpNtpZCUxwD+bSisu9c+x7zyAB9aWaLAuZnxvC9ZgF3hZaO0o
         WOP4nQjtf79ZdzyqIOY+ZyEbqbBkZoChf1veF2JWSCafJdphGX8JgTqVFIAdSlkOBefO
         FTFA==
X-Gm-Message-State: AJcUukfCI/Cn9MB/ooVvD6uz0u5qj8tSeuLZsDkXiW9POwO0B+kW6MIx
        Av110ySC4njYg+Fjbj+GfTDAw1xZhTFlKzLv20EbWA==
X-Google-Smtp-Source: ALg8bN5chq7o0ZBbn81NBrSM0lFUnpG+t9BEegIPg82bAqfX6f8rOsFHaN6TuwfWXUhfxLwKMRPQWfVz78/MWuC0P2s=
X-Received: by 2002:a9d:394:: with SMTP id f20mr19747872otf.98.1548116960377;
 Mon, 21 Jan 2019 16:29:20 -0800 (PST)
MIME-Version: 1.0
References: <154785884329.2202034.3295476681016958230.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190122002615.GB5855@richard>
In-Reply-To: <20190122002615.GB5855@richard>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 21 Jan 2019 16:29:08 -0800
Message-ID: <CAPcyv4jXS-doCdyTrcV3DL63N-q4m1H2=Msgm1z88HnF8bcEig@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm: Clarify nd_pfn_init() flow
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 4:26 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
[..]
> >@@ -706,6 +711,22 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
> >               sig = DAX_SIG;
> >       else
> >               sig = PFN_SIG;
> >+
> >+      /*
> >+       * Check for an existing 'pfn' superblock before writing a new
> >+       * one. The intended flow is that on the first probe of an
> >+       * nd_{pfn,dax} device the superblock is calculated and written
> >+       * to the namespace. In this case nd_pfn_validate() returns
> >+       * -ENODEV because no valid superblock exists currently.
>
> As you replied in following mail:
>
> 3/ If present, nd_pfn_validate() returns 0 and nd_dax_probe()
> registers the dax0.1 device (this is a libnvdimm 'personality device).
>
> So at this point, nd_pfn_validate() return 0 or -ENODEV?

In this case 0, because the configuration was successfully validated.

-ENODEV, is only returned for the initial case where we want the
kernel to write the configuration.

All other error codes are an actual failure and the probe procedure stops.
