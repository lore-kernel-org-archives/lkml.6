Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5F4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E3421571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bUr6mxMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E3421571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeI1D3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:29:14 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38079 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeI1D3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:29:14 -0400
Received: by mail-oi1-f196.google.com with SMTP id u197-v6so3475179oif.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 14:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bICWFM1jyMxBwC6r22lCQ/9c4PhzMBZbxjc7KfJXWk=;
        b=bUr6mxMzKYpRrdKum5UAWcTWL3o3seT1pffAZRfM0Ze5gDprguctl/FBkD3fe1tJYz
         37Hyf4y1jxMA2vRDOWZpahhad8ThE3gwT1WQnDusnhIXVz9Ki62aqmXqNMw0L+mjrcHW
         SJxV3QtBtwqkc7LEpSs9A7DhPCl1Srz0GtowfxTZXXogOjFkj9GO2pwlRG6tzitdfj7s
         G7pbOJnqj+l1Pqf5nn+XS4SzOR2izly8HQ0ufihiXw93kTir+KcqcZC1ogbMk/madrOv
         F0nZrrjiv/75V3r3Gq9RlMsTmz2nC951LVmY01y/1qrdIVYaao1kgDNmQ2XQyZjDdO2c
         cFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bICWFM1jyMxBwC6r22lCQ/9c4PhzMBZbxjc7KfJXWk=;
        b=FhHQw6c2MnCsPM7EqH/zvXdaafuZy1PHZUG0XCtqZm0ukRCtuPd+8mDgZwb3lJz2ew
         xPFljqmt9FAfbTIEla+ugIDqthbBWAAk0zIH5OqLM6fPUG8I8I/pzIZYFrHyfl/3BiK+
         +r9KFFpj+DUJ8s1EguooF6x78dG0lB+t36Tesp3O4wZcRLy1Pbl6ur9j+JnfgZGgMt5+
         tDeNoXHbpHF7X/Vd7IVSzICW0Jfg3tyReLb98tQLtZxzAPDtiaVQ4/8OINtlRBiMIS4t
         0pIfm7vhaRcIDZFEgcvrbwZ2xVUe6HhkZGvPV/eOKXxcElzzP95cYTssEADcbWpV7wtP
         AKEQ==
X-Gm-Message-State: ABuFfoiRG38ltKEoC8pl74bCMYCPd+LpP4fLtH2eVju2db3nbaYz+0iI
        8ewsWogLT92r7Mh66qkxBv0eCylKerrwzSZeIPYGjA==
X-Google-Smtp-Source: ACcGV63DPaNQvd494x430KLuBNnMg4fHn1+HW91d2MmR54KhTkCUk+W/f8SvpbzkDhTLJwjc0dOBLu6lVLJWvdOkTQw=
X-Received: by 2002:aca:b355:: with SMTP id c82-v6mr4406474oif.9.1538082542181;
 Thu, 27 Sep 2018 14:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <1538077089-14550-1-git-send-email-yang.shi@linux.alibaba.com>
In-Reply-To: <1538077089-14550-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 Sep 2018 14:08:51 -0700
Message-ID: <CAPcyv4jvmTUUgVXd7gCVcmMbOM0OcY8rTQGkp+Ak1NHpi+zS_g@mail.gmail.com>
Subject: Re: [PATCH] mm: dax: add comment for PFN_SPECIAL
To:     yang.shi@linux.alibaba.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 12:39 PM <yang.shi@linux.alibaba.com> wrote:
>
> The comment for PFN_SPECIAL is missed in pfn_t.h. Add comment to get
> consistent with other pfn flags.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  include/linux/pfn_t.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
> index 21713dc..d2e5dd4 100644
> --- a/include/linux/pfn_t.h
> +++ b/include/linux/pfn_t.h
> @@ -9,6 +9,7 @@
>   * PFN_SG_LAST - pfn references a page and is the last scatterlist entry
>   * PFN_DEV - pfn is not covered by system memmap by default
>   * PFN_MAP - pfn has a dynamic page mapping established by a device driver
> + * PFN_SPECIAL - indicates that _PAGE_SPECIAL should be used for DAX ptes

That's not quite accurate, I would change this to:

PFN_SPECIAL - for CONFIG_FS_DAX_LIMITED builds to allow XIP, but not
get_user_pages.
