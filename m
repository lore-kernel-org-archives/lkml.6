Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeDOTMV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 15:12:21 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:60098 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752639AbeDOTMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 15:12:20 -0400
X-Google-Smtp-Source: AIpwx4/RSIrvWnsllFGHyAc9WAgAwGCGJIBpa5dtCPqqdLCWKK6c5WPhvukcKqZa7VPZ9RDaWCisAQ==
From: valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To: Ivid Suvarna <ivid.suvarna@gmail.com>
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org
Subject: Re: Softlockup and Hardlockup sample test module
In-Reply-To: <CABXF_ACzu=+AKYqPyZwFzFw95KrczVEKaYifmOVuv=YhsvcTtQ@mail.gmail.com>
References: <CABXF_ACzu=+AKYqPyZwFzFw95KrczVEKaYifmOVuv=YhsvcTtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1523819531_4636P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 15 Apr 2018 15:12:11 -0400
Message-ID: <90446.1523819531@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1523819531_4636P
Content-Type: text/plain; charset=us-ascii

On Sun, 15 Apr 2018 13:17:27 +0530, Ivid Suvarna said:

> I had tried with the module where I put a busy loop inside spinlock
> but was not able to cause any lockups. Maybe this is because of SMP
> which schedule the job to other CPU. "How do I make a task to run on
> single CPU only?"

So you get a kernel thread that's taken a lock and will busy-loop and not free
it.  What sort of lockup do you expect will be detected from this? Would the
results be any different if you didn't take a lock before busy-looping?

For bonus points - what additional things have to happen before a livelock
happens?

And before a deadlock happens?

--==_Exmh_1523819531_4636P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWtOkC40DS38y7CIcAQJoTwgAksmWck+WZzNBo9TYKvlHhGOSRskb1mBz
2m+oFqhBVfgJ6w0/+QUWmCp/pW66EoLjelPa6PhIA09pK/Q8twV6EnTRTqfxzuOe
WZrhBoxSavfp8cIrBw2PLX91enzENjHbwc9wukaLk0eVBO24oEtX2/sQQHUaus97
u/QNUEFQSCFR6qiMTcTUZ6dS+uwwL6QC8UoQi38VHsoSM/nQhrw7cFr4YzNizrAh
Kyg8O4E7t9GPwAW2Xa0IUpk5cLsKziQe0qaAPmkpomT7FAPfuUtTEO+KcPyyr64F
EQFQAjZ28z7SpqffOMRFEbYHbODF+zZ5zL16Lr8XduIQlJ3xMXaTRQ==
=7fja
-----END PGP SIGNATURE-----

--==_Exmh_1523819531_4636P--
