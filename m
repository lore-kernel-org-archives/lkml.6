Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033429AbeEXQCE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:02:04 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34183 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030215AbeEXQCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:02:01 -0400
X-Google-Smtp-Source: AB8JxZqpJsHHeabGN0Zjq/MGV83mEVWKI+B9BnKcbul5QAXCw4wk9uBCoW4zXDjVPOrlHwC/tFiVCw==
Date: Thu, 24 May 2018 09:01:54 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] pinctrl: cherryview: limit Strago DMI workarounds to
 version 1.0
Message-ID: <20180524160154.GA177107@dtor-ws>
References: <20180522204753.GA260493@dtor-ws>
 <CACRpkdabMV1Vy5dGjW-eRVxY9yAcVhukMY1RNnb7nbYc7keHGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdabMV1Vy5dGjW-eRVxY9yAcVhukMY1RNnb7nbYc7keHGw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, May 24, 2018 at 10:19:55AM +0200, Linus Walleij wrote:
> On Tue, May 22, 2018 at 10:47 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> 
> > As Google/Intel will fix the BIOS/Coreboot issues with hardcoding
> > virtual interrupt numbers for keyboard/touchpad/touchscreen controllers
> > in ACPI tables, they will also update BOARD version number from 1.0
> > to 1.1. Let's limit the DMI quirks that try to preserve virtual IRQ
> > numbers on Strago boards to those that still carry older BIOSes.
> >
> > Note that ideally not BOARD but BIOS version should have been updated.
> > However the BIOS version used by Chrome devices has format of
> > Google_BUILD.BRANCH.PATCH which is not well suited for DMI matching as
> > we do not have "less than" match mode for DMI data.
> >
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=197953
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >
> > v1->v2:
> >
> > - switch from matching on DMI_BIOS_VERSION to DMI_BOARD_VERSION
> 
> Patch applied for fixes.
> 
> Should this also be tagged for stable?

No, I do not think so. The workaround being active does not cause any
issues on boxes with updated firmware, so there is no point in trying to
get the patch to older kernels. It is going forward that we want the
"proper" behavior, when possible.

Also, I am not quite sure when the new firmware version will get
qualified for release.

Thanks.

-- 
Dmitry
