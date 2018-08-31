Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0701CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB5120658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB5120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeHaPa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:30:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbeHaPa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:30:56 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7VBK5ro106946
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 07:23:55 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m741v9s44-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 07:23:54 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ivan@de.ibm.com>;
        Fri, 31 Aug 2018 12:23:52 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 31 Aug 2018 12:23:49 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7VBNnmX18808868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Aug 2018 11:23:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19E4C4204C;
        Fri, 31 Aug 2018 14:23:46 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D3B142041;
        Fri, 31 Aug 2018 14:23:46 +0100 (BST)
Received: from d06ml001.portsmouth.uk.ibm.com (unknown [9.149.76.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 31 Aug 2018 14:23:46 +0100 (BST)
Received: from localhost.localdomain ([9.145.170.35])
          by d06ml001.portsmouth.uk.ibm.com (IBM Domino Release 9.0.1FP10HF192)
          with ESMTP id 2018083112234840-26468 ;
          Fri, 31 Aug 2018 12:23:48 +0100 
From:   Ivan Mikhaylov <ivan@de.ibm.com>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Christian Lamparter" <chunkeey@gmail.com>
Subject: Re: [PATCH 2/2] net/ibm/emac: deletion of unneeded macros definitions
Date:   Fri, 31 Aug 2018 14:23:45 +0300
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180829.181007.967677259832053608.davem@davemloft.net>
References: <20180829.181007.967677259832053608.davem@davemloft.net>
X-MIMETrack: Itemize by SMTP Server on D06ML001/06/M/IBM(Release 9.0.1FP10HF192 | April
 16, 2018) at 31/08/2018 12:23:48,
        Serialize by Router on D06ML001/06/M/IBM(Release 9.0.1FP10HF192 | April 16, 2018) at
 31/08/2018 12:23:48,
        Serialize complete at 31/08/2018 12:23:48
X-TNEFEvaluated: 1
X-TM-AS-GCONF: 00
x-cbid: 18083111-0008-0000-0000-0000026A4136
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18083111-0009-0000-0000-000021D244EB
Message-Id: <20180831112345.16594-1-ivan@de.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-31_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=739 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808310119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Please do not delete these, they could be useful for other
>developers and people reading this driver.
Hmm, that's possible, need I resubmit first patch without this one?

