Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B9FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E57C21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUriPEK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeLRV0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:26:08 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46042 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbeLRV0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:26:08 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so15104601edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qe/9z26MJ28plQcnRiNJ+pvdevYuanRs3dB9ghQ/QEA=;
        b=jUriPEK1lW7py4o8LcU3wq8YqzEc+xAzD/84378HaAKZVIaMIP757XdzWh2kQBXqT2
         K6Doo/hULyxhBnjTgs/iVtCnQu+/03gsZ5J+9jL/NXjKkK0Hk4TH0wsCgnljS1nKF/FN
         B6q2AYUgTEorDXzOzvTpHEurTqYmDT0EwwbZz1//Zxu7llHj0e7wEPt6Qbmh+ar6J983
         R1ngw7gnPz0PoR3xJLdRqQrBU0A3CGhmmI+id3cZPj7oE5zMX2hhOYQeTstJxMAxwzqD
         /MNPvclqILJisU3rqP2H7Ny5SgKRkXCSV21xXbdSLntK89NOQKQBbsAYz+WKeKDbGaf9
         obrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qe/9z26MJ28plQcnRiNJ+pvdevYuanRs3dB9ghQ/QEA=;
        b=Mp/NhR0sTkztUlYFrYThiiIJv7Em7nZvV5sejoN75pr3FLHKt1YuGMgy/dU3HsA4jQ
         LbGR/3zLhS/YVv7373KoZmjbjV0yiKEJ0CfV4cfNmHg5izZh4I88i08xgJK7NULAUc2g
         EJMpjpy2UkVZ4MgADbXk4eNdraAhd9ts2vfZV30uf45Ecc1OQTzQN55+9TVmBKmGT+g6
         HXCaUsxzG4VBtros2293E0YNLZP7eMWA1X0H5gRcPXEtnYGC3bymUXRbmcgQKc2TN+bw
         IPg7jC0GX5/CzRpekGUpjOmsMWkCjPNQZXi2L7tgc9fetAeG7wYCeIhioxZ+NfyX05e8
         a6uw==
X-Gm-Message-State: AA+aEWYaJ6ucONj8QkmUUMIodqUb15ZimpAt7aNirqasw0trUMlZWQ6u
        E/oDgzt3N0kYNrYpA2VPQtf4EPtU
X-Google-Smtp-Source: AFSGD/UNO/WW005EGoD/7WdyBgNsIJENJp57NHVzGXY9aUSfHnLDvOAZAsZZ5Fgy4xqHZBZ9x5z1kw==
X-Received: by 2002:a50:9315:: with SMTP id m21mr17490609eda.58.1545168366276;
        Tue, 18 Dec 2018 13:26:06 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id k20sm4950532eda.71.2018.12.18.13.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 13:26:05 -0800 (PST)
Date:   Tue, 18 Dec 2018 21:26:05 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] memory_hotplug: add missing newlines to debugging output
Message-ID: <20181218212605.4wa35jzlewp3rj7f@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181218162307.10518-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218162307.10518-1-mhocko@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 05:23:07PM +0100, Michal Hocko wrote:
>From: Michal Hocko <mhocko@suse.com>
>
>pages_correctly_probed is missing new lines which means that the line is
>not printed rightaway but it rather waits for additional printks.
>
>Add \n to all three messages in pages_correctly_probed.
>
>Fixes: b77eab7079d9 ("mm/memory_hotplug: optimize probe routine")
>Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
> drivers/base/memory.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>index 0e5985682642..b5ff45ab7967 100644
>--- a/drivers/base/memory.c
>+++ b/drivers/base/memory.c
>@@ -207,15 +207,15 @@ static bool pages_correctly_probed(unsigned long start_pfn)
> 			return false;
> 
> 		if (!present_section_nr(section_nr)) {
>-			pr_warn("section %ld pfn[%lx, %lx) not present",
>+			pr_warn("section %ld pfn[%lx, %lx) not present\n",
> 				section_nr, pfn, pfn + PAGES_PER_SECTION);
> 			return false;
> 		} else if (!valid_section_nr(section_nr)) {
>-			pr_warn("section %ld pfn[%lx, %lx) no valid memmap",
>+			pr_warn("section %ld pfn[%lx, %lx) no valid memmap\n",
> 				section_nr, pfn, pfn + PAGES_PER_SECTION);
> 			return false;
> 		} else if (online_section_nr(section_nr)) {
>-			pr_warn("section %ld pfn[%lx, %lx) is already online",
>+			pr_warn("section %ld pfn[%lx, %lx) is already online\n",
> 				section_nr, pfn, pfn + PAGES_PER_SECTION);
> 			return false;
> 		}
>-- 
>2.19.2

-- 
Wei Yang
Help you, Help me
