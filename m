Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE81C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3982120817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="oud5sjbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3982120817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731851AbeK1Elr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:41:47 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35463 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbeK1Elq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:41:46 -0500
Received: by mail-oi1-f193.google.com with SMTP id v6so20062751oif.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W6kqbdoIdoOTcEMfh8M3eg7P++NjiSNDJAcPi/8vdBw=;
        b=oud5sjbVeBFfvW6GQ6O0/nJR3O0tkTdfklfksZnfyr/QUkxVDR3j40K/AgpTNWsL3E
         VEAtDP6g8fVx0om6CV+ZZkJE/XJg/7/bFkYPYW062bl/x1M5IO3r939LaM9zAQo89Bh0
         wJ7YCN0tP58WUNEeYOzPgyqCgQ7IPXanDwXlFUMDTIk3wbyVSbJN2ir/1gXAoacEgL+H
         tkbXJpAKsGnayckXmvuaz+8werplOfzjd4AyWpFL1TghbRLYprooBtQo//1ENrtQSXvM
         sVvWydIvR/kR4ReMeVhhoOHY6cfNWDkvvVC7JWo3HcvV4wYB2Ku5JuwZnDzvg51bK3PA
         5KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W6kqbdoIdoOTcEMfh8M3eg7P++NjiSNDJAcPi/8vdBw=;
        b=feM4XHIvI20YqZvR0JYY+zQuEh4y/Vd89Ud/uzxHTLUte1sR/WjarkR+qJXiuQt0l6
         WoybdtpFMGYT3xfjnOOGW2wDkS/qguoqmB7m0YV00UwK7RsDWHJizugG9plDG+xSDumB
         AVuS0PODHgxElTDzQ2nrV19aHg1QR8sW7H3GW3COPSN4kIPqMsBxFqg1FWL/CXRJrFNb
         Sb+p2ZHQL6McqMTXcpokueLzRMid5Xf7QWquhSr18ukKDXkllBRGz3RJqZB1aNgHvgft
         W2Pd/ytcZfCLN6qmTFF+lUqrpbSyWaKw0PBnL25vl2RjxGeg3HLICvRF58OYGXPyUSK1
         27QQ==
X-Gm-Message-State: AGRZ1gJBgKk+bt16vOZ2/9wbM/EKrV8Y3D7rSkNclwujz0EkzXYDlDsC
        NMIXDmD4w2USFI0sfHU/dKl9cv/LC5NVqgey19If3g==
X-Google-Smtp-Source: AJdET5doZLF+QT1lbW4hzzE3wzo/ph5iO0QBD1G9JAa2Icz3LbuwEk5QgQmYLiYwto7Hac1d4MswnO2zigQLq5nievI=
X-Received: by 2002:aca:e691:: with SMTP id d139-v6mr17528580oih.232.1543340587265;
 Tue, 27 Nov 2018 09:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20181114224921.12123-2-keith.busch@intel.com> <20181114224921.12123-3-keith.busch@intel.com>
 <CAPcyv4jNpgzpfG1awrxspTeQ1JOK-4-Wu6Kb6cd6NGY6Atj3cg@mail.gmail.com>
In-Reply-To: <CAPcyv4jNpgzpfG1awrxspTeQ1JOK-4-Wu6Kb6cd6NGY6Atj3cg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 27 Nov 2018 09:42:54 -0800
Message-ID: <CAPcyv4hMFc7K=FjHWiMVAiOxVC-s0itPjVTs_-7KrFhg4h_SXQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] node: Add heterogenous memory performance
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Mon, Nov 26, 2018 at 11:00 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Nov 14, 2018 at 2:53 PM Keith Busch <keith.busch@intel.com> wrote:
> >
> > Heterogeneous memory systems provide memory nodes with latency
> > and bandwidth performance attributes that are different from other
> > nodes. Create an interface for the kernel to register these attributes
> > under the node that provides the memory. If the system provides this
> > information, applications can query the node attributes when deciding
> > which node to request memory.
> >
> > When multiple memory initiators exist, accessing the same memory target
> > from each may not perform the same as the other. The highest performing
> > initiator to a given target is considered to be a local initiator for
> > that target. The kernel provides performance attributes only for the
> > local initiators.
> >
> > The memory's compute node should be symlinked in sysfs as one of the
> > node's initiators.
> >
> > The following example shows the new sysfs hierarchy for a node exporting
> > performance attributes:
> >
> >   # tree /sys/devices/system/node/nodeY/initiator_access
> >   /sys/devices/system/node/nodeY/initiator_access
> >   |-- read_bandwidth
> >   |-- read_latency
> >   |-- write_bandwidth
> >   `-- write_latency
>
> With the expectation that there will be nodes that are initiator-only,
> target-only, or both I think this interface should indicate that. The
> 1:1 "local" designation of HMAT should not be directly encoded in the
> interface, it's just a shortcut for finding at least one initiator in
> the set that can realize the advertised performance. At least if the
> interface can enumerate the set of initiators then it becomes clear
> whether sysfs can answer a performance enumeration question or if the
> application needs to consult an interface with specific knowledge of a
> given initiator-target pairing.

Sorry, I misread patch1, this series does allow publishing the
multi-initiator case that shares the same performance profile to a
given target.

> It seems a precursor to these patches is arranges for offline node
> devices to be created for the ACPI proximity domains that are
> offline-by default for reserved memory ranges.

Likely still need this though because node devices don't tend to show
up until they have a cpu or online memory.
