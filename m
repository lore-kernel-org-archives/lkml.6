Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932773AbeCEXk5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 18:40:57 -0500
Received: from 5.mo1.mail-out.ovh.net ([178.33.45.107]:57871 "EHLO
        5.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932581AbeCEXk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 18:40:56 -0500
Message-ID: <1520292305.14077.11.camel@florentflament.com>
Subject: Re: [PATCH v2 1/1] HID: Logitech K290: Add driver for the Logitech
 K290 USB keyboard
From: Florent Flament <contact@florentflament.com>
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: andy.shevchenko@gmail.com, jikos@kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Date: Tue, 06 Mar 2018 00:25:05 +0100
In-Reply-To: <CAE7qMrpF4dGCUrtnXbxb4MLFPZ0Wf13mrQEPypwPbEHaB9e44A@mail.gmail.com>
References: <20180304170004.26553-1-contact@florentflament.com>
         <20180304221425.28611-1-contact@florentflament.com>
         <20180304221425.28611-2-contact@florentflament.com>
         <CAE7qMrpF4dGCUrtnXbxb4MLFPZ0Wf13mrQEPypwPbEHaB9e44A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15120835749780486896
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtfedrjeekgdduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-05 at 10:31 +0100, Nestor Lopez Casado wrote:
> Hello Florent,

Hi Nestor,

> In my view, this driver may not be a good idea. The default behaviour
> of K290 is 'send multimedia keycodes' with the user given the choice
> to change that behaviour via vendor commands. Putting a driver that
> will unconditionally change that behaviour without the user's consent
> might bother other users that prefer the multimedia keycodes by
> default.

Actually, the default behavior of the proposed driver is currently to
let the K290 send multimedia keycodes by default (as if using the
generic HID driver). And this behavior can be changed by using the
fn_mode parameter. We may also add a third behavior consisting in not
doing anything, and letting a user space application managing the
keyboard, which could possibly be the default behavior.

> Besides, I'd argue that instead of a kernel module this would be best
> achieved from a user space application. Something in the lines of
> Solaar (github pwr/solaar) or libratbag (there's an issue open to
> support keyboards) or even a specific application built for the
> purpose. Anyways, please collect the input from Benjamin and Jiri as
> they as they best placed to advise than myself.

Indeed, this driver is based on a working user space application
available there https://github.com/milgner/k290-fnkeyctl . However, I
feel a bit awkward to have to install a dedicated package, or compile &
install an application to have proper support of a keyboard. I feel
like it would be more beautiful to have it supported directly by a
module, like most devices.

Regards,
Florent
