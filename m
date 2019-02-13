Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E24C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA222222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393568AbfBMSGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:06:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729522AbfBMSGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:06:12 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DHx1mu018865
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:06:11 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qmqp01g0s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:06:10 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 13 Feb 2019 18:06:08 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Feb 2019 18:06:04 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1DI63AM2228508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Feb 2019 18:06:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 821EF4C05E;
        Wed, 13 Feb 2019 18:06:03 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15D864C04A;
        Wed, 13 Feb 2019 18:06:01 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.163])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 13 Feb 2019 18:06:00 +0000 (GMT)
Date:   Wed, 13 Feb 2019 20:05:58 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v4 6/6] RISC-V: Free-up initrd in free_initrd_mem()
References: <20190213063127.28703-1-anup.patel@wdc.com>
 <20190213063127.28703-7-anup.patel@wdc.com>
 <20190213064419.GA27012@infradead.org>
 <20190213073835.GA18267@rapoport-lnx>
 <20190213175415.GA11635@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213175415.GA11635@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19021318-0028-0000-0000-000003483187
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021318-0029-0000-0000-000024065633
Message-Id: <20190213180557.GA15270@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-13_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=770 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902130126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 09:54:15AM -0800, Christoph Hellwig wrote:
> On Wed, Feb 13, 2019 at 09:38:36AM +0200, Mike Rapoport wrote:
> > memblock_free() is has no real effect at this point, no idea why arm64
> > calls it.
> 
> Looks like the call was added fairly recently by:
> 
> commit 05c58752f9dce11e396676eb731a620541590ed0
> Author: CHANDAN VN <chandan.vn@samsung.com>
> Date:   Mon Apr 30 09:50:18 2018 +0530
> 
>     arm64: To remove initrd reserved area entry from memblock
> 
> which claims it is to work around the initrd being displayed in
> /sys/kernel/debug/memblock/reserved.
> 
> I really think we need to have common behavior there - either do this
> for all architectures or none.  I've just sent a series that
> consolidates all but a handful of the free_initrd_mem, so implementing
> any common behavior on top of that would be good.

I've just started to look into it today :)
I'll reply on that thread.

-- 
Sincerely yours,
Mike.

