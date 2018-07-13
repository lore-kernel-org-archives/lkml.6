Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A417ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 01:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E27208E9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 01:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xgYyBh+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E27208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388078AbeGMCKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 22:10:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49660 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387969AbeGMCKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 22:10:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6CNs8JM129705;
        Fri, 13 Jul 2018 01:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to :
 content-type; s=corp-2018-07-02;
 bh=nQdqGE+K77MaxDhOmg40CAXU6twoI+B+omClLtdMwFY=;
 b=xgYyBh+lqoviFwFrqb5OMHxGff7upYh0ZNPr066l0Zu330hIdKj0N6f2QHZLUXuzUeoZ
 Dl/CS2i7/4U/0Y2UPAf4TkolCG3HGMnoeA4a8jGBiKnVZ/DMbKb71Y4McLnGYBaQVSql
 nvROnWAfoEyqZ+HocBuv6ZVoe6iWeSP3pFi8/5UaZjWwap7imyiRvN6QwHyhdL6Y6f6X
 /UJtYUbEYXF3qQmwm0VBF6k4vL6UO6euCBmqXxzbanpDMnjlLyrsErjwlRToAYR0Fjx/
 B4RoVqiOFbzAMS6CsL2RWxIHu6ES0aajomrkFU8KYqgxTQglNOfNRUDdal+wnqKShzBF xw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2k2p7e5xrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 01:58:18 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6D1wG7f005090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 01:58:16 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6D1wFPh006007;
        Fri, 13 Jul 2018 01:58:16 GMT
Received: from mail-oi0-f54.google.com (/209.85.218.54)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Jul 2018 18:58:15 -0700
Received: by mail-oi0-f54.google.com with SMTP id w126-v6so59434059oie.7;
        Thu, 12 Jul 2018 18:58:15 -0700 (PDT)
X-Gm-Message-State: AOUpUlEFbLKwMkemPzkoxQG7RVlgBGg75lN2zk/8HgCwsv2T95DAHsOL
        YAgZDC+COnCP8PTe3spG1MrFoKziGng7KXvBnWM=
X-Google-Smtp-Source: AAOMgpc0S48UcJnhOL7W0T8q1C8dcff6yz655gcJrYxBIvsoymg29WWKuMXwMNEKrxQqBxpUB6N4+gaG/LNWpnQV5H8=
X-Received: by 2002:aca:db09:: with SMTP id s9-v6mr5264636oig.339.1531447095334;
 Thu, 12 Jul 2018 18:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180712000419.5165-1-pasha.tatashin@oracle.com> <20180712000419.5165-7-pasha.tatashin@oracle.com>
In-Reply-To: <20180712000419.5165-7-pasha.tatashin@oracle.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 12 Jul 2018 21:57:39 -0400
X-Gmail-Original-Message-ID: <CAGM2reaBMEdf6E2JJno2vX70-Et80iv4-M26WVBOiKZsiBcq8A@mail.gmail.com>
Message-ID: <CAGM2reaBMEdf6E2JJno2vX70-Et80iv4-M26WVBOiKZsiBcq8A@mail.gmail.com>
Subject: Re: [PATCH v13 06/18] x86/xen/time: initialize pv xen time in init_hypervisor_platform
To:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, Petr Mladek <pmladek@suse.com>,
        gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8952 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=716
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807120253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -void __ref xen_init_time_ops(void)
> +void __init xen_init_time_ops(void)
>  {
>         pv_time_ops = xen_time_ops;
>
> @@ -542,17 +542,11 @@ void __init xen_hvm_init_time_ops(void)
>                 return;
>
>         if (!xen_feature(XENFEAT_hvm_safe_pvclock)) {
> -               printk(KERN_INFO "Xen doesn't support pvclock on HVM,"
> -                               "disable pv timer\n");
> +               pr_info("Xen doesn't support pvclock on HVM, disable pv timer");
>                 return;
>         }
> -
> -       pv_time_ops = xen_time_ops;
> +       xen_init_time_ops();
>         x86_init.timers.setup_percpu_clockev = xen_time_init;
>         x86_cpuinit.setup_percpu_clockev = xen_hvm_setup_cpu_clockevents;

Boris reported a bug on HVM, which causes a panic in
x86_late_time_init(). It is introduced here: xen_init_time_ops() sets:
x86_init.timers.timer_init = xen_time_init; which was hpet_time_init()
in HVM. However, we might not even need hpet here. Thus, adding
x86_init.timers.timer_init = x86_init_noop; to the end of
xen_hvm_init_time_ops() should be sufficient.

Thank you,
Pavel
