Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AC6ECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FC32150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="TAEPYJku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FC32150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732719AbeITEH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:07:27 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43099 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeITEH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:07:27 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so6561644oib.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGMQku/mSf/wlwCn7dSOXgEkc1lf1Qq67PJwNZrg7dk=;
        b=TAEPYJkunp+z1Wo7Vi84X5OEIbkdbDCf9qbroz69oJno6DvrEQPfxhws6xk9N2+3FP
         ibyYbpPOSjz/1aNHvPrkgfW1r2/FOoLBl0cTEXanxZpTbq58nCs7Fo3ESVYY0+TLrmw8
         aLh/kF4ek1Adv4AbLQodDdsKMUHDdCHpur7FTcRYIyTneorKzr5yhy9e9bz7IB2Nhq3y
         IkYD+XNYkraxFdKPcQqRTmiBntJe6Sm9rcMGUlTY/J9DFJyQbhd2llsLq6Y51YOoUrij
         UFdWaagYTQERaAiM6+sgmnWt4s+gL7uVluexVcwAKQMiqbk4gyBZ8ZVFmfH7LHWljUVm
         MgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGMQku/mSf/wlwCn7dSOXgEkc1lf1Qq67PJwNZrg7dk=;
        b=TugjkaEq0fWKq32o9gDhAm3BJsOdsghqYlNo49eCVZIyVTpTkb3Sg7CVfbqkdqlSvd
         T+4wkjj1H/+S/AUkFPloMedW1MpGtyFthpfqjKKMHKAzQJ0nI6vwkyp2Y0No5J7ZUPXc
         g0zuG038x0GmwHt1eutpzDwe3Ojo/XCg4T7PQONV5Ftl0BsdIx8uuzCXyByoY1eNTpPI
         12sfOV6GVQ6P5rDBOeqLw9KIHVDVUoYeaI0QRVzguynZYo4bhHK+enY/9RqHY8gXy4hF
         AcF7v5Y6DxiYFXYY6xB27K9m4vMVoWDGa5Xx/BERnI08sDf4r0hdOZ95RAEslCzQPNjI
         mEpg==
X-Gm-Message-State: APzg51Cer4l0a2qIQdLcQHtVfoAb+M5V1XeNoiBlUBiXNs+BiYbFYjhh
        VMC+aw4WD8FWy7+WfF/tz5yA5dJaFIv4lkMN/p13lA==
X-Google-Smtp-Source: ANB0VdZ8J4ZfkBK1JYHlWIJdmEH+mGrqmJes73hYFnKH3HjXt+/5nCuK9rPs2NkN49U/PaiRw/b+6LM+LnF/EFtEmNc=
X-Received: by 2002:aca:e504:: with SMTP id c4-v6mr2776122oih.246.1537396044382;
 Wed, 19 Sep 2018 15:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180919210250.28858-1-keith.busch@intel.com> <40b392d0-0642-2d9b-5325-664a328ff677@intel.com>
In-Reply-To: <40b392d0-0642-2d9b-5325-664a328ff677@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 Sep 2018 15:27:13 -0700
Message-ID: <CAPcyv4iVpKD=yLS=YM18+_LGQp3_y+h4Cx4s3Bc9gHmdRrimAg@mail.gmail.com>
Subject: Re: [PATCH 0/7] mm: faster get user pages
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Keith Busch <keith.busch@intel.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 2:15 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 09/19/2018 02:02 PM, Keith Busch wrote:
> > Pinning user pages out of nvdimm dax memory is significantly slower
> > compared to system ram. Analysis points to software overhead incurred
> > from a radix tree lookup. This patch series fixes that by removing the
> > relatively costly dev_pagemap lookup that was repeated for each page,
> > significantly increasing gup time.
>
> Could you also remind us why DAX pages are such special snowflakes and
> *require* radix tree lookups in the first place?

They are special because they need to check backing device live-ness
when taking new references. We manage a percpu-ref for each device
that registers physical memory with devm_memremap_pages(). When that
device is disabled we kill the percpu-ref to block new references
being taken, and then wait for existing references to drain. This
allows for disabling persistent-memory namepace-devices at will
relative to new get_user_pages() requests.
