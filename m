Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752361AbeBZJvF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:51:05 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36165 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeBZJvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:51:00 -0500
X-Google-Smtp-Source: AG47ELsgMCxaoAFbk0WzaMnMgz8Vx7XokWPNnB0GuOh8pTodXnkl1H1PglbgHNtdMRkXFQeK7/VowZTlXIaYouS25ZI=
MIME-Version: 1.0
In-Reply-To: <20180225185250.10759-1-rodrigorivascosta@gmail.com>
References: <20180225185250.10759-1-rodrigorivascosta@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Mon, 26 Feb 2018 10:50:59 +0100
Message-ID: <CAO-hwJ+PDkR4v5r93KJBCqxfm3FTCkrzaOd-K=HxLMwhoAomXQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] new driver for Valve Steam Controller
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Cameron Gutman <aicommander@gmail.com>,
        =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo,

On Sun, Feb 25, 2018 at 7:52 PM, Rodrigo Rivas Costa
<rodrigorivascosta@gmail.com> wrote:
> This patchset implements a driver for Valve Steam Controller, based on a
> reverse analysis by myself.

To me, the code looks OK now. I haven't got the time to do a better
review, so giving my:
Acked-by: Bnejamin Tissoires <benjamin.tissoires@redhat.com>

However, before we include it, I'd like to have the ACK from
Pierre-Loup and Clément. They should be more qualified than me to say
if this will interfere with the official Steam client (I think we are
good now, but that's just my opinion).

Cheers,
Benjamin

>
> This is reroll v3, codenamed "lazy lizard". Changes from v2:
>  * Use RCU to do the dynamic connec/disconnect of wireless devices. Please,
>    to anybody that knows their way around RCU, review.
>  * Remove entries in hid-quirks.c as they are no longer needed. This allows
>    this module to be blacklisted without side effects.
>  * Do not bypass the virtual keyboard/mouse HID devices to avoid breaking
>    existing use cases (lizard mode). A user-space tool to do that is
>    linked.
>  * Fully separated axes for joystick and left-pad. As it happens, there are
>    people with too many fingers.
>  * Add fuzz values for left/right pad axes, they are a little wiggly.
>
> Notable changes from patchset v1:
>  * Remove references to USB. Now the interesting interfaces are selected by
>    looking for the ones with feature reports.
>  * Feature reports buffers are allocated with hid_alloc_report_buf().
>  * Feature report length is checked, to avoid overflows in case of
>    corrupt/malicius USB devices.
>  * Resolution added to the ABS axes.
>  * A lot of minor cleanups.
>
> Rodrigo Rivas Costa (3):
>   HID: add driver for Valve Steam Controller
>   HID: steam: add serial number information.
>   HID: steam: add battery device.
>
>  drivers/hid/Kconfig     |   8 +
>  drivers/hid/Makefile    |   1 +
>  drivers/hid/hid-ids.h   |   4 +
>  drivers/hid/hid-steam.c | 777 ++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 790 insertions(+)
>  create mode 100644 drivers/hid/hid-steam.c
>
> --
> 2.16.2
>
