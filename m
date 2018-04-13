Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeDMPkP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 11:40:15 -0400
Received: from smtp-out4.electric.net ([192.162.216.185]:62403 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeDMPkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 11:40:13 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'James Hogan'" <jhogan@kernel.org>, Sinan Kaya <okaya@codeaurora.org>
CC: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
Thread-Topic: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
Thread-Index: AQHT0qikXjJOjqk/vUybR+JVW4DLMKP+1Ukw
Date: Fri, 13 Apr 2018 15:41:00 +0000
Message-ID: <e38a329dfb9c461ab3e91de7b96db3dc@AcuMS.aculab.com>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <20180412215149.GA27802@saruman>
In-Reply-To: <20180412215149.GA27802@saruman>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3DFeL6c009004

From: James Hogan
> Sent: 12 April 2018 22:52
> On Tue, Apr 03, 2018 at 08:55:04AM -0400, Sinan Kaya wrote:
> > While a barrier is present in writeX() function before the register write,
> > a similar barrier is missing in the readX() function after the register
> > read. This could allow memory accesses following readX() to observe
> > stale data.
> >
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> 
> Both patches look like obvious improvements to me, so I'm happy to apply
> to my fixes branch.

Don't you also need at least barrier() between the register write in writeX()
and the register read in readX()?
On ppc you probably need eieio.
Or are drivers expected to insert that one?
If they need to insert that one then why not all the others??

	David
