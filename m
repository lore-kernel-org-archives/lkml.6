Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5757C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906AD20835
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="YOL18WEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906AD20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeJMXsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 19:48:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38875 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeJMXsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 19:48:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id l1so15139657otj.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 09:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rUm75vsj2T3ZwwUEwJjSXUa/a61Y8S155/Y4IOfsEg=;
        b=YOL18WEIzI48IFjuX+LN0oYP7r/rIK24Le2MOrDJQNVTY6KWL2bKLs1kcSnUdyC9mw
         kfv/zSqV9CoSK2O32AxY53OdqQPLPOe0sGtqzBCCtkZ9/CU+pYbpCIM4k+pNp2A4TDPX
         C/4LjmjsVdhZCXHy+eTASqsKyKKZBB7zjS3xU8kd/n8dG3kK64D4L65HYxuqw1rY/6RA
         OV8Xw1mo9LAIFPQIhgifOGxs8mzC3jL4IfAHC4MXs0/kqT3vyZzAhrqaaFocUs+In0dy
         9hZI4C0v0r6LNMFV1uRf5SZ2Pa+oi1lNQPyOyqD8iOyJSip+t+8YFd0lSb4XKvfh6H3I
         QVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rUm75vsj2T3ZwwUEwJjSXUa/a61Y8S155/Y4IOfsEg=;
        b=jSkt0po3ZiZByVLU89Y1tqNl6RUZuYhA38qF/9J9mLfqIh6AZb/HasBgNVm8oGr0+4
         QMzkdpCxNwxTJUm3Ho37x2mONz8hkPNIW51nKc7CseE9v5Vx8njWEM7O1U8OBP5xpHcA
         3cFvVbcbpgI7qmCwO6/2Zf+d0NiErxBO/Aj9VmEFeeBLCE2YefrCwT6V+R+i6ZxeOFgV
         LdUq4Pa9dKKfO0AupS+b5ro/UAKLksQ0tYJeYWh0mrOYxoUTtUf77Cs0K7MoqMv2gt2r
         KmSgS5oF6GYl9WfEujyt1VQUdGaiZhRkbbfJ8rnms/+N+UDWlxT1B1mL7XhnZ0cErVon
         HzDA==
X-Gm-Message-State: ABuFfoiFcBKcytRIPMATnx3T0yBpqivHkMhvf7rHzje0TxX5iDuHVQrr
        amHOVHILquah4DS0Zom/WqNAS611uUmZVmnDHRwEVw==
X-Google-Smtp-Source: ACcGV61o1EUMByc7H2Mz/Fv5yQKaM5cGIb8m9ocoFDu9s/YrqsrX8V2agWnvH72oUz/bwtZTx7n3C31nMT5J2BWPbF0=
X-Received: by 2002:a9d:256e:: with SMTP id j43mr6779840otd.367.1539447024538;
 Sat, 13 Oct 2018 09:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181013050021.11962-1-pagupta@redhat.com> <20181013050021.11962-3-pagupta@redhat.com>
In-Reply-To: <20181013050021.11962-3-pagupta@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 13 Oct 2018 09:10:13 -0700
Message-ID: <CAPcyv4hroaVWA-HgjWCnr7QTd_y7U8sCvS+Up733ttnD6_cKzQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] virtio-pmem: Add virtio pmem driver
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>, Jan Kara <jack@suse.cz>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Kevin Wolf <kwolf@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, zwisler@kernel.org,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, lcapitulino@redhat.com,
        Igor Mammedov <imammedo@redhat.com>,
        Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:01 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> This patch adds virtio-pmem driver for KVM guest.
>
> Guest reads the persistent memory range information from
> Qemu over VIRTIO and registers it on nvdimm_bus. It also
> creates a nd_region object with the persistent memory
> range information so that existing 'nvdimm/pmem' driver
> can reserve this into system memory map. This way
> 'virtio-pmem' driver uses existing functionality of pmem
> driver to register persistent memory compatible for DAX
> capable filesystems.
>
> This also provides function to perform guest flush over
> VIRTIO from 'pmem' driver when userspace performs flush
> on DAX memory range.

Before we can move forward with this driver we need additional
filesystem enabling to detect when the backing device is fronting DAX
pmem or a paravirtualized page cache through virtio-pmem. Any
interface that requires fsync() and a round trip to the hypervisor to
flush host page cache is not DAX.
