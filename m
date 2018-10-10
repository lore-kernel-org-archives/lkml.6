Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5BDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC6B2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC6B2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbeJKDon convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:44:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44885 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727478AbeJKDom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:44:42 -0400
Received: from [10.171.235.234] ([192.55.54.59])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w9AKKoIh1611568
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 10 Oct 2018 13:20:50 -0700
Date:   Wed, 10 Oct 2018 13:20:48 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20181010211717.30c1f052@alans-desktop>
References: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com> <20181010211717.30c1f052@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: Insanely high baud rates
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
CC:     linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
From:   hpa@zytor.com
Message-ID: <16D6AB22-697E-498C-A5B2-3AD90B567E86@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 10, 2018 1:17:17 PM PDT, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>On Tue, 9 Oct 2018 12:19:04 -0700
>"H. Peter Anvin" <hpa@zytor.com> wrote:
>
>> [Resending to a wider audience]
>> 
>> In trying to get the termios2 interface actually implemented in
>glibc,
>> the question came up if we will ever care about baud rates in excess
>of
>> 4 Gbps, even in the relatively remote future.
>
>Even RS485 at 4MBits involves deep magic. I think we are fairly safe.
>Not
>only that but our entire tty layer isn't capable of sustaining anything
>even remotely in that range.
>
>I think its non issue.
>
>Alan

I'm mostly wondering if it is worth future-proofing for new transports. It sounds like we can have a consensus on leaving the upper 4 bits of the speed fields reserved, but leave the details of implementation for the future?
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
