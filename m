Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549FEC67838
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F94C20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F94C20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbeLIUdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:33:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726246AbeLIUdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:33:10 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB9KSqo1072666
        for <linux-kernel@vger.kernel.org>; Sun, 9 Dec 2018 15:33:08 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p98m5an2j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 15:33:08 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 9 Dec 2018 20:33:07 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 9 Dec 2018 20:33:04 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB9KX38B58064988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 9 Dec 2018 20:33:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 157A64C040;
        Sun,  9 Dec 2018 20:33:03 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E0C14C046;
        Sun,  9 Dec 2018 20:33:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.88.113])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  9 Dec 2018 20:33:01 +0000 (GMT)
Subject: Re: [PATCH v6 4/7] tpm: modify tpm_pcr_read() definition to pass a
 TPM hash algorithm
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Sun, 09 Dec 2018 15:32:51 -0500
In-Reply-To: <2f6c0365-6c17-2da1-9f5b-3c8e5cc301b2@huawei.com>
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
         <20181204082138.24600-5-roberto.sassu@huawei.com>
         <20181204234024.GC1233@linux.intel.com>
         <1544041904.4017.8.camel@linux.ibm.com>
         <1544125756.4017.70.camel@linux.ibm.com>
         <2f6c0365-6c17-2da1-9f5b-3c8e5cc301b2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18120920-0012-0000-0000-000002D6BDB8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120920-0013-0000-0000-0000210C2DE6
Message-Id: <1544387571.3794.17.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-09_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=857 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812090189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-07 at 15:51 +0100, Roberto Sassu wrote:
> On 12/6/2018 8:49 PM, Mimi Zohar wrote:

> > PCRs for sha1 and sha256 algorithms are being updated and the
> > measurement list verifies against the SHA1 PCR-10.
> > 
> > Roberto, have you added support in ima-evm-utils to validate the other
> > banks?
> 
> I modified IMA LTP.

I'm not finding it.  Was the test for the current code, where the same
value is being padded for different algorithms, or for walking the
proposed hash agile format?

Mimi

