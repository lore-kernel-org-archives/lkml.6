Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08045C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB8F20C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB8F20C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389320AbeGKQI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:08:57 -0400
Received: from smtprelay0220.hostedemail.com ([216.40.44.220]:36163 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726586AbeGKQI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:08:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 8319C1801A5F4;
        Wed, 11 Jul 2018 16:03:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: blood24_52d189885c60
X-Filterd-Recvd-Size: 2499
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Jul 2018 16:03:55 +0000 (UTC)
Message-ID: <2ebdcea56cc0d8e5cff906c7991c74fc6b01ee76.camel@perches.com>
Subject: Re: [PATCH 3/6] staging: rtl8723bs: fix indentation
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Wed, 11 Jul 2018 09:03:53 -0700
In-Reply-To: <005bbcfc-402d-db85-8f5a-1b64cfe6b612@gmail.com>
References: <20180708103855.12473-1-straube.linux@gmail.com>
         <20180708103855.12473-3-straube.linux@gmail.com>
         <194c5239a1ef9a1f472bad7c5bcc6e3b7675b0ec.camel@perches.com>
         <b7468cdd-1555-ef61-b475-3d4677aa423a@gmail.com>
         <005bbcfc-402d-db85-8f5a-1b64cfe6b612@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 15:57 +0200, Michael Straube wrote:
> On 07/08/18 19:36, Michael Straube wrote:
> > On 07/08/18 18:46, Joe Perches wrote:
> > > On Sun, 2018-07-08 at 12:38 +0200, Michael Straube wrote:
> > > 
> > > uint rtw_is_cckratesonly_included(u8 *rate)
> > > {
> > >     while (*rate) {
> > >         u8 r = *rate & 0x7f;
> > > 
> > >         if (r != 2 && r != 4 && r != 11 && r != 22)
> > >             return false;
> > >         rate++;
> > >     }
> > > 
> > >     return true;
> > > }
> > > 
> > 
> > The patch has been added to staging-testing already.
> > I will send patches with your suggestions the next days.
> 
> Would it be preferred to declare the variable at the functions beginning,
> or doesn't it matter regarding coding style?

Not really.

It's generally preferred to have declarations in the
nearest possible open brace to allow the compiler to
reduce the overall stack space consumed by the function.

For example prefer:

int some_function(int arg, void *pointer)
{
	if (arg == 1} {
		struct foo a = *(struct foo *)pointer;
		...
	} else if (arg == 2) {
		struct bar b = *(struct bar *)pointer;
		...
	}
}

over

int some_function(int arg, void *pointer)
{
	struct foo a;
	s
truct bar b;

	if (arg == 1} {
		a = *(struct foo *)pointer;
		...
	} else if (arg == 2) {
		b = *(struct bar *)pointer;
		...
	}
}

as a and b could use the same stack in the
first example but not the second.
