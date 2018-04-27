Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757897AbeD0LyQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:54:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40279 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbeD0LyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:54:15 -0400
Message-ID: <1524830050.17614.9.camel@pengutronix.de>
Subject: Re: [PATCH v4 2/5] reset: qcom: AOSS (always on subsystem) reset
 controller
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Sibi S <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Date: Fri, 27 Apr 2018 13:54:10 +0200
In-Reply-To: <ce0d4222-ae39-56f0-a99c-49b7ac8fde05@codeaurora.org>
References: <20180425150843.26657-1-sibis@codeaurora.org>
         <20180425150843.26657-3-sibis@codeaurora.org>
         <1524825675.17614.6.camel@pengutronix.de>
         <ce0d4222-ae39-56f0-a99c-49b7ac8fde05@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

On Fri, 2018-04-27 at 16:45 +0530, Sibi S wrote:
[...]
> > > +	/* Wait 6 32kHz sleep cycles for reset */
> > > +	usleep_range(200, 210);
> > 
> > 6 32 kHz cycles are about 188 µs (184 µs for 32.768 kHz).
> > Just out of curiosity, is the minimum increased to 200 µs on purpose, or
> > to have a nice round number? The maximum seems oddly small, unless it is
> > essential to wait less than 7 cycles.
> 
> anything above 188 µs should be fine 200 µs is just a round number.
> 
> no it is not essential to wait less than 7 cycles so I can increase
> the max limit to 300 µs.

Ok, thanks for the info.

> > The driver looks good to me now. I plan to apply patches 1 and 2 with
> > Rob's ack.
> > Is it ok to merge them independently from the remoteproc driver, or is
> > there a dependency?
> 
> Yes it should be fine to merge them independently. I can add a dt entry
> to the dtsi and separate the 2 patches from the remoteproc patches if
> that helps ?

I plan to just pick up the reset DT binding documentation patch (1/5)
and the reset driver patch (2/5) then, whether they are sent separately
or as part of the larger remoteproc series does not matter to me.

The dtsi patch would have to go through the arm/qualcomm tree.
I can put the reset patches onto a separate branch that could be pulled
into the qcom tree ahead of the dtsi change, or you could send the dtsi
change with numbers at first, and only replace them with the header
defines after patch 1 is merged through the reset tree.

regards
Philipp
