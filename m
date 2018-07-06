Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61EBC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A10420837
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A10420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbeGFOLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:11:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753075AbeGFOLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:11:30 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w66E8Ycp014457
        for <linux-kernel@vger.kernel.org>; Fri, 6 Jul 2018 10:11:30 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k29wug4gb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:11:29 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
        Fri, 6 Jul 2018 15:11:27 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Jul 2018 15:11:25 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w66EBOB216908354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Jul 2018 14:11:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80B7311C07F;
        Fri,  6 Jul 2018 17:11:48 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5285611C069;
        Fri,  6 Jul 2018 17:11:47 +0100 (BST)
Received: from skywalker (unknown [9.199.55.125])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri,  6 Jul 2018 17:11:47 +0100 (BST)
Received: (nullmailer pid 20426 invoked by uid 1000);
        Fri, 06 Jul 2018 14:11:22 -0000
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc:     paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 00/10] KASan ppc64 support
In-Reply-To: <7d459964-ce68-db1c-3d28-ae206d5ebdb0@c-s.fr>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com> <CAPAsAGyMBnGJyBCoq2n9YSgC73GXr9-w3SjCTVdfz++drzOVGw@mail.gmail.com> <87k2sic6pw.fsf@linux.vnet.ibm.com> <7d459964-ce68-db1c-3d28-ae206d5ebdb0@c-s.fr>
Date:   Fri, 06 Jul 2018 19:41:21 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18070614-0016-0000-0000-000001E41DBF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070614-0017-0000-0000-0000323890C2
Message-Id: <87h8lch2t2.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=769 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807060156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Hi Aneesh,
>
> Are you still working on support for KASan for ppc64 ?
>

Haven't got time to work on this. The hash memory layout makes it
a bit complicated to implement this.

-aneesh

