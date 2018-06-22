Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C789C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E10C248F3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E10C248F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754541AbeFVVQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:16:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754382AbeFVVQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:16:32 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MLDw9F050716
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 17:16:31 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2js4ef9ac4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 17:16:31 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <arbab@linux.vnet.ibm.com>;
        Fri, 22 Jun 2018 15:16:31 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Jun 2018 15:16:26 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5MLGPXq10027302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jun 2018 14:16:25 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EAB1BE051;
        Fri, 22 Jun 2018 15:16:25 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36F6ABE04F;
        Fri, 22 Jun 2018 15:16:25 -0600 (MDT)
Received: from arbab-laptop.localdomain (unknown [9.53.92.213])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 22 Jun 2018 15:16:25 -0600 (MDT)
Received: from arbab-laptop.localdomain (localhost.localdomain [IPv6:::1])
        by arbab-laptop.localdomain (Postfix) with ESMTP id BABD14602F4;
        Fri, 22 Jun 2018 16:16:23 -0500 (CDT)
Date:   Fri, 22 Jun 2018 16:16:23 -0500
From:   Reza Arbab <arbab@linux.vnet.ibm.com>
To:     osalvador@techadventures.net
Cc:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        pasha.tatashin@oracle.com, Jonathan.Cameron@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 0/4] Small cleanup for memoryhotplug
References: <20180622111839.10071-1-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180622111839.10071-1-osalvador@techadventures.net>
Organization: IBM Linux Technology Center
User-Agent: NeoMutt/20180512
X-TM-AS-GCONF: 00
x-cbid: 18062221-8235-0000-0000-00000DC5DF31
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009242; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01050841; UDB=6.00538569; IPR=6.00829811;
 MB=3.00021811; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-22 21:16:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062221-8236-0000-0000-0000419EDA90
Message-Id: <20180622211622.hwkcrlexjo5ygxns@arbab-laptop.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=712 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806220234
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 10:32:58AM +0200, Michal Hocko wrote:
>[Cc Reza Arbab - I remember he was able to hit some bugs in memblock
>registration code when I was reworking that area previously]

Thanks for the heads-up!

I have verified that this patchset doesn't seem to cause any regression 
in the kooky memoryless node use case I was testing.

-- 
Reza Arbab

