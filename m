Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CDFC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA03021726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="wHa+dG5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfBAXr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:47:29 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37766 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfBAXr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:47:28 -0500
Received: by mail-ot1-f65.google.com with SMTP id s13so7574232otq.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 15:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5AyYOj0kb/AWXiQxcZtkLm8mTHqXu+C78ARgkAzy/48=;
        b=wHa+dG5KU7n1ymKaUd6BBvnCgPke5Pdqy7L6sK1O4nqf0H/5/7ra9tKsR2FeSJarVH
         6coHWYyG0a/lmiptwQIxBsLnpHUxqWqSDD77ou2lTNyXFE5UGHDvv6Qtt+vrTzonn3gr
         mtasqTeQ6EjvfThk0GbewPHJyZrkfx4iJ57pHNEEk/jzqahNpPZ8fopMxqYimPWE4wSp
         3iN4/3eLMT8UJlY3gyHVueZpVnSOEJBp0GvyAE+G0ZWHCSOVcKtts/kToJYCgIKkPBTH
         PKMip9Ei4zo+3FCBJhCCtDnLUt2sgLtQfeIWK8ddCZnVp6ZQboZye3/JoMSDjh473YEm
         NQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5AyYOj0kb/AWXiQxcZtkLm8mTHqXu+C78ARgkAzy/48=;
        b=FXLbhMKeDIj9m2DURZA0iqouqkba/NxqTJ3X3Vt31metlNlOsezA6zT0DzDdUJsdC8
         18ZPWmxB/V3yKe+ZHGntJHSkVjOhXQYhg9ekdOrz37+T42cxDYGteOeKrGw1VbCromBf
         GxInDHg71ThhSo0RLBoqXDiH5QbHtlKMAhzj9dpdoMAFeGCfjKWTo+vc8fv/h3iJBDIJ
         Slan4ZcZwVh2OeNLL8UGBsnjVywyyONIYuz2UIbiwG8CPelVDweCoJkKZKgpXvlPcIm3
         CH8dR1u+XXfNmoXbcrqImQDNtbBxPHpiq3c0QzuJn1ZtCdrEyxU5sI05fQJJsq5FCdIn
         pbRw==
X-Gm-Message-State: AHQUAuYkEwt6fxvtT6rEkNrpRNk/GZ6g1thhsePJT/mGSEB/OE5GwR8V
        WD4RvMPZVxi0z2kOrqdLTQa6ivuSI8pNn2FIhzqRyg==
X-Google-Smtp-Source: AHgI3IblOMW8IPR0YtV+4uAcK5S36H+vsQfjab2Z3YJ+1P20rEGMB89jwUFYzWINR9WCJpdPimTnUs9PkHy4nAw3C60=
X-Received: by 2002:a9d:6ac2:: with SMTP id m2mr7957299otq.353.1549064847317;
 Fri, 01 Feb 2019 15:47:27 -0800 (PST)
MIME-Version: 1.0
References: <PU1P153MB01690EDA138D3ABDE5B4A482BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4jD1oRWzA4ZiMYZm1uxsbOdgqzbb9raH70-HBDqapcE_g@mail.gmail.com>
 <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4haUouYs_Vfju2SMvjcwc7rqY06zqT8NJ-3uakGMZSu0w@mail.gmail.com> <PU1P153MB01694FCAF062E089059CD441BF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB01694FCAF062E089059CD441BF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 1 Feb 2019 15:47:15 -0800
Message-ID: <CAPcyv4gdWJ8qtiASU9ggz56Mkrm9OXfsO74RM9OOrXFmBw_A9Q@mail.gmail.com>
Subject: Re: [PATCH v2] nfit: add Hyper-V NVDIMM DSM command set to white list
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Josh Poulson <jopoulso@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 3:17 PM Dexuan Cui <decui@microsoft.com> wrote:
>
> > From: Dan Williams <dan.j.williams@intel.com>
> > Sent: Friday, February 1, 2019 9:29 AM
> > > Hi Dan,
> > > Unluckily it looks this commit causes a regression ...
> > > With the patch, "ndctl list" shows nothing, and /dev/pmem0 can't appear.
> > > If I revert the patch, it will be back to normal.
> > >
> > > I attached the config/logs. In the bad case, "dmesg" shows a line
> > > [    5.259017] nd_pmem namespace0.0: 0x0000000000000000, too small
> > must be at least 0x1000
> > > Any idea why this happens? I'm digging into the details and I appreciate your
> > insights.
> >
> > Looks like it is working as expected.
>
> I was working on linux-next tree's next-20190107 and this patch did "work fine"
> there. The "regression" happens on djbw/nvdimm.git tree's libnvdimm-pending
> branch because we have this recent commit (Jan 19):
>
> 11189c1089da ("acpi/nfit: Fix command-supported detection"), which makes such
> a change in acpi_nfit_ctl():
>
> -       if (!test_bit(cmd, &cmd_mask) || !test_bit(func, &dsm_mask))
> +       if (cmd == ND_CMD_CALL && !test_bit(func, &dsm_mask))
> +               return -ENOTTY;
> +       else if (!test_bit(cmd, &cmd_mask))
>                 return -ENOTTY;
>
> So previously ND_CMD_GET_CONFIG_DATA fails with -ENOTTY and we're good.
>
> Now the command succeeds, but it looks the returned data is inavlid, and I see
> the "regression".

I believe it's the same reason. Without 11189c1089da the _LSR method
will fail, and otherwise it works and finds the label that it doesn't
like.

I'm not seeing "invalid" data in your failure log. Could you double
check that it's just not the success of _LSR that causes the issue?

> > The regression you are seeing is the fact that the patch enables the kernel to
> > enable nvdimm-namespace-label reads.
> Yes.
>
> > Those reads find a namespace index block
> > and a label. Unfortunately the label has the LOCAL flag set and Linux
> > explicitly ignores pmem namespace labels with that bit set. The reason
> Can you please point out the function that ignores the flag?
>
> I checked where NSLABEL_FLAG_LOCAL is used, but it looks I can't find a
> related function.

scan_labels() is where the namespace label is validated relative to
the region type:

                if (is_nd_blk(&nd_region->dev)
                                == !!(flags & NSLABEL_FLAG_LOCAL))
                        /* pass, region matches label type */;
                else
                        continue;

It also has meaning for the namespace capacity allocation
implementation that needed that flag to distinguish aliased capacity
between Block Aperture Mode and PMEM Mode access.

> > for that is due to the fact that the original definition of the LOCAL
> > bit from v1.1 of the namespace label implementation [1] explicitly
> > limited the LOCAL flag to "block aperture" regions. If you clear that
> > LOCAL flag I expect it will work. To my knowledge Windows pretends
> > that the v1.1 definition never existed.
> I'm trying to find out where the flag is used and how to clear it.

Assuming Hyper-V implements _LSW, you can recreate / reinitialize the
label area:

ndctl disable-region all
ndctl init-labels -f all
ndctl enable-region all
ndctl create-namespace

> > The UEFI 2.7 specification for v1.2 labels states that setting the
> > LOCAL flag is optional when "nlabel", number of labels in the set, is
> > 1. Linux makes that mandatory as LOCAL is redundant when nlabel is 1.
> >
> > That said, the Robustness Principle makes a case that Linux should
> > tolerate the bit being set. However, it's just a non-trivial amount of
> > work to unwind the ingrained block-aperture assumptions of that bit.
> Can you please explain this a bit more? Sorry, I'm new to this area...

The short story is that Linux enforces that LOCAL == Block Mode
Namespaces. See section 2.2 Namespace Label Layout in the original
spec [1]. The EFI 2.7 definition tried to allow for LOCAL to be set
when an interleave-set was comprised of a single NVDIMM, but then also
states its optional when Nlabel is 1. It has zero functional use for
interleave-set based namespaces even when the interleave-set-width is
1. So Linux takes the option to never set it, and goes further to
reject it if it's set and the region-type does not match, because that
follows the v1.1 meaning of the flag.

[1]: http://pmem.io/documents/NVDIMM_Namespace_Spec.pdf
