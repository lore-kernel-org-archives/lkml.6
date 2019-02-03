Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A8EC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E172073F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="RKkEx2bP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfBCTNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 14:13:51 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42468 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfBCTNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 14:13:50 -0500
Received: by mail-oi1-f194.google.com with SMTP id w13so9846775oiw.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 11:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GAE0x8+CdnGfSUomCqdCZFwa5+m8ZwkJ7khVTAMV0cc=;
        b=RKkEx2bP88f0QPj6P+JSenTWzYxugjZP3CN6oJIw3x2MXEp3IEfTszaGQOO+umtewU
         6Xy0uE8Z+nJ1jtnN6UmCxDnHfWtGJIpMi6SGjWdeh/4WDvZHsazYq39G0mAkJ3c1oiZ+
         QAld6w2ZuPlEt7cVK1u+wnljNIL6r4+tnnPWGT9SaR8b8zidyX7bqo0JVlQpOnvDyKiR
         XUNwEHiQTEwkThFmSHbeA4JPC51xA6dORhp1rO6wV/+W2xZmBZUXCAB7cLENgMmWlT9G
         r1L/7cIcygJyThjQTcxdiUnxxD/BC5dadnhKWRUzDfI62dmBDCNnblNzBD/MGC505EsF
         4pTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAE0x8+CdnGfSUomCqdCZFwa5+m8ZwkJ7khVTAMV0cc=;
        b=a4PAbCk9CJ5Z6WR6rZ1eyaVWFA34OcDx4TwMQ1NzT0r5q3buqwIupQtYjKrxRo5xGh
         X95Q97LsJv1icjNdJPvnRsc6rr6CAm13AKwUqsZRpjYCYciGmtP3d+saPdqK5XfOoOZq
         DLG1uM9HfIqTRDnq8hL2M7tql00bwrYhEbvUPw84G3VRzIB3Nad2hjqH+PtB2wRmF7bx
         QBdi1zT+kgONa61pOUsSdUzcqIuUPm2N/lsiRsHXzynZPdeS8inEt3/yuaqzJ7mUVFiH
         zb0MtRAMzLsRqscm+CNRjQhIeuKZDGnTdAfH6frvaU1fs/LwGoKcJ78haFaMBu32KMI2
         knkQ==
X-Gm-Message-State: AHQUAubhAiWZckXJkBKX47l48lIJNnfmyQfiQpiHp+t7sCu6I488phgX
        PjPD5TClz5/xM6l6HeYozY8tG7rOXXtM1MPeup3wgw==
X-Google-Smtp-Source: AHgI3IZZU5ZZkTyy2TJ6sUkJQyqz3MVGRjr7jkgt914poIxL2WsEZgwW/gQo/CUwml/GdUOiNgIYrhcQzSPO7NmxrdA=
X-Received: by 2002:aca:5205:: with SMTP id g5mr5738264oib.149.1549221229499;
 Sun, 03 Feb 2019 11:13:49 -0800 (PST)
MIME-Version: 1.0
References: <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <154915640488.3541628.4947340559510114602.stgit@dwillia2-desk3.amr.corp.intel.com>
 <PU1P153MB0169BD9237F2DC1FA64721BABF6C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4h0B0sBMjiAC=Tk=Mu58A4vZ5F9yUPQsXqf5jyYF37VCw@mail.gmail.com> <PU1P153MB0169F7C111EEC5890D3F840ABF6C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169F7C111EEC5890D3F840ABF6C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 3 Feb 2019 11:13:38 -0800
Message-ID: <CAPcyv4iMau=fvOfubDvK=cg5v5287TvXqBCm=p8nqbz2es6YEg@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/dimm: Add a no-BLK quirk based on NVDIMM family
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 3, 2019 at 10:13 AM Dexuan Cui <decui@microsoft.com> wrote:
>
> > From: Dan Williams <dan.j.williams@intel.com>
> > Sent: Sunday, February 3, 2019 9:49 AM
> > > ...
> > > It looks the namespace created by Ubuntu 19.04 (4.18) is incompatible with
> > > the libnvdimm-pending branch + this patch.
> >
> > This is correct, the configuration switched from label-less by default
> > to labeled.
> Thanks for the confirmation!
>
> > > It looks we need to completely disable the label usage for
> > NVDIMM_FAMILY_HYPERV
> > > due to compability?
> >
> > It's either going to be a quirk in Linux or a quirk in the Hyper-V
> > configuration. I think it's more manageable for Hyper-V to ship a
> > "label disable" switch than to try to ship a workaround in Linux. The
> > "noblk" quirk in Linux works around the LOCAL bit in the labels.
> > However, the namespace mode regression can only be resolved by hiding
> > the label capability until the administrator manually switches from
> > label-less to labeled operation.
>
> As I understand, the essence of the issue is: Hyper-V emulates the
> label mechanism (i.e. it supports _LSI and LSR), but doesn't do it
> right (i.e. it doesn't support _LSW).
>
> To manage the namespaces, Linux can choose to use label or not.
>
> If _LSI/_LSR are supported, Linux assumes _LSW is supported as well
> and chooses to use label (i.e. the label mode), but since Hyper-V doesn't
> support _LSW, Linux fails to change the namespace configuration.

No, that's not quite right. The reason Linux does not see the fsdax
mode configuration is due to the missing "address abstraction GUID" in
the label produced the default Hyper-V configuration. In label-less
mode there is no "address abstraction GUID" to validate so it falls
back to just using the info-block directly.

The _LSW issue is if you wanted to reconfigure a raw namespace to
fsdax mode. The current flow tries to delete the label, but that's
only for reconfiguration, not the initial boot-up case that is
currently failing. The deletion would fail on finding no label-write
capability, but to be clear the boot-up case does not perform any
writes.

> In
> Ubuntu 19.04 (4.18), the kernel is not aware of Hyper-V _LSI/_LSR, so
> the created namespace is in "label-less" mode, and hence can't be used
> with the libnvdimm-pending branch + this patch, unless we add a quirk
> in Linux to explicitly not use the label.
>
> I agree ideally Hyper-V should hide the label capability, and I'll request
> Hyper-V team to do that. I hope Hyper-V guys are still able to do that
> in time so we won't need a quirk in Linux kernel.

After some more thought, the "no regressions" rule means that Linux
should ship a quirk for this by default. I think a good heuristic is
to disable label support by default if no _LSW method is detected. An
opt-in can be specified to accept "read-only" configurations, but
that's an exceptional case. I'll send a patch for this.

> BTW, I suppose Windows VM should be in "label-less" mode.

I expect Windows mandates labeled operation. This label-less concept
was something Linux shipped in advance of a specification being
ratified and to support early NVDIMMs that don't advertise label
space.

> Thanks for the help, Dan!

Thanks for the quick feedback and testing.
