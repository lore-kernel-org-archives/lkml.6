Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id hX4GJxrXGFt2SQAAmS7hNA
	; Thu, 07 Jun 2018 06:56:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8612F608B8; Thu,  7 Jun 2018 06:56:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cxl33Uvu"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 138A5607F7;
	Thu,  7 Jun 2018 06:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 138A5607F7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeFGG4Y (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 02:56:24 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:42497 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbeFGG4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 02:56:22 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DAD7F1E03E8;
        Thu,  7 Jun 2018 08:56:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1528354581; bh=U/B/vEGZzSoiW3M/fjxBTgAGW+pLRtonYKME16fX5Ds=;
        h=From:To:CC:Subject:Date:References:From;
        b=cxl33UvuJLuH3SEFdUbCTdhOifYcRFM4jyT4O/I85EQMihHTEpLbySnn6moaKxC8x
         00sDbUNqKRWHwmq9KoMb7mVfQyPYUQgoMoefPHKvLKkcOPeIQYcjPOwltEE5BMhAdQ
         497YxcBc8Adwel0JyoKwvWBN8ejIQdewzzriR0brT4lefKH8U2Aru7tqbZqA2/TmR4
         ei9bw9hdBeal1yDygKgdVD265yeNoU+yfAGMSMbbt9jksdYUhkGyZtXUOiyBZhB3No
         t2iYn1HULeOE0Z8INnZA4Lj4Xw1m8ZONntmueAcFCJBmYjk8lS/bMnhHpaV8EUlBk9
         lsWmC/MecAMpQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1.internal.synopsys.com [10.12.239.235])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7D8975B1D;
        Wed,  6 Jun 2018 23:56:19 -0700 (PDT)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 6 Jun 2018 23:55:53 -0700
Received: from IN01WEMBXA.internal.synopsys.com ([fe80::ed6f:22d3:d35:4833])
 by IN01WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu,
 7 Jun 2018 12:25:43 +0530
From: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
To: Jens Axboe <axboe@kernel.dk>,
        Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>,
        Christoph Hellwig <hch@infradead.org>
CC: Hannes Reinecke <hare@suse.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Manjunath M Bettegowda <Manjunath.MB@synopsys.com>,
        Prabu Thangamuthu <Prabu.T@synopsys.com>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Milan Broz" <gmazyland@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Eric Biggers" <ebiggers3@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] block: Add block level changes for inline encryption
Thread-Topic: [PATCH] block: Add block level changes for inline encryption
Thread-Index: AQHT+YBsRN+yoa9w10qCAP3oXXj0ew==
Date: Thu, 7 Jun 2018 06:55:42 +0000
Message-ID: <BD7FB879CC136E419544C8E2AE7B9C3020C7FA@IN01WEMBXA.internal.synopsys.com>
References: <d3624fab-e6fc-f14d-c780-db703c809068@synopsys.com>
 <20180601081330.GA13067@infradead.org>
 <BD7FB879CC136E419544C8E2AE7B9C3020C566@IN01WEMBXA.internal.synopsys.com>
 <918609fa-8721-0ee1-801e-4c29b64ac9ae@kernel.dk>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.239.235]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 June 2018 02:53 AM, Jens Axboe wrote:=0A=
> On 6/6/18 1:35 AM, Ladvine D Almeida wrote:=0A=
>> On Friday 01 June 2018 09:13 AM, Christoph Hellwig wrote:=0A=
>>> On Mon, May 28, 2018 at 02:43:09PM +0100, Ladvine D Almeida wrote:=0A=
>>>> This patch introduces new variable under bio structure to=0A=
>>>> facilitate inline encryption. This variable is used to=0A=
>>>> associate I/O requests to crypto information.=0A=
>>> This seems to be missing a whole lot of context.  Where is the whole=0A=
>>> series showing what you are trying to do?=0A=
>>>=0A=
>> Christoph,=0A=
>>=0A=
>> The patches are generated in the below > manner, with a thought of=0A=
>> sending separately to the MAINTAINERS responsible for each.=0A=
> What both Christoph and I have said is that it's _impossible_ to review=
=0A=
> changes when you don't know what is being built on top of it. The block=
=0A=
> change, by itself, is utterly useless. The use case needs to be seen.=0A=
> But apart from that, my comments on why it's doing it completely=0A=
> backwards still apply, and I've outlined how you need to fix it. The=0A=
> patch, in its current form, isn't going anywhere.=0A=
>=0A=
Jens,=0A=
=0A=
Since there are implementation level concerns on both device mapper layer a=
nd block layer, I will investigate=0A=
=0A=
more and work on those lines. I can send the full patch series to the relev=
ant maintainers after addressing the=0A=
=0A=
issues.=0A=
=0A=
Regards,=0A=
=0A=
Ladvine=0A=
=0A=
