Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0502EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49B42171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfABLkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 06:40:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17075 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727631AbfABLkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 06:40:41 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7A8E77A22DE4D;
        Wed,  2 Jan 2019 19:40:37 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Wed, 2 Jan 2019
 19:40:38 +0800
Subject: Re: [PATCH -next] mm: Mark 'stack_vm_area' with __maybe_unused
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Michal Hocko <mhocko@kernel.org>
References: <1545965190-2381-1-git-send-email-yuehaibing@huawei.com>
 <20181228085804.GR16738@dhcp22.suse.cz> <20190102105531.GI3781@kadam>
CC:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        David Windsor <dave@nullcore.net>,
        "Roman Gushchin" <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@surriel.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <ae41ee4b-4e3f-d39b-1ad8-40d0096b713d@huawei.com>
Date:   Wed, 2 Jan 2019 19:40:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190102105531.GI3781@kadam>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/2 18:55, Dan Carpenter wrote:
> On Fri, Dec 28, 2018 at 09:58:04AM +0100, Michal Hocko wrote:
>> On Fri 28-12-18 02:46:30, YueHaibing wrote:
>>> Fixes gcc '-Wunused-but-set-variable' warning when
>>> CONFIG_VMAP_STACK is not set:
>>
>> Isn't this warning disabled? I can see the following
>> # These warnings generated too much noise in a regular build.
>> # Use make W=1 to enable them (see scripts/Makefile.extrawarn)
>> KBUILD_CFLAGS += -Wno-unused-but-set-variable
>>
>> in the main makefile. IMHO this warning doesn't really give us much.
>>
> 
> It would be nice to enable that warning.  YueHaibing and Colin King have
> been whittling away at the problematic code...
> 
> YueHaibing, how many of these warnings do we have remaining on an
> allmodoconfig?

about 1300+

> 
> regards,
> dan carpenter
> 
> 
> .
> 

