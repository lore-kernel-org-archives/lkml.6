Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88617C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EA5206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ZwK21aCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfAIRCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:02:20 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44532 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfAIRCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:02:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so6843635oig.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 09:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7sNnDMFw4VIZsLXOrJLZvpnECNNbNnsIn5HyYP9TH8=;
        b=ZwK21aCKJy3sN9O9+FB6O5TtQVui4KsvCS4DIJr1cIH02xEhwhaUlQNfNK+40SK0co
         sAJCljM+wAQozgzPqPr9ByJDneqCHGL28A4qVs15kmX272rrqHAr4fVVFCC0jHVZATr2
         jYibFBr2R8Cq58bn3DMHlYF1kfWhRhr9t5DVksJuRdnJm1T/1ZRMT7nlTfDbIe7K89FT
         rfghw8w1Uwx3+RbHwZT9VzfcozyWnkaMNjTh7xyaFgfRpOkZYj+BYqfImpJ5gYrBfoq6
         mKpMgS5f29My91FxV+MxlEuIMMnYepvn3UlDGgqLXa6Tlu4QLrS0aK5oVkkNaT+6xSQu
         j7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7sNnDMFw4VIZsLXOrJLZvpnECNNbNnsIn5HyYP9TH8=;
        b=W1vJukXlJpyUISzm1g8Dfty9trFSiW+mHHLR/spF6RowN9CywI6W2vqnOmirPbcvlN
         7dkE0ZWl7anAGCWIF09uSB5RqZUnYbk7AN8fWES63Fiu3CyAqsSwBDcs7O8+B0OQFRgb
         OQ+EhwW2sJB9WBNNtphTStt4sJFdyWlkv7yrZOxH5N2sgvH6zDQv8M2uLr5oUwGnjgj4
         zMT1NHxCvcGo5mHUkCsjrWdAb3wpc8926HWLjiqUE4fl6dfyIi/wvjSyWpTLo4nWB5pH
         /wBJEDUzaGSKsxx/n9yRtX6PrL6LtvAUdkmM7KMkL16qlQkXFQDdvJBvWQhTUOcWtPDw
         21Zw==
X-Gm-Message-State: AJcUukfT3QBCelaxVAIfa+1Xy+pwMrUdbDfETn76GpTCThOJRXGzVifn
        LNHeNAunT2mk9FYCFc5Ec31rw/mr360kqOX/iWdDdg==
X-Google-Smtp-Source: ALg8bN6jkVl85oaGqiV7CChhOFhFQSoHqe5tntafGRsV8hP4Qzz+Qk3qEtDA5yB3Y6rhbWpDYkKGT9EwwnKnNKu/KWg=
X-Received: by 2002:aca:f4c2:: with SMTP id s185mr4547835oih.244.1547053338706;
 Wed, 09 Jan 2019 09:02:18 -0800 (PST)
MIME-Version: 1.0
References: <20190109135024.14093-1-pagupta@redhat.com> <20190109135024.14093-4-pagupta@redhat.com>
In-Reply-To: <20190109135024.14093-4-pagupta@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Jan 2019 09:02:07 -0800
Message-ID: <CAPcyv4jsa709BVPAx_BT5eFrODf-PUPOZ4aguDsjZVawVXTVHQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] libnvdimm: add nd_region buffered dax_dev flag
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        jmoyer <jmoyer@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, lcapitulino@redhat.com,
        Igor Mammedov <imammedo@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 5:53 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> This patch adds 'DAXDEV_BUFFERED' flag which is set
> for virtio pmem corresponding nd_region. This later
> is used to disable MAP_SYNC functionality for ext4
> & xfs filesystem.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  drivers/dax/super.c          | 17 +++++++++++++++++
>  drivers/nvdimm/pmem.c        |  3 +++
>  drivers/nvdimm/region_devs.c |  7 +++++++
>  drivers/virtio/pmem.c        |  1 +
>  include/linux/dax.h          |  9 +++++++++
>  include/linux/libnvdimm.h    |  6 ++++++
>  6 files changed, 43 insertions(+)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 6e928f3..9128740 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -167,6 +167,8 @@ enum dax_device_flags {
>         DAXDEV_ALIVE,
>         /* gate whether dax_flush() calls the low level flush routine */
>         DAXDEV_WRITE_CACHE,
> +       /* flag to disable MAP_SYNC for virtio based host page cache flush */
> +       DAXDEV_BUFFERED,
>  };
>
>  /**
> @@ -335,6 +337,21 @@ bool dax_write_cache_enabled(struct dax_device *dax_dev)
>  }
>  EXPORT_SYMBOL_GPL(dax_write_cache_enabled);
>
> +void virtio_pmem_host_cache(struct dax_device *dax_dev, bool wc)
> +{
> +       if (wc)
> +               set_bit(DAXDEV_BUFFERED, &dax_dev->flags);
> +       else
> +               clear_bit(DAXDEV_BUFFERED, &dax_dev->flags);
> +}
> +EXPORT_SYMBOL_GPL(virtio_pmem_host_cache);

The "write_cache" property was structured this way because it can
conceivably change at runtime. The MAP_SYNC capability should be
static and never changed after init.

> +bool virtio_pmem_host_cache_enabled(struct dax_device *dax_dev)
> +{
> +       return test_bit(DAXDEV_BUFFERED, &dax_dev->flags);
> +}
> +EXPORT_SYMBOL_GPL(virtio_pmem_host_cache_enabled);

Echoing Darrick and Jan this is should be a generic property of a
dax_device and not specific to virtio. I don't like the "buffered"
designation as that's not accurate. There may be hardware reasons why
a dax_device is not synchronous, like a requirement to flush a
write-pending queue or otherwise notify the device of new writes.

I would just have a dax_synchronous() helper and a DAXDEV_SYNC flag. I
would also modify alloc_dax() to take a flags argument so that the
capability can be instantiated when the dax_device is allocated.
