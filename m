Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14784C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2ED8240CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SrQ7VCZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2ED8240CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeGDQso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:48:44 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35185 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeGDQsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:48:41 -0400
Received: by mail-oi0-f66.google.com with SMTP id i12-v6so11838714oik.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 09:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UO4TqdHc0KesOVBbzOdRbn/byUiBL6qA1beasYR8aeQ=;
        b=SrQ7VCZ3MFGvIJigUvJ0CY44Edj8QaKWvjRIwBZnSf439sjBLP1eIJRTXbfQ9AVOMt
         w1XHOTu0BrtxAfKCARvh5fN6gKe3+TwMHC6vQNkYo62SG7mk9BKhZbfsBhCJV1uFMwpz
         cHhlovOg5Tlb++Jiy0Kedgm01yqL2hSyKa3391B36QzHZiMVpYMDjPgAAX/8NoMfyPpC
         +gLKBivGdwrGptiwGykQwLUdU4StKzNiTobYOhjWrDdjg4X80vSKr2UMcd6+6isA9SV9
         oFwQ5IlSDx7e2LvW44ax7mL+2Me3UVwJtsXVkaU73WWNXkpVAFuAJST1htvBx4VIZ8QT
         zynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UO4TqdHc0KesOVBbzOdRbn/byUiBL6qA1beasYR8aeQ=;
        b=MdesKvMlHfmw5xPgmDASbal68PlXLvxtqPhIpnjPFpiVwXtbYjeYWy/MLCn+ZifrsK
         B8C+/da3/MxzGPOwyP8XhNYpcRjcHRLKVXrZrmgqoy1pVNQCbFEb1ALySHu2ev5bFKHO
         yPPfVO93iyPBWFOAM8hsSwwSrz1LYkSQ5XHJrkEFqunM6yaBo8A4sGMojhTjNAW6+wcz
         2zaPguSOs0mo6jCkCdpU2sCDm0u6yoBkZKSNtHWyspHacm9otdLhu2YUBeYUXn7Gt8NP
         HEfPru/tu9JRlfpe0wgixzB9daGDzI4QHOAXQ/mtXS11dfLrx99z5JNieWWzoGqmZZZ1
         Il5Q==
X-Gm-Message-State: APt69E3bXww7Y61Ze0ekQHXUJ8KUllwfshZ0C/rrOxZhBnCmhRbIDBKm
        BqPrBeeAn9XbPZmkEfHBB1MObiQXyfCto049i4VP7w==
X-Google-Smtp-Source: AAOMgpcs5uC4Ru+9uyoJMLdbK6FzhXLYIzm8PoL6q2PIslwrCi55dvU1kFa2WjCDRbrlHqw5A78vhNH9cYVewatLXRk=
X-Received: by 2002:aca:3954:: with SMTP id g81-v6mr3208501oia.215.1530722921386;
 Wed, 04 Jul 2018 09:48:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 09:48:40 -0700 (PDT)
In-Reply-To: <20180704163823.9980-1-yehs2007@zoho.com>
References: <20180704163823.9980-1-yehs2007@zoho.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 4 Jul 2018 09:48:40 -0700
Message-ID: <CAPcyv4hgk89NKGhmZ1Z3XsGFzJAn1y+46WJn_61r8rj5bmqv6A@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Assigning NULL to gfn of dax_direct_access if useless
To:     Huaisheng Ye <yehs2007@zoho.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        colyli <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        Huaisheng Ye <yehs1@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 9:38 AM, Huaisheng Ye <yehs2007@zoho.com> wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
>
> Changes since v1 [1]:
> * Collect Jan's reviewed-by.
> * According to Dan's suggestion, update the unit test infrastructure
>   tools/testing/nvdimm/pmem-dax.c for checking the validity of gfn.
>
> [1]: https://lkml.org/lkml/2018/7/4/81
>
> ---
>
> Some functions within fs/dax don't need to get gfn from direct_access.

Any reason you are calling it 'gfn'? I'm assuming that is a typo and
it should be 'pfn'.
