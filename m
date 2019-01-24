Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE35C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848A021872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfAXRir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:38:47 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.119]:25051 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727664AbfAXRir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:38:47 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 71439439382
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 11:38:46 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id mixigmfU2iQermixig5oPV; Thu, 24 Jan 2019 11:38:46 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=42898 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gmixi-0007RP-2y; Thu, 24 Jan 2019 11:38:46 -0600
Subject: Re: powerpc/ps3: Use struct_size() in kzalloc()
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        Geoff Levand <geoff@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <43lSbT1lyfz9sN8@ozlabs.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Message-ID: <36d34731-e072-452b-48b8-9e68773c5425@embeddedor.com>
Date:   Thu, 24 Jan 2019 11:38:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <43lSbT1lyfz9sN8@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gmixi-0007RP-2y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.130.205]:42898
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/19 9:40 PM, Michael Ellerman wrote:
> On Tue, 2019-01-08 at 21:00:10 UTC, "Gustavo A. R. Silva" wrote:
>> One of the more common cases of allocation size calculations is finding the
>> size of a structure that has a zero-sized array at the end, along with memory
>> for some number of elements for that array. For example:
>>
>> struct foo {
>>     int stuff;
>>     void *entry[];
>> };
>>
>> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>>
>> Instead of leaving these open-coded and prone to type mistakes, we can now
>> use the new struct_size() helper:
>>
>> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
>>
>> This code was detected with the help of Coccinelle.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Applied to powerpc next, thanks.
> 
> https://git.kernel.org/powerpc/c/31367b9a01d6a3f4f77694bd44f547d6
> 

Thanks, Michael.

--
Gustavo
