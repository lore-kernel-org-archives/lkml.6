Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932534AbeCOPZT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:25:19 -0400
Received: from foss.arm.com ([217.140.101.70]:41288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932101AbeCOPZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:25:17 -0400
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Leo Li <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yuantian Tang <andy.tang@nxp.com>
Subject: Re: [PATCH 3/3] arm64: dts: update the cpu idle node
To: Ran Wang <ran.wang_1@nxp.com>, Shawn Guo <shawnguo@kernel.org>
References: <20180208075436.38443-1-ran.wang_1@nxp.com>
 <20180208075436.38443-3-ran.wang_1@nxp.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <346ad3d2-04e4-7df3-5187-36124b3c717b@arm.com>
Date: Thu, 15 Mar 2018 15:25:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180208075436.38443-3-ran.wang_1@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry for replying so late, just found this by accident when clearing
 old emails)

On 08/02/18 07:54, Ran Wang wrote:
> From: Yuantian Tang <andy.tang@nxp.com>
> 
> According to PSCI standard v0.2, for CPU_SUSPEND call, which is
> used by cpu idle framework, bit[16] of state parameter must be 0.
> So update bit[16] of property 'arm,psci-suspend-param', which is
> used as state parameter, to 0.
> 
This changelog makes zero sense to me.

1. PSCI specification makes no reference to "cpu idle framework".
   It's not a Linux specification to reference anything specific to
   Linux CPUIdle framework.

2. "for CPU_SUSPEND call,...bit[16] of state parameter must be 0."
   Where exactly to you see that ? Specification tells what value of
   0 or 1 in bit[16] means.

3. Is this retention state and doesn't need any save restore ? If not
   this change is wrong and will break if and when we use
   CPU_PM_CPU_IDLE_ENTER_RETENTION if this bit is not set.

-- 
Regards,
Sudeep
