Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C577AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 05:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6462075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 05:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6462075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbeICJbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 05:31:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725977AbeICJbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 05:31:17 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8358lA5078327
        for <linux-kernel@vger.kernel.org>; Mon, 3 Sep 2018 01:12:48 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m8u1spa4j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 01:12:47 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 3 Sep 2018 06:12:46 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 3 Sep 2018 06:12:43 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w835CgiV42467396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Sep 2018 05:12:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E80AAAE04D;
        Mon,  3 Sep 2018 08:12:07 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46554AE045;
        Mon,  3 Sep 2018 08:12:07 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.79])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  3 Sep 2018 08:12:07 +0100 (BST)
Date:   Mon, 3 Sep 2018 08:12:40 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Michal Hocko <mhocko@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] docs/core-api: add memory allocation guide
References: <1534517236-16762-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534517236-16762-1-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18090305-4275-0000-0000-000002B43073
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090305-4276-0000-0000-000037BD3CDA
Message-Id: <20180903051239.GB5826@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=949 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809030056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any updates on this?

On Fri, Aug 17, 2018 at 05:47:13PM +0300, Mike Rapoport wrote:
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
> Note that the second patch depends on the mm docs update [2] that Andrew
> took to the -mm tree.
> 
> v2 -> v3:
>   * s/HW/hardware
> 
> [1] https://www.spinics.net/lists/netfilter-devel/msg55542.html
> [2] https://lkml.org/lkml/2018/7/26/684
> 
> Mike Rapoport (3):
>   docs: core-api/gfp_mask-from-fs-io: add a label for cross-referencing
>   docs: core-api/mm-api: add a lable for GFP flags section
>   docs: core-api: add memory allocation guide
> 
>  Documentation/core-api/gfp_mask-from-fs-io.rst |   2 +
>  Documentation/core-api/index.rst               |   1 +
>  Documentation/core-api/memory-allocation.rst   | 124 +++++++++++++++++++++++++
>  Documentation/core-api/mm-api.rst              |   2 +
>  4 files changed, 129 insertions(+)
>  create mode 100644 Documentation/core-api/memory-allocation.rst
> 
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.

