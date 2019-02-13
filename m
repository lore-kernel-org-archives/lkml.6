Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC667C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48FE21902
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404402AbfBMQRJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:17:09 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:56039 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404221AbfBMQRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:17:02 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-120-j48i3whzPMyeTZXy-1nD-Q-1; Wed, 13 Feb 2019 16:16:58 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 13 Feb 2019 16:17:41 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 13 Feb 2019 16:17:41 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>,
        David Miller <davem@davemloft.net>
CC:     "julien@arista.com" <julien@arista.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>,
        "vyasevich@gmail.com" <vyasevich@gmail.com>,
        "lucien.xin@gmail.com" <lucien.xin@gmail.com>
Subject: RE: [PATCH net] sctp: make sctp_setsockopt_events() less strict about
 the option length
Thread-Topic: [PATCH net] sctp: make sctp_setsockopt_events() less strict
 about the option length
Thread-Index: AQHUwX1vGkCaWibVqE6iK21f5qVrJKXd6y/A
Date:   Wed, 13 Feb 2019 16:17:41 +0000
Message-ID: <71e3d64ae3d44e499f3fb9f876398ee4@AcuMS.aculab.com>
References: <20190206201430.18830-1-julien@arista.com>
 <20190206203754.GC13621@localhost.localdomain>
 <20190209.151217.175627323493244750.davem@davemloft.net>
 <20190210124616.GG13621@localhost.localdomain>
 <20190210201559.GE10665@localhost.localdomain>
In-Reply-To: <20190210201559.GE10665@localhost.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: j48i3whzPMyeTZXy-1nD-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Ricardo Leitner
> Sent: 10 February 2019 20:16
...
> We have issues on read path too. 52ccb8e90c0a ("[SCTP]: Update
> SCTP_PEER_ADDR_PARAMS socket option to the latest api draft.")
> extended struct sctp_paddrparams and its getsockopt goes with:

The API shouldn't change like this at all.
Is this from the RFC or elsewhere??

If the structure changes the socket option name and value
should also change.

IMHO large chunks of the sctp rfc are just horrid.
In particular all the places where is states that API functions are
implemented using setsockopt() - that should be an implementation detail.
Also ISTR that some of the structures are defined to have holes in them...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

