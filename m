Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C301AC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792D721471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XsZz2DuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792D721471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732370AbeGLDAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 23:00:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46382 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbeGLDAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 23:00:52 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6C2i5Sk078473;
        Thu, 12 Jul 2018 02:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=OnbjnVd6dKHGHU6/jnDFS1tjvvt44ra9wrGOWE3a9Uc=;
 b=XsZz2DuTAjaa1z1itlZATYfytWS5At2+bc9ha77v+0+p4jyHte/xkedLVdcZLP773qD3
 48upR0hbMf+eIW/4kgVJ7W2pmP+UEa7ZTP6014n/vI5vnTAGxe69vM4ZKLSLCccJnExt
 hVW3BTPCXG8zw/zUboXrudh6drOTwWnxKAdu12sIpcMhrrTVZT1NOZBlezbOrM77eMy2
 NbkSNlM1XY/3B+ylSFWLwcy7hIfJDbLadSfxUj+o7aIlwywUkjVKxWw+kLmcRg0PQ70Y
 jq6kAN/Z87CNOFRdYWMpDfWI2GmxqEdSoltFEhi0l63vCx5+d+7WSeM+UFIDr8/VtZJv dQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2k2p760guq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 02:53:31 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6C2rUx7014237
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 02:53:30 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6C2rUhN020053;
        Thu, 12 Jul 2018 02:53:30 GMT
Received: from mail-oi0-f50.google.com (/209.85.218.50)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 19:53:30 -0700
Received: by mail-oi0-f50.google.com with SMTP id v8-v6so53099083oie.5;
        Wed, 11 Jul 2018 19:53:29 -0700 (PDT)
X-Gm-Message-State: AOUpUlGQRbmaM3ycalUo3FvFOxULbInqfvNpHbtDQBXiPfw8M8y1TqO+
        DEt2Uo5cJ7beFBY6WBPLzRv4rnbGzaulpEYBm5g=
X-Google-Smtp-Source: AAOMgpdbyXlzk+apjb+LOFdABiSnnxYKIdw48qeFrD1+gDuH9Ki03mQrF9D39eDip50QufyLKjiEPwE63CusjG+iGpw=
X-Received: by 2002:aca:db09:: with SMTP id s9-v6mr450243oig.339.1531364009740;
 Wed, 11 Jul 2018 19:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180706161307.733337643@linutronix.de> <20180706162049.765314976@linutronix.de>
In-Reply-To: <20180706162049.765314976@linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 11 Jul 2018 22:52:53 -0400
X-Gmail-Original-Message-ID: <CAGM2reY5MoUq_BSHwE7GN=55oM1dNhXZ8s_z58HxbARu+REsSA@mail.gmail.com>
Message-ID: <CAGM2reY5MoUq_BSHwE7GN=55oM1dNhXZ8s_z58HxbARu+REsSA@mail.gmail.com>
Subject: Re: [patch 6/7] x86/kvmclock: Move kvmclock vsyscall param and init
 to kvmclock
To:     tglx@linutronix.de
Cc:     LKML <linux-kernel@vger.kernel.org>, pbonzini@redhat.com,
        rkrcmar@redhat.com, peterz@infradead.org, jgross@suse.com,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>, x86@kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=702
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807120029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+#include <asm/hypervisor.h>

Can be removed, because as Paolo, noticed X86_HYPER_KVM check is not needed.

> +static int __init kvm_setup_vsyscall_timeinfo(void)
> +{
> +#ifdef CONFIG_X86_64
> +       u8 flags;
> +
> +       if (!hv_clock || !kvmclock_vsyscall)
> +               return 0;
> +
> +       flags = pvclock_read_flags(&hv_clock[0].pvti);
> +       if (!(flags & PVCLOCK_TSC_STABLE_BIT))
> +               return 1;
> +
> +       pvclock_set_pvti_cpu0_va(hv_clock);
> +       kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
> +#endif
> +       return 0;
> +}
> +early_initcall(kvm_setup_vsyscall_timeinfo);
> +
....
> -
> -int __init kvm_setup_vsyscall_timeinfo(void)
> -{
> -#ifdef CONFIG_X86_64
> -       u8 flags;
> -
> -       if (!hv_clock)
> -               return 0;
> -
> -       flags = pvclock_read_flags(&hv_clock[0].pvti);
> -       if (!(flags & PVCLOCK_TSC_STABLE_BIT))
> -               return 1;
> -
> -       pvclock_set_pvti_cpu0_va(hv_clock);
> -       kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
> -#endif
> -       return 0;
> -}

I am not sure what the point of moving this function. The patch would
be much smaller without it.

Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
