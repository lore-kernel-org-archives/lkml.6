Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEB2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EE020857
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="uhSKUK1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39EE020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbeGRR0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:26:18 -0400
Received: from vern.gendns.com ([206.190.152.46]:60805 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731191AbeGRR0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Wtfqs0Pn8QT/fhy/IMEWfsdefG2RLex/ASKOtNzVdo4=; b=uhSKUK1XLTef+NJ8F1zkRwLt9x
        K47QguDv6N17SL85uP0pyY0tZzOyCREzGDyHFN9Ur0sJUWSDbD7u5oqFk6eqAwPYo6LpF+Mgg77g6
        mLtRd783hGvOY+QjHS3Wo1W5l7ARopY6d5IWhcIoGG6VGlRUxvzgA9rsv0Q8VIiCdmzNf6Esh5CDt
        jWYkVt4qCFH5I8t48c44B/diIft8CLsrFB5/JckXabSI71K9DzN4MRhIquInBcDNmnbSqdsMnwOnS
        5Rgo4PtRaPQKv70X6EMJjQYZPDZYXWMM8FHIhSh4+YJHNhtj/y9EMXznzGX6Ps488OMvRT3GaU0rG
        aqWdvbzw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:55453 helo=gerda.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1ffpbv-00094N-KD; Wed, 18 Jul 2018 12:47:31 -0400
Subject: Re: [PATCH 2/4] spi: add new SPI_CS_WORD flag
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
References: <20180717032052.12273-1-david@lechnology.com>
 <20180717032052.12273-3-david@lechnology.com>
 <20180718150450.GO5700@sirena.org.uk>
From:   David Lechner <david@lechnology.com>
Message-ID: <a183973d-e648-c7e6-d65b-1479f7e32bb5@lechnology.com>
Date:   Wed, 18 Jul 2018 11:47:30 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180718150450.GO5700@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/18 10:04 AM, Mark Brown wrote:
> On Mon, Jul 16, 2018 at 10:20:50PM -0500, David Lechner wrote:
>> This adds a new SPI mode flag, SPI_CS_WORD, that is used to indicate
>> that a SPI device requires the chip select to be toggled after each
>> word that is transferred.
> 
> This feels like it should have a soft implementation if it is going to
> be truly usable, the vast majority of SPI controllers don't do this and

This occurred to me as well. Another possibility, though, would be to 
leave it up to the client device drivers to support both cases, e.g.:

	if (master has SPI_CS_WORD support)
		setup message as single transfer
	else
		setup message as multiple one-word transfers

This seems like that would be more efficient than having a generic 
implementation for masters that says:

	if (master does not have SPI_CS_WORD support)
		allocate enough transfers for each word of each
			each transfer of the message
		allocate and setup a new message for these transfers
		loop through the original transfers of the original
			message and copy them to the new transfers
		send the new message
		free allocated message and transfers

> I can only think of a few that have the hardware feature.  I'd also
> expect to see some validation added to the core spi_setup() since at
> present a client driver could set the mode option but then have it
> ignored by the controller which would presumably break things, we
> currently only have checks for specific modes and nothing that'd catch
> an unknown flag like this.

There is already a generic mode flags check in spi_setup() that will 
catch this and return an error if the device has the SPI_CS_WORD flag 
set and the controller does not. (I know this works because I ran into 
it during development.)

> 
> Ideally we'd also have some ability to use this as an optimization where
> possible with longer sequences (I can see a regmap cache sync being able
> to take advantage of this for example) but that might be more trouble
> than it's worth.
> 
