Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751567AbeDYJyC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:54:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:53049 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751353AbeDYJyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:54:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,325,1520924400";
   d="scan'208";a="36900655"
Date: Wed, 25 Apr 2018 12:53:55 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Javier Arteaga <javier@emutex.com>
Cc: linux-kernel@vger.kernel.org, "Dan O'Donovan" <dan@emutex.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [RFC PATCH RESEND 0/3] UP Squared board drivers
Message-ID: <20180425095355.GM2173@lahna.fi.intel.com>
References: <20180421085009.28773-1-javier@emutex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180421085009.28773-1-javier@emutex.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2018 at 09:50:06AM +0100, Javier Arteaga wrote:
> [linux-kernel correctly Cc'd on the series now. Sorry for the noise.]
> 
> Hi all,
> 
> This series adds platform support for AAEON's UP Squared, a x86 SBC
> based on Apollo Lake [1]. Specifically, it enables control for the board
> pin headers and for the LEDs, as both of these features are only
> available behind a FPGA-based platform controller.
> 
> This is structured around a MFD driver that provides a regmap interface
> to that platform controller to each MFD cell.
> 
> The series is carved out from an out-of-tree support patchset, initially
> written by Dan O'Donovan for the original UP Board [2] and then extended
> through the past year to support new entries in the lineup (UP Board, UP
> Squared and UP Core) [3].
> 
> Here we only submit support for UP Squared to simplify review. Still,
> the driver is designed so that it can easily gain support for the other
> boards.
> 
> Questions:
> 
> * Is MFD the right fit for the platform controller?
>   The intention here is to encapsulate the custom GPIO-bitbanged control
>   protocol by sharing the regmap between the drivers.
> 
> * Is our use of two chained pinctrls (in patch 3/3) valid?

There are few minor comments but other than that, to me this looks like
a reasonable approach.
