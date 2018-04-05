Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbeDEOkC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:40:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751179AbeDEOkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:40:01 -0400
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
To: virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
Cc: robh@kernel.org, aik@ozlabs.ru, jasowang@redhat.com, joe@perches.com,
        linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net,
        david@gibson.dropbear.id.au, "Michael S. Tsirkin" <mst@redhat.com>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 5 Apr 2018 20:09:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18040514-0044-0000-0000-00000543DC6E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040514-0045-0000-0000-00002883F93B
Message-Id: <3e1b113b-79ca-b700-5be9-10c66d74aabe@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804050153
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2018 04:26 PM, Anshuman Khandual wrote:
> There are certian platforms which would like to use SWIOTLB based DMA API
> for bouncing purpose without actually requiring an IOMMU back end. But the
> virtio core does not allow such mechanism. Right now DMA MAP API is only
> selected for devices which have an IOMMU and then the QEMU/host back end
> will process all incoming SG buffer addresses as IOVA instead of simple
> GPA which is the case for simple bounce buffers after being processed with
> SWIOTLB API. To enable this usage, it introduces an architecture specific
> function which will just make virtio core front end select DMA operations
> structure.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

+ "Michael S. Tsirkin" <mst@redhat.com>
