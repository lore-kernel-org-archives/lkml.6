Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752702AbeCXXC2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 19:02:28 -0400
Received: from mout.perfora.net ([74.208.4.197]:58447 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752174AbeCXXC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 19:02:27 -0400
X-Google-Smtp-Source: AG47ELsyozL/C/z+7OuERYkmzYyoK7s6Vyzy8jxx/HOcHDW+t2SUn/Vc+YQNdtuZVjh4UtRlM0JhUQyDl+G0JN4bl9E=
MIME-Version: 1.0
In-Reply-To: <e31eb13b-598b-e7c7-607b-c98664818563@lwfinger.net>
References: <20180324041027.6498-1-quytelda@tamalin.org> <e31eb13b-598b-e7c7-607b-c98664818563@lwfinger.net>
From: Quytelda Kahja <quytelda@tamalin.org>
Date: Sat, 24 Mar 2018 16:02:24 -0700
X-Gmail-Original-Message-ID: <CAFLvi20sgO4aKTLYutvwUr5aN9TLaqLWVghC9Y9MrKZvcixAYA@mail.gmail.com>
Message-ID: <CAFLvi20sgO4aKTLYutvwUr5aN9TLaqLWVghC9Y9MrKZvcixAYA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ieee80211: Replace bit shifts with the BIT() macro
 for WLAN_CAPABILITY_*.
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K0:781fKwMWKbcz+oMNI8aL8ms8MLWSX8MpasNKFbmAZvWpsK1zbJv
 qqujV3PW3RRNBDWLQjo2UFXgU0wQ8vz/vxyHzO0Mz9kXfjzFWujQJhoyR7UleIEe3THrT68
 JqQHNg9HJ35M29MJxDbxwLCkGcrHi5u3q4QTipajTknZz2hGJDhdjjIu+gusaWdMxYgxSol
 tR8TuJidw2pkrHwY4CAjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lonYFvSsRHE=:EKqqkVVhsQnaJfdeueAjHW
 KuStuAdweUZTFR+FIDoJ05gY1Dl9sDmKzWR4s/uzea6pGF6fMGKSpI4odKnXNZC+UvZtEmw6a
 Wb4b2yW8ef+MVDFEPlI5VTkmHeLghDBoJOocPYNahXNzUWlSa+FplJPnRpExGa6+kHXc30KiB
 /d2TLubHkyaY455egFUiKFg0SEHsdChJGkUBbmc3jiPg/5kPjacesqGc/CneFEqMNDfTHCc/M
 Eqv1gVRNYmX4HKIVDZFY4dQyqFMoioURsjrUHPLdkCo61M1PA5WkaIOHWDNTUFsnS0dV67drG
 eBy39qxonhHr2AmgKjQqldRgKbBojUfBn2NmmA7oAaRvTIvINX+J6SK52YqoTVrYtbiPpqXbm
 g3UqjYUKb3SPaoLozDYOz3V0ripTbSWmrEUwPbKMixWdFD4Kmrz08J+RFGonfahxXBu+4ud08
 G1RVRQv0vd1g9oFbCjSSRCOHE7q2QVphHOeaLHqbNAnocNX6YIWpMlsm1El1x8MoFER617gGb
 ukJwF5MoAZl9GMyvUe/Kwnbwmqiynp+J11ILd6lSlcu76CNcufxZEhiiIkCFfbZTYdltBjcUI
 FzdIpb8lw3AceRAmqm/A6IwlGexAKtRqCA+WdIQRPajUs1fH1MGqHfoydHDjKlVrNRcKz59dX
 81C3m5QFzixgZOysI+F3w2Nt4BMsrOQ9y17l1DiBaivx23bd5lNpzp7awOG8nJXoDXaq7J89s
 o2e8w4xUCTJTYqE3xfhySD2jqAUPIxl50t9qYS2ebE3FcR/Ik+tLFzvxnnE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "document" refers to the file in which the changes were made
('include/linux/ieee80211.h').

I tend to try to split my commits into the smallest logically related
changes possible, hence the three patch series.  This particular case
may be a little on the extreme side, but if the maintainer desires,
they can always squash them together or ask me to resubmit as one
patch.

On 3/24/18, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> On 03/23/2018 11:10 PM, Quytelda Kahja wrote:
>> It is neater and more consistent with the rest of the document to use the
>> BIT() macro from 'linux/bitops.h' to define the WLAN_CAPABILITY_*
>> bitmasks.  In the case of WLAN_CAPABILITY_DMG_TYPE_{IBSS, PBSS, AP},
>> bitshifting integers by 0 does nothing, so there is no reason to do it in
>> the code; replace these values with plain integers.
>>
>> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
>
> In the commit message for all of these, what is the "document" to which you
> refer?
>
> I'm not quite sure why you split these changes into 3 parts, but I guess
> that is OK.
>
> Larry
>
-- 
Thank you,
Quytelda Kahja
