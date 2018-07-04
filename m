Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC311C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873C023E3C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="gD5axOLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873C023E3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeGDOll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:41:41 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42500 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbeGDOlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:41:37 -0400
Received: by mail-oi0-f67.google.com with SMTP id n84-v6so11135507oib.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q8ouDihyCU9MNCD5pE+nKQzrxYMCthzPdo4QzPUmiEM=;
        b=gD5axOLp4HKMNaIPFrR9bQVNxtFAcQ9X7YBsgGGOgruOQcbWWH6bCAsZJPdKAuzm+e
         iq/5zWSQ4YXBfUaU3nox5HAhf5/9EkWoC/59cgXktVHuUMMo4AI4zPPSi24dUIojsopC
         L6q2HIU1v4w7K2KsCdrG42Pr+giGFs0NL3RKdejaC/wnZfHrYt+y0yvHwaVyS6f5puT7
         w6rAFledA3CvzYZavZ3DgIx1HuqqCaaXq4JaKVpvjlBY/x3PKn+N1WMTV+zOlXruOj01
         1MyDTPTXzTNihCoxkV2+i2Lp+y8wUT5o0Je7jXuHQnj0OI7v8vSBto0bQGVUxQBJ1SU5
         NlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q8ouDihyCU9MNCD5pE+nKQzrxYMCthzPdo4QzPUmiEM=;
        b=MwYEh96IiIjNNs/quymOTBjv3AExz3XN6uggeb8amama41Q3NmaMU16z1BMOcKKvXl
         f1Ez1+QhygHkQzhjO0o2dbE8ngLslRe76smnjpdfRDRr1TyTB3JBTxhwELPz5Zl8yfBQ
         2klV4rUPMCLGhkYuea4XzLBPYoIIaN0TiBbxsOy5Ln+TlNghLO47pVDAZr/0WYRWPIWM
         Vuv15e6FgOkG8Az2PlcrAjwbObdaoMLkZNIyobTvH82/xiD8D/tuJ2jUM8Yd182AAVs0
         +xaHj2IxPLDJjvB60HxlcKAq3/R7NOj+JjQqYo//ZGEmvr5WqbVYJLdX+hg9fsOZZIvo
         9WvQ==
X-Gm-Message-State: APt69E37W/FOq3B6lIgNsyjtjgBDhur7i1KkXUziHiNmrIDqOUFYoCl8
        2IXC493pYN0QuvKy4pbq2rez9hFnj6XMgkMwXih07A==
X-Google-Smtp-Source: AAOMgpf2UzyjibaLGq+cOWAGptGjwSQ2HdFbUZUhjOa9fCnSpV+gY0CeWVqqdJMlpkShnwljQoTOIqtsDdq6GFSfdig=
X-Received: by 2002:aca:3954:: with SMTP id g81-v6mr2701831oia.215.1530715297337;
 Wed, 04 Jul 2018 07:41:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 07:41:36 -0700 (PDT)
In-Reply-To: <CAPcyv4hPEch02C7UfCGgpXmsCVyT2zwV=4Tr8jv8W1i6_poAJQ@mail.gmail.com>
References: <20180704064058.1344-1-yehs2007@zoho.com> <20180704064058.1344-3-yehs2007@zoho.com>
 <20180704113012.trnfzeefao25clri@quack2.suse.cz> <1646567c191.ed8ea5b817045.8715756414911693238@zoho.com>
 <CAPcyv4hPEch02C7UfCGgpXmsCVyT2zwV=4Tr8jv8W1i6_poAJQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 4 Jul 2018 07:41:36 -0700
Message-ID: <CAPcyv4hxx9JjJZGRTg1NHgN9k0Brwj5yozSWMuNCKBi88wKQWw@mail.gmail.com>
Subject: Re: [PATCH 3/3] fs/dax: Assigning NULL to gfn of dax_direct_access if useless
To:     Huaisheng Ye <yehs2007@zoho.com>
Cc:     Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jan Kara <jack@suse.com>, NingTing Cheng <chengnt@lenovo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Huaisheng Ye <yehs1@lenovo.com>, colyli <colyli@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 7:37 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Wed, Jul 4, 2018 at 6:07 AM, Huaisheng Ye <yehs2007@zoho.com> wrote:
>>  ---- On Wed, 04 Jul 2018 19:30:12 +0800 Jan Kara <jack@suse.cz> wrote ----
>>  > On Wed 04-07-18 14:40:58, Huaisheng Ye wrote:
>>  > > From: Huaisheng Ye <yehs1@lenovo.com>
>>  > >
>>  > > Some functions within fs/dax don't need to get gfn from direct_access.
>>  > > Assigning NULL to gfn of dax_direct_access is more intuitive and simple
>>  > > than offering a useless local variable.
>>  > >
>>  > > Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
>>  >
>>  > I like this. You can add:
>>  >
>>  > Reviewed-by: Jan Kara <jack@suse.cz>
>>  >
>>  > for the series.
>>  >
>>  >                                 Honza
>>  >
>> I am so happy you like them, thank you very much.
>
> Yes, I like this too. In fact I have a similar patch in my tree
> already that I have been preparing to send out. I am using it to delay
> when we need to have the 'struct page' memmap for dax initialized.
> Attached is the full patch, but the series is still a work in
> progress.

Btw, I'll drop my version and apply your series since you got it
posted first and it can stand alone as its own cleanup.
