Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D79ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896C220779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896C220779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387907AbeGWH2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:28:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387828AbeGWH2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:28:11 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6N6SSH1017690
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 02:28:33 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kd7r4vq0p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 02:28:33 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <khandual@linux.vnet.ibm.com>;
        Mon, 23 Jul 2018 07:28:30 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Jul 2018 07:28:27 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6N6SQTN38862882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jul 2018 06:28:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36B1911C05C;
        Mon, 23 Jul 2018 09:28:41 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D488B11C04C;
        Mon, 23 Jul 2018 09:28:38 +0100 (BST)
Received: from [9.109.221.92] (unknown [9.109.221.92])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Jul 2018 09:28:38 +0100 (BST)
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
To:     "Michael S. Tsirkin" <mst@redhat.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720161541-mutt-send-email-mst@kernel.org>
Cc:     robh@kernel.org, srikar@linux.vnet.ibm.com, aik@ozlabs.ru,
        jasowang@redhat.com, linuxram@us.ibm.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, hch@infradead.org,
        paulus@samba.org, joe@perches.com, linuxppc-dev@lists.ozlabs.org,
        elfring@users.sourceforge.net, haren@linux.vnet.ibm.com,
        david@gibson.dropbear.id.au
From:   Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date:   Mon, 23 Jul 2018 11:58:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180720161541-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18072306-4275-0000-0000-0000029C40FC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072306-4276-0000-0000-000037A47131
Message-Id: <8f51d2c6-cc0c-9e42-f0fd-a8a33acc8b83@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807230077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/2018 06:46 PM, Michael S. Tsirkin wrote:
> On Fri, Jul 20, 2018 at 09:29:37AM +0530, Anshuman Khandual wrote:
>> This patch series is the follow up on the discussions we had before about
>> the RFC titled [RFC,V2] virtio: Add platform specific DMA API translation
>> for virito devices (https://patchwork.kernel.org/patch/10417371/). There
>> were suggestions about doing away with two different paths of transactions
>> with the host/QEMU, first being the direct GPA and the other being the DMA
>> API based translations.
>>
>> First patch attempts to create a direct GPA mapping based DMA operations
>> structure called 'virtio_direct_dma_ops' with exact same implementation
>> of the direct GPA path which virtio core currently has but just wrapped in
>> a DMA API format. Virtio core must use 'virtio_direct_dma_ops' instead of
>> the arch default in absence of VIRTIO_F_IOMMU_PLATFORM flag to preserve the
>> existing semantics. The second patch does exactly that inside the function
>> virtio_finalize_features(). The third patch removes the default direct GPA
>> path from virtio core forcing it to use DMA API callbacks for all devices.
>> Now with that change, every device must have a DMA operations structure
>> associated with it. The fourth patch adds an additional hook which gives
>> the platform an opportunity to do yet another override if required. This
>> platform hook can be used on POWER Ultravisor based protected guests to
>> load up SWIOTLB DMA callbacks to do the required (as discussed previously
>> in the above mentioned thread how host is allowed to access only parts of
>> the guest GPA range) bounce buffering into the shared memory for all I/O
>> scatter gather buffers to be consumed on the host side.
>>
>> Please go through these patches and review whether this approach broadly
>> makes sense. I will appreciate suggestions, inputs, comments regarding
>> the patches or the approach in general. Thank you.
> I like how patches 1-3 look. Could you test performance
> with/without to see whether the extra indirection through
> use of DMA ops causes a measurable slow-down?

I ran this simple DD command 10 times where /dev/vda is a virtio block
device of 10GB size.

dd if=/dev/zero of=/dev/vda bs=8M count=1024 oflag=direct

With and without patches bandwidth which has a bit wide range does not
look that different from each other.

Without patches
===============

---------- 1 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.95557 s, 4.4 GB/s
---------- 2 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 2.05176 s, 4.2 GB/s
---------- 3 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.88314 s, 4.6 GB/s
---------- 4 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.84899 s, 4.6 GB/s
---------- 5 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 5.37184 s, 1.6 GB/s
---------- 6 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.9205 s, 4.5 GB/s
---------- 7 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 6.85166 s, 1.3 GB/s
---------- 8 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.74049 s, 4.9 GB/s
---------- 9 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 6.31699 s, 1.4 GB/s
---------- 10 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 2.47057 s, 3.5 GB/s


With patches
============

---------- 1 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 2.25993 s, 3.8 GB/s
---------- 2 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.82438 s, 4.7 GB/s
---------- 3 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.93856 s, 4.4 GB/s
---------- 4 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.83405 s, 4.7 GB/s
---------- 5 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 7.50199 s, 1.1 GB/s
---------- 6 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 2.28742 s, 3.8 GB/s
---------- 7 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 5.74958 s, 1.5 GB/s
---------- 8 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.99149 s, 4.3 GB/s
---------- 9 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 5.67647 s, 1.5 GB/s
---------- 10 ---------
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 2.93957 s, 2.9 GB/s

Does this look okay ?

