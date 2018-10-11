Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34D2C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7012077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7012077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeJKThW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:37:22 -0400
Received: from mail1.windriver.com ([147.11.146.13]:63986 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbeJKThW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:37:22 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w9BCACYg023291
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 11 Oct 2018 05:10:12 -0700 (PDT)
Received: from [128.224.155.90] (128.224.155.90) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 11 Oct
 2018 05:10:11 -0700
Subject: Re: net/tipc: recursive locking in tipc_link_reset
To:     Dmitry Vyukov <dvyukov@google.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        <tipc-discussion@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>
References: <CACT4Y+bcxEz=P2E5TRj6A1qeCOQ+WtWR44WGLzqdDttLzD393A@mail.gmail.com>
 <CACT4Y+Ym3_NuqWrgHXWfTahWTm17xi_2gjy8hvuDeyUCPuYXUQ@mail.gmail.com>
From:   Ying Xue <ying.xue@windriver.com>
Message-ID: <97d8c196-cd11-8859-fc14-ed12191f52af@windriver.com>
Date:   Thu, 11 Oct 2018 20:03:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Ym3_NuqWrgHXWfTahWTm17xi_2gjy8hvuDeyUCPuYXUQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.155.90]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2018 03:59 PM, Dmitry Vyukov wrote:
> On Thu, Oct 11, 2018 at 9:55 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> Hi,
>>
>> I am getting the following error while booting the latest kernel on
>> bb2d8f2f61047cbde08b78ec03e4ebdb01ee5434 (Oct 10). Config is attached.
>>
>> Since this happens during boot, this makes LOCKDEP completely
>> unusable, does not allow to discover any other locking issues and
>> masks all new bugs being introduced into kernel.
>> Please fix asap.
>> Thanks
> -parthasarathy.bhuvaragan address as it gives me bounces
> but this is highly likely due to:
> 
> commit 3f32d0be6c16b902b687453c962d17eea5b8ea19
> Author: Parthasarathy Bhuvaragan
> Date:   Tue Sep 25 22:09:10 2018 +0200
> 
>     tipc: lock wakeup & inputq at tipc_link_reset()
> 
> 

Dmitry, I agree with you. The complaint should be caused by the commit
above. Please try to verify the patch:
https://patchwork.ozlabs.org/patch/982447.

Thanks,
Ying
