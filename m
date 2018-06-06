Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 035D060290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeFFPm3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:42:29 -0400
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:46944 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751546AbeFFPm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:42:26 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mine84_6bcbbd078f712
X-Filterd-Recvd-Size: 2845
Message-ID: <517d33d8219f22126ec8caaf41072c14b5ebf407.camel@perches.com>
Subject: Re: [PATCH v3 00/12] cros_ec: Match licenses and switch to SPDX
 identifier.
From: Joe Perches <joe@perches.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Paolo Cretaro <paolocretaro@gmail.com>,
        linux-iio@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i2c@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        linux-rtc@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        linux-input@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>
Date: Wed, 06 Jun 2018 08:42:19 -0700
In-Reply-To: <20180606150900.8342-1-enric.balletbo@collabora.com>
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-06 at 17:08 +0200, Enric Balletbo i Serra wrote:
> Dear all,
> 
> This patchset is just to adopt the SPDX license identifier for all
> ChromeOS Embedded Controller related drivers.

This bit is fine,

>  The patches touches
> different subsystems but every patch can be picked from their respective
> maintainer independently.
> 
> This third version takes the license note as the valid license (I did
> the contrary in the second version) so apart from add the SPDX tags it
> also introduces new patches to match the license.

But why change any MODULE_LICENSE text?

There are uses of MODULE_LICENSE("GPL") where
the SPDX license identifier is some GPL variant

For instance:
$ git grep -P --name-only
'MODULE_LICENSE\s*\("GPL"\s*\)\s*;'| \
  xargs grep "SPDX-License-
Identifier:" | \
  cut -f3- -d: | \
  sed -r 's@\s*\*/\s*$@@' | \
  sort |
uniq -c | sort -rn
    551  GPL-2.0+
    281  GPL-2.0
     13  GPL-1.0+
    
  9  GPL-2.0-only
      2  GPL-2.0 OR MIT
      1  (GPL-2.0 OR MPL-1.1)
   
   1  (GPL-2.0+ OR BSD-3-Clause)
      1  (GPL-2.0 OR BSD-3-Clause)

And if you were to do this, please do it tree-wide,
and ideally via a script
