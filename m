Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbeBHPac (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:30:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751946AbeBHPaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:30:30 -0500
Subject: Re: [PATCH v2 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics
 support
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org,
        geert@linux-m68k.org, stefan.kristiansson@saunalahti.fi,
        tomi.valkeinen@ti.com, schwidefsky@de.ibm.com,
        dri-devel@lists.freedesktop.org, Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net
References: <cover.1517508744.git.alifm@linux.vnet.ibm.com>
 <CGME20180202080007epcas5p306896fe66e4bbf4bf5f8d91306a5d016@epcas5p3.samsung.com>
 <246f92c9-15dc-223f-59d9-b2f0756cdf5e@de.ibm.com>
 <1610039.4trOurtpys@amdc3058>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 8 Feb 2018 16:30:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1610039.4trOurtpys@amdc3058>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18020815-0040-0000-0000-0000040DC626
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020815-0041-0000-0000-000026117BD0
Message-Id: <b93b12b9-bfcc-8ae4-ad74-fd4f262872a8@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802080180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/2018 02:11 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> [ dri-devel ML & arch/[score,um] Maintainers added to Cc: ]
> 
> On Friday, February 02, 2018 08:59:57 AM Christian Borntraeger wrote:
>> On 02/01/2018 07:41 PM, Farhan Ali wrote:
>>> The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
>>> added the HAS_IOMEM dependecy for "Graphics support". This disabled the
>>> "Graphics support" menu for S390. But if we enable VT layer for S390,
>>> we would also need to enable the dummy console. So let's remove the
>>> HAS_IOMEM dependency.
>>>
>>> Move this dependency to Opencores framebuffer driver which would fail to build
>>> with CONFIG_HAS_IOMEM disabled:
>>>
>>> ERROR: "devm_ioremap_resource" [drivers/video/fbdev/ocfb.ko] undefined!
> 
> "Graphics support" menu covers other things (i.e. DRM), I assume that
> they were also checked to not break due to this change?
> 
> Moreover it seems that after this change "Graphics support" menu will
> be also enabled (besides s390) for score, tile and um architectures,
> I assume that this is okay?

I can add this patch to my next tree (after merge window) and check for
any errors from all the build bots.
