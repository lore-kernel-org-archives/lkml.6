Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DFCECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E8820861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E8820861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeINWa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:30:29 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:57014 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbeINWa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:30:29 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 0rgIgcbxsw2L80rgLgb9M2; Fri, 14 Sep 2018 19:15:04 +0200
Subject: Re: [PATCH v2 0/2] media: platform: Add Aspeed Video Engine Driver
To:     Eddie James <eajames@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, andrew@aj.id.au,
        openbmc@lists.ozlabs.org, robh+dt@kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org
References: <1536866964-71593-1-git-send-email-eajames@linux.vnet.ibm.com>
 <3fe3a367-5e63-446b-faba-fa6ac7a007cd@xs4all.nl>
 <1436d8d6-25ab-4bb8-5558-3e02fbe95e58@linux.vnet.ibm.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <eff9f795-d28f-d9cd-ff04-752757856f94@xs4all.nl>
Date:   Fri, 14 Sep 2018 19:14:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1436d8d6-25ab-4bb8-5558-3e02fbe95e58@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGsQz9k/kkaFnUvGGoSaIy0yl7JB0a38WLpwYm8/Eo/wHnFobGCUFDS1I8kxjbNjBJjAlQhAZoBvbKP07YQV9hHUcGIXus/EA8zYWiPUGvjJUzIjOA3N
 gN+TcleydGy0NthGCmpSA8xOSpUSMdUWQIdQoDfp75m3BEp+ktxcR1gY70TBgYn/9YV8dRYbDJDn7/mLIRBQDZ615M0bhoGKKL4RtWZ51UKtxaZFTdnL8XYC
 BUHfz5ciLV/RbN4vc6fGHPcTY9MH/5OXcDyBXIDjdLPTAX3LOfBMhdCpq5fb4xjvU/zQkIXhVg+6/2UYNEzINb4p6rwwn4yEVDDh8OpCXyxWbS4DdBF2TBN8
 jd3VmsfYfD50dC0qFber+bBZX+do7Fzst8hfRnUHwbSylZNoON0pnhmzq+T1HZwNKQx8/zS+AXHEj/7yp/ebUG8SC9IbZTdSCXaKml0BtwvRoXu9UU23Avak
 H+Tl0jZWP6N43WMvWaKc84y+nuq+dw8OzPBOoA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/2018 05:08 PM, Eddie James wrote:
> 
> 
> On 09/14/2018 01:59 AM, Hans Verkuil wrote:
>> On 09/13/2018 09:29 PM, Eddie James wrote:
>>> The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs
>>> can capture and compress video data from digital or analog sources. With
>>> the Aspeed chip acting as a service processor, the Video Engine can
>>> capture the host processor graphics output.
>>>
>>> This series adds a V4L2 driver for the VE, providing a read() interface
>>> only. The driver triggers the hardware to capture the host graphics output
>>> and compress it to JPEG format.
>>>
>>>
>>> v4l2-compliance output:
>>>
>>> v4l2-compliance SHA   : not available
>> There should be a SHA here. "not available" indicates that you didn't compile
>> from the git repository directly, and now I do not know how old this compliance
>> test is. Always compile from the latest git repo, never use a version from e.g.
>> a distro as they tend to be old and missing tests.
>>
>> It would be great if you can do this and reply with the new compliance output.
> 
> Hmm, I did compile from the latest git repo (maybe a week old now), but 
> maybe our cross complication setup is preventing that hash from being 
> generated. Will try and get it.

You can also just report the git commit hash if you can't get it to work.
As long as I know from which source version it was built.

Regards,

	Hans
