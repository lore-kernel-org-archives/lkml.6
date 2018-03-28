Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeC1LH6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 07:07:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54986 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752259AbeC1LH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 07:07:56 -0400
X-Google-Smtp-Source: AIpwx4/c6PvwlqovEioyF6N3EtlvpP8ZllMmWoaN91UypFfT7outbLVb7aHjWEm6I0/TlvogW29cFw==
Date: Wed, 28 Mar 2018 12:07:53 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v5 1/2] mfd: arizona: Update reset pin to use GPIOD
Message-ID: <20180328110753.vqhngsus5gpl6qld@dell>
References: <20180312155201.30108-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180312155201.30108-1-ckeepax@opensource.cirrus.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2018, Charles Keepax wrote:

> Now GPIOD has support for both pdata systems and for non-standard DT
> bindings the Arizona reset GPIO can be converted to use it. Worth
> noting gpiod_set_raw_value_cansleep is used to match the behaviour
> of the old GPIOs. This is because the part is fairly widely used and
> it is unknown how many DTs are correctly setting active low through
> device tree, so to avoid breaking any existing users it is best to
> match the previous behaviour.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v4:
>  - Don't use a switch statement for handling return values
>  - Add some comments to the handling for the older binding
>  - Use gpiod_set_raw_value_cansleep to avoid potential breakage
> 
> I have also removed Linus's reviewed-by was a bit border line but
> I felt there have probably been enough code changes since he gave
> it that it was probably safer to remove it.
> 
> Thanks,
> Charles
> 
>  drivers/mfd/arizona-core.c        | 53 ++++++++++++++++++++++++++-------------
>  include/linux/mfd/arizona/pdata.h |  3 ++-
>  2 files changed, 37 insertions(+), 19 deletions(-)

Applied with Linus' Ack, thanks

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
