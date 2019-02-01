Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB4DC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA3D20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kCYyN/5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfBAHHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:07:52 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38906 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfBAHHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:07:51 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x1173hRM143618;
        Fri, 1 Feb 2019 07:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=r3IWrG34oLJ0PgAvd5kQCIqTRBZnuQWbLQOXPQoCqS0=;
 b=kCYyN/5Qwx6IzNV/xjFViRbvbRonZBvy4/mgRQKgKe4NceMkRdey3JA8LT3IJ7hyne4e
 t8n+4LlRhA7lfHNQaEp3PVhNnsNENXVUZtt+PtOtbyRa7YQDWFCN/wZoJdSTGy6glcKC
 5BUt75F0AgdWtMf98AzdLSwI4tF9IS9IkhCiEBhOdpEpAsXWN3EiMJJMgKUegz0bG6RV
 hyAcEFflwN3rSM6UbIIjpgHZilGBEtxvOfTYN/V2csOJKu5aDa1P2UF7yEeaPlYxxq4O
 uQ/0wYVPWqND+m0npTpHoOuwp3gpB7YYYeF8td+a86AGV9GnpUuoFvS51JF4bvWrTbiQ wA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2q8d2en1sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Feb 2019 07:07:16 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1177Fat007406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Feb 2019 07:07:15 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1177C6C008766;
        Fri, 1 Feb 2019 07:07:12 GMT
Received: from kadam (/197.157.0.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Jan 2019 23:07:11 -0800
Date:   Fri, 1 Feb 2019 10:06:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     lantianyu1986@gmail.com
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com,
        mchehab+samsung@kernel.org, sashal@kernel.org,
        sthemmin@microsoft.com, joro@8bytes.org, x86@kernel.org,
        michael.h.kelley@microsoft.com, mingo@redhat.com,
        Lan Tianyu <Tianyu.Lan@microsoft.com>, arnd@arndb.de,
        haiyangz@microsoft.com, alex.williamson@redhat.com, bp@alien8.de,
        tglx@linutronix.de, vkuznets@redhat.com,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        iommu@lists.linux-foundation.org, devel@linuxdriverproject.org,
        akpm@linux-foundation.org, davem@davemloft.net
Subject: Re: [PATCH 1/3] x86/Hyper-V: Set x2apic destination mode to physical
 when x2apic is available
Message-ID: <20190201070655.GA14343@kadam>
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1548929853-25877-2-git-send-email-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548929853-25877-2-git-send-email-Tianyu.Lan@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9153 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=980 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902010052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 06:17:31PM +0800, lantianyu1986@gmail.com wrote:
>
>

This comment needs to be indented one tab or it looks like we're outside
the funciton.

> +/*
> + * Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> + * set x2apic destination mode to physcial mode when x2apic is available
> + * and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs
> + * have 8-bit APIC id.
> + */
> +# if IS_ENABLED(CONFIG_HYPERV_IOMMU)
> +	if (x2apic_supported())
> +		x2apic_phys = 1;
> +# endif

The IS_ENABLED() macro is really magical.  You could write this like so:

	if (IS_ENABLED(CONFIG_HYPERV_IOMMU) && x2apic_supported())
		x2apic_phys = 1;

It works the same and is slightly more pleasant to look at.

regards,
dan carpenter

