Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933784AbeEWQ6i (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:58:38 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36042 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933476AbeEWQ6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:58:36 -0400
X-Google-Smtp-Source: AB8JxZqcY54ZarX3nQIQ0wB9IMiV+1Y21ar6S5E7wX5K0+Ck75i4vbxzrPfmrTlrEr8p5lCEP9cUIw==
Date: Wed, 23 May 2018 11:58:34 -0500
From: Rob Herring <robh@kernel.org>
To: Saravana Kannan <skannan@codeaurora.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rjendra@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PM / devfreq: Generic cpufreq governor
Message-ID: <20180523165834.GA11016@rob-hp-laptop>
References: <1526631889-5084-1-git-send-email-skannan@codeaurora.org>
 <1526631889-5084-3-git-send-email-skannan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526631889-5084-3-git-send-email-skannan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 01:24:48AM -0700, Saravana Kannan wrote:
> This devfreq governor is a generic implementation that can scale any
> devfreq device based on the current CPU frequency of all ONLINE CPUs. It
> allows for specifying CPU freq to devfreq mapping for specific devices.
> When such a mapping is not present, it defaults to scaling the device
> frequency in proportion to the CPU frequency.
> 
> Change-Id: I7f786b9059435afe85b9ec8c504a4655731ee20e

drop this.

> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  .../bindings/devfreq/devfreq-cpufreq.txt           |  53 ++

Please split bindings to separate patch.

>  drivers/devfreq/Kconfig                            |   8 +
>  drivers/devfreq/Makefile                           |   1 +
>  drivers/devfreq/governor_cpufreq.c                 | 628 +++++++++++++++++++++
>  4 files changed, 690 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/devfreq-cpufreq.txt
>  create mode 100644 drivers/devfreq/governor_cpufreq.c
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq.txt b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq.txt
> new file mode 100644
> index 0000000..6537538
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq.txt
> @@ -0,0 +1,53 @@
> +Devfreq CPUfreq governor
> +
> +devfreq-cpufreq is a parent device that contains one or more child devices.
> +Each child device provides CPU frequency to device frequency mapping for a
> +specific device. Examples of devices that could use this are: DDR, cache and
> +CCI.
> +
> +Parent device name shall be "devfreq-cpufreq".

I don't really understand any of this and how it relates to the other 
QCom cpufreq and devfreq bindings. Seems like this all needs some 
discussion amongst the PM folks first.

Rob
