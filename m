Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA07C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD9520852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JmoQNfQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD9520852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeGYFQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 01:16:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48020 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbeGYFQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 01:16:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6P44lE4062111;
        Wed, 25 Jul 2018 04:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=xD7R6+wrm4LgKmO93IcH/vSrDUCngJWwF5y1ojqHJEk=;
 b=JmoQNfQe2pRsMdO8tuYUKBZUjzAPTsevhhK+NTac+/e0AQfggPdwS2I8O5zP0YpLtjGf
 ni40VdsdMxDohb9aMirTGXhr6ZPiWatloUZ3GFxq2FDJIremxFIWu+GOHSwLE3iB+YFv
 EJnjPQPPVCFacuU3tMgEvsbsumbz/oYUF37yqY9Y07FW3PI8KtjjmPYwDrRG03jDFZI0
 hLTQdF/zxtp1GiU3pKCld1yCcfErAiQIBzEMnlGVFwd6szqUjoQlkq8kJXjpwS2dBlhj
 WOR1QxNj4RM6l3ZqVfx9LrL4JYACQe1Rg1bQJkdIXRmKRyJhWLH0YaDI6mFzC38rk2QD aQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2kbv8t3pch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 04:06:44 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6P46hHv025211
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 04:06:43 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6P46g0E012639;
        Wed, 25 Jul 2018 04:06:43 GMT
Received: from mail-oi0-f52.google.com (/209.85.218.52)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Jul 2018 19:05:39 -0700
Received: by mail-oi0-f52.google.com with SMTP id n84-v6so11110170oib.9;
        Tue, 24 Jul 2018 19:05:39 -0700 (PDT)
X-Gm-Message-State: AOUpUlGwpYiFH+hCAbKbgwlMZqO9lLd2123JTbQnFD8X6Z8+1dXNHl5U
        5TIKoii4j79NDBMkjoexkhTDVGdpIAjsBgDCMAM=
X-Google-Smtp-Source: AAOMgpevuKalShhb8sq0Y352f6AsIo1IW+c0SjLA0yO4Bhvy8+nK9XG/FxI5qZJM3WC5N6TsTVLOYRnC0slvQuMftC8=
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr1292010oig.221.1532484339135;
 Tue, 24 Jul 2018 19:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180719205545.16512-24-pasha.tatashin@oracle.com>
 <tip-857baa87b6422bcfb84ed3631d6839920cb5b09d@git.kernel.org>
 <20180724195215.GA22496@roeck-us.net> <CAGM2reayvBs8rs6yHZYV9SvPz-tsNG_Ux8ypHguLLagiS2SkuA@mail.gmail.com>
 <CAGM2rebX7dq_ejNuSotV_0gJZY6pqro-KteXz9zzhDkjtSxaOw@mail.gmail.com> <ddb6bc3d-b764-3115-ebc7-54c70c967f24@roeck-us.net>
In-Reply-To: <ddb6bc3d-b764-3115-ebc7-54c70c967f24@roeck-us.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 24 Jul 2018 22:05:03 -0400
X-Gmail-Original-Message-ID: <CAGM2reaUEOMbbtfbLY2n66jJV=ZH0Wy7GtX-tfCG62U7Uhn14g@mail.gmail.com>
Message-ID: <CAGM2reaUEOMbbtfbLY2n66jJV=ZH0Wy7GtX-tfCG62U7Uhn14g@mail.gmail.com>
Subject: Re: [tip:x86/timers] sched/clock: Enable sched clock early
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8964 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=943
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807250044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> integrator_defconfig+CONFIG_DEVTMPFS=y+CONFIG_DEVTMPFS_MOUNT=y
>
> Qemu command line is
>         qemu-system-arm -M integratorcp  -m 128 \
>         -kernel arch/arm/boot/zImage -no-reboot \
>         -initrd busybox-armv4.cpio \
>         --append "rdinit=/sbin/init console=ttyAMA0,115200" \
>         -serial stdio -monitor null -nographic \
>         -dtb arch/arm/boot/dts/integratorcp.dtb
>
> The scripts and files used are available from git@github.com:groeck/linux-build-test.git.
> qemu is version 2.12.

Reproduced. Thank you
