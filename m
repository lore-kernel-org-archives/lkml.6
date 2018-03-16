Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753378AbeCPPUi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 11:20:38 -0400
Received: from vern.gendns.com ([206.190.152.46]:57229 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753340AbeCPPUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 11:20:36 -0400
Subject: Re: [PATCH] ARM: davinci: DA8XX: fix oops in USB PHY driver due to
 stack allocated platform platform_data
To: Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org
References: <1521136976-32730-1-git-send-email-david@lechnology.com>
 <382a269a-f486-8c1a-23b2-9620a01a073c@ti.com>
From: David Lechner <david@lechnology.com>
Message-ID: <c8ece16e-7335-f99e-8602-5f0be6897a1d@lechnology.com>
Date: Fri, 16 Mar 2018 10:20:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <382a269a-f486-8c1a-23b2-9620a01a073c@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16/2018 05:17 AM, Sekhar Nori wrote:
> On Thursday 15 March 2018 11:32 PM, David Lechner wrote:
>> This fixes a possible kernel oops due to using stack allocated platform
>> data for the USB PHY driver on DA8XX devices. If the platform device
>> probe is deferred, then we get a corrupt pointer for the platform data.
>>
>> We now use a global static struct for the platform data so that the
>> platform data pointer does not get written over.
>>
>> Tested on OMAP-L138 LCDK board using legacy board file.
> 
> Oops. That should have been caught in review.
> 
>>
>> Fixes: 9b504750923cb ("ARM: davinci: da8xx: Add USB PHY platform device")
> 
> The offending commit seems to be bdec5a6b5789 ("ARM: da8xx: use platform
> data for CFGCHIP syscon regmap") in my tree which should be in
> linux-next. I don't think we have this issue in mainline. Right?

You are right. I'm not sure how I got that older commit. The issue is not
in mainline yet.

> 
>> Signed-off-by: David Lechner <david@lechnology.com>
> 
> Thanks,
> Sekhar
> 
