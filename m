Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC941C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC872152E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC872152E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbeITKLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 06:11:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726195AbeITKLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 06:11:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8K4TMhR063017
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 00:29:38 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mm04kgjv1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 00:29:38 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 20 Sep 2018 05:29:37 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Sep 2018 05:29:33 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8K4TXYW57475098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Sep 2018 04:29:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A93611C054;
        Thu, 20 Sep 2018 07:29:17 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C589911C05B;
        Thu, 20 Sep 2018 07:29:16 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.53])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 20 Sep 2018 07:29:16 +0100 (BST)
Date:   Thu, 20 Sep 2018 07:29:30 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] docs/core-api: add memory allocation guide
References: <1536917278-31191-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536917278-31191-1-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18092004-0020-0000-0000-000002C8B354
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092004-0021-0000-0000-000021163216
Message-Id: <20180920042930.GA19495@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809200046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On Fri, Sep 14, 2018 at 12:27:55PM +0300, Mike Rapoport wrote:
> Hi,
> 
> As Vlastimil mentioned at [1], it would be nice to have some guide about
> memory allocation. This set adds such guide that summarizes the "best
> practices". 
> 
> The changes from the RFC include additions and corrections from Michal and
> Randy. I've also added markup to cross-reference the kernel-doc
> documentation.
> 
> I've split the patch into three to separate labels addition to the exiting
> files from the new contents.
> 
> v3 -> v4:
>   * make GFP_*USER* description less confusing
> 
> v2 -> v3:
>   * s/HW/hardware
> 
> [1] https://www.spinics.net/lists/netfilter-devel/msg55542.html
> 
> Mike Rapoport (3):
>   docs: core-api/gfp_mask-from-fs-io: add a label for cross-referencing
>   docs: core-api/mm-api: add a lable for GFP flags section
>   docs: core-api: add memory allocation guide
> 
>  Documentation/core-api/gfp_mask-from-fs-io.rst |   2 +
>  Documentation/core-api/index.rst               |   1 +
>  Documentation/core-api/memory-allocation.rst   | 122 +++++++++++++++++++++++++
>  Documentation/core-api/mm-api.rst              |   2 +
>  4 files changed, 127 insertions(+)
>  create mode 100644 Documentation/core-api/memory-allocation.rst
> 
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.

