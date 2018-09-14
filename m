Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08053FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DEB20833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="kadeIvz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DEB20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbeINWkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:40:37 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41414 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbeINWkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:40:36 -0400
Received: by mail-ot1-f68.google.com with SMTP id e18-v6so5305958oti.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=phi8I026HDVxLHHCe6d5uSXFF9kD41eK8OzyWTqmjpI=;
        b=kadeIvz6HAGVWB035dR/YYXf02lgGfDxn9lyuGLjRsLDtr8hMvrtkCrVDU5sz1yiIH
         rLNydHfjXeZyt0plr4GFWswGoKAPEhKO5qbh1EfWJreXtfGeBxhc2/x7uNzGzgemagQB
         9mjRGIH+tNBFGPLRaj1KAMgnV3Cp1ONlmdyb8KSvBRx0QaLt+QVXmHiuat9sNTpvT06t
         kGIF6SSO/O6wyL981MiBeIKqHKn/umWlsAkAUk+SvETTXYZ9ZOB5XVGQaF279Wycuofu
         igy6RvKf2XoPCB8CfWgKMIIkUS8DBF14l/Lo99nHn09vRYC26QRGG8d/sXAQ+ZEaBpZ6
         uJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=phi8I026HDVxLHHCe6d5uSXFF9kD41eK8OzyWTqmjpI=;
        b=nVPkDsmzqAqHS1fqaem3ADEBROPVrCFH1pIPzUeJLhmFcOoHfSDWcoYGuhrzoE0AIN
         sQSsR42Ye4rtrdf6sMI0OktfkLENyk4TC/fygiR6BGb33bJAEqHmTFhJPbACq9z/hGBn
         /CYJ4D9mjg6ZpP0uWg4mbN1ZBb02gsZC6fICYFyUbHWgk4S20c/mXoGx0jaedJkeSdxq
         uhdyF70zOrEzCOCAzpUCYSO43s/CvO/EQAACBatYpQK0hOOKmc/JAq1E/mhIFy4CA1C6
         52GDwfGrb4aIuMhzyo1xQpmGQjV9Qr7kbhOIkrXfyyf405x6sUPMpLSb/+zUpo6hrSh4
         7NnQ==
X-Gm-Message-State: APzg51CwkopAK3sGJJjJ7nP4cJslNZhr5pLRZ/nWZ2xw2AGaHlgbJZG2
        ZGX0jP5G8KHJ7N1ealBm2GqgY+vvUQKRQAqNYatgHw==
X-Google-Smtp-Source: ANB0VdYv2Y2zasXsj9soyPha3M4METzLlIdQiCBB0YFTkrcVnI2+D1oJl6+wsjhTA+989MpxOeawCcF30Kii6/DZpP8=
X-Received: by 2002:a9d:d7:: with SMTP id 23-v6mr4770359otk.372.1536945909514;
 Fri, 14 Sep 2018 10:25:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8e85:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 10:25:09
 -0700 (PDT)
In-Reply-To: <20180914131618.GD27141@lst.de>
References: <153680531988.453305.8080706591516037706.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153680533706.453305.3428304103990941022.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180914131618.GD27141@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 14 Sep 2018 10:25:09 -0700
Message-ID: <CAPcyv4jTOYjeG4eJd+XR9dzQGb2f_rdn1Knb7V=AMgokzC0M7Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] mm, devm_memremap_pages: Fix shutdown handling
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 6:16 AM, Christoph Hellwig <hch@lst.de> wrote:
>> An argument could be made to require that the ->kill() operation be set
>> in the @pgmap arg rather than passed in separately. However, it helps
>> code readability, tracking the lifetime of a given instance, to be able
>> to grep the kill routine directly at the devm_memremap_pages() call
>> site.
>
> I generally do not like passing redundant argument, and I don't really
> see why this case is different.  Or in other ways I'd like to make
> your above argument..

Logan had similar feedback, and now the chorus is getting louder. I
personally like how I can do this with grep:

drivers/dax/pmem.c:114: addr = devm_memremap_pages(dev,
&dax_pmem->pgmap, dax_pmem_percpu_kill);
--
drivers/nvdimm/pmem.c:411:              addr =
devm_memremap_pages(dev, &pmem->pgmap,
drivers/nvdimm/pmem.c-412-                              pmem_freeze_queue);
--
drivers/nvdimm/pmem.c:425:              addr =
devm_memremap_pages(dev, &pmem->pgmap,
drivers/nvdimm/pmem.c-426-                              pmem_freeze_queue);
--
mm/hmm.c:1059:  result = devm_memremap_pages(devmem->device, &devmem->pagemap,
mm/hmm.c-1060-                  hmm_devmem_ref_kill);
--
mm/hmm.c:1113:  result = devm_memremap_pages(devmem->device, &devmem->pagemap,
mm/hmm.c-1114-                  hmm_devmem_ref_kill);

...and see all of the kill() variants, but the redundancy will likely
continue to bother folks.

> Except for that the patch looks good to me.

Thanks, I'll fix it up to drop the redundant arg.
