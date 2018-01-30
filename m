Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752496AbeA3NWs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:22:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751464AbeA3NWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:22:46 -0500
Subject: Re: [PATCH v1 0/2] Kconfig changes to enable Graphics Support for
 S390
To: Farhan Ali <alifm@linux.vnet.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
References: <cover.1516892845.git.alifm@linux.vnet.ibm.com>
 <CAMuHMdW7jR2Oa6dsameR76FLhSnX+kZ7jXqpfQC+oHy_uaMJaQ@mail.gmail.com>
 <19306e74-7c9b-5644-6f08-bbaef226afd8@linux.vnet.ibm.com>
 <CAMuHMdUFCKtdAHHt6SwBSQXiRgSKvnqFXUvrQ1jFkb8J0nuSMw@mail.gmail.com>
 <85ab024b-6af2-8b58-f9e8-7920d132cefb@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 30 Jan 2018 14:22:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <85ab024b-6af2-8b58-f9e8-7920d132cefb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18013013-0012-0000-0000-000005A967D4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18013013-0013-0000-0000-00001925056F
Message-Id: <cb4c884b-9334-325c-0c2d-0f93fae9f1cc@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1801300169
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, merging sounds good.
Farhan, can you maybe resend t whole series together with your CONFIG_VT rework?



On 01/26/2018 05:26 PM, Farhan Ali wrote:
> 
> 
> On 01/26/2018 10:06 AM, Geert Uytterhoeven wrote:
>>> Hi Geert,
>>>
>>> I wasn't sure what would be the best ordering since we would never hit the
>>> issue if patch 1 didn't exist. But if the preference is to invert the
>>> ordering of patches, then I will change the ordering.
>> Alternatively, you can combine two patches into a single patch, which
>> moves the dependency from the whole subsystem to the driver that needs
>> it (are there more?).
>>
>> Gr{oetje,eeting}s,
>>
>>                          Geert
> 
> 
> I like the idea of combining both patches into one.
> 
> There are other fbdev drivers that use iomem (found by grepping for "devm_ioremap_resource"):
> 
> CONFIG_FB_S3C (s3c-fb.c)
> 
> CONFIG_FB_CLPS711X (clps711x-fb.c)
> 
> CONFIG_FB_JZ4740 (jz4740_fb.c)
> 
> CONFIG_FB_DA8XX (da8xx-fb.c)
> 
> CONFIG_FB_WM8505 (wm8505fb.c)
> 
> CONFIG_OMAP2_VRFB (omap2/omapfb/vrfb.c)
> 
> CONFIG_FB_OMAP2 (omap2/omapfb/dss/*
> 
> CONFIG_FB_MXS (mxsfb.c)
> 
> CONFIG_PXA3XX_GCU (pxa3xx-gcu.c)
> 
> CONFIG_FB_XILINX (xilinxfb.c)
> 
> 
> All of these are already fenced off by architecture dependencies (which I am assuming enables CONFIG_HAS_IOMEM by default). If we want to be cautious I can add HAS_IOMEM dependency for all of them.
> 
> Thanks
> Farhan
