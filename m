Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7E9C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39112086B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39112086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388427AbeKGGCs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:02:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33889 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbeKGGCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:02:48 -0500
Received: by mail-ot1-f65.google.com with SMTP id t5so9129035otk.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 12:35:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T6HUuE2/8GG90Ndl8cZ2SLuqHmoLPm9aHgvMMjeqolY=;
        b=ZUTU2gXFgY4/FSDEYvChCqOphBM55XdusBg9qnMEOfh2IHMAsLr2wuA5QYu7Li3aW9
         GPUj0cTZZTRfhEFvHkIgrmlag+q8hWUe1Cmp+I1KKGoKKjmAnMfYqYHLIkeC773cj+EI
         5UY1DpkAHejcST0l0VSlqClGGYyHaAHIZA9efolcrbcS6CBxjknyOXPR21uV96mdYxbB
         hT6rldRZMVOeL/LNJ5dK5cBB/EjxcpHoxZFlPv9GzDYT5sP/TdPLM3UjOnb7O6qxWrrv
         RQytq8U1QujjpANDGIeEvEJhr0WyVJInQXc1HqpWDsUjNVYVMWoEJlaiLxx1u2WJDFFi
         aeaw==
X-Gm-Message-State: AGRZ1gItmfu9BrhNJPUE3fgkAd2CNwCc1c1kk6gZVyImNdi5q8VytQUz
        Zzp05vMSWLS3+bB0E50UvprCcNzQ/aPKMD6ujEQ=
X-Google-Smtp-Source: AJdET5cbwBYGR5TzNxrVO0LgTLWBueFhEspSqVb9wGdLNxrg/IYo1q5Dv/Y9MJdt5i3LcVV4j7aTvcDZ+J4rJjIhIi0=
X-Received: by 2002:a9d:56db:: with SMTP id b27mr17602801otj.365.1541536547423;
 Tue, 06 Nov 2018 12:35:47 -0800 (PST)
MIME-Version: 1.0
References: <20180606194232.17653-1-malat@debian.org>
In-Reply-To: <20180606194232.17653-1-malat@debian.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 6 Nov 2018 21:35:35 +0100
Message-ID: <CA+7wUsw0X541yTuG2t6-=3cDY9pjeA9yki10VgBRsVZB1hBLBA@mail.gmail.com>
Subject: Re: [PATCH] kernel/watchdog: add missing prototypes for weak functions
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Babu Moger <babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ?
On Wed, Jun 6, 2018 at 9:42 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> In commit 73ce0511c436 ("kernel/watchdog.c: move hardlockup detector to
> separate file") two new functions were added ‘watchdog_nmi_enable’ and
> ‘watchdog_nmi_disable’ the functions were changed from static to weak.
> In which case expose the function declarations in header file.
>
> Silence the following gcc warnings:
>
>   kernel/watchdog.c:109:12: warning: no previous prototype for ‘watchdog_nmi_enable’ [-Wmissing-prototypes]
>   kernel/watchdog.c:115:13: warning: no previous prototype for ‘watchdog_nmi_disable’ [-Wmissing-prototypes]
>
> Cc: Babu Moger <babu.moger@oracle.com>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  include/linux/nmi.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index b8d868d23e79..50d143995338 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -113,6 +113,8 @@ static inline int hardlockup_detector_perf_init(void) { return 0; }
>  void watchdog_nmi_stop(void);
>  void watchdog_nmi_start(void);
>  int watchdog_nmi_probe(void);
> +int watchdog_nmi_enable(unsigned int cpu);
> +void watchdog_nmi_disable(unsigned int cpu);
>
>  /**
>   * touch_nmi_watchdog - restart NMI watchdog timeout.
> --
> 2.11.0
>
