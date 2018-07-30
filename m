Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA0813F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB84020870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vqkYY8pz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB84020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeG3Po6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:44:58 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35370 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbeG3Po5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:44:57 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6UE8wMS014091
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 14:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=aEYywBpLuJb06lebWVOkgljrAav/y+L2dQUSu2nsXR0=;
 b=vqkYY8pzAWi0lT0QFyglPZIUXOtQ7+BXW4DqgfpVA2Sb9nXD2Y++4jO35FrpO6SMvQLy
 cM60bGVwL8FcPaIVVGQU+LvCD1N6+yBerx+xN7iSEnQivvK3ZEj0UMj/ihxrU/CoyFCT
 oEF1K+9o875vv9rm+dGq7hEXtdrE2WdUe8hV0/yki5QWEqt0pxFH/0jf0yvx63bE2gT2
 AUvkvkyVDRYaKWejw4c8v4fNfItlLjRxxsgLHhob2+zI0lw/LXNoV8k5sLjlr3YAhXXj
 LzTgTHYxtGBH80/Bcw4qENo1bF8D3ysMucxF1mYcJQoPdoZhkjS20UPTITLavzMKXOCo IQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2kge0cvsn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 14:09:46 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6UE9itq018900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 14:09:44 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6UE9iD2000320
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 14:09:44 GMT
Received: from mail-oi0-f44.google.com (/209.85.218.44)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 07:09:44 -0700
Received: by mail-oi0-f44.google.com with SMTP id s198-v6so21451705oih.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 07:09:44 -0700 (PDT)
X-Gm-Message-State: AOUpUlGZ4PNknANq/ZWS1viVCBNXzy/dgH4kg7yGXXU/GJy9JZrEDAfQ
        9+3YO5mrXDYnzgCyIir8FlEWm2dEPb1g8OFx1pc=
X-Google-Smtp-Source: AAOMgpfslVkE7C0au497fy4JJ28GzkhAlo5aWdDfA8yyjo0OvGbkNq+2TSuqCkKfFFrCY06ZGcQ0UKoaNdB3+Ct6buM=
X-Received: by 2002:aca:db09:: with SMTP id s9-v6mr19391498oig.339.1532959783786;
 Mon, 30 Jul 2018 07:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180730075421.22830-1-douly.fnst@cn.fujitsu.com> <20180730075421.22830-2-douly.fnst@cn.fujitsu.com>
In-Reply-To: <20180730075421.22830-2-douly.fnst@cn.fujitsu.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 30 Jul 2018 10:09:07 -0400
X-Gmail-Original-Message-ID: <CAGM2rebgzrPAOSHXq8XY=e6YoHLeg-qhJZy4JJLntV7xLnrPDw@mail.gmail.com>
Message-ID: <CAGM2rebgzrPAOSHXq8XY=e6YoHLeg-qhJZy4JJLntV7xLnrPDw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/tsc: Avoid a double call if TSC initializes earlier.
To:     douly.fnst@cn.fujitsu.com
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8969 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807300157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 3:55 AM Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>
> static_branch_enable(&__use_tsc) may be called twice in common case, that
> is redundant. And there are also some common functions both in
> tsc_early_init() and tsc_init().
>
> Move them into a separate helper function, only call it once.
> Also fix comments:
>  -s/authorative/authoritative
>  -s/cyc2ns_init/tsc_init
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>

Hi Dou,

Nice cleanup.
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Thank you,
Pavel

> ---
>  arch/x86/kernel/tsc.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 02e416b87ac1..ba0a6b6e0726 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -182,7 +182,7 @@ static void __init cyc2ns_init_boot_cpu(void)
>  }
>
>  /*
> - * Secondary CPUs do not run through cyc2ns_init(), so set up
> + * Secondary CPUs do not run through tsc_init(), so set up
>   * all the scale factors for all CPUs, assuming the same
>   * speed as the bootup CPU. (cpufreq notifiers will fix this
>   * up if their speed diverges)
> @@ -1389,7 +1389,7 @@ static bool __init determine_cpu_tsc_frequencies(bool early)
>         }
>
>         /*
> -        * Trust non-zero tsc_khz as authorative,
> +        * Trust non-zero tsc_khz as authoritative,
>          * and use it to sanity check cpu_khz,
>          * which will be off if system timer is off.
>          */
> @@ -1421,6 +1421,14 @@ static unsigned long __init get_loops_per_jiffy(void)
>         return lpj;
>  }
>
> +static void __init enable_use_tsc(void)
> +{
> +       /* Sanitize TSC ADJUST before cyc2ns gets initialized */
> +       tsc_store_and_check_tsc_adjust(true);
> +       cyc2ns_init_boot_cpu();
> +       static_branch_enable(&__use_tsc);
> +}
> +
>  void __init tsc_early_init(void)
>  {
>         if (!boot_cpu_has(X86_FEATURE_TSC))
> @@ -1429,10 +1437,7 @@ void __init tsc_early_init(void)
>                 return;
>         loops_per_jiffy = get_loops_per_jiffy();
>
> -       /* Sanitize TSC ADJUST before cyc2ns gets initialized */
> -       tsc_store_and_check_tsc_adjust(true);
> -       cyc2ns_init_boot_cpu();
> -       static_branch_enable(&__use_tsc);
> +       enable_use_tsc();
>  }
>
>  void __init tsc_init(void)
> @@ -1456,13 +1461,10 @@ void __init tsc_init(void)
>                         setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
>                         return;
>                 }
> -               /* Sanitize TSC ADJUST before cyc2ns gets initialized */
> -               tsc_store_and_check_tsc_adjust(true);
> -               cyc2ns_init_boot_cpu();
> +               enable_use_tsc();
>         }
>
>         cyc2ns_init_secondary_cpus();
> -       static_branch_enable(&__use_tsc);
>
>         if (!no_sched_irq_time)
>                 enable_sched_clock_irqtime();
> --
> 2.14.3
>
>
>
