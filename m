Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeBTJnh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 04:43:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751228AbeBTJnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 04:43:35 -0500
Subject: Re: [PATCH v3 0/3] Enable CONFIG_VT support for S390
To: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, tomi.valkeinen@ti.com, thuth@redhat.com,
        b.zolnierkie@samsung.com
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 20 Feb 2018 10:43:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18022009-0008-0000-0000-000004D2331F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022009-0009-0000-0000-00001E653542
Message-Id: <c4319571-96fd-8f5b-68e3-c06b7968203f@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802200125
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added to my linux next tree to check for any fallout.


On 02/19/2018 04:47 PM, Farhan Ali wrote:
> Hi,
> 
> This series of patches add support for an additional tty
> and console for a S390 KVM guest using a virtio-gpu device[1].
> 
> Patch 1 enables the "Graphics support" menu which is
> needed to enable dummy console, since the VT layer needs it.
> The dependency is moved to sub menu items and console
> drivers now.
> 
> Patch 2 fixes few linker issues.
> 
> Patch 3 add support for enabling VT layer for S390.
> 
> 
> ChangeLog
> ---------
> v2 -> v3
>     - Move HAS_IOMEM dependency to sub menu items and console
>     drivers (patch 1)
> 
> v1 -> v2
> 
> v1 was posted under a different subject and here is a link to it:
> https://www.spinics.net/lists/linux-s390/msg18175.html
> 
>    - Combine patch 1 and 2 from v1 into one patch (patch 1).
>    - Additional patches to enable CONFIG_VT for S390.
> 
> 
> Thanks
> Farhan
> 
> 
> Farhan Ali (3):
>   Kconfig : Remove HAS_IOMEM dependency for Graphics support
>   s390/char : Rename EBCDIC keymap variables
>   s390/setup : enable display support for KVM guest
> 
>  arch/s390/kernel/setup.c      |  2 ++
>  drivers/s390/char/defkeymap.c | 66 ++++++++++++++++++++++---------------------
>  drivers/s390/char/keyboard.c  | 32 ++++++++++-----------
>  drivers/s390/char/keyboard.h  | 11 ++++++++
>  drivers/tty/Kconfig           |  2 +-
>  drivers/video/Kconfig         | 21 +++++++-------
>  drivers/video/console/Kconfig |  6 ++--
>  7 files changed, 78 insertions(+), 62 deletions(-)
> 
