Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50BEC37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D86D20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="l5pKLiFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfAVBBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 20:01:00 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39800 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAVBA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 20:00:59 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so22184924otl.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 17:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1skLVYct8+bIxnDMaRew62Ki/2P0urZDZUEYKn1S/U=;
        b=l5pKLiFOtvtdJGkSnP8DHtCa57MqidgH+8wxJUMFFHiLyW77Mvezzicpr278Dbwm8f
         XNboLh+U49Jx7EGv96M6LqzbDWFki0Hudy72n1zZ9FRfIv2Fi9G1IetLHeXnaSjRBvPX
         i9c4SF3uMqiQLXjuYIX+jhplLqEnx7STUKHA5Ss0fm8NJAopD8jdFrAJC5sytP9Peb7N
         MoXJPS9L1f2kusGjeo+ZD/xnT0zTGrfDcJC+e85qD3Qkmq7Vc4IvLUJlMuYR8jbo+X/j
         YZL1U1hA6lUxTqOhYe1lZ6jzB+YVsHBkFI9f+AlxTfIDcHsuRDlBs6/N26DsKbd5E44Z
         SAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1skLVYct8+bIxnDMaRew62Ki/2P0urZDZUEYKn1S/U=;
        b=JuA+lX6vK5cR1C1hcXxwOLlBt9CE4GcytqaROGFwkrP0hItHos9suHzVv+ZxwyBzFp
         Eotq5Fj1k3KLiphYnZQ6MjJYXnXBH6befnN6zx8buDvlVmm7ZSGdFiH/N2+pRn47SBTv
         jWuinMqyUXR/2Ll99tFtbiTXklHnh7+ZIINGk+NCHsPAE/iL7aN8fDuu6BStmGxQ4Olw
         Aaagvqeunm27Y4P0un9xcug5eShCJ75LhceIHCuBa+UONQXY2/qsIsO5EQTIIO9O9H/7
         QpoS8xxb+acjyu1ruVVsZFmT0nyhfHlq8Dfaz1XrdZ4vnOcWYh6rhQ0z7hy7Y28s6L+z
         rwsA==
X-Gm-Message-State: AJcUukcIUwsNYq2vR8mH01xM1OAegJJyfeoh4n9sqQFVPaFBHZk32PVI
        yYppka9XhuyhcgcY8bbEbN3fCnOvglQhX/vNyaWBgw==
X-Google-Smtp-Source: ALg8bN7inZo4gLeCMcjjb/+RwyWZATLJVYXo/PSMrbNmjzbHNngsGlV4YbMsVb3KnujAnw21gcqD4HyTwn3ZJ0rkTPg=
X-Received: by 2002:a9d:394:: with SMTP id f20mr19794870otf.98.1548118858400;
 Mon, 21 Jan 2019 17:00:58 -0800 (PST)
MIME-Version: 1.0
References: <154785884329.2202034.3295476681016958230.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190122002615.GB5855@richard> <CAPcyv4jXS-doCdyTrcV3DL63N-q4m1H2=Msgm1z88HnF8bcEig@mail.gmail.com>
 <20190122004647.GA6575@richard>
In-Reply-To: <20190122004647.GA6575@richard>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 21 Jan 2019 17:00:47 -0800
Message-ID: <CAPcyv4iVg09ryVAqOnxXAGUJf7xZqzxL0CWxGY4WOTEman--8w@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm: Clarify nd_pfn_init() flow
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 4:47 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>
> On Mon, Jan 21, 2019 at 04:29:08PM -0800, Dan Williams wrote:
> >On Mon, Jan 21, 2019 at 4:26 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
> >[..]
> >> >@@ -706,6 +711,22 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
> >> >               sig = DAX_SIG;
> >> >       else
> >> >               sig = PFN_SIG;
> >> >+
> >> >+      /*
> >> >+       * Check for an existing 'pfn' superblock before writing a new
> >> >+       * one. The intended flow is that on the first probe of an
> >> >+       * nd_{pfn,dax} device the superblock is calculated and written
> >> >+       * to the namespace. In this case nd_pfn_validate() returns
> >> >+       * -ENODEV because no valid superblock exists currently.
> >>
> >> As you replied in following mail:
> >>
> >> 3/ If present, nd_pfn_validate() returns 0 and nd_dax_probe()
> >> registers the dax0.1 device (this is a libnvdimm 'personality device).
> >>
> >> So at this point, nd_pfn_validate() return 0 or -ENODEV?
> >
> >In this case 0, because the configuration was successfully validated.
> >
> >-ENODEV, is only returned for the initial case where we want the
> >kernel to write the configuration.
> >
> >All other error codes are an actual failure and the probe procedure stops.
>
> To be honest, this maybe crystal clear for you. But I still feel a little
> confused. Especially on differentiating those cases. How many cases we have?

There are 4 cases:

1/ namespace probed, no personality info-block found, namespace
results in 'raw' mode

2/ namespace probed, {pfn,btt,dax} info-block found, {pfn,btt,dax}
device created and attached to the corresponding personality driver

3/ namespace probing ends in failure like -ENOMEM, or a -EIO error
reading namespace capacity, for example due to a bad block.

4/ namespace force assigned to a {pfn,btt,dax} device instance,
{pfn,btt,dax} device force enabled  leading to the info-block being
written out to the device

> And what's your first probe mean? This the nd_btt/pfn/dax_probe()? or the
> linux driver probe?

The first probe is always nd_pmem_probe(). nd_{pfn,btt,dax}_probe()
are secondary.
