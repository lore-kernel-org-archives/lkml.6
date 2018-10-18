Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7A3C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F28E21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="X7rgRuDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F28E21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeJRXet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:34:49 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40866 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeJRXes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:34:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id w67so30157407ota.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/oIFlO+sVnxZUNAXBnxq101uFbJ6w0Vo3FQRE4rDus=;
        b=X7rgRuDXbqDvpUfx1JU3i0UGG9j1XAM0Jv9GXOzuWSJjkAlbgc1/B+rgfqvTjQ47tv
         Afb67gbrqWZ6+cAo6Q3jHfFBzfC0YgtTXLTH5u+TAqtkvu6Wsdi++8PnlYmJrfAQvesO
         ev2CzbzQ1XUNIVCXgyjVhEKV0bHRW612jwL6l53x+5M9aBiAcfE4v+mZE7iT2uw3pfgI
         j8InpGzm+qQOz6sDJgtzvDtKk7STZcxIxdQjmzIsCMb1vBUApIbJwsj2QqAhVSd67ra2
         cyrdQRvm5xmj6mMlhKbgcR1WOm8oGCPiXoz3xlHWfroJFAPrjiQAHbDM6sQI79tMg6M/
         zk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/oIFlO+sVnxZUNAXBnxq101uFbJ6w0Vo3FQRE4rDus=;
        b=IBi3tofRPiBpURgzYvsno+FjBdDYRLeEI8mCZykToUdiKjkeeiqXs7GW5/GUhv6A3X
         lYEA4vYLPbH9xvGtENy43271aXClWW7fdv9BP8t0NeHeCq2s62J++BD3M1qps/S7axUy
         n0UQe3rY/GMLmiEwsVbilzFcmuMZ6Zi85DP0lOv/XRBXDIVWVffxirTm+55LfL6lOojB
         DihJuo57bIEfdbiE5VcQSUXiDzq4kfxckQgUQSwF/JNE4o5I7wx8zSp0XiaD4XfzxvaK
         WU5e6otQMBTlcpEWVq1kYCI/qogw8eicUo8+yBooKnAGAiB5DXo2eyA7kjulWTN6GEFF
         rnLQ==
X-Gm-Message-State: ABuFfohSc2ukkcWw4/LnIhZsQxQpKB91DG4acgu5X7FQd2RikIq1ZvWk
        gt8QPeSNdA9+yfnoGUGtabt6khdMq2o8Jt3bf04sQw==
X-Google-Smtp-Source: ACcGV62B99UQfiLR0okGdyJu/cAvtm55JwLx+sJivtS0BWzei8yfZwO/vMjwaCqFt0jqwNzVt2u0naIhPDmEI0vyEYw=
X-Received: by 2002:a9d:256e:: with SMTP id j43mr20002064otd.367.1539876795646;
 Thu, 18 Oct 2018 08:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181018002924.GA42803@beast> <CAPcyv4g_W5KJq8vrVdi8-Hij4zQLLjZdZMkmP7oWABSrmGfLRw@mail.gmail.com>
 <CAGXu5jK5GrgoHSC_peChp9Uzx-_EbPqZgtpDC=F+V1cP92cKxA@mail.gmail.com>
In-Reply-To: <CAGXu5jK5GrgoHSC_peChp9Uzx-_EbPqZgtpDC=F+V1cP92cKxA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 18 Oct 2018 08:33:04 -0700
Message-ID: <CAPcyv4gO2zN-ixVE1eLpe4RT1Vkkyp_C+LbGnNVT+gnJG=h3KQ@mail.gmail.com>
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

[ add Ross ]

On Thu, Oct 18, 2018 at 12:15 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Oct 17, 2018 at 5:49 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> > On Wed, Oct 17, 2018 at 5:29 PM Kees Cook <keescook@chromium.org> wrote:
> >>
> >> When ramoops reserved a memory region in the kernel, it had an unhelpful
> >> label of "persistent_memory". When reading /proc/iomem, it would be
> >> repeated many times, did not hint that it was ramoops in particular,
> >> and didn't clarify very much about what each was used for:
> >>
> >> 400000000-407ffffff : Persistent Memory (legacy)
> >>   400000000-400000fff : persistent_memory
> >>   400001000-400001fff : persistent_memory
> >> ...
> >>   4000ff000-4000fffff : persistent_memory
> >>
> >> Instead, this adds meaningful labels for how the various regions are
> >> being used:
> >>
> >> 400000000-407ffffff : Persistent Memory (legacy)
> >>   400000000-400000fff : ramoops:dump(0/252)
> >>   400001000-400001fff : ramoops:dump(1/252)
> >> ...
> >>   4000fc000-4000fcfff : ramoops:dump(252/252)
> >>   4000fd000-4000fdfff : ramoops:console
> >>   4000fe000-4000fe3ff : ramoops:ftrace(0/3)
> >>   4000fe400-4000fe7ff : ramoops:ftrace(1/3)
> >>   4000fe800-4000febff : ramoops:ftrace(2/3)
> >>   4000fec00-4000fefff : ramoops:ftrace(3/3)
> >>   4000ff000-4000fffff : ramoops:pmsg
> >
> > Hopefully ramoops is doing request_region() before trying to do
> > anything with its ranges, because it's going to collide with the pmem
> > driver doing a request_region(). If we want to have pstore use pmem as
> > a backing store that's a new drivers/nvdimm/ namespace personality
> > driver to turn around and register a persistent memory range with
> > pstore rather than the pmem block-device driver.
>
> Yup: it's using request_mem_region() (that's where the labels above
> are assigned).
>
> As for nvdimm specifically, yes, I'd love to get pstore hooked up
> correctly to nvdimm. How do the namespaces work? Right now pstore
> depends one of platform driver data, device tree specification, or
> manual module parameters.

From the userspace side we have the ndctl utility to wrap
personalities on top of namespaces. So for example, I envision we
would be able to do:

    ndctl create-namespace --mode=pstore --size=128M

...and create a small namespace that will register with the pstore sub-system.

On the kernel side this would involve registering a 'pstore_dev' child
/ seed device under each region device. The 'seed-device' sysfs scheme
is described in our documentation [1]. The short summary is ndctl
finds a seed device assigns a namespace to it and then binding that
device to a driver causes it to be initialized by the kernel.

[1]: https://www.kernel.org/doc/Documentation/nvdimm/nvdimm.txt
