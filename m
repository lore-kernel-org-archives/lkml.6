Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0D4C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0AD24076
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="E6qQ/USs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0AD24076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754177AbeGETwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 15:52:10 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40805 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753828AbeGETwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 15:52:08 -0400
Received: by mail-oi0-f68.google.com with SMTP id w126-v6so19148035oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 12:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZQhz6+odNFNPJ7fo3CIkIRrMCRrU7IxUcR5cgf4FM54=;
        b=E6qQ/USsNTmiY2wAMr6z+k0Vgv7HjFxEmfZq/xz+eMuN67FHUj1O9vcKi0K/Ln11ZG
         ndrqHvSuwdorOvtWDwm7zQKvI52mFpgIl6ddlea23wWxsUlow49JhipsmaO/NU7efW2j
         9f1AuJ32eDPBtgaebakoTXZnDetZVpBFXwk71FbHyKpUc/0LrODju3K1e+Hc9v/GfqLe
         zKpctXQ21IzTqZrfh7YBW6wbS+Qh8N3YOX/TCj1STP+UkM6HHctxDCO0N5P1WOISwzsV
         afTpukBVAkxRUUDTIcKcnUvVibyM8pXATpHr/O45BGdp1WkD/Ux9h6RvKQlikkGGv2LP
         /InQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZQhz6+odNFNPJ7fo3CIkIRrMCRrU7IxUcR5cgf4FM54=;
        b=EBNL72qCOuV/XP1tQMGbu8Tbv1K3jvfS/W5r40B6Py2QNRds8bTDeclegf5ozXSfVP
         4TRZZiWS0l0M7VSVGBYUW5HOImMuU8gYbcR47DOET3Gc1I8dxjFZvFYrTiV5SUwXJoyD
         QIMn4Crw0NZeTCgEcGDf9KoVjvPGEdMyUYIYSsg77du7ApoHVtVx+nDWeGzl4nu7dl+E
         jTTZIYfP6ICcOMLQNvaHA+PhFLAPi4lC+W6ap189J7paN567xnS/g6LWA4c2HdCOAWfF
         DPifRUc3CFI2gMwlacdA2cNm1vuonlvyaSWaqpo3q2JAcquGeK/GYLG0pmzffHouCk9Q
         k2Tg==
X-Gm-Message-State: APt69E33PjKzGcxTQT1JXAAP5jWx/vDo2FYIzXUo4ZB17nkSOMn1oGSO
        wNoYHapS+rIGmNM++qza0IWWdJQcWUUVaaub70gyjw==
X-Google-Smtp-Source: AAOMgpfkAzaWTSi4hj8fjOIYSwDSXK5dd66zUhHY3rn0q04XXYQ9T+ycL7Jj49yjyUO3hpAnzObiYB2D+Wcc8Mc2qqs=
X-Received: by 2002:aca:a993:: with SMTP id s141-v6mr8614481oie.72.1530820328425;
 Thu, 05 Jul 2018 12:52:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 12:52:07 -0700 (PDT)
In-Reply-To: <20180705194936.GA28447@bombadil.infradead.org>
References: <153077334130.40830.2714147692560185329.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153077341292.40830.11333232703318633087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180705082931.echvdqipgvwhghf2@linux-x5ow.site> <CAPcyv4h1L6ZMCqWXhWD_ZJ=sH7SVzuUGMG2Ln=6Cy6sR4S=VUw@mail.gmail.com>
 <20180705194936.GA28447@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 5 Jul 2018 12:52:07 -0700
Message-ID: <CAPcyv4jHG9jCWz_hVc8DPxxALQ2JyD=AJKuYn6-ZMhB_fot1-Q@mail.gmail.com>
Subject: Re: [PATCH 13/13] libnvdimm, namespace: Publish page structure init
 state / control
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 12:49 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Thu, Jul 05, 2018 at 07:46:05AM -0700, Dan Williams wrote:
>> On Thu, Jul 5, 2018 at 1:29 AM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
>> > On Wed, Jul 04, 2018 at 11:50:13PM -0700, Dan Williams wrote:
>> >> +static ssize_t memmap_state_store(struct device *dev,
>> >> +             struct device_attribute *attr, const char *buf, size_t len)
>> >> +{
>> >> +     int i;
>> >> +     struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
>> >> +     struct memmap_async_state *async = &nd_pfn->async;
>> >> +
>> >> +     if (strcmp(buf, "sync") == 0)
>> >> +             /* pass */;
>> >> +     else if (strcmp(buf, "sync\n") == 0)
>> >> +             /* pass */;
>> >> +     else
>> >> +             return -EINVAL;
>> >
>> > Hmm what about:
>> >
>> >         if (strncmp(buf, "sync", 4))
>> >            return -EINVAL;
>> >
>> > This collapses 6 lines into 4.
>>
>> ...but that also allows 'echo "syncAndThenSomeGarbage" >
>> /sys/.../memmap_state' to succeed.
>
>         if (strncmp(buf, "sync", 4))
>                 return -EINVAL;
>         if (buf[4] != '\0' && buf[4] != '\n')
>                 return -EINVAL;
>

Not sure that's a win either, I'd rather just:

+       if (strcmp(buf, "sync") == 0 || strcmp(buf, "sync\n") == 0)
+               /* pass */;
+       else
+               return -EINVAL;

If we're trying to save those 2 lines.
