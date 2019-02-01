Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF4AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1802C218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbfBAP7e convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:59:34 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51415 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726172AbfBAP7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:59:33 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x11FudRT030104;
        Fri, 1 Feb 2019 16:59:29 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qc941vs10-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 01 Feb 2019 16:59:29 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8E3533A;
        Fri,  1 Feb 2019 15:59:28 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6CB2C5143;
        Fri,  1 Feb 2019 15:59:28 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 1 Feb
 2019 16:59:27 +0100
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Fri, 1 Feb 2019 16:59:27 +0100
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arnaud POULIQUEN" <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "s-anna@ti.com" <s-anna@ti.com>
Subject: RE: [PATCH v2 0/7] remoteproc: Fixes for memoy carveout management
Thread-Topic: [PATCH v2 0/7] remoteproc: Fixes for memoy carveout management
Thread-Index: AQHUqOtJYKXS3arRdkq+Wy8b8EMBf6XLO5Kg
Date:   Fri, 1 Feb 2019 15:59:27 +0000
Message-ID: <6d88bb6cdf1947c185b7aebe01a998a0@SFHDAG7NODE2.st.com>
References: <1547128151-44077-1-git-send-email-loic.pallardy@st.com>
In-Reply-To: <1547128151-44077-1-git-send-email-loic.pallardy@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-01_11:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

> -----Original Message-----
> From: Loic PALLARDY <loic.pallardy@st.com>
> Sent: jeudi 10 janvier 2019 14:49
> To: bjorn.andersson@linaro.org; ohad@wizery.com
> Cc: linux-remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org;
> Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
> benjamin.gaignard@linaro.org; s-anna@ti.com; Loic PALLARDY
> <loic.pallardy@st.com>
> Subject: [PATCH v2 0/7] remoteproc: Fixes for memoy carveout
> management
> 
> These patches fix the comments sent on remoteproc mailing
> list after acceptation of memory carveout patch series [1].
> 
> In few words, series corrects:
> - memory carveout allocation for rproc without iommu
> - rproc_da_to_va and trace buffer access to take into account
>   late carveout allocation
> - resource table cast by adding warning messages

Could you please merge this series for next pull request as it contains only fixes of patches merged in kernel 4.20.

Regards,
Loic 

> 
> Regards,
> Loic
> 
> [1] https://lkml.org/lkml/2018/7/27/612
> 
> ---
> Changes from v1:
> - Modify way to notify resource table cast issue
> - Complete trace buffer patch
> 
> 
> Loic Pallardy (7):
>   remoteproc: correct rproc_mem_entry_init() comments
>   remoteproc: fix rproc_da_to_va in case of unallocated carveout
>   remoteproc: fix rproc_alloc_carveout() bad variable cast
>   remoteproc: add warning on resource table cast
>   remoteproc: fix rproc_alloc_carveout() for rproc with iommu domain
>   remoteproc: fix trace buffer va initialization
>   remoteproc: fix rproc_check_carveout_da() returned error and comments
> 
>  drivers/remoteproc/remoteproc_core.c     | 108 ++++++++++++++++++-----
> --------
>  drivers/remoteproc/remoteproc_debugfs.c  |  21 ++++--
>  drivers/remoteproc/remoteproc_internal.h |   9 ++-
>  3 files changed, 89 insertions(+), 49 deletions(-)
> 
> --
> 2.7.4

