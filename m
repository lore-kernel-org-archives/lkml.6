Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeDFQa7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:30:59 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47220 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbeDFQa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:30:58 -0400
Subject: Re: [PATCH] drivers/memory: can't open emif-asm-offsets.s for writing
To: Anders Roxell <anders.roxell@linaro.org>, tony@atomide.com,
        d-gerlach@ti.com
Cc: rmk+kernel@armlinux.org.uk, linux-kernel@vger.kernel.org
References: <20180406130030.745-1-anders.roxell@linaro.org>
From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <938b0adb-e1b1-2825-14b9-8352b1b23ad8@oracle.com>
Date: Fri, 6 Apr 2018 09:30:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180406130030.745-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8854 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=740
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804060162
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/2018 6:00 AM, Anders Roxell wrote:
> Build failes due to that the directory isn't created before we execute
> the build rule.
> cc1: fatal error: can’t open ‘drivers/memory/emif-asm-offsets.s’ for
>    writing: No such file or directory compilation terminated.
> drivers/memory/Makefile.asm-offsets:2: recipe for target 'drivers/memory/emif-asm-offsets.s' failed
> make[2]: *** [drivers/memory/emif-asm-offsets.s] Error 1
> Makefile:1060: recipe for target
> 'arch/arm/mach-omap2' failed
> make[1]: *** [arch/arm/mach-omap2] Error 2
> make[1]: *** Waiting for unfinished jobs....
> 
> Current code adds a file check before checking the dependency, in
> filechk it does mkdir -p $(dir $@).
> 
> Fixes: 41d9d44d7258 ("ARM: OMAP2+: pm33xx-core: Add platform code needed for PM")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
