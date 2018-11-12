Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433B9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126DA224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126DA224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbeKMEoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:44:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727530AbeKMEoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:44:22 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wACIhamf076544
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 13:49:53 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nqc4613t4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 13:49:52 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 12 Nov 2018 18:49:50 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Nov 2018 18:49:48 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wACInmhS8716774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 18:49:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8386AE057;
        Mon, 12 Nov 2018 18:49:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05A65AE045;
        Mon, 12 Nov 2018 18:49:47 +0000 (GMT)
Received: from dhcp-9-31-102-82.watson.ibm.com (unknown [9.31.102.82])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Nov 2018 18:49:46 +0000 (GMT)
Subject: Re: [PATCH 02/11] libnvdimm/security: change clear text nvdimm keys
 to encrypted keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        keyrings@vger.kernel.org
Date:   Mon, 12 Nov 2018 13:49:46 -0500
In-Reply-To: <bf917ee9-1795-9c10-ecec-28c7d5d68345@intel.com>
References: <154180093865.70506.6858789591063128903.stgit@djiang5-desk3.ch.intel.com>
         <154180163666.70506.8805433934495072699.stgit@djiang5-desk3.ch.intel.com>
         <1541957268.3734.53.camel@linux.ibm.com>
         <CAPcyv4jMPDap8L6jTo9NGnrJGCjUY_BvSBuPge8NL4QS2Ku0CQ@mail.gmail.com>
         <1541966975.3734.78.camel@linux.ibm.com>
         <bf917ee9-1795-9c10-ecec-28c7d5d68345@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18111218-4275-0000-0000-000002DFDF31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111218-4276-0000-0000-000037ECEB5D
Message-Id: <1542048586.3769.120.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=884 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-12 at 08:42 -0700, Dave Jiang wrote:

> How does one generate new encrypted keys with the system masterkey 
> removed from the keyring?

I don't think you can.

Mimi

