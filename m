Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F60C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0EE20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="qpIQtRdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0EE20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeK3XUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:20:46 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:33446 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeK3XUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:20:46 -0500
Received: by mail-it1-f193.google.com with SMTP id m8so1839590itk.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 04:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YwIfHVjwrxDwoTVFzcSrztBgOKxXx33KyDc2yAbM9KI=;
        b=qpIQtRdDw/fYe2CofshuyYNIXiegAaFHBlLaSA0TqLXPoqgwTCFei9+BbX+HUq0OME
         Z9y1NpzpFgtUe7MdEgF86EAxDJ8gvS6+gMWV4BHSFYOTFilc25qf/MommGQVRvGSO0HR
         fhgkIsf+Alu/Pk4OjeQilwLTOQtXBhWnTNX/bZ3Ozhyj6RQJLf9evytK53InzSx+9MDK
         49E6HZ9MvYDToejri2c3/H9+OnbTEAoSSufNp0qrbthhxVNKKz+9kwgw0KrqOAFWhHFp
         6XWgdzdo4RZ931v7kpNor7xqWyTPQv8eQicSsCM0wbA2UOkEtf8PP6kVFosvzbZfY84P
         iJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YwIfHVjwrxDwoTVFzcSrztBgOKxXx33KyDc2yAbM9KI=;
        b=gV9x6csTnC6PCI8NWSaB6RkYviqPvggKz+YlTfo753+ymd6gD/xZHHP6ipE9f+ujGS
         BskS8V7O5OrSClpF/Nz1DS3qmGygDGLwgtl0E/zGFO6atCImqoaPWYC9su8L/ng/8l4h
         evdCoIIrNpzoWw8uJFzq37IkzUCT3ZskhHEFFm/19lcuKHrDYOBFPdCGkjQ4AHRIa9DU
         udvHCj2sa68y4/QWpQiwEm0E0wDMxnn2AoQnPkzW4AV7RbVmdXGqSEIofFXqef6RN4GD
         BS67CmLMu883oOnadrFNhMNR0dC7UsH1GJ4u8JPJyUPkoVflXiM8oKelLqnNT/PIHg8Q
         RJPg==
X-Gm-Message-State: AA+aEWZ4FQrtBZFe58ACSJ6oNE4yLAz2nR004dylxyZp6oUu0KtYv9pf
        NDgKmIqKHus9wZaJXzt1XZpkv6Vqq0Y7waa5GM/5PA==
X-Google-Smtp-Source: AFSGD/W8ajO59KzngpG0bAww0smgYyTLTqorJfk7j0MeHncxQuEahsaxjanfSaiI79yPgFYj3TkIvUI7pGPMwD3YAuk=
X-Received: by 2002:a24:7284:: with SMTP id x126mr5231984itc.96.1543579901288;
 Fri, 30 Nov 2018 04:11:41 -0800 (PST)
MIME-Version: 1.0
References: <20181130115325.16539-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20181130115325.16539-1-srinivas.kandagatla@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 30 Nov 2018 13:11:30 +0100
Message-ID: <CAMRc=MfN=N9i372QBjHfAT-rR7t6ZLL1r-ZSM3LkF+sA4CK++w@mail.gmail.com>
Subject: Re: [PATCH 0/6] nvmem: patches for 4.21
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 30 lis 2018 o 12:53 Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> napisa=C5=82(a):
>
> Hi Greg,
>
> This patchset adds support to
>         - new meson-efuse peripheral clock
>         - add type attribute
>         - add new config option to ignore dt node to scan cells.
>
> Can you please pick them up for 4.21.
>

Greg,

could you also pick up this one:
https://patchwork.kernel.org/patch/10680701/ together with my nvmem
patch from this series?

Bart

> thanks,
> srini
>
>
> Alexandre Belloni (1):
>   nvmem: add type attribute
>
> Andy Shevchenko (1):
>   nvmem: Move nvmem_type_str array to its only user
>
> Bartosz Golaszewski (1):
>   nvmem: add new config option
>
> Jerome Brunet (3):
>   nvmem: meson-efuse: add error message on user_max failure.
>   nvmem: meson-efuse: bindings: add peripheral clock
>   nvmem: meson-efuse: add peripheral clock
>
>  .../bindings/nvmem/amlogic-efuse.txt          |  3 ++
>  drivers/nvmem/core.c                          | 31 ++++++++++++++++++-
>  drivers/nvmem/meson-efuse.c                   | 29 ++++++++++++++++-
>  include/linux/nvmem-provider.h                | 11 +++++++
>  4 files changed, 72 insertions(+), 2 deletions(-)
>
> --
> 2.19.2
>
