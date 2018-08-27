Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FFCC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED7D208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="b4kNc42H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED7D208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mork.no
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeH0UDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:03:14 -0400
Received: from canardo.mork.no ([148.122.252.1]:53065 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbeH0UDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:03:14 -0400
Received: from miraculix.mork.no (miraculix.mork.no [IPv6:2001:4641:0:2:7627:374e:db74:e353])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id w7RGFrB6025580
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 27 Aug 2018 18:15:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1535386553; bh=FeX1yd0BphP3LVpPVtVoDA5spzeQ26wOD27tiDUFm9o=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=b4kNc42HYj8BLIFqr9MsoxPaVnaDgxaVyRi/iIrXyU7z3C7WncjtNyfM7v20ZImCG
         a0dA3Iol6PPe1Sk1Hf4YGNUHSFvYzZ2EJinBft5wPpOC+eYrTttyO/NeTQv3BmYaxf
         CLqcBF269xOmm7ffPN9Eefocp7EfyLFA82Qn0VCg=
Received: from bjorn by miraculix.mork.no with local (Exim 4.89)
        (envelope-from <bjorn@mork.no>)
        id 1fuKBE-0005Ja-Id; Mon, 27 Aug 2018 18:15:52 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Johan Hovold <johan@kernel.org>
Cc:     Romain Izard <romain.izard.pro@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Lars Melin <larsm17@gmail.com>
Subject: Re: [PATCH] option: Do not try to bind to ADB interfaces
Organization: m
References: <20180723140220.7166-1-romain.izard.pro@gmail.com>
        <20180723140801.GA4835@kroah.com>
        <CAGkQfmPbuK7-f=9GcvQPH6mkHXwsaGpjqv40DLgFUJmbOCpbgQ@mail.gmail.com>
        <20180827132815.GD14967@localhost>
Date:   Mon, 27 Aug 2018 18:15:52 +0200
In-Reply-To: <20180827132815.GD14967@localhost> (Johan Hovold's message of
        "Mon, 27 Aug 2018 15:28:15 +0200")
Message-ID: <87r2ijdbuv.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.100.1 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Hovold <johan@kernel.org> writes:

> It would allow for simpler device-id entries, at least when ADB is the
> only blacklisted interface, and may enable ADB for some older entries.
>
> On the other hand, interface class 0xff is indeed supposed to be vendor
> specific as Lars and Greg pointed out, and with status quo we don't
> cause any regressions. If ADB isn't currently available for some device
> due to option binding to that interface, we'll just blacklist it as soon
> we get a report.
>
> So personally I'm not sure it's worth it, but I don't have a strong
> opinion on the matter either.

+1

The adb userspace application is also free to unbind any conflicting
driver, so I don't think blacklisting is strictly necessary.  Except to
prevent any confusion caused by bogus ttyUSBx devices.


Bj=C3=B8rn
