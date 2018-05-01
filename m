Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755453AbeEAODl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:03:41 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:12060 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754798AbeEAODj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:03:39 -0400
Subject: Re: [PATCH v9 03/27] clk: davinci: psc: allow for dev == NULL
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20180427001745.4116-1-david@lechnology.com>
 <20180427001745.4116-4-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <8940259b-5811-ce9f-8262-17d39ca0a46f@ti.com>
Date: Tue, 1 May 2018 19:32:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427001745.4116-4-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 April 2018 05:47 AM, David Lechner wrote:
> +static inline void *_devm_kzalloc(struct device *dev, size_t size, gfp_t flags)
> +{
> +	if (dev)
> +		return devm_kzalloc(dev, size, flags);
> +
> +	return kzalloc(size, flags);
> +}

I have the same question on the utility of this. A memory allocation
error so early on is not going to result in a bootable system anyway.
So, I wonder if its better to just BUG() in such cases. That will
actually help faster debug than returning an error back. I know the push
back on using BUG(), but clock drivers are special, and I think thats
why its seems to be used quite a bit already.

Thanks,
Sekhar
