Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFD0C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC4223DA4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="JrejdkUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC4223DA4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751206AbeFVGME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:12:04 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:32779 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbeFVGMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:12:02 -0400
Received: by mail-ot0-f194.google.com with SMTP id h6-v6so6310627otj.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 23:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xfHnxkzE4Wi5xDsDcRnYG+o731E8cZ9kYe04AJmD+yM=;
        b=JrejdkUk0X7Ye3BjJBCaN8e2ZqjqtL830W/n9W2IdtgjSSBU1eNVLzGLsaKK5NiR5B
         5Gl+fUdDucy7z9QWQhECePwPwmW5XCqFR4/7SCZ+X7mYYJI4sAu5xWH6GIGsWGNtvYsR
         FnjN8JgXvKjn3kPIpY6vgGQAqoDlS6iDGgWRhse9xijNPxERnH8LVR8DrMKgyYgI4Hba
         gS8rC2q+0Aai/VfhYR3zpFxNS4eUTPAuQYchJzFA0YNo0CQLdjz+6X22BNCinh1HksDA
         cCwuZj/Mw8HaV1VXW1wmZgo9H03CO42rZX/x03VvGoqQ9v97s7oTiCx8M5eCa94jZmuN
         yynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xfHnxkzE4Wi5xDsDcRnYG+o731E8cZ9kYe04AJmD+yM=;
        b=FBOripGktCtfZ64G/P6dIDRnxU7fuwgiccXuB7JJ5Z574P79bW8+72rrlKCbfVELwP
         DL1a44zlNqebdPmLM1K7j4qyl9Ua22gqY4VCduETxIxR6yUdX+i1vRcRMnnkdqITH65I
         TwYy4UZ6zCrtELt4blWCiM+q0lTMscJ2KRY7IyDe9znNwlUg6NiHUUYishyM7JmHsJWe
         3DR5VlUBT0YSd377S7ssU6tc0mL2pqVgBoFgjYH9UYO/27PVzBdRxYrakpzQH6Uxn5ah
         gQZD+F3WTFQYov58Ih1POA2xvnrERr6RTOjwNB3YHyfMQ8PRy2RG5YbbjcEbnaz1NiQf
         PKcg==
X-Gm-Message-State: APt69E1eVLhlvT/k029pjlm3GrFxCvfiPyitrhSxRMqn0RxnD6pfC2Jf
        ah0kotWtuP9vJCLN8jO8cK38l5OxCip2oYq1mMB+Dg==
X-Google-Smtp-Source: ADUXVKI5M5w/n2SJbUQz3pe90kG5qTKuAkumQE/1EjAcTt26FfBKac4qk2jVksqZAgj1ir2tkI5MPG77KJY8Ey8Zudc=
X-Received: by 2002:a9d:3072:: with SMTP id w47-v6mr149351otd.387.1529647922226;
 Thu, 21 Jun 2018 23:12:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 23:12:01
 -0700 (PDT)
In-Reply-To: <1529647683-14531-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1529647683-14531-1-git-send-email-n-horiguchi@ah.jp.nec.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 21 Jun 2018 23:12:01 -0700
Message-ID: <CAPcyv4hpdvGRi+=psT47ePB6QigJW2JEq-zhbVXsTHb14pWfUQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm: initialize struct page for reserved pages in ZONE_DEVICE
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:08 PM, Naoya Horiguchi
<n-horiguchi@ah.jp.nec.com> wrote:
> Reading /proc/kpageflags for pfns allocated by pmem namespace triggers
> kernel panic with a message like "BUG: unable to handle kernel paging
> request at fffffffffffffffe".
>
> The first few pages (controlled by altmap passed to memmap_init_zone())
> in the ZONE_DEVICE can skip struct page initialization, which causes
> the reported issue.
>
> This patch simply adds some initialization code for them.
>
> Fixes: 4b94ffdc4163 ("x86, mm: introduce vmem_altmap to augment vmemmap_populate()")
> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> ---
>  mm/page_alloc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git v4.17-mmotm-2018-06-07-16-59/mm/page_alloc.c v4.17-mmotm-2018-06-07-16-59_patched/mm/page_alloc.c
> index 1772513..0b36afe 100644
> --- v4.17-mmotm-2018-06-07-16-59/mm/page_alloc.c
> +++ v4.17-mmotm-2018-06-07-16-59_patched/mm/page_alloc.c
> @@ -5574,8 +5574,16 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>          * Honor reservation requested by the driver for this ZONE_DEVICE
>          * memory
>          */
> -       if (altmap && start_pfn == altmap->base_pfn)
> +       if (altmap && start_pfn == altmap->base_pfn) {
> +               unsigned long i;
> +
> +               for (i = 0; i < altmap->reserve; i++) {
> +                       page = pfn_to_page(start_pfn + i);
> +                       __init_single_page(page, start_pfn + i, zone, nid);
> +                       SetPageReserved(page);
> +               }
>                 start_pfn += altmap->reserve;
> +       }

No, unfortunately this will clobber metadata that lives in that
reserved area, see __nvdimm_setup_pfn().
