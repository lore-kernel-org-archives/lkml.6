Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABB3C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B28217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfBHSM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:12:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727863AbfBHSM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:12:57 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x18I46iw104899
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 13:12:56 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qhd3s4xx0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 13:12:55 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Fri, 8 Feb 2019 18:12:53 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Feb 2019 18:12:51 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x18ICopq4981158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Feb 2019 18:12:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AADDAE051;
        Fri,  8 Feb 2019 18:12:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5ACF8AE045;
        Fri,  8 Feb 2019 18:12:49 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.183])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  8 Feb 2019 18:12:49 +0000 (GMT)
Date:   Fri, 8 Feb 2019 20:12:47 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] generic asm: mman cleanup
References: <20190124142448.23243-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124142448.23243-1-mst@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19020818-0012-0000-0000-000002F37387
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020818-0013-0000-0000-0000212ADDE2
Message-Id: <20190208181246.GF11096@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=649 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 01:02:51AM -0500, Michael S. Tsirkin wrote:
> Now that we have MAP_SHARED, MAP_PRIVATE and MAP_SHARED_VALIDATE on all
> architectures, it probably makes sense to de-duplicate these
> and put them into a common header.

I like the idea, but it seems there are more asm/mman.h users than just mpx
and drm.

Any reason only those were updated to include linux/mman.h?

 
> Please review and consider merging though the generic tree.
> 
> Build tested on x86 only. Has been in linux-next for a while now.
> 
> Michael S. Tsirkin (3):
>   x86/mpx: tweak header name
>   drm: tweak header name
>   arch: move common mmap flags to linux/mman.h
> 
>  arch/alpha/include/uapi/asm/mman.h     | 4 +---
>  arch/mips/include/uapi/asm/mman.h      | 4 +---
>  arch/parisc/include/uapi/asm/mman.h    | 4 +---
>  arch/x86/mm/mpx.c                      | 2 +-
>  arch/xtensa/include/uapi/asm/mman.h    | 4 +---
>  include/drm/drmP.h                     | 3 +--
>  include/uapi/asm-generic/mman-common.h | 4 +---
>  include/uapi/linux/mman.h              | 4 ++++
>  8 files changed, 11 insertions(+), 18 deletions(-)
> 
> -- 
> MST
> 

-- 
Sincerely yours,
Mike.

