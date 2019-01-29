Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012DAC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA812083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfA2M1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:27:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727215AbfA2M1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:27:11 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0TCPLY5028943
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 07:27:10 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qamdhrkw6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 07:27:09 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 29 Jan 2019 12:27:08 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Jan 2019 12:27:05 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0TCR35g5570972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Jan 2019 12:27:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AEC111C05B;
        Tue, 29 Jan 2019 12:27:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 461BB11C052;
        Tue, 29 Jan 2019 12:27:03 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.212])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jan 2019 12:27:03 +0000 (GMT)
Date:   Tue, 29 Jan 2019 13:27:01 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Michael Mueller <mimu@linux.ibm.com>
Cc:     KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v6 10/13] KVM: s390: add kvm reference to struct
 sie_page2
In-Reply-To: <20190124125939.130763-11-mimu@linux.ibm.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-11-mimu@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012912-0020-0000-0000-0000030D4ABB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012912-0021-0000-0000-0000215E4E67
Message-Id: <20190129132701.563109e5@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=861 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 13:59:36 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> Adding the kvm reference to struct sie_page2 will allow to
> determine the kvm a given gisa belongs to:
> 
>   container_of(gisa, struct sie_page2, gisa)->kvm
> 
> This functionality will be required to process a gisa in
> gib alert interruption context.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>


Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

[..]

