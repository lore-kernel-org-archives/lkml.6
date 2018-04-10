Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbeDJNlC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:41:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36189 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753057AbeDJNlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:41:00 -0400
Message-ID: <1523367652.4981.9.camel@pengutronix.de>
Subject: Re: [PATCH V7 00/13] drivers: Boot Constraint core
From: Lucas Stach <l.stach@pengutronix.de>
To: Georgi Djakov <georgi.djakov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robdclark@gmail.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, fabio.estevam@nxp.com,
        nm@ti.com, xuwei5@hisilicon.com, robh+dt@kernel.org, olof@lixom.net
Date: Tue, 10 Apr 2018 15:40:52 +0200
In-Reply-To: <cbcfeb15-d940-f066-739d-25adfe09f019@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
         <20180322012606.vuaemu3pvpeojtwr@vireshk-mac-ubuntu>
         <20180323150420.GA21152@kroah.com>
         <cbcfeb15-d940-f066-739d-25adfe09f019@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georgi,

Am Freitag, den 30.03.2018, 18:24 +0300 schrieb Georgi Djakov:
[...]
> The interconnect core takes requests from consumer drivers for their
> bandwidth needs and configures the hardware to keep the lowest possible
> power profile. I think that the boot constraint patches would be useful
> to make a board run at maximum performance during boot, until all
> consumer drivers are probed and all bandwidth requests are taken into
> account.

Can you please describe how this bootconstraints core integration is
simpler than a "run things at max performance until late kernel init",
which could be triggered by a simple initcall similar to what is done
for clocks and regulators?

To me the bootcontraints stuff looks like a fairly complex solution and
your use-case doesn't even sound like you strictly want to keep a
bootloader configuration, but rather run things at max performance
until you are reasonably sure that you got all the necessary bandwidth
requests.

Regards,
Lucas
