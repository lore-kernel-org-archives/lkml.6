Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946411AbeCBKvH convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:51:07 -0500
Received: from smtp-out4.electric.net ([192.162.216.195]:57017 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423907AbeCBKum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:50:42 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: "'Florian Fainelli'" <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Woojung Huh <Woojung.Huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net 3/4] net: dsa: microchip: Utilize strncpy() for
 ethtool::get_strings
Thread-Topic: [PATCH net 3/4] net: dsa: microchip: Utilize strncpy() for
 ethtool::get_strings
Thread-Index: AQHTsb1J6/+s0d4DzEGPcuGOW9QFtaO8xLkg
Date: Fri, 2 Mar 2018 10:51:33 +0000
Message-ID: <5dfe389482c54437873d4c0ae29eca8a@AcuMS.aculab.com>
References: <20180302002529.15226-1-f.fainelli@gmail.com>
 <20180302002529.15226-4-f.fainelli@gmail.com>
In-Reply-To: <20180302002529.15226-4-f.fainelli@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
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

From: Florian Fainelli
>
> Do not use memcpy() which is not safe, but instead use strncpy() which
> will make sure that the string is NUL terminated (in the Linux
> implementation) if the string is smaller than the length specified. This
> fixes KASAN out of bounds warnings while fetching port statistics.

You really ought to use a copy function that will truncate the
string if it is too long.
Just assuming the string isn't too long is asking for trouble.
You might (almost) just use strcpy().

strlcpy() will probably work best here.

	David
