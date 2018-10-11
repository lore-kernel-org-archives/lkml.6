Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA4BC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E65220652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E65220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeJKU30 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:29:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbeJKU30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:29:26 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BCrvJ9117383
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 09:02:19 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n26hw9grp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 09:02:18 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Thu, 11 Oct 2018 14:02:16 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Oct 2018 14:02:14 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9BD2DZP4981088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Oct 2018 13:02:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13698AE05A;
        Thu, 11 Oct 2018 16:00:56 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6875AE055;
        Thu, 11 Oct 2018 16:00:55 +0100 (BST)
Received: from mschwideX1 (unknown [9.152.212.164])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Oct 2018 16:00:55 +0100 (BST)
Date:   Thu, 11 Oct 2018 15:02:11 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Li Wang <liwang@redhat.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: s390: runtime warning about pgtables_bytes
In-Reply-To: <CAEemH2eExK_jwOPZDFBZkwABucpZqh+=s+qpN-tFfMzxwo7cZA@mail.gmail.com>
References: <CAEemH2eExK_jwOPZDFBZkwABucpZqh+=s+qpN-tFfMzxwo7cZA@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
X-TM-AS-GCONF: 00
x-cbid: 18101113-0008-0000-0000-0000027E21DD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101113-0009-0000-0000-000021E76940
Message-Id: <20181011150211.7d8c07ac@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=828 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018 18:04:12 +0800
Li Wang <liwang@redhat.com> wrote:

> When running s390 system with LTP/cve-2017-17052.c[1], the following BUG is
> came out repeatedly.
> I remember this warning start from kernel-4.16.0 and now it still exist in
> kernel-4.19-rc7.
> Can anyone take a look?
> 
> [ 2678.991496] BUG: non-zero pgtables_bytes on freeing mm: 16384
> [ 2679.001543] BUG: non-zero pgtables_bytes on freeing mm: 16384
> [ 2679.002453] BUG: non-zero pgtables_bytes on freeing mm: 16384
> [ 2679.003256] BUG: non-zero pgtables_bytes on freeing mm: 16384
> [ 2679.013689] BUG: non-zero pgtables_bytes on freeing mm: 16384
> [ 2679.024647] BUG: non-zero pgtables_bytes on freeing mm: 16384
> [ 2679.064408] BUG: non-zero pgtables_bytes on freeing mm: 16384
> [ 2679.133963] BUG: non-zero pgtables_bytes on freeing mm: 16384
> 
> [1]:
> https://github.com/linux-test-project/ltp/blob/master/testcases/cve/cve-2017-17052.c
 
Confirmed, I see this bug with cvs-2017-17052 on my LPAR as well.
I'll look into it.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

