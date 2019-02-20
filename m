Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACFCC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B3F2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="NOZh/E/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfBTQPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:15:48 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46053 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfBTQPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:15:47 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so40968764ota.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 08:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPE9MdTOQQF/riTAULLmWZCcqgCHbenu251Uz8XsTdA=;
        b=NOZh/E/YCVr7fXjTD+7SiNl5H+znaUgQAAQXXEPbo/X/05nfDfYHUmI970Ay0kqmer
         ofhWL58a62JWUyrY5DiStRwhA2w5d/SNmKNNC38n/FS+sx0W29VLjA//YJec++Jd9wm8
         1l1qD3yjx0b1Ec+clBVuZ0/KGkh4SvbbWj6r9xYwc645MMI9l/0IAM6f6VT463tc00TF
         gYazaYlGwt6XvD7dzfKFpP0O6l4E96KNg60OD3PvlObQORYxAgAVO5ztvpOMAefSxCca
         d00LWXFnpXkW6pkj4MLUxNudy9eT7sinEKFHkHxQL12E5O7xZw04pByrQYVLSqi8F1ch
         Tx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPE9MdTOQQF/riTAULLmWZCcqgCHbenu251Uz8XsTdA=;
        b=tevBDs8SShyLqMsIb2V47+OyuWQDMWd00rj090d9QzOviQ7USzMzX0wbbJJuW4bZWy
         jViUUfFlDvBUwOgD2ngaYcf+uYl29TynnzEMfsDjWAPiqQiACjDWnLl7y0C37tJRq84w
         1elFPd6X+fUQt7UcScTzoVajiOjxsACMXts+KVKnzYzCpwpF0Aeam/v01oLG3eHrXCEh
         MZGKo0zfTofDJN7rU1bZnGRdjG5NB6Y3qqL/v7Y9uOLSyRRi5zL4vYGzlZicXw7MCQ8k
         dIkf+nKveSPsHZAu40h444WgIn3G0LBC0U95qgCiwwnms5Smh7ZfzFkDbyeJjl0rW73M
         FI7Q==
X-Gm-Message-State: AHQUAuYVPOftPHw0X95DoIbe8sYO6yrJjp/+4QQniAjgBgh1w4WYmGiD
        uCjTajk47x2I+blG1c0uOIm8RQSQHGt2fsj/i5UqPQ==
X-Google-Smtp-Source: AHgI3IaQbOMhRvwqP/wZDLEYAhgmmnPllTX716ebdrTB0Wkk2gQDW8T0UPzUSZ9l8gLDoT9JudlGjUiNvda6Cv1z2pQ=
X-Received: by 2002:a9d:7a87:: with SMTP id l7mr14100307otn.98.1550679346817;
 Wed, 20 Feb 2019 08:15:46 -0800 (PST)
MIME-Version: 1.0
References: <154958385172.3932544.193235520333886200.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49lg2bql2v.fsf@segfault.boston.devel.redhat.com> <CAPcyv4iiZS_zfroRtmS-zD-cCDj1yQonBsWM23utR9m9kiBizA@mail.gmail.com>
 <b1f73551-5c11-3651-dc6f-5cdcf815e0d0@suse.de>
In-Reply-To: <b1f73551-5c11-3651-dc6f-5cdcf815e0d0@suse.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Feb 2019 08:15:35 -0800
Message-ID: <CAPcyv4hZXJbrLc9f3xsOTPs_RYVH9vhuxSxHj-4L56ZNi+ZRZg@mail.gmail.com>
Subject: Re: [PATCH] acpi/nfit: Fix bus command validation
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal Verma <vishal.verma@intel.com>,
        stable <stable@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 12:30 AM Johannes Thumshirn <jthumshirn@suse.de> wrote:
>
> On 20/02/2019 03:58, Dan Williams wrote:
> [...]
>
> >>
> >> Tricky code path, eh?
> >
> > ioctl path, number one source of bugs / thrash in this subsystem. 2nd
> > place, ARS.
>
> Possibly unpopular idea, but should we maybe teach trinity/syzcaller
> about these ioctl()s?
>
> Better we find the bugs in a QA like environment than in the filed, I guess?

I wouldn't be opposed to syzkaller fuzzing the nvdimm-ioctl path.
