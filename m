Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754888AbeEHJjC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 05:39:02 -0400
Received: from smtp-out6.electric.net ([192.162.217.188]:64208 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754431AbeEHJjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 05:39:00 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Salvatore Mesoraca'" <s.mesoraca16@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
CC: Andrew Lunn <andrew@lunn.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: RE: [PATCH v2] net: dsa: drop some VLAs in switch.c
Thread-Topic: [PATCH v2] net: dsa: drop some VLAs in switch.c
Thread-Index: AQHT5heG2KIG7XY3ikmi8HLwy1tagKQkgWcAgAANjQCAAQU2oA==
Date: Tue, 8 May 2018 09:39:58 +0000
Message-ID: <f733e4630e424e0aaf402d5d840cb6e2@AcuMS.aculab.com>
References: <1525706596-13601-1-git-send-email-s.mesoraca16@gmail.com>
 <d7fa9cf7-7c7e-b01c-8925-ce6dafc8721c@gmail.com>
 <CAJHCu1KsvPEs9vpp5bY04OeVfMtqZzPuO=9c8e2QP-+n+VKUjQ@mail.gmail.com>
In-Reply-To: <CAJHCu1KsvPEs9vpp5bY04OeVfMtqZzPuO=9c8e2QP-+n+VKUjQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w489d8lE000902

From: Salvatore Mesoraca
> Sent: 07 May 2018 20:03
...
> This optimization will save us an allocation when number of ports is
> less than 32 or 64 (depending on arch).
> IMHO it's useful, if you consider that, right now, DSA works only with
> 12-ports switches.

Why not just error out if the number of ports is greater than the compile-time
limit?

Worry about dynamic allocation if you need a lot more than 64 ports.

	David
