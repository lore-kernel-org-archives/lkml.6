Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753971AbeEaGPe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 02:15:34 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33858 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753760AbeEaGPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 02:15:30 -0400
X-Google-Smtp-Source: ADUXVKJBMB9mNbjztCcrbFLRSf0VjsIzE0NkPme5S+HmmxalC/DfyO2lyP0NsYdcmxwee32TUesKYg==
Date: Thu, 31 May 2018 11:45:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>
Subject: Re: [PATCH v2 3/9] PM / Domains: Drop genpd as in-param for
 pm_genpd_remove_device()
Message-ID: <20180531061528.6b7qdfygk5ouyeyh@vireshk-i7>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-4-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180529100421.31022-4-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-05-18, 12:04, Ulf Hansson wrote:
> There is no need to pass a genpd struct to pm_genpd_remove_device(), as we
> already have the information about the PM domain (genpd) through the device
> structure.
> 
> Additionally, we don't allow to remove a PM domain from a device, other
> than the one it may have assigned to it, so really it does not make sense
> to have a separate in-param for it.
> 
> For these reason, drop it and update the current only call to
> pm_genpd_remove_device() from amdgpu_acp.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: David (ChunMing) Zhou <David1.Zhou@amd.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c             | 8 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 2 +-
>  include/linux/pm_domain.h               | 5 ++---
>  3 files changed, 7 insertions(+), 8 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
