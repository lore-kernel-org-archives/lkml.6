Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbeBEN6W (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 08:58:22 -0500
Received: from smtp-out4.electric.net ([192.162.216.185]:52249 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752461AbeBEN6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 08:58:14 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: "'Arnd Bergmann'" <arnd@arndb.de>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Nicolas Pitre <nico@linaro.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jan Beulich <jbeulich@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] xen: hypercall: fix out-of-bounds memcpy
Thread-Topic: [PATCH] xen: hypercall: fix out-of-bounds memcpy
Thread-Index: AQHTnH5MZeMmOwTXYkSEccagX73Jx6OVu3wggAAHrYCAABaB8A==
Date: Mon, 5 Feb 2018 13:58:55 +0000
Message-ID: <b24d41d767554cd5bdbd7cd4fc83d30c@AcuMS.aculab.com>
References: <20180202153240.1190361-1-arnd@arndb.de>
 <aa6e25c7-dc55-a5bf-39cb-8b9453604111@oracle.com>
 <1eddce614f604c518b9bf238a2f92e4b@AcuMS.aculab.com>
 <CAK8P3a0z72S6mY7Q7RBJ_EMCbF9DOi+RdVaUEsB_qo+rGurQ1g@mail.gmail.com>
In-Reply-To: <CAK8P3a0z72S6mY7Q7RBJ_EMCbF9DOi+RdVaUEsB_qo+rGurQ1g@mail.gmail.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w15DwPYR019467

From: Arnd Bergmann
> Sent: 05 February 2018 12:37
....
> > Are the EVTCHNOP_xxx values dense?
> > In which case an array is almost certainly better than the switch statement.
> 
> They are, yes. PHYSDEVOP_xxx are also consecutive by start at '4'.
> Dan made the same comment earlier, and I replied that my I had
> considered it but went for the more failsafe route. I also verified my
> assumption now that gcc in fact is smart enough to turn this
> into a table by itself:

I've never spotted that optimisation, must be fairly new.

	David
