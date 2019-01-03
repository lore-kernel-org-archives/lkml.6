Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5CAC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C4721479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfACVSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:18:47 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.126]:20712 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726898AbfACVSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:18:46 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id D34847631
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jan 2019 15:18:45 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id fAO5gchjf2PzOfAO5gIhtL; Thu, 03 Jan 2019 15:18:45 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.104] (port=52568 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gfAO5-002Ijv-9e; Thu, 03 Jan 2019 15:18:45 -0600
Subject: Re: [PATCH] drm/amd/display: Fix boolean expression in
 get_surf_rq_param
To:     "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190103194845.GA26175@embeddedor>
 <8169baae-434e-2d08-d63f-a285d1c3457e@amd.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <fa256e45-60dd-d7ea-75c4-898583b49480@embeddedor.com>
Date:   Thu, 3 Jan 2019 15:18:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8169baae-434e-2d08-d63f-a285d1c3457e@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.78.104
X-Source-L: No
X-Exim-ID: 1gfAO5-002Ijv-9e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.78.104]:52568
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/3/19 3:11 PM, Wentland, Harry wrote:
> On 2019-01-03 2:48 p.m., Gustavo A. R. Silva wrote:
>> Fix boolean expression by using logical AND operator '&&'
>> instead of bitwise operator '&'.
>>
>> This issue was detected with the help of Coccinelle.
>>
>> Fixes: 6d04ee9dc101 ("drm/amd/display: Restructuring and cleaning up DML")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> and applied.
> 

Thanks, Harry.

--
Gustavo
