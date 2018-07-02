Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EE1C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECBD22549
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="ndP0gynz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECBD22549
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mork.no
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeGBSEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:04:46 -0400
Received: from canardo.mork.no ([148.122.252.1]:46961 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752150AbeGBSEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:04:45 -0400
Received: from miraculix.mork.no (miraculix.mork.no [IPv6:2001:4641:0:2:7627:374e:db74:e353])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id w62I4Xji018808
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 Jul 2018 20:04:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1530554674; bh=TZOq2KeODHTdX5+sSdn4jbcfAXhgPM6Dxfgg1QECIQ0=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=ndP0gynzLWRTzc2eDoavdPyyAyuJGSkiVsnkGs1mW8aLpXSbXJZuLDD13U+PjDTUk
         T0NW05QIIs1TU7tHTJFoN4oCUOtgUI0coG0txg/5VVmRD+8rnmEU01GBD8Bm9ffsxU
         A5y0wYr7Zh8AEHIjlnn4UW7H0La4a3BoEHwvpS6c=
Received: from bjorn by miraculix.mork.no with local (Exim 4.89)
        (envelope-from <bjorn@mork.no>)
        id 1fa3Bg-0007X6-VF; Mon, 02 Jul 2018 20:04:32 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Johan Hovold <johan@kernel.org>
Cc:     Karoly Pados <pados@pados.hu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martyn Welch <martyn.welch@collabora.co.uk>
Subject: Re: [PATCH] USB: serial: cp210x: Implement GPIO support for CP2102N
Organization: m
References: <20180620082507.GO32411@localhost>
        <20180617182503.23080-1-pados@pados.hu>
        <b2526c441d5d99b5f491b78cf9e84475@pados.hu>
        <20180620105231.GQ32411@localhost>
Date:   Mon, 02 Jul 2018 20:04:32 +0200
In-Reply-To: <20180620105231.GQ32411@localhost> (Johan Hovold's message of
        "Wed, 20 Jun 2018 12:52:31 +0200")
Message-ID: <87d0w5wm33.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.99.3 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Hovold <johan@kernel.org> writes:

>> Not quite. It is not from a forum post, but from a SiLabs Knowledge
>> Base article
>> (https://www.silabs.com/community/interface/knowledge-base.entry.html/20=
17/06/12/fletcher_checksumfo-TeDF)
>
> Yeah, that's the one I was referring to.
>
>> That article states explicitly that the code was taken from Wikipedia,
>> so it is CC-SA, which is to the best of my knowledge 1) compatible
>> with GPL, and 2) does not require attribution if the original material
>> is missing it, and it does. So AFAICT we are clear on the licensing
>> front.
>
> First of all I can't seem to find that code snippet on the wiki page it
> does refer to, so I'm still not convinced.

It was there in older versions of the article.  See for example:
https://en.wikipedia.org/w/index.php?title=3DFletcher%27s_checksum&oldid=3D=
730327006

> Second, this should have been high-lighted in your submission somehow.

Definitely. All code has an original author who deserves credit.  And if
you cannot find the original author, then there is always a risk than
someone along the line stole the code...  Maybe long before it ended up
in Wikipedia.  But that doesn't matter.

Doesn't seem worth the risk for a simple checksum algorithm which
probably has lots of GPL implementations.


Bj=C3=B8rn
