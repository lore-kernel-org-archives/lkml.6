Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55A5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E8C20665
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfAHIWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:22:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728018AbfAHIW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:22:29 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x088JGAR021543
        for <linux-kernel@vger.kernel.org>; Tue, 8 Jan 2019 03:22:28 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pvr6t8b7t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 03:22:28 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 8 Jan 2019 08:22:26 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 8 Jan 2019 08:22:22 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x088MLPR2425178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jan 2019 08:22:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 341264204B;
        Tue,  8 Jan 2019 08:22:21 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA79E4203F;
        Tue,  8 Jan 2019 08:22:20 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  8 Jan 2019 08:22:20 +0000 (GMT)
Date:   Tue, 8 Jan 2019 09:22:19 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        chris@zankel.net, fenghua.yu@intel.com, tglx@linutronix.de,
        schwidefsky@de.ibm.com, linux-ia64@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 1/8] arch: Use asm-generic/socket.h when possible
References: <20190108032657.8331-1-deepa.kernel@gmail.com>
 <20190108032657.8331-2-deepa.kernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20190108032657.8331-2-deepa.kernel@gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 19010808-0008-0000-0000-000002ACC4DD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010808-0009-0000-0000-00002218D1B1
Message-Id: <20190108082219.GA7023@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=405 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 07:26:50PM -0800, Deepa Dinamani wrote:
> Many architectures maintain an arch specific copy of the
> file even though there are no differences with the asm-generic
> one. Allow these architectures to use the generic one instead.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
>  arch/s390/include/uapi/asm/Kbuild     |   1 +
>  arch/s390/include/uapi/asm/socket.h   | 117 ------------------------

For the s390 bits:

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

