Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbeCWQtv convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbeCWQtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:49:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A3421839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Sekhar Nori <nsekhar@ti.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180323130455.11470-1-brgl@bgdev.pl>
Cc: devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180323130455.11470-1-brgl@bgdev.pl>
Message-ID: <152182378792.178046.3747112581117251857@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 0/8] ARM: davinci: complete the conversion to using the reset
 framework
Date: Fri, 23 Mar 2018 09:49:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bartosz Golaszewski (2018-03-23 06:04:47)
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This series converts the only user of the handcoded, mach-specific reset
> routines in the davinci platform to using the reset framework.
> 
> Patch 1 modifies the way lookup entries are registered with the reset
> framework.
> 
> Patches 2-4 add necessary lookups/DT-properties.
> 
> Patches 5-7 convert the davinci-rproc driver to the reset framework.
> 
> Patch 8 removes now dead code.
> 
> Philipp: it turned out that it's indeed better to use the reset
> controller's device name for the entry lookup.
> 
> Tested both in DT and legacy modes by booting the examples from
> ti-ipc-rtos recipe in meta-ti.
> 
> This series applies on top of David Lechner's common-clk-v9 branch[1]
> with Philipp Zabel's reset/next branch[2] pulled in.
> 
> It can be found in my github tree as well[3].
> 

What's the merge strategy for the rest of the patches? I should apply
the clk ones after the next -rc1?
