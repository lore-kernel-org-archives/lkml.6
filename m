Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8E4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FCE20878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FCE20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbeLFMGY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:06:24 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:59360 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbeLFMGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:06:24 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 65D94149B5; Thu,  6 Dec 2018 12:06:22 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Abel <rabel@robertabel.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] auxdisplay: charlcd: fix x/y command parsing
References: <20181205135247.7964-1-mans@mansr.com>
        <CANiq72=Xg--8vG0+JLsPykOUfXpo89R2H-pBLuMROnQjMui7qA@mail.gmail.com>
        <yw1xr2evkg8t.fsf@mansr.com>
        <CANiq72keqco3F=8YDHFqoeBRFsrs1Cbd1aF1owf90Hbncv40mA@mail.gmail.com>
Date:   Thu, 06 Dec 2018 12:06:22 +0000
In-Reply-To: <CANiq72keqco3F=8YDHFqoeBRFsrs1Cbd1aF1owf90Hbncv40mA@mail.gmail.com>
        (Miguel Ojeda's message of "Thu, 6 Dec 2018 11:06:22 +0100")
Message-ID: <yw1xmupikgg1.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Wed, Dec 5, 2018 at 6:58 PM Måns Rullgård <mans@mansr.com> wrote:
>>
>> Suppose the command "\e[Lx0y0;" is written to the device.  The
>> charlcd_write_char() function adds one character at a time to the escape
>> sequence buffer.
>
> Ah, yes, that is much more clear. Indeed, parse_xy() expects the
> entire command; the strchr() should still be there.
>
> By the way, if we are going to move to a direct check, I would also do
> so in the generator command too if possible, to be consistent (in
> another patch, possibly).

I'd consider that separately.  You're the maintainer, so it's up to you.

>> BTW, the parsing of this command has been broken since 3.2-rc1 due to
>> commit 129957069e6a.
>
> Thanks for checking! Are you able to test this?

Yes, that's how I noticed it was broken.

-- 
Måns Rullgård
