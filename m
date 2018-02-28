Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbeB1MDM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:03:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:8055 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752195AbeB1MDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:03:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,405,1515484800";
   d="asc'?scan'208";a="38105551"
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: HRTimer causing rtctest to fail
In-Reply-To: <alpine.DEB.2.21.1802281246420.1886@nanos.tec.linutronix.de>
References: <87vaei601x.fsf@linux.intel.com> <alpine.DEB.2.21.1802271640010.1886@nanos.tec.linutronix.de> <87muzt5usg.fsf@linux.intel.com> <alpine.DEB.2.21.1802281043050.1886@nanos.tec.linutronix.de> <87k1ux5qpf.fsf@linux.intel.com> <alpine.DEB.2.21.1802281246420.1886@nanos.tec.linutronix.de>
Date: Wed, 28 Feb 2018 14:02:20 +0200
Message-ID: <87h8q15nlf.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Thomas Gleixner <tglx@linutronix.de> writes:
> On Wed, 28 Feb 2018, Felipe Balbi wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>> > All numbers in micro seconds! What happens if you load the system or
>> > restrict C-States?
>>=20
>> added intel_idle.max_cstate=3D0 to cmdline. Still see some failures,
>> albeit a lot more rare, for example, caught one on iteration 8 of
>> 8192Hz:
>>=20
>> 8192Hz:	 1 2 3 4 5 6 7
>> PIE delta error: 0.000135 should be close to 0.000122
>>=20
>> That is, however, only 13 uS late. Is that within the limits of "we
>> don't quite care"?
>
> I think so. 13us (depending on the machine) can easily happen if multiple
> interrupts/timers happen at the same time or if something keeps interrupts
> disabled for a few microseconds which is certainly possible.
>
> What kind of system is this?

4 core Kabylake.

>> BTW, it took some effort to get that one failure. I'll leave rtctest
>> running in a long loop and try to figure out approximately how frequently
>> it fails, but it seems like it's within the realm of "don't care", would
>> you agree?
>
> Yes.

cool, thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqWmkwACgkQzL64meEa
mQb/ew/9Gnyi62Ax+VhMMlisM+4JJVP2AqY+MM9c7KMs/TwdNEaUwBhdkIE2gd4L
jb+x9RdKRL8cpx3dZkzrhXSRvOfOfL7EXNjL2rUJkX/R+PUSkP1yMH0P90CqmMmD
awGBxmveQ6/Dwg+jcSR0nRhbShLfY8Q36nRESHUQtTCBDweNcQTB7qFyDsF3/KHY
476+lpNVWc8thm7yxATZN8epGU9SbhI39pmnzyrPnEOPCOi7Gf+qit/AHOtYB7x2
kUZRVqHeOdnBAFMwTxV+syWKNsIE/lA5Km3wf+d0bubDhAHsBZvLj1JBslkxY5lf
in0yrsFLmKHJYJBvctRbGQuRwf1yY7LWFFD07spjIIDHCK8dBn1wdC2jq0a90tM6
a+SIjL+YryOKF0kPR85y4JJYKUq4XcIw9VXqkcFaYt4fgQ9TCwpI7hZfv+5Vys3W
QegfxWWIqaMpnAIwnJEf63+4qj2pzlX2n7fMK/ZlU/pOVmFXvYEJSLbuUFcdgcIK
7WznEQgbCW8lfzhScjqswvWPSrf1R6KuYo8vRAYFMxccCKSiRfbC84Te6xqcq8WQ
Bu/UL+v/f97jV0vpnv7dqv07Di+C48PWY9aUoImV6EvNI+X0g/sKQEhaxBR4I5Ab
up8RR+W0kOEB9sN3KN4CyIOmCioLZ6oVFTW7QzyM7QLZzq2K/4s=
=dEkH
-----END PGP SIGNATURE-----
--=-=-=--
