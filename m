Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F3FECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC8020878
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zsB9yXIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC8020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbeGMLpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:45:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48594 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbeGMLpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:45:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6DBSvGN005514;
        Fri, 13 Jul 2018 11:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=nJjfmxJCsyjyvKYZmwIjfMpuj/Gt705Pguj8KU5bPFU=;
 b=zsB9yXIaDC4n0bRwp3ewyDn5thL0tiXZyZjCwWi3IoQcJKH3LlCy+hsuJjN0A5j6hnIe
 a1ZT2IzSC8BWVR8n/AtDRbivJaqMzgg53XGjIyrU6jeEpcP1NJ2UlYSXatrowMnHDDQb
 heKYTbbvkI5ASuAvlC6p6p/oabjitj/vLo1OC5O5DsDTbPSx6eVb5NdwZY9l6kzPO2tI
 GUxF5lD+PI/WxGL+Q1gYRtCn/nt5XpYD5xEL8u4DoYmUv4/Vzqv5GVV6LmOOFcFPuJs3
 bez6DZRlyPZ8OjBIlNZl64XX29YDp8k6P0WDOS36XNdPgBf4IvHyA/llwcRPYl4xmriF vw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2k2p7e7epm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 11:31:18 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6DBVGk1001501
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 11:31:16 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6DBVGYc023781;
        Fri, 13 Jul 2018 11:31:16 GMT
Received: from mail-oi0-f48.google.com (/209.85.218.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Jul 2018 11:31:15 +0000
Received: by mail-oi0-f48.google.com with SMTP id y207-v6so61609961oie.13;
        Fri, 13 Jul 2018 04:31:15 -0700 (PDT)
X-Gm-Message-State: AOUpUlGz0dauBZd5sXAQEdMl6uA+rUtBaSKzSdZ4mGlY4m2eYJ+qJGMd
        LaaWkRkGMdcKmp7Yyk+xDaUYi4GwtFDw6gs7zLg=
X-Google-Smtp-Source: AAOMgpeRjV2mhT7WbDU4grjFFRqjtq5An5ihiFZp3vxqg3o6TcmEsnN2xrATlWycwmkQTehHhhvXcagqYOc9+TqnElg=
X-Received: by 2002:aca:b541:: with SMTP id e62-v6mr7018850oif.136.1531481475136;
 Fri, 13 Jul 2018 04:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
 <20180712000419.5165-14-pasha.tatashin@oracle.com> <928b8490-89d2-46a3-8596-16751bcd12db@cn.fujitsu.com>
In-Reply-To: <928b8490-89d2-46a3-8596-16751bcd12db@cn.fujitsu.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 13 Jul 2018 07:30:39 -0400
X-Gmail-Original-Message-ID: <CAGM2reb-MwiT8qoiSkXCjAAM46JOYL9BP+U3q7PMTcxp9EiK7w@mail.gmail.com>
Message-ID: <CAGM2reb-MwiT8qoiSkXCjAAM46JOYL9BP+U3q7PMTcxp9EiK7w@mail.gmail.com>
Subject: Re: [PATCH v13 13/18] x86/tsc: calibrate tsc only once
To:     douly.fnst@cn.fujitsu.com
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8952 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807130090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 3:24 AM Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>
>
> At 07/12/2018 08:04 AM, Pavel Tatashin wrote:
> > During boot tsc is calibrated twice: once in tsc_early_delay_calibrate(),
> > and the second time in tsc_init().
> >
> > Rename tsc_early_delay_calibrate() to tsc_early_init(), and rework it so
> > the calibration is done only early, and make tsc_init() to use the values
> > already determined in tsc_early_init().
> >
> > Sometimes it is not possible to determine tsc early, as the subsystem that
> > is required is not yet initialized, in such case try again later in
> > tsc_init().
> >
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>
> Hi Pavel,
>
> Aha, a complex solution for a simple problem! ;-) And I did find any
> benefits of doing that. did I miss something?

Hi Dou,

I had this in previous version:  init early, and unconditionally
re-init later (which required to resync sched clocks for continuity,
and check for some other corner cases). Thomas did not like the idea,
as it is less deterministic: it leads for code to work by accident,
where we might get one tsc frequency early and another later, and so
on. The request was to initialize only once, and if that fails do it
again later. This way, if early initialization is broken, we will know
and fix it.

>
> As the cpu_khz and tsc_khz are global variables and the tsc_khz may
> be reset to cpu_khz. How about the following patch.

Could you please explain where you think this patch can be applied,
and what it fixes?

Thank you,
Pavel

>
> Thanks,
>         dou
> ------------------------8<-----------------------------------
>
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 74392d9d51e0..e54fa1037d45 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1370,8 +1370,10 @@ void __init tsc_init(void)
>                  return;
>          }
>
> -       cpu_khz = x86_platform.calibrate_cpu();
> -       tsc_khz = x86_platform.calibrate_tsc();
> +       if (!tsc_khz) {
> +               cpu_khz = x86_platform.calibrate_cpu();
> +               tsc_khz = x86_platform.calibrate_tsc();
> +       }
>
>          /*
>           * Trust non-zero tsc_khz as authorative,
