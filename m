Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE682C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E8B21532
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E8B21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbeHWOvP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:51:15 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([146.101.78.211]:32544 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729486AbeHWOvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:51:14 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-21-ll2a5rXaNe2EUF83RZfEmQ-1; Thu, 23 Aug 2018 12:21:56 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 23 Aug 2018 12:23:35 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 23 Aug 2018 12:23:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michal Hocko' <mhocko@kernel.org>, Weikang Shi <swkhack@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "my_email@gmail.com" <my_email@gmail.com>
Subject: RE: [PATCH] fs: fix local var type
Thread-Topic: [PATCH] fs: fix local var type
Thread-Index: AQHUOtKgUsSAnLeal0y8ska0EIofcaTNMUuQ
Date:   Thu, 23 Aug 2018 11:23:35 +0000
Message-ID: <b66e21d0f55b4f568c81bb9d5d22b7a7@AcuMS.aculab.com>
References: <1535014754-31918-1-git-send-email-swkhack@gmail.com>
 <20180823111355.GD29735@dhcp22.suse.cz>
In-Reply-To: <20180823111355.GD29735@dhcp22.suse.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: ll2a5rXaNe2EUF83RZfEmQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko
> Sent: 23 August 2018 12:14
> 
> On Thu 23-08-18 01:59:14, Weikang Shi wrote:
> > In the seq_hex_dump function,the remaining variable is int, but it receive a type of size_t
> argument.
> > So I change the type of remaining
> 
> The changelog should explain _why_ we need this fix. Is any of the code
> path overflowing?
> 
> Besides that I do not think this fix is complete. What about linelen?
> 
> Why do we even need len to be size_t? Why it cannot be int as well. I
> strongly doubt we need more than 32b here.

Although you may well want 'unsigned int' to avoid the sign extension
instruction that gets added for x86_64 when a signed int is added
to a pointer.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

