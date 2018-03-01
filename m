Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032585AbeCAPk6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:40:58 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:51123 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032532AbeCAPiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:38:03 -0500
X-Google-Smtp-Source: AG47ELuFcQZ6QeFngO/eu/EeHC2yp+FrTfXW9E2Xz4+pdWOisEIfeL2XIxHLIRNIikWYr9YxBwOfwg==
Subject: Re: linux-next: build warnings after merge of the block tree
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180301112624.652612c7@canb.auug.org.au>
 <1f3b4275-b346-d768-681e-b180ec351140@linux.vnet.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bd4fd250-645e-6521-d95f-6d2ab60f2f0c@kernel.dk>
Date: Thu, 1 Mar 2018 08:37:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1f3b4275-b346-d768-681e-b180ec351140@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/18 9:02 PM, Anshuman Khandual wrote:
> On 03/01/2018 05:56 AM, Stephen Rothwell wrote:
>> Hi Jens,
>>
>> After merging the block tree, today's linux-next build (x86_64
>> allmodconfig) produced these warning:
>>
>> In file included from drivers/misc/cardreader/rts5209.c:24:0:
>> include/linux/rtsx_pci.h:40:0: warning: "SG_END" redefined
>>  #define   SG_END   0x02
>>  
>> In file included from include/linux/dmapool.h:14:0,
>>                  from include/linux/pci.h:1311,
>>                  from include/linux/rtsx_pci.h:26,
>>                  from drivers/misc/cardreader/rts5209.c:24:
>> include/linux/scatterlist.h:69:0: note: this is the location of the previous definition
>>  #define SG_END  0x02UL
>>  
>> In file included from drivers/staging/rts5208/rtsx.h:180:0,
>>                  from drivers/staging/rts5208/rtsx.c:28:
>> drivers/staging/rts5208/rtsx_chip.h:343:0: warning: "SG_END" redefined
>>  #define SG_END   0x02
>>  
>> In file included from include/linux/blkdev.h:28:0,
>>                  from drivers/staging/rts5208/rtsx.c:23:
>> include/linux/scatterlist.h:69:0: note: this is the location of the previous definition
>>  #define SG_END  0x02UL
>>  
>>
>> and many more the same.
>>
>> Introduced by commit
>>
>>   723fbf563a6a ("lib/scatterlist: Add SG_CHAIN and SG_END macros for LSB encodings")
> 
> IIRC this was already detected and hence sent a new version changing
> this to SG_LAST.
> 
> https://patchwork.kernel.org/patch/10227897/

The right fix is for drivers to not use defines that end up conflicting
with the global namespace. Should have been fixed up earlier, but I
have applied the patches from Arnd to rectify that.

-- 
Jens Axboe
