Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757671AbeD0Il7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 04:41:59 -0400
Received: from mail.netline.ch ([148.251.143.178]:44255 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757536AbeD0Il6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 04:41:58 -0400
Subject: Re: [PATCH 1/2] drm/ttm: Add TTM_PAGE_FLAG_TRANSHUGE
To: zhoucm1 <zhoucm1@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180426150618.13470-1-michel@daenzer.net>
 <a77d7229-e8f7-83bf-2098-8db07cebb117@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <d6a07516-64bc-003d-946f-09f3cb9ded1c@daenzer.net>
Date: Fri, 27 Apr 2018 10:41:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a77d7229-e8f7-83bf-2098-8db07cebb117@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Dropping Roger He, his e-mail address seems to bounce ]

On 2018-04-27 04:51 AM, zhoucm1 wrote:
> On 2018年04月26日 23:06, Michel Dänzer wrote:
>> From: Michel Dänzer <michel.daenzer@amd.com>
>>
>> When it's set, TTM tries to allocate huge pages if possible.
> Do you mean original driver doesn't do this?
> From the code, driver always try huge pages if
> CONFIG_TRANSPARENT_HUGEPAGE is enabled.

Right, before this change, TTM would do this unconditionally for all
drivers. The point of this change is not to incur any huge page related
overhead for drivers which can't take advantage of huge pages anyway.
I'll try changing the commit log to make this clearer in v2.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
