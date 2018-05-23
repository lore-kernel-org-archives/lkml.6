Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754861AbeEWSSF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:18:05 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36870 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754658AbeEWSSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:18:03 -0400
X-Google-Smtp-Source: AB8JxZoWzP3GsCmZic4l8YCzm49ojp3LLKgPcG2uOgZvfEQmmzMr8KFUj/SYpmO78S1na99NpunrDg==
Date: Wed, 23 May 2018 13:18:00 -0500
From: Rob Herring <robh@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, sudeep.holla@arm.com,
        frowand.list@gmail.com, coresight@lists.linaro.org,
        mark.rutland@arm.com, Mike Leach <mike.leach@linaro.org>,
        John Horley <john.horley@arm.com>,
        Robert Walker <robert.walker@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 06/11] dts: bindings: Restrict coresight tmc-etr
 scatter-gather mode
Message-ID: <20180523181800.GA610@rob-hp-laptop>
References: <1526661567-4578-1-git-send-email-suzuki.poulose@arm.com>
 <1526661567-4578-7-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526661567-4578-7-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 05:39:22PM +0100, Suzuki K Poulose wrote:
> We are about to add the support for ETR builtin scatter-gather mode
> for dealing with large amount of trace buffers. However, on some of
> the platforms, using the ETR SG mode can lock up the system due to
> the way the ETR is connected to the memory subsystem.
> 
> In SG mode, the ETR performs READ from the scatter-gather table to
> fetch the next page and regular WRITE of trace data. If the READ
> operation doesn't complete(due to the memory subsystem issues,
> which we have seen on a couple of platforms) the trace WRITE
> cannot proceed leading to issues. So, we by default do not
> use the SG mode, unless it is known to be safe on the platform.
> We define a DT property for the TMC node to specify whether we
> have a proper SG mode.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: John Horley <john.horley@arm.com>
> Cc: Robert Walker <robert.walker@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: frowand.list@gmail.com
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/coresight.txt | 2 ++
>  drivers/hwtracing/coresight/coresight-tmc.c         | 9 ++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
