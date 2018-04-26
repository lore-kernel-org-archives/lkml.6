Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2141624-1524726580-2-1650465084750646966
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: to='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524726580; b=rXNRYAHeIqf8yno+zva40YtcXI7ejAOgVICm1fP8kQRGnTUXgv
    e4Xeedq0goTKO36FAVurxwiyvNdTUmml3jlK42ltFAtsFeXLOiJ1pG7xZMny3mLw
    +6ppyOieMO+NWqJL9EYzkU2zEvg3XHmM8Mr3Pdclqb6uFzz0zanbRjg0P5gNCPxt
    6DdtYIC0gcECqahZkJTQ6Z2Vyvevd1eL1ayrL2SmoNvfA7t/2yogOis0pA4Wz7S4
    TQvjFJP+p4yP+D+0hF9qr/ggpGSIn9hCPkly+xCKZgFwyf5Z7L0ohnCiCJTTuTRQ
    XePGAAo/VwgubngRqI/0tcScBw1xXKFAR12w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524726580; bh=zKUDve03tJD
    uZ+KiArsY8H3yvOMBuYb/YrLrDoUnxoE=; b=Vh+Bn9i39iKzSrb/L2UN/X+o918
    +wm+gPCHdOZXEZ8l8rzKmL2NNtNcArzSl4jkEcW3s5ku9f285YQ0jGxoWod8ekIT
    rQtfq0hqMXrYJaQJjTDCMUQi6t7Y7IRtQoRkovPeMBdx/1bnDsj8SAHjU6aAD4ph
    EiRuH79w/dAdH1I7Z+KgqwQCdppq6Re2Gy++cK6uiovag/yZBmViEHCkSiMNkY+S
    jLy6ub7yDsiWjvh6/G3/0/jUNNLZkGtkojiER4lRmpVh2TUS70E8C/urshSx3v2x
    WTvn8mgBtOL45Iv04CfhVlfsomotAWgtN5K8pee7GBD5TuFIAKmQDkifCXg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OeTSm+vo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Q6qWfzxR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OeTSm+vo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Q6qWfzxR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEzfIoesrjZYUZuDXqgu2BdUGLGcm4h5D9ve2hkRE1+H4jJ3Dqxcjns4Y06lEjH/ijrMdMIL8/jZhNGafBVhwG0sTfOOP9qKMpG1Voi5Z8V13LKV/x+Z
    f2Y/Pz/bZ4B5fqqIDS0/WUIKZbpcqB2QG0vrUyqQ8YWALnz9Cjr0AsvtB465be97yQNrjdGkhFckgFB/WZOllPrsAEcdsmpbdFsa7udYY5Zf5xHVHC3pito4
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=dZ7Af3Q_AAAA:8 a=VwQbUJbxAAAA:8 a=c0ExXQgsuaHJUOM1Z6oA:9 a=QEXdDO2ut3YA:10
    a=xnyMoErWsJe9py2mg6Iw:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752972AbeDZHJi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 03:09:38 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36977 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeDZHJh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 03:09:37 -0400
X-Google-Smtp-Source: AB8JxZqol96cwxZ4SWI93lVzAQRqn+TdV/rFlZDZl3t+RlAG9+D0tE4Kqsb0t/zf0HW8u98jvPJp8w==
Date: Thu, 26 Apr 2018 09:09:27 +0200
From: Johan Hovold <johan@kernel.org>
To: SZ Lin =?utf-8?B?KOael+S4iuaZuik=?= <sz.lin@moxa.com>
Cc: stable <stable@vger.kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: adding support for ublox R410M
Message-ID: <20180426070927.GT4615@localhost>
References: <20180426062831.320-1-sz.lin@moxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180426062831.320-1-sz.lin@moxa.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 02:28:31PM +0800, SZ Lin (林上智) wrote:
> This patch adds support for ublox R410M PID 0x90b2 USB modem to option
> driver, this module supports LTE Cat M1 / NB1.
> 
> Interface layout:
> 0: QCDM/DIAG
> 1: ADB
> 2: AT
> 3: RMNET
> 
> Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
> Cc: stable <stable@vger.kernel.org>

Applied, thanks.

Johan
