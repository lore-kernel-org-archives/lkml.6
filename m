Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77D3C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D66208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D66208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934094AbeFRL0y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:26:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933381AbeFRL0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:26:52 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5IBNrGL128981
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 07:26:52 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jpa3q4bx7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 07:26:51 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Mon, 18 Jun 2018 12:26:48 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Jun 2018 12:26:46 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5IBQjrg33226792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Jun 2018 11:26:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 565C152043;
        Mon, 18 Jun 2018 11:16:05 +0100 (BST)
Received: from mschwideX1 (unknown [9.152.212.186])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 151E45203F;
        Mon, 18 Jun 2018 11:16:05 +0100 (BST)
Date:   Mon, 18 Jun 2018 13:26:43 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>, y2038@lists.linaro.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: hypfs: use ktime_get_seconds() instead of
 get_seconds()
In-Reply-To: <20180618100534.1857997-1-arnd@arndb.de>
References: <20180618100534.1857997-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18061811-0016-0000-0000-000001DD3B1D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061811-0017-0000-0000-000032313EF6
Message-Id: <20180618132643.79cbed17@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=591 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806180138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018 12:05:00 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> time_t and get_seconds() are deprecated because they will overflow on
> 32-bit architectures in the future. This is not a problem on 64-bit s390,
> but we should use proper interfaces anyway.
> 
> Besides moving to the time64_t based interface, the CLOCK_MONOTONIC
> based ktime_get_seconds() is preferred for kernel internal timekeeping
> because it does not behave in unexpected ways during leap second changes
> or settimeofday() calls.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Added to my set of patches for the next merge window.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

