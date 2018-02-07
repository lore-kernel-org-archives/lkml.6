Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeBGWnv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 17:43:51 -0500
Received: from vern.gendns.com ([206.190.152.46]:40404 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752237AbeBGWnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 17:43:46 -0500
Subject: Re: [PATCH 0/7] ARM: davinci: add genpd support
To: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180207134553.13510-1-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <4dbc57ec-3506-eb1d-e00d-adfe75c3b39b@lechnology.com>
Date: Wed, 7 Feb 2018 16:43:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180207134553.13510-1-brgl@bgdev.pl>
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

On 02/07/2018 07:45 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Hi Sekhar et al,
> 
> please take a look at the following patches. They add a simple genpd
> driver and use it in DT mode on da850 boards.
> 
> I was trying to use genpd in legacy mode too, but couldn't find neither
> any interfaces nor users that would do that. For now I added a check in
> arch/arm/mach-davinci/pm_domain.c that disables the clock pm setup if
> we're using genpd.
> 
> This series applies on top of and has been tested with David Lechner's
> for-bartosz branch. It fixes the clock look-up issues we faced with
> lcdc and emac.

I'm starting to think that it makes more sense to just make the PSC driver
a power-domain and reset provider rather than a clock provider. It is
unfortunate that genpd is DT only.
