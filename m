Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PgrtQs0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F2D9601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933517AbeFFQo0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:44:26 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39776 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933494AbeFFQoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:44:23 -0400
X-Google-Smtp-Source: ADUXVKKhoe7qc8CNtv8IN2LfZl6hG1r46qT/iE886VUZkqXJSZojE5MrY/w6efTspSpBHXv1pLQIKg==
Date: Wed, 6 Jun 2018 09:46:28 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: Tomasz Figa <tfiga@chromium.org>, vgarodia@codeaurora.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, andy.gross@linaro.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: Re: [PATCH v2 5/5] venus: register separate driver for firmware
 device
Message-ID: <20180606164628.GF510@tuxbook-pro>
References: <1527884768-22392-1-git-send-email-vgarodia@codeaurora.org>
 <1527884768-22392-6-git-send-email-vgarodia@codeaurora.org>
 <CAAFQd5D39CkA=GucUs7YOHwsdj0gbk55BiY_gSvArY_RH4uDkg@mail.gmail.com>
 <2cf4f7e8-f9e6-d62b-45a8-2c348af4aafe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf4f7e8-f9e6-d62b-45a8-2c348af4aafe@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04 Jun 06:56 PDT 2018, Stanimir Varbanov wrote:
> On 06/04/2018 04:18 PM, Tomasz Figa wrote:
> > On Sat, Jun 2, 2018 at 5:27 AM Vikash Garodia <vgarodia@codeaurora.org> wrote:
[..]
> >> +               venus-firmware {
> >> +                       compatible = "qcom,venus-firmware-no-tz";
> > 
> > I don't think "-no-tz" should be mentioned here in DT, since it's a
> > firmware/software detail.
> 
> I have to agree with Tomasz, non-tz or tz is a software detail and it
> shouldn't be reflected in compatible string.
> 

While it is software, the alternative boot and security configuration
does imply different requirements on how the driver deals with the
hardware. I'm not sure how you expect the kernel to be informed about
the abilities of the boot/security capabilities if it's not passed
through DT.


In the other cases of firmware loading for co-processors this means that
a number of additional resources (clocks, resets) needs to be specified
in the DT node; something it seems like Venus doesn't have to do.

> Also I'm not sure but what will happen if this video-firmware subnode is
> not added, do you expect that backward compatibility is satisfied for
> older venus versions?
> 

I do expect that the driver should be possible to run on a 845 with the
normal TZ based security model we've seen on e.g. 820. I don't know the
details of Venus well enough to see if this differentiation would be
sufficient.

Regards,
Bjorn
