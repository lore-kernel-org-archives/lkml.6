Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeEOWZk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:25:40 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:34308 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751149AbeEOWZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:25:38 -0400
X-Google-Smtp-Source: AB8JxZoOidBld1ZvBruAUOWjRMrmn2rygxPxwwFpseGR45Wp4Vmd5mNggSqu0T1uc20pgsRWdJsHBA==
From: valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To: ahs3@redhat.com
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next 20180515 - ACPI disabled..
In-Reply-To: <664f2475-9718-d38e-7270-3426c94f86e8@redhat.com>
References: <50539.1526419088@turing-police.cc.vt.edu> <CAHp75VdwDPumYBphE0BTE=ngsvGkWKuOr9QjBv4c+yw-1pKBWg@mail.gmail.com>
 <664f2475-9718-d38e-7270-3426c94f86e8@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1526423130_2497P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 15 May 2018 18:25:30 -0400
Message-ID: <58438.1526423130@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1526423130_2497P
Content-Type: text/plain; charset=us-ascii

On Tue, 15 May 2018 15:49:15 -0600, Al Stone said:

> Not off-hand.  Could you please send me a copy of /sys/firmware/acpi/tables/APIC

cat /sys/firmware/acpi/tables/APIC | od -x
0000000 5041 4349 0072 0000 3903 4544 4c4c 2020
0000020 4243 3358 2020 0020 2009 0107 4d41 2049
0000040 0013 0001 0000 fee0 0001 0000 0800 0001
0000060 0001 0000 0800 0202 0001 0000 0800 0103
0000100 0001 0000 0800 0304 0001 0000 0c01 0002
0000120 0000 fec0 0000 0000 0a02 0000 0002 0000
0000140 0000 0a02 0900 0009 0000 000d 0604 05ff
0000160 0100
0000162

> on this machine?  The commit cd8c65a6442b that I wrote looks like it got pulled
> in on 20180430, which if I'm understanding correctly, seems to have fixed the
> problem.  Did this work before 20180415?  I assume it did.

0430 is what I'm running right ow, and it works.  Everything before that too.
It fell over sometime between 0430 and 0515,

> What puzzles me is that this message:
>
>    ACPI: [APIC:0x05] Invalid zero length
>
> should only have shown up if the MADT has a broken subtable, and I think that
> bit of code has been that way for quite some time (git blame says somewhere
> around 2012 when the test for this condition was put in).


--==_Exmh_1526423130_2497P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWvteWo0DS38y7CIcAQJhTggAoiu8+B4mhmiBhryQoqlstVmkbH8CJ2dP
xpm1cHb+D5uStRY1QnwDPiKn/avJIbdcF8z0aI4AHLkrlAdZMPZ52+hOZORgne/+
hUoygcXOfU+QzYRSBq4ey/wCBQotOuocc9tJTkmASN3ZfGpFb/kbR+xXmrq8zrVD
3yJ0TtAbMratiAQ91aEEMNHpzX4QHgoOBECOIIvzba4Ylpbm+Wseq7Xs7dMLEkIN
KmniuuGJrbVSOd9UelWvfAMqVBHuWH55+TEcgkFSjbrsn9fbe5gI7xfyVnP0Iwap
NkrFmRue+2HHblSxOTK9mSoDcmsQOT44+DRUiQblZmG83rCllciJOw==
=5bpC
-----END PGP SIGNATURE-----

--==_Exmh_1526423130_2497P--
