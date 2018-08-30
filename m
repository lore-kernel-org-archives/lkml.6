Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F51C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B132D20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="twWNxcI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B132D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeH3Tka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:40:30 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43364 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeH3Tka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:40:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id h64-v6so7535394lfi.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 08:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1XI6QdjA8q9PD/nI9BnqEKh3J2lWq2KH4Kcq+OFMH5g=;
        b=twWNxcI5GTqUF0OGuD5t8Ro0a8nlmdnwQlFQXPsJPB5l7ls87yC0xwiZj9leeC4lnp
         2PqmLh5/ccU+TOss3QfjCmUXDhtgSQZDsexHG1svHPzpUhGCThcND9ubMMshX9vlQUZe
         /nePoyuLnMvkmhM4zfEig1mhyb/YItEQHvbOBC2CTHYISGV5yO2pSUOH/ctTA4C9JfEn
         mSrG8H7sH79Xhr0jxwVH3kn+nhiicHhMXtJNrB7On6TR9auSQ08vmfxAimUmVWB6EhNu
         7M9bKD0rwTWsjk0zrrAEL5uQ0cwvZMAdiQ0esB505FY1dmeADja5zg49Q4K9cRbUbp2W
         1wZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1XI6QdjA8q9PD/nI9BnqEKh3J2lWq2KH4Kcq+OFMH5g=;
        b=le/Twwu176c/ZeXdukv+ag85plDCzqVlL+9jhvtPbLmhijzKAfJKau8QNVo/Ky7Zhi
         88PWRoRKOcZ/LYvjUhc2aFWl+6CjNUkQ823NutCxd6+ZIsuWLBTZtKLo7ZSkcAIgaRAR
         JGTVb1T1FWTpFKx25+VspivM5g1v0B379gf0PM1BTlOlQ9MKNchTM+UdhJ4aaZnHgS6q
         wKLnkK0FEDUgn0nDt/gtxGsZldTrio91nfFx6qmerkXNCyEvMCEnru9hy5JMBIEPUxZp
         G9DH1HFD8fQD8a+BEBKDwW2wia61q7SIgGm+Bt6AJBAwOeLeCHS5+YPN8KHJkA+DscdB
         BUcA==
X-Gm-Message-State: APzg51BF/IISJW+ul96JyVQhLTZLmQHfZ/UW6CjcDthx9u7tzIvjvaru
        mng1/iJQcEHNgrdh7VGnGYTPL3R6lJ0AE/AiifmhkA==
X-Google-Smtp-Source: ANB0VdboPGb92xQjLfKlPzItR8S8d3kkUWBST2zMTQlg52PM7/LUBb/BscGTIK6Q+WqALS78K+UBtqSMS8MdiHWxs5w=
X-Received: by 2002:a19:124d:: with SMTP id h74-v6mr7627305lfi.107.1535643465525;
 Thu, 30 Aug 2018 08:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180830153813.GA26059@jordon-HP-15-Notebook-PC>
In-Reply-To: <20180830153813.GA26059@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 30 Aug 2018 21:10:35 +0530
Message-ID: <CAFqt6zbz6bb55BYvWHq4PwH64hUWQ8DnGV9U3hB3Mg4AO3PwjQ@mail.gmail.com>
Subject: Re: [PATCH] device-dax: Convert variable to vm_fault_t type
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
        zwisler@kernel.org, vishal.l.verma@intel.com,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 9:05 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> As part of commit 226ab561075f ("device-dax: Convert to
> vmf_insert_mixed and vm_fault_t") in 4.19-rc1,
> 'rc' was not converted to vm_fault_t. Now converted.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Sorry, I missed this initially.
> ---
>  drivers/dax/device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> index 6fd4608..bbe4d72 100644
> --- a/drivers/dax/device.c
> +++ b/drivers/dax/device.c
> @@ -392,7 +392,8 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
>  {
>         struct file *filp = vmf->vma->vm_file;
>         unsigned long fault_size;
> -       int rc, id;
> +       vm_fault_t rc = VM_FAULT_SIGBUS;
> +       int id;
>         pfn_t pfn;
>         struct dev_dax *dev_dax = filp->private_data;
>
> --
> 1.9.1
>
