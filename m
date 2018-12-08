Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94352C07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5429D20857
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FVqmMQvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5429D20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeLHA4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 19:56:20 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52382 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeLHA4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 19:56:19 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB80tQIa170767;
        Sat, 8 Dec 2018 00:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=J+lVoOHuj8szMg+MYqI8zrVm2AoYn6Sxi8Y9P2ILo8k=;
 b=FVqmMQvcooIXYbzOxPQ0e2tZZTInCvN4LIlTIgMO3+c1c/Qw1VwRCEWuengBdoMSwUe1
 Uux5MyHbDakpJumdykYdphknG7fthaRo8bDyjWwf2lz3mfy7Bcs9yvbmt+rFMf5ywKrO
 Re0XJj2qY4aEfher0/gaBefTv7GZc9R4pLLaJ4j/Qpw/2/VnNgQ7QKtl2lkfOtrGtvfQ
 6J96pqsZIAf5cMURB9s5emTzIgplriDdRWBSDp0Yp+Qf+eXOt8cUvv2R5Wzl5+0VrVci
 RIlrQbYGtQw1dlPzihrXE8JzpENGZf67E5x2nQTdK/uBxuWo8dsxwIA1ObssvJF6HUgY dQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2p83fdr119-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Dec 2018 00:56:14 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB80uEFb004218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Dec 2018 00:56:14 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB80uEdo028001;
        Sat, 8 Dec 2018 00:56:14 GMT
Received: from [10.191.0.52] (/10.191.0.52)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Dec 2018 16:56:13 -0800
Subject: Re: [PATCH 1/1] virtio: remove deprecated VIRTIO_PCI_CONFIG()
To:     "Michael S. Tsirkin" <mst@redhat.com>
References: <1544168081-13205-1-git-send-email-dongli.zhang@oracle.com>
 <20181207125951-mutt-send-email-mst@kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, jasowang@redhat.com
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <e91c687f-0683-1d88-bf0a-cfb5e43ee316@oracle.com>
Date:   Sat, 8 Dec 2018 08:56:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181207125951-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9100 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812080006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/08/2018 02:01 AM, Michael S. Tsirkin wrote:
> On Fri, Dec 07, 2018 at 03:34:41PM +0800, Dongli Zhang wrote:
>> VIRTIO_PCI_CONFIG() is deprecated. Use VIRTIO_PCI_CONFIG_OFF() instead.
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>  drivers/virtio/virtio_pci_legacy.c | 6 ++++--
>>  include/uapi/linux/virtio_pci.h    | 2 --
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
>> index de062fb..eff9ddc 100644
>> --- a/drivers/virtio/virtio_pci_legacy.c
>> +++ b/drivers/virtio/virtio_pci_legacy.c
>> @@ -52,7 +52,8 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
>>  {
>>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>>  	void __iomem *ioaddr = vp_dev->ioaddr +
>> -				VIRTIO_PCI_CONFIG(vp_dev) + offset;
>> +			VIRTIO_PCI_CONFIG_OFF(vp_dev->msix_enabled) +
>> +			offset;
>>  	u8 *ptr = buf;
>>  	int i;
>>  
>> @@ -67,7 +68,8 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
>>  {
>>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>>  	void __iomem *ioaddr = vp_dev->ioaddr +
>> -				VIRTIO_PCI_CONFIG(vp_dev) + offset;
>> +			VIRTIO_PCI_CONFIG_OFF(vp_dev->msix_enabled) +
>> +			offset;
>>  	const u8 *ptr = buf;
>>  	int i;
>>
> 
> I agree that VIRTIO_PCI_CONFIG_OFF is a better interface. So above looks
> fine.
>   
>> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
>> index 90007a1..2070232 100644
>> --- a/include/uapi/linux/virtio_pci.h
>> +++ b/include/uapi/linux/virtio_pci.h
>> @@ -78,8 +78,6 @@
>>  /* The remaining space is defined by each driver as the per-driver
>>   * configuration space */
>>  #define VIRTIO_PCI_CONFIG_OFF(msix_enabled)	((msix_enabled) ? 24 : 20)
>> -/* Deprecated: please use VIRTIO_PCI_CONFIG_OFF instead */
>> -#define VIRTIO_PCI_CONFIG(dev)	VIRTIO_PCI_CONFIG_OFF((dev)->msix_enabled)
>>  
>>  /* Virtio ABI version, this must match exactly */
>>  #define VIRTIO_PCI_ABI_VERSION		0
> 
> This might break some userspace builds, I don't see why we should bother
> removing it. Any reason?

Apologies.

I thought about some compatibility issue for building third-party kernel module
at userspace, but did not realize it will break other userspace software builds.

I will keep the definition of VIRTIO_PCI_CONFIG() and resend again.

Thank you very much!

Dongli Zhang

> 
> 
>> -- 
>> 2.7.4
