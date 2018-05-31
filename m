Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932755AbeEaDjh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:39:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932735AbeEaDjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:39:35 -0400
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
To: Ram Pai <linuxram@us.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <20180524072104.GD6139@ram.oc3035372033.ibm.com>
Cc: robh@kernel.org, aik@ozlabs.ru, jasowang@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, hch@infradead.org,
        joe@perches.com, linuxppc-dev@lists.ozlabs.org,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 31 May 2018 09:09:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180524072104.GD6139@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18053103-0008-0000-0000-00000242325B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053103-0009-0000-0000-000021A7DB8F
Message-Id: <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=907 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805310039
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/2018 12:51 PM, Ram Pai wrote:
> On Wed, May 23, 2018 at 09:50:02PM +0300, Michael S. Tsirkin wrote:
>> subj: s/virito/virtio/
>>
> ..snip..
>>>  machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
>>> +
>>> +bool platform_forces_virtio_dma(struct virtio_device *vdev)
>>> +{
>>> +	/*
>>> +	 * On protected guest platforms, force virtio core to use DMA
>>> +	 * MAP API for all virtio devices. But there can also be some
>>> +	 * exceptions for individual devices like virtio balloon.
>>> +	 */
>>> +	return (of_find_compatible_node(NULL, NULL, "ibm,ultravisor") != NULL);
>>> +}
>>
>> Isn't this kind of slow?  vring_use_dma_api is on
>> data path and supposed to be very fast.
> 
> Yes it is slow and not ideal. This won't be the final code. The final
> code will cache the information in some global variable and used
> in this function.

Right this will be a simple check based on a global variable.
