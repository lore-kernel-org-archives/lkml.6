Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeDKEjw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 00:39:52 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:32855 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbeDKEju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 00:39:50 -0400
X-Google-Smtp-Source: AIpwx4/JKknpBvirRn0conLmrQujZ7AbiprQ/yoXFDw90OYtxTY+okVwwtyfWcckdE3A2O/lN86pcw==
Date: Wed, 11 Apr 2018 10:09:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Georgi Djakov <georgi.djakov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robdclark@gmail.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, fabio.estevam@nxp.com,
        nm@ti.com, xuwei5@hisilicon.com, robh+dt@kernel.org, olof@lixom.net
Subject: Re: [PATCH V7 00/13] drivers: Boot Constraint core
Message-ID: <20180411043947.GK7671@vireshk-i7>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
 <20180322012606.vuaemu3pvpeojtwr@vireshk-mac-ubuntu>
 <20180323150420.GA21152@kroah.com>
 <cbcfeb15-d940-f066-739d-25adfe09f019@linaro.org>
 <1523367652.4981.9.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523367652.4981.9.camel@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-04-18, 15:40, Lucas Stach wrote:
> Can you please describe how this bootconstraints core integration is
> simpler than a "run things at max performance until late kernel init",
> which could be triggered by a simple initcall similar to what is done
> for clocks and regulators?
> 
> To me the bootcontraints stuff looks like a fairly complex solution and
> your use-case doesn't even sound like you strictly want to keep a
> bootloader configuration, but rather run things at max performance
> until you are reasonably sure that you got all the necessary bandwidth
> requests.

What about this case where drivers of some of the devices used during
boot are built as modules, like display, HDMI, etc., and would be
available only after userspace is up. We need to take care of their
bandwidth requirements as well, until the time their driver comes up.

-- 
viresh
