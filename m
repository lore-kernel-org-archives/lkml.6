Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBCDC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033482081F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SMwiI9t1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033482081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbeLKAKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:10:44 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38672 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeLKAKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:10:44 -0500
Received: by mail-oi1-f194.google.com with SMTP id a77so10583255oii.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 16:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=yi1VF96O/q8BCikgm25lag/fmoX6JrFGqfib6kD7cMo=;
        b=SMwiI9t1szhtExZ4zKZzTD2Xqq8bjMi8Ht4SZDzQC8L17IrgIDSRQWAZn4Maf+5D3e
         AmS8nDPTGpBoEyA5uyzbGgQGarVOGRzxMAi8nJKO56Yno1mx6JHll3xtNDZ8NDMz+gZe
         8A5lZ9WXfvbykOp2DCHCEseD2lKFgw7FLXEIekcSXqEgmMTpWgstajDqicyhpdL3/lBr
         MofVO/cz1rbKVoIjkftwOfM5ptIW17YX+IbPKJxmfYUTNjOuUV5yyF1UC88sWzdHYIlC
         REuV+/iI75QL0Ml08Nk+TFtIstSE9tGdrP3D2BYzbadhzxSi2yzivL3oDXb73pwDbJ9R
         oEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=yi1VF96O/q8BCikgm25lag/fmoX6JrFGqfib6kD7cMo=;
        b=b2/9mN9sV/WU5dkL1SMI8ik4xWZG1K/MIPJeGmksfgJ9+51H0irhCVfsnn6ttm6eC3
         Mjk//Ae34nlXB51SB9I7g+5ZUCXyTQtBJPwR8Qu4sh63BhXCCPDkimZoXBsvp7ah+R//
         XkWMbfrpsNChO1yKOpxIIGMqZrUPkWzQEyqmM7XubOOQ4oqT5X1ASsruS2z5rsSjJl1o
         +k9ajXYVs4l7Vsrrj0l933VQnWaTOp8snSoGSlJQ4XGMC4pzhqHZK2tm2ACVA99TLHsq
         8MqN//V3NQvuea+b48bzlEGB2hGrIPBMmUkwHqkBHa7B/E6jdauyPyR8q4l0tOJMgKE4
         UbGA==
X-Gm-Message-State: AA+aEWa8yWeUeQ0yBodCqf9ou3mO3rT1GbbywDQTlcg7JW6RG7DOyLfD
        nd1xbw0dxy2qgUufHqxZktH2gNbu+Ob93vSoYh/ImA==
X-Google-Smtp-Source: AFSGD/U9fkviS0WqQTaJiACbHQOcSpOVSimdAl9DgNHDHCZZGzBjUp0IDAt7q/57xoa3TB10jaUStuEpZC81NX7byWc=
X-Received: by 2002:aca:d905:: with SMTP id q5mr119976oig.0.1544487043418;
 Mon, 10 Dec 2018 16:10:43 -0800 (PST)
MIME-Version: 1.0
References: <46441800c43f029757c70d8386e3112701081503.1534160958.git.yi.z.zhang@linux.intel.com>
 <1534787638.13739.52.camel@intel.com> <89e7bd54-4afa-614d-ec54-49af7928d6c7@intel.com>
 <20180821161657.GA22028@tiger-server>
In-Reply-To: <20180821161657.GA22028@tiger-server>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 10 Dec 2018 16:10:31 -0800
Message-ID: <CAPcyv4gZ8WBhUZkoUd1m6bCrtKW0EmfWfCtpGULvjfM=yJ9_sg@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] device-dax: check for vma range while dax_mmap.
To:     Dave Jiang <dave.jiang@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, zwisler@kernel.org,
        Jan Kara <jack@suse.cz>, "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 12:38 AM Yi Zhang <yi.z.zhang@linux.intel.com> wrote:
>
> On 2018-08-20 at 12:50:31 -0700, Dave Jiang wrote:
> >
> >
> > On 08/20/2018 10:53 AM, Verma, Vishal L wrote:
> > >
> > > On Mon, 2018-08-13 at 20:02 +0800, Zhang Yi wrote:
> > >> This patch prevents a user mapping an illegal vma range that is larger
> > >> than a dax device physical resource.
> > >>
> > >> When qemu maps the dax device for virtual nvdimm's backend device, the
> > >> v-nvdimm label area is defined at the end of mapped range. By using an
> > >> illegal size that exceeds the range of the device dax, it will trigger a
> > >> fault with qemu.
> > >>
> > >> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> > >> ---
> > >>  drivers/dax/device.c | 29 +++++++++++++++++++++++++++++
> > >>  1 file changed, 29 insertions(+)
> > >>
> > >
> > > Looks good to me:
> > > Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> >
> > Applied.
> Thanks Dava and Vishal's kindly review. Thank you.

So, it turns out this patch did not get merged for 4.20. I fumbled it
when returning from vacation. However, I'm not sure it is needed. As
long as attempts to access the out-of-range capacity results in SIGBUS
then the implementation is correct. This is similar to the case where
a file is truncated after the vma is established. That size is
validated at fault time.

Could you be clearer about why this is a problem? The fault sounds
like the correct result.
