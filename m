Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbeEGQpj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 12:45:39 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36621 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbeEGQpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 12:45:36 -0400
X-Google-Smtp-Source: AB8JxZpkb9oPdPdSD6bg6kh5UOxBXMO3OVK3EuT/7pkW9sNBnE5g1lN2Ikvl92kxqiI1b32Io8WKdg==
Date: Mon, 7 May 2018 11:45:34 -0500
From: Rob Herring <robh@kernel.org>
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: bjorn.andersson@linaro.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V2 2/5] backlight: qcom-wled: Add support for WLED4
 peripheral
Message-ID: <20180507164534.GB21042@rob-hp-laptop>
References: <1525342352-25072-1-git-send-email-kgunda@codeaurora.org>
 <1525342352-25072-3-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525342352-25072-3-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 03:42:29PM +0530, Kiran Gunda wrote:
> WLED4 peripheral is present on some PMICs like pmi8998
> and pm660l. It has a different register map and also
> configurations are different. Add support for it.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  .../bindings/leds/backlight/qcom-wled.txt          | 172 ++++-

Please split bindings to a separate patch.

This is also a whole lot of churn re-formatting. That is fine, but don't 
mix actual changes to the binding with re-formatting. You can do 2 
patches in this case: 

- move and reformat (as long as the move shows up as a move 
and not a remove and add) 
- additions for new chips

>  drivers/video/backlight/qcom-wled.c                | 749 +++++++++++++++------
>  2 files changed, 696 insertions(+), 225 deletions(-)
