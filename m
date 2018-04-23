Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932395AbeDWTOF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 15:14:05 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.184]:26727 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932330AbeDWTOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 15:14:02 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH 00/11] fix potential Spectre variant 1 issues
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Jonathan Corbet <corbet@lwn.net>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <cover.1524499368.git.gustavo@embeddedor.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <96bd3e25-9503-d23d-4e3c-091e68b6bf8f@embeddedor.com>
Date: Mon, 23 Apr 2018 14:13:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1524499368.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1fAguW-001IbZ-FI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.145.48.65]:60348
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please, drop this series. Further analysis is required as it seems all 
these are False Positives.

Sorry for the noise.

Thanks
--
Gustavo

On 04/23/2018 12:37 PM, Gustavo A. R. Silva wrote:
> This patchset aims to fix various media platform and media usb
> cases where we have user controlled array dereferences that could
> be exploited due to the Spectre variant 1 vulnerability. All were
> reported by Dan Carpenter.
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
> 
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> 
> Thanks
> 
> Gustavo A. R. Silva (11):
>    media: tm6000: fix potential Spectre variant 1
>    exynos4-is: mipi-csis: fix potential Spectre variant 1
>    fsl-viu: fix potential Spectre variant 1
>    marvell-ccic: mcam-core: fix potential Spectre variant 1
>    omap_vout: fix potential Spectre variant 1
>    rcar-v4l2: fix potential Spectre variant 1
>    rcar_drif: fix potential Spectre variant 1
>    sh_vou: fix potential Spectre variant 1
>    vimc-debayer: fix potential Spectre variant 1
>    vivid-sdr-cap: fix potential Spectre variant 1
>    vsp1_rwpf: fix potential Spectre variant 1
> 
>   drivers/media/platform/exynos4-is/mipi-csis.c   | 5 ++++-
>   drivers/media/platform/fsl-viu.c                | 8 ++++----
>   drivers/media/platform/marvell-ccic/mcam-core.c | 3 +++
>   drivers/media/platform/omap/omap_vout.c         | 3 +++
>   drivers/media/platform/rcar-vin/rcar-v4l2.c     | 4 +++-
>   drivers/media/platform/rcar_drif.c              | 4 +++-
>   drivers/media/platform/sh_vou.c                 | 3 +++
>   drivers/media/platform/vimc/vimc-debayer.c      | 5 ++++-
>   drivers/media/platform/vivid/vivid-sdr-cap.c    | 6 ++++++
>   drivers/media/platform/vsp1/vsp1_rwpf.c         | 3 +++
>   drivers/media/usb/tm6000/tm6000-video.c         | 2 ++
>   11 files changed, 38 insertions(+), 8 deletions(-)
> 
