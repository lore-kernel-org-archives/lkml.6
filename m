Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030754AbeCSVNX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:13:23 -0400
Received: from gateway36.websitewelcome.com ([50.116.125.2]:34487 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030489AbeCSVNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:13:06 -0400
Subject: Re: [PATCH] drm/i915/gvt/scheduler: fix potential NULL pointer
 dereference
To: Chris Wilson <chris@chris-wilson.co.uk>,
        Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>
Cc: intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180319193053.GA7016@embeddedgus>
 <152149190651.3594.5036347331521892974@mail.alporthouse.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <8f70ff7b-9575-006b-2384-88899f24fda6@embeddedor.com>
Date: Mon, 19 Mar 2018 15:50:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152149190651.3594.5036347331521892974@mail.alporthouse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.36.34
X-Source-L: No
X-Exim-ID: 1ey1jT-000hkx-BR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.67]) [189.145.36.34]:56132
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On 03/19/2018 03:38 PM, Chris Wilson wrote:
> Quoting Gustavo A. R. Silva (2018-03-19 19:30:53)
>> _workload_ is being dereferenced before it is null checked, hence
>> there is a potential null pointer dereference.
>>
>> Fix this by moving the pointer dereference after _workload_ has
>> been null checked.
> 
> The checks are misleading and not required.

All of them?

if (!workload || !reg_state || workload->ring_id != RCS)
	return;

or just the null check on workload ?

Thanks for the feedback.
--
Gustavo
