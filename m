Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965815AbeCAEC3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 23:02:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965752AbeCAEC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 23:02:28 -0500
Subject: Re: linux-next: build warnings after merge of the block tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Jens Axboe <axboe@kernel.dk>
References: <20180301112624.652612c7@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 09:32:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180301112624.652612c7@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18030104-0016-0000-0000-0000052B4138
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030104-0017-0000-0000-0000286843A6
Message-Id: <1f3b4275-b346-d768-681e-b180ec351140@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010050
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2018 05:56 AM, Stephen Rothwell wrote:
> Hi Jens,
> 
> After merging the block tree, today's linux-next build (x86_64
> allmodconfig) produced these warning:
> 
> In file included from drivers/misc/cardreader/rts5209.c:24:0:
> include/linux/rtsx_pci.h:40:0: warning: "SG_END" redefined
>  #define   SG_END   0x02
>  
> In file included from include/linux/dmapool.h:14:0,
>                  from include/linux/pci.h:1311,
>                  from include/linux/rtsx_pci.h:26,
>                  from drivers/misc/cardreader/rts5209.c:24:
> include/linux/scatterlist.h:69:0: note: this is the location of the previous definition
>  #define SG_END  0x02UL
>  
> In file included from drivers/staging/rts5208/rtsx.h:180:0,
>                  from drivers/staging/rts5208/rtsx.c:28:
> drivers/staging/rts5208/rtsx_chip.h:343:0: warning: "SG_END" redefined
>  #define SG_END   0x02
>  
> In file included from include/linux/blkdev.h:28:0,
>                  from drivers/staging/rts5208/rtsx.c:23:
> include/linux/scatterlist.h:69:0: note: this is the location of the previous definition
>  #define SG_END  0x02UL
>  
> 
> and many more the same.
> 
> Introduced by commit
> 
>   723fbf563a6a ("lib/scatterlist: Add SG_CHAIN and SG_END macros for LSB encodings")

IIRC this was already detected and hence sent a new version changing
this to SG_LAST.

https://patchwork.kernel.org/patch/10227897/
