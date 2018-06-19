Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC37C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF5F2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF5F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966373AbeFSN02 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:26:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966193AbeFSN00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:26:26 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5JDNrtv130366
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:26:25 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jq1sjjwdv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:26:25 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alifm@linux.ibm.com>;
        Tue, 19 Jun 2018 07:26:24 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Jun 2018 07:26:21 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5JDQKO710813730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jun 2018 06:26:20 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36981C6065;
        Tue, 19 Jun 2018 07:26:20 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7809DC6055;
        Tue, 19 Jun 2018 07:26:19 -0600 (MDT)
Received: from [9.56.58.93] (unknown [9.56.58.93])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 19 Jun 2018 07:26:19 -0600 (MDT)
Subject: Re: [PATCH v2 0/2] Detect & register virtio-crypto algos only if it
 can be supported by backend
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     mst@redhat.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com,
        longpeng2@huawei.com, pasic@linux.ibm.com, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
References: <cover.1528921468.git.alifm@linux.ibm.com>
From:   Farhan Ali <alifm@linux.ibm.com>
Date:   Tue, 19 Jun 2018 09:26:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <cover.1528921468.git.alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18061913-0036-0000-0000-00000A00DDC7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009219; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049250; UDB=6.00537616; IPR=6.00828223;
 MB=3.00021736; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-19 13:26:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061913-0037-0000-0000-000047CBB666
Message-Id: <44ccc5db-e1d4-27b7-8942-c77f467f422e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806190152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A polite ping :)

If no one has any more comments/feedback then I would like to how to 
merge these patches to the mainline kernel tree.

Thanks
Farhan

On 06/13/2018 04:38 PM, Farhan Ali wrote:
> Hi,
> 
> Currently the Linux virtio-crypto driver registers the crypto
> algorithm without verifying if the backend actually supports the
> algorithm.
> 
> This kernel patch series adds support for registering algorithm
> with Linux crypto layer, only if the algorithm is supported by
> the backend device. This also makes the driver more compliant with
> the virtio-crypto spec [1].
> 
> I would appreciate any feedback or comments on this.
> 
> Thank you
> Farhan
> 
> Reference
> ---------
> [1] Virtio crypto spec proposal https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00816.html
> 
> ChangeLog
> ---------
> v1 -> v2
>     - Modify comment as suggested by Arei (patch 1)
>     - Modify error message as suggested by Arei (patch 2)
> 
> 
> Farhan Ali (2):
>    crypto/virtio-crypto: Read crypto services and algorithm masks
>    crypto/virtio-crypto: Register an algo only if it's supported
> 
>   drivers/crypto/virtio/virtio_crypto_algs.c   | 112 ++++++++++++++++++---------
>   drivers/crypto/virtio/virtio_crypto_common.h |  25 +++++-
>   drivers/crypto/virtio/virtio_crypto_core.c   |  29 +++++++
>   drivers/crypto/virtio/virtio_crypto_mgr.c    |  81 +++++++++++++++++--
>   4 files changed, 202 insertions(+), 45 deletions(-)
> 

