Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8253C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4A820672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="fWWhmI5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4A820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeLJQMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:12:36 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34340 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbeLJQMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:12:35 -0500
Received: by mail-oi1-f193.google.com with SMTP id h25so9427515oig.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXBaR7F0Nj4Mp5RDUQk/IIzpiBgmuHu9tmtX2N1eI2k=;
        b=fWWhmI5zL+VePlrxW5AO9FYuBP6pf8MpwnXS5DeLtwlBGpVBUpIGQMCir+xQjC0/Jx
         hHzzemhAxtDRbMl0o42A4k8QWUjqKnrLk8XodvtP+CEGsCyiIHB1w3lCuor6V+Bj5RY9
         yAk1Dj/i9FYwPpOatKkwv3ATRF7ggyePPJwF1/hOEx3REgcOq/vo9OCLd9k4CFgMaapH
         kPGJ292TJhhqy82zTOn1qthzKTDSClWmHR0/zEI+XhkftdM29nfCeLI7C0yis5bxTj/Q
         LuReNIOAjlLXYUW/M/UNEpNmBidoBzu+2kI1ZU3RA/hMwrj2v5wSYUGJx7NFTTLBbWT6
         0+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXBaR7F0Nj4Mp5RDUQk/IIzpiBgmuHu9tmtX2N1eI2k=;
        b=YwUqP0EOffguBzGnielkZF8dHq+RvQKsDVVYqMEkIhH+9Fv9jU2MGa8flYae37q5l1
         mBnrVQap5o7MpKJMUB7Q25SnXTahbiOnQTVv/SJ96uUh0JV2eyip8XphDmSh7qSCoQTj
         hFRlb999Njf2/6MiVPzp1s/dyj6KiBHXURp0D9NdeSnb/OebrFWz4XozZy1eS/AdPKXd
         /9Vh50tKFr8zlNWiUEnM4dAdxje1wy5u2VF3TGuPpHJJ+NepqtYS7tXDZDT7PCi1rGTC
         6jXafK9CvFMprjEGysepunvLN4UcM8rHlAy8Zpga+T0O3oPVa4iMG4gI9gpYeJvD1sc2
         f2yw==
X-Gm-Message-State: AA+aEWbZ+4pz8O7ggvK64PAmOVAoU1NGpXKTQcCvgiLQmhazMO+GI8qL
        fXyrFx9ahbdHI+DUdwJX4uwObshGWIkIfXhXnL8RnQ==
X-Google-Smtp-Source: AFSGD/VON5942vDhGGY/j3EcECAiTIJSkJ1/hPZ4NVXihAeVPk0azSLNHh4Uicsjvd5Uf6JFvzB5Se9Ac+4fGCNoliw=
X-Received: by 2002:aca:b804:: with SMTP id i4mr7472637oif.280.1544458354575;
 Mon, 10 Dec 2018 08:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20181114224921.12123-2-keith.busch@intel.com> <20181114224921.12123-4-keith.busch@intel.com>
 <20181115125909.000067aa@huawei.com>
In-Reply-To: <20181115125909.000067aa@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 10 Dec 2018 08:12:23 -0800
Message-ID: <CAPcyv4jtf8guXutLKnHt9UbyS0-sEZ5pVJfse49xe3gCCkW8dQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] doc/vm: New documentation for memory performance
To:     jonathan.cameron@huawei.com
Cc:     Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 4:59 AM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Wed, 14 Nov 2018 15:49:16 -0700
> Keith Busch <keith.busch@intel.com> wrote:
[..]
> > +The kernel does not provide performance attributes for non-local memory
> > +initiators. The performance characteristics the kernel provides for
> > +the local initiators are exported are as follows::
> > +
> > +     # tree /sys/devices/system/node/nodeY/initiator_access
> > +     /sys/devices/system/node/nodeY/initiator_access
> > +     |-- read_bandwidth
> > +     |-- read_latency
> > +     |-- write_bandwidth
> > +     `-- write_latency
> > +
> > +The bandwidth attributes are provided in MiB/second.
> > +
> > +The latency attributes are provided in nanoseconds.
> > +
> > +See also: https://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
>
> My worry here is we are explicitly making an interface that is only ever
> providing "local" node information, where local node is not the best
> defined thing in the world for complex topologies.
>
> I have no problem with that making a sensible starting point for providing
> information userspace knows what to do with, just with an interface that
> in of itself doesn't make that clear.
>
> Perhaps something as simple as
> /sys/devices/system/nodeY/local_initiatorX
> /sys/devices/system/nodeX/local_targetY
>
> That leaves us the option of coming along later and having a full listing
> when a userspace requirement has become clear.  Another option would
> be an exhaustive list of all initiator / memory pairs that exist, with
> an additional sysfs file giving a list of those that are nearest
> to avoid every userspace program having to do the search.

I worry that "local" is an HMAT specific concept when all it is in
actuality is a place for platform firmware to list the "best" or
"primary" access initiators. How about "initiator_classX" with some
documentation that the 0th class captures this primary initiator set.
That leaves the interface a straightforward way to add more classes in
the future, but with no strict association to the class number.
