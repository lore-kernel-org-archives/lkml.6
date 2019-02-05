Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E62C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D55120844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfBEKFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:05:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728921AbfBEKFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:05:53 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x159wswC001453
        for <linux-kernel@vger.kernel.org>; Tue, 5 Feb 2019 05:05:52 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qf6km5g49-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 05:05:52 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 5 Feb 2019 10:05:50 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Feb 2019 10:05:46 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x15A5iXM721342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Feb 2019 10:05:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91DA611C052;
        Tue,  5 Feb 2019 10:05:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2787D11C05B;
        Tue,  5 Feb 2019 10:05:44 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Feb 2019 10:05:44 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v7 12/15] KVM: s390: kvm_s390_gisa_clear() now clears the
 IPM only
To:     Michael Mueller <mimu@linux.ibm.com>,
        KVM Mailing List <kvm@vger.kernel.org>
Cc:     Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
 <20190131085247.13826-13-mimu@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Tue, 5 Feb 2019 11:05:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131085247.13826-13-mimu@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19020510-0028-0000-0000-000003445C61
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020510-0029-0000-0000-000024026495
Message-Id: <a0a9510d-c399-6f7f-36bf-3610abebfeae@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902050080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2019 09:52, Michael Mueller wrote:
> Function kvm_s390_gisa_clear() now clears the Interruption
> Pending Mask of the GISA asap. If the GISA is in the alert
> list at this time it stays in the list but is removed by
> process_gib_alert_list().
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>


I would have written "will be removed by ...." however

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

