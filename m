Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C26C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893E020659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="anLbxKCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfANVgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:36:11 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45950 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfANVgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:36:10 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so504412ota.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 13:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6Q1Z9siWlt75gYyENAulZ+E6jB+huYePgaEmzfAUcs=;
        b=anLbxKCkq4twJco8nMO6LA9dDtWLUW8xuzTqHuyq2S7qx8GgCaIgSIu1+mVzASm0hp
         Zv8s9VHCebErD+983hj5ARy84J0uGjoqExlqloxpMFxLs0mQ6DfsStebBTaQjHpZjv/4
         9mdCrcYyYBaTU9dhw7wlVbaapxE129qoR0/AIEEzozYhtCO+0nvD7bcuT8p4hPLqYHCq
         yWCKGqVpChI3nYHCWAzWQGo0IUR3idIHu05P+h6iYynCu+k+wWdrRMNs9wop6toj1MdM
         zJmeSv4UVH/vipERJ3wMDF0TDCYm3Tx4wVp5C2TcKYbAcFR3JokvIYzgpBhilY2T07YO
         qJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6Q1Z9siWlt75gYyENAulZ+E6jB+huYePgaEmzfAUcs=;
        b=LUvWy6mgRQkzFrCtoAdwABvqMvuAkcPuV+JVezW0Jf+DtPnj5PrssyzXwEWqhKcasG
         CEfoQvBbRNlCO+Xi+5hgBindm1oOGuK4YrTji7qJu6Iak2JS+xk8GSE3ry2cgLuicBOa
         KxXrLs9BsLZVh+xBlJYP6Q3+RbtWxGmJjwRaBHc693vsiuBFuhKCtVJMCno9/eFmcx6t
         WWGpt/g/oXaM+vrjeIlvjnaabfgRaq7goBNgVLqaRx4QyXDlZnCRk1Pu57bd/VrgVORZ
         zugtPdGUzsQjWaDSBbedhEimfqqUfTeeoZq+WLsDzVppf6Fcif6cHvUp320OTlfVxbkl
         Es+w==
X-Gm-Message-State: AJcUukfoMRvj96rp1n4/Usl+U3HMdsX6GxAMigcTqKUxyS729+o+umbU
        5hQqFVoIv983PXRB89INbpFyNvIx3RuxooDwRkLsXVhW
X-Google-Smtp-Source: ALg8bN7sM5lUsMnFtCgg/ctrMEAGuqRlx7k6Ir7v6j19ZiKoSn0zC6FcuSNALADb4aA2aRTqnS0RXhYlQxTbKE1FvW4=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr313672oti.367.1547501769412;
 Mon, 14 Jan 2019 13:36:09 -0800 (PST)
MIME-Version: 1.0
References: <20190109144736.17452-1-pagupta@redhat.com> <20190110012617.GA4205@dastard>
 <1326478078.61913951.1547192704870.JavaMail.zimbra@redhat.com>
 <20190113232902.GD4205@dastard> <20190113233820.GX6310@bombadil.infradead.org>
 <942065073.64011540.1547450140670.JavaMail.zimbra@redhat.com> <20190114212501.GG4205@dastard>
In-Reply-To: <20190114212501.GG4205@dastard>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 14 Jan 2019 13:35:57 -0800
Message-ID: <CAPcyv4jtPcLV-s0sKNHwwk0ug7GLBV6699dpm1h3r2xSo879dg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] kvm "virtio pmem" device
To:     Dave Chinner <david@fromorbit.com>
Cc:     Pankaj Gupta <pagupta@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Kevin Wolf <kwolf@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ross Zwisler <zwisler@kernel.org>,
        vishal l verma <vishal.l.verma@intel.com>,
        dave jiang <dave.jiang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        jmoyer <jmoyer@redhat.com>,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, lcapitulino@redhat.com,
        Igor Mammedov <imammedo@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        adilger kernel <adilger.kernel@dilger.ca>,
        darrick wong <darrick.wong@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 1:25 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Jan 14, 2019 at 02:15:40AM -0500, Pankaj Gupta wrote:
> >
> > > > Until you have images (and hence host page cache) shared between
> > > > multiple guests. People will want to do this, because it means they
> > > > only need a single set of pages in host memory for executable
> > > > binaries rather than a set of pages per guest. Then you have
> > > > multiple guests being able to detect residency of the same set of
> > > > pages. If the guests can then, in any way, control eviction of the
> > > > pages from the host cache, then we have a guest-to-guest information
> > > > leak channel.
> > >
> > > I don't think we should ever be considering something that would allow a
> > > guest to evict page's from the host's pagecache [1].  The guest should
> > > be able to kick its own references to the host's pagecache out of its
> > > own pagecache, but not be able to influence whether the host or another
> > > guest has a read-only mapping cached.
> > >
> > > [1] Unless the guest is allowed to modify the host's file; obviously
> > > truncation, holepunching, etc are going to evict pages from the host's
> > > page cache.
> >
> > This is so correct. Guest does not not evict host page cache pages directly.
>
> They don't right now.
>
> But someone is going to end up asking for discard to work so that
> the guest can free unused space in the underlying spares image (i.e.
> make use of fstrim or mount -o discard) because they have workloads
> that have bursts of space usage and they need to trim the image
> files afterwards to keep their overall space usage under control.
>
> And then....

...we reject / push back on that patch citing the above concern.

> > In case of virtio-pmem & DAX, guest clears guest page cache exceptional entries.
> > Its solely decision of host to take action on the host page cache pages.
> >
> > In case of virtio-pmem, guest does not modify host file directly i.e don't
> > perform hole punch & truncation operation directly on host file.
>
> ... this will no longer be true, and the nuclear landmine in this
> driver interface will have been armed....

I agree with the need to be careful when / if explicit cache control
is added, but that's not the case today.
