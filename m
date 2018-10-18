Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22302C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9298D2086E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="POFD5UTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9298D2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeJSG0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:26:49 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40689 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbeJSG0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:26:49 -0400
Received: by mail-oi1-f196.google.com with SMTP id j68-v6so25342470oib.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 15:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=APmd96SG+NyXCvrqngy5DnWmDlvUuBrNgdaiTc+qOBg=;
        b=POFD5UTMJvKcdBMzXUAf+e9jHDOEXpxDgfIlht0NMx/V6KdGw4oT6jce0Wl9wBUKms
         YtaIbEa4iW/zQeMdfeZPBX057crxglLDMcMXF6low63mx57VpK525JoyWBrBlfNhkpI6
         rOe3XN4eEuRJZXS/aWJp2dPWMT3IrR620kRXz7AKwtfcscD2xaDXnSWdcM0aB0NOSwsD
         puOzq/c8ZA/+pRyJwa4j97zhckl7oe+32EaiYGvr17OKyJrcFOGrzNLNEqDDcUHu8jr3
         xMvkdf6x4NCBkLE1kPMlRu73wcLNYibskoOeuxTOK2dbP9XW0igCbKjZ8BfWnXUk9vHy
         vNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APmd96SG+NyXCvrqngy5DnWmDlvUuBrNgdaiTc+qOBg=;
        b=QmxL1Y9fvhBT9UI07wvwzZHat6vnxnpXb2amorgzNbpJyzc73SJh5lDxkA3DunHwUN
         atYLRtsLcZ6Z8iItIHSrJrDyh5+VU/slfVUoc3kpBT7lJ/292YQIO1euAXhNpI8S0VbN
         KMTWwknIWRGwllVKCYXOpc9X+rAis16AqLWZ50meCyEal6ScenqXoBaH3DlKcZqXK3zI
         Lli3BC0yH1KKbxFOE0CGKsqU6YXd8aYSOC9psspsGJVPNU81OVAXGF5C/914KS8Qy67i
         z+8KxK5zUwMwdL8He1BnptpDe0ggj+bosUra2tvMlK8hvRkWWC28kpEviPgnszC8Xt0R
         Su3A==
X-Gm-Message-State: ABuFfoiD3+Mrmmwr8zFi+Cptl2kC/l6Q8g0J/UihxY1DwXhCQ2DZFGIV
        ayDCPWnYVuLgI9JgDbP4o8GpWPHCPcVgcbi5uHYVjQ==
X-Google-Smtp-Source: ACcGV62EBS3m/GrJ3nwauWa3Sr9647Yb0kR8VnRHcXGuETBnhWvqHihd91VjL6SPlahy2NEPkpVIevyCM147Yg3J/jw=
X-Received: by 2002:aca:f512:: with SMTP id t18-v6mr17860669oih.244.1539901423341;
 Thu, 18 Oct 2018 15:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181018002924.GA42803@beast> <CAPcyv4g_W5KJq8vrVdi8-Hij4zQLLjZdZMkmP7oWABSrmGfLRw@mail.gmail.com>
 <CAGXu5jK5GrgoHSC_peChp9Uzx-_EbPqZgtpDC=F+V1cP92cKxA@mail.gmail.com>
 <CAPcyv4gO2zN-ixVE1eLpe4RT1Vkkyp_C+LbGnNVT+gnJG=h3KQ@mail.gmail.com>
 <CAGXu5jKUc0+EnV0m1ii_aRVa2XJSDtKY4Xq77Q+an1Z1VUqV7w@mail.gmail.com>
 <CAPcyv4jzic5zd1AJci439zWzJ0-nP_vf3k7Xzkm7AGvvge8SEA@mail.gmail.com> <CAGXu5j+Ne7cJBWp0Tzp++c+iOTgT5SeZCE0wVOR1xcmaQJDKiw@mail.gmail.com>
In-Reply-To: <CAGXu5j+Ne7cJBWp0Tzp++c+iOTgT5SeZCE0wVOR1xcmaQJDKiw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 18 Oct 2018 15:23:32 -0700
Message-ID: <CAPcyv4hyZFRog8EBvhnO0bz3ryVNX=udupgnFUSZDgUBN23YWg@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Clarify resource reservation labels
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        "Luck, Tony" <tony.luck@intel.com>, joel@joelfernandes.org,
        zwisler@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 3:19 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 18, 2018 at 2:35 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> > On Thu, Oct 18, 2018 at 1:31 PM Kees Cook <keescook@chromium.org> wrote:
[..]
> > I cringe at users picking addresses because someone is going to enable
> > ramoops on top of their persistent memory namespace and wonder why
> > their filesystem got clobbered. Should attempts to specify an explicit
> > ramoops range that intersects EfiPersistentMemory fail by default? The
> > memmap=ss!nn parameter has burned us many times with users picking the
> > wrong address, so I'd be inclined to hide this ramoops sharp edge from
> > them.
>
> Yeah, this is what I'm trying to solve. I'd like ramoops to find the
> address itself, but it has to do it really early, so if I can't have
> nvdimm handle it directly, will having regions already allocated with
> request_mem_region() "get along" with the rest of nvdimm?

If the filesystem existed on the namespace before the user specified
the ramoops command line then ramoops will clobber the filesystem and
the user will only find out when mount later fails. All the kernel
will say is:

    dev_warn(dev, "could not reserve region %pR\n", res);

...from the pmem driver, and then the only way to figure who the
conflict is with is to look at /proc/iomem, but the damage is already
likely done by that point.
