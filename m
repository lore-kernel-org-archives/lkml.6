Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbeDFCxV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 22:53:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751315AbeDFCxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 22:53:19 -0400
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
 <3e1b113b-79ca-b700-5be9-10c66d74aabe@linux.vnet.ibm.com>
 <20180405175326-mutt-send-email-mst@kernel.org>
 <1522940983.21446.205.camel@kernel.crashing.org>
 <20180405213042-mutt-send-email-mst@kernel.org>
 <1522963113.21446.211.camel@kernel.crashing.org>
Cc: robh@kernel.org, aik@ozlabs.ru, jasowang@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, joe@perches.com,
        david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
        elfring@users.sourceforge.net
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 6 Apr 2018 08:23:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1522963113.21446.211.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18040602-0008-0000-0000-000004E75044
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040602-0009-0000-0000-00001E7A685E
Message-Id: <70cb433f-a8f7-5199-3c96-a760c7624804@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-06_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804060027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2018 02:48 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2018-04-05 at 21:34 +0300, Michael S. Tsirkin wrote:
>>> In this specific case, because that would make qemu expect an iommu,
>>> and there isn't one.
>>
>>
>> I think that you can set iommu_platform in qemu without an iommu.
> 
> No I mean the platform has one but it's not desirable for it to be used
> due to the performance hit.

Also the only requirement is to bounce the I/O buffers through SWIOTLB
implemented as DMA API which the virtio core understands. There is no
need for an IOMMU to be involved for the device representation in this
case IMHO.
