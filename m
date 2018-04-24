Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934338AbeDXNbG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:31:06 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.184]:27836 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933939AbeDXNbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:31:02 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH] drm/i915/selftests: Fix uninitialized variable
To: Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180424131545.GA4053@embeddedor.com>
 <152457614368.12387.9348969127399551440@mail.alporthouse.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <09f02909-90cb-60f0-e362-7d5314dd8964@embeddedor.com>
Date: Tue, 24 Apr 2018 08:30:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152457614368.12387.9348969127399551440@mail.alporthouse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.48.65
X-Source-L: No
X-Exim-ID: 1fAy28-002kzT-OW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.145.48.65]:37174
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2018 08:22 AM, Chris Wilson wrote:
> Quoting Gustavo A. R. Silva (2018-04-24 14:15:45)
>> There is a potential execution path in which variable err is
>> returned without being properly initialized previously.
>>
>> Fix this by initializing variable err to 0.
> 
> err is only returned along an error path, returning 0 would not be
> useful. Which path? All the error paths look correct to me.
> -Chris
> 

If the following two conditions take the false branch then the function 
returns err with a random stack value:

if (intel_has_reset_engine(i915)) {
		...
}

if (intel_has_gpu_reset(i915)) {
		...
}

Thanks
--
Gustavo
