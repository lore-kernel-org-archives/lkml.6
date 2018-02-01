Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeBAKNp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:13:45 -0500
Received: from smtp-out6.electric.net ([192.162.217.195]:51941 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeBAKNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:13:44 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: "'Gustavo A. R. Silva'" <garsilva@embeddedor.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
CC: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Wong Hoi Sing, Edison" <hswong3i@gmail.com>,
        "Hung Hing Lun, Mike" <hlhung3i@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tcp_lp: use 64-bit arithmetic instead of 32-bit
Thread-Topic: [PATCH] tcp_lp: use 64-bit arithmetic instead of 32-bit
Thread-Index: AQHTmvk7Mo28H5m4ekm8jq1nUbqRXqOPUiCw
Date: Thu, 1 Feb 2018 10:14:29 +0000
Message-ID: <ef625a4f15144822a037ddabc33a4134@AcuMS.aculab.com>
References: <20180201002407.GA1608@embeddedgus>
 <20180201003236.06143fd0@alans-desktop>
 <20180131190749.Horde.bsc7GhewsZwdnkmDtMlSwWO@gator4166.hostgator.com>
In-Reply-To: <20180131190749.Horde.bsc7GhewsZwdnkmDtMlSwWO@gator4166.hostgator.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w11ADpTF013364

> > The question you need to ask is 'can it overflow 32bit maths', otherwise
> > you are potentially making the system do extra work for no reason.
> >
> 
> Yeah, I get your point and it seems that in this particular case there
> is no risk of a 32bit overflow, but in general and IMHO as the code
> evolves, the use of incorrect arithmetic may have security
> implications in the future, so I advocate for code correctness in this
> case.

Even if the variable are 64bit you still need to worry (maybe less)
about arithmetic overflow.
The only real way to avoid overflow is to understand the domain
of the values being used.

	David
