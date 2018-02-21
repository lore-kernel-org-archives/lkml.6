Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932708AbeBUKFy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:05:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932670AbeBUKFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:05:53 -0500
Subject: Re: [PATCH v3 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics
 support
To: Farhan Ali <alifm@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, tomi.valkeinen@ti.com, b.zolnierkie@samsung.com
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
 <2beec7645bac82e7bdef4f6df0b9f4fe28696575.1519053920.git.alifm@linux.vnet.ibm.com>
 <cce8b082-c780-3559-4491-c39eb09482b0@redhat.com>
 <6cae85dc-76d5-1b92-ab13-a5e441eb84a0@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 21 Feb 2018 11:05:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6cae85dc-76d5-1b92-ab13-a5e441eb84a0@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18022110-0040-0000-0000-00000435FAC0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022110-0041-0000-0000-000020D80E8D
Message-Id: <faffcd8e-4ef6-64bc-ab11-9b48ca488ed6@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-21_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802210123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/19/2018 05:38 PM, Farhan Ali wrote:
> 
> 
> On 02/19/2018 11:25 AM, Thomas Huth wrote:
>> On 19.02.2018 16:47, Farhan Ali wrote:
>>> The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
>>> added the HAS_IOMEM dependecy for "Graphics support". This disabled the
>>> "Graphics support" menu for S390. But if we enable VT layer for S390,
>>> we would also need to enable the dummy console. So let's remove the
>>> HAS_IOMEM dependency.
>>>
>>> Move this dependency to sub menu items and console drivers that use
>>> io memory.
>>>
>>> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
>>> ---
>>>   drivers/video/Kconfig         | 21 +++++++++++----------
>>>   drivers/video/console/Kconfig |  4 ++--
>>>   2 files changed, 13 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>>> index 3c20af9..8f10915 100644
>>> --- a/drivers/video/Kconfig
>>> +++ b/drivers/video/Kconfig
>>> @@ -3,7 +3,6 @@
>>>   #
>>>     menu "Graphics support"
>>> -    depends on HAS_IOMEM
>>>     config HAVE_FB_ATMEL
>>>       bool
>>> @@ -11,20 +10,22 @@ config HAVE_FB_ATMEL
>>>   config SH_LCD_MIPI_DSI
>>>       bool
>>>   -source "drivers/char/agp/Kconfig"
>>> +if HAS_IOMEM
>>> +    source "drivers/char/agp/Kconfig"
>>>   -source "drivers/gpu/vga/Kconfig"
>>> +    source "drivers/gpu/vga/Kconfig"
>>>   -source "drivers/gpu/host1x/Kconfig"
>>> -source "drivers/gpu/ipu-v3/Kconfig"
>>> +    source "drivers/gpu/host1x/Kconfig"
>>> +    source "drivers/gpu/ipu-v3/Kconfig"
>>>   -source "drivers/gpu/drm/Kconfig"
>>> +    source "drivers/gpu/drm/Kconfig"


Hmmm, looks like that this makes it impossible to select VIRTIO_GPU - need still more
work.
