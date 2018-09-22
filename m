Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062D5ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AB12156E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="cbjiuR6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AB12156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391740AbeIVGip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:38:45 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43081 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbeIVGip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:38:45 -0400
Received: by mail-ot1-f68.google.com with SMTP id e21-v6so1995039otk.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 17:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=thMTjBYg+6WKqkYaoBm2zaWnrXuykg/WL3BhAPijcYA=;
        b=cbjiuR6un8rT2QPtyvSgzjYrd5VxLQV1HelP79xTBohZuG2iHkdbabKyXAC3uVZDxj
         XKDrYhdxdzP27SP8o9CUceQwB7gH9G/LJuYOqX48bMI8XPhm4/sbg7d5V2Fx/xqpgIBC
         etyyFYsUaS8DIS8oJMSCtw+uiGnMsC1BXBwoOg6v0V+5MwaDvUp3BJ2IhD+wkGpUVU67
         rUfKuHVId+5Od2qjCFlSthyoPc0HnjNpZ66XZx5uR9knM8XVpnM32uK5RDMXfeDF8mTR
         J6cgIMLp+Mr6Cj3OFNk9fu2jYKHsvruEJ8K8DI8Zg4Jiryi9xp8rSsgTbvswWhBmPtzp
         LNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=thMTjBYg+6WKqkYaoBm2zaWnrXuykg/WL3BhAPijcYA=;
        b=t4XifJF7c7gwg00TP7arPQ4apa+V0nCd4jTER0GM7Ptx93aI7ietEuHNEZA/wwQfsa
         yxgEkZOlOHQ26xCGiKL/nY+DcpGCHw/pIfkSKExbcRZN1PO50A4V9vztjqevcVhsiwip
         FGEns7rdXKqp8ubGG4I2gvIzP0lDRVe04FsV+3r4WeQpC7B0GzM07y3Cr6K5s54XBkiF
         UefieSxVumqBWuQ/29Sh8mdYFU1G6wD6VLSdlajF+oZym/sp+TpkLG+W7GKfBPhC2pYH
         N5y8YczXaHl2eX/IsBJX3hTFvvHXsEQe+RoEwRP+iF4jtOoY6SJrPFA5QFAU2z0vOJRJ
         uIXg==
X-Gm-Message-State: ABuFfoh6/3aXcHaMb/3xAuj1s/Pvzs9GyGEP8SgOmOlj0j2aH64joHGF
        yXkdbp+iXvzcR3H3+S+3oxjknhR+tv8odOiigKD+hg==
X-Google-Smtp-Source: ACcGV60j+6Cj9Wji94HEqK+WmFqAuGlqVN0MJObLbhzffa58BVayLBNgIN4p9Ni2JyV3ezOaf82IqAez98h4E/9mIQM=
X-Received: by 2002:a9d:7519:: with SMTP id r25-v6mr149182otk.73.1537577241614;
 Fri, 21 Sep 2018 17:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180831133019.27579-1-pagupta@redhat.com> <20180831133019.27579-2-pagupta@redhat.com>
In-Reply-To: <20180831133019.27579-2-pagupta@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 Sep 2018 17:47:10 -0700
Message-ID: <CAPcyv4jFimkVnVuzza5TCG=KvY88KZnXzH4GNEgUBbTouprzJA@mail.gmail.com>
Subject: Re: [PATCH 1/3] nd: move nd_region to common header
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>, Jan Kara <jack@suse.cz>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Kevin Wolf <kwolf@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Zwisler, Ross" <ross.zwisler@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        niteshnarayanlal@hotmail.com, lcapitulino@redhat.com,
        Igor Mammedov <imammedo@redhat.com>,
        Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 6:31 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> This patch moves nd_region definition to common header
> include/linux/nd.h file. This is required for flush callback
> support for both virtio-pmem & pmem driver.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  drivers/nvdimm/nd.h | 39 ---------------------------------------
>  include/linux/nd.h  | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 39 deletions(-)

No, we need to find a way to do this without dumping all of these
internal details to a public / global header.
