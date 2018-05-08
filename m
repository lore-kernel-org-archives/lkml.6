Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2552373-1525774155-2-5404931709282883022
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: to='iso-8859-1', plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525774154; b=CBvW4UyLQ1xalv0BRwL3x3AzQ5zPpvZ5OXUiPJcA8mcCs62dlb
    t+WS3J81sxRqOXRGIYDQjyOvc7riIo9b5rlDYoJdSznn3JusbAPjltojjAzVi/5B
    MnQPV22LAzejosnMFj6sOcUU8Gp8Hd5e5JuNOQZQwxD48s2DxP8eu+HrxwQ2Jl8K
    Qg9TIa5zpMR0wAHG2URER5w/wvMnmXS8F0DXnaN7G4rF7W0YagQ4nK1VngVLOygl
    PKSU4ZEg7NxxIgQm3q96mkYwSyRz0ZEzjIqoERsp/bTsNCQTNCyrQjJeIbe6pnsS
    bkFAJlsxlx91ARGIfyAKmJLXEIT66zUsYFNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525774154; bh=wN0c6tZ75HD
    S49+QkOxRmoZduw2pBPmoV3y5gw5Nr+c=; b=JEF1+E4ID5Nt47Oi19Szfbd0KNR
    H6cDpszeSAFXdcuPLjuEreIyKRvOTyLNjkBJ6wvJANgqGTySWyfvT1uRpH1wxrvq
    Jg9OYRMedi3dhEmrDGVHxUTWstq1H0jBT2Lgcau0T8m++eMKr4fbpb1QCL908GLS
    yuw2YYEWIaLRH7gF33mB6ypY//+PL0JmREIWjfV1J1xGA7PA1uhAHJdtfnPL1jGN
    PIX1XRKajEEc6Xm0NsdZoewyMsfgbT3VrvWOSfO1a+t7zZNfObyBTuONZZRTzjIK
    aqInz574UWGzVDrUlYjw8Bgskk8B0y5eW/crzdkLxbjwIoe2x1hJqyLpNZQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=cn8NHdcF x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=BqZMdy1B;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=cn8NHdcF x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=BqZMdy1B;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNoLRvb8IojPRV7bQp0gIIqI+ZPEyXHh5Fl6FAtynDPxIYy05c7JtUtC9nTCTQjTCLG3F8BL3EJzbJ1SpRjVYK3OGxnnAM0HoaAlWWrSfdQ3DyTB3fZ5
    Y/YVEhDDQzDfVXteMwuvsxsDY/7IeVS6qZ5xWh6cqRXvPBzc7UBZ5iSF4c7TcPp7w2JkYhJtmlOR8DFAe/z3AkjowZkB8iT3Kvwe0m7NZxL/zmiCjFCMh+Nn
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=epukvrtiIu9ddjx4lnYA:9 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754426AbeEHKI6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 06:08:58 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45431 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754223AbeEHKI4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 May 2018 06:08:56 -0400
X-Google-Smtp-Source: AB8JxZrzTBgM54/E3Z+aJLCwOIJshoVOpxt3bEl+rOMBLx4tMDMUvArhlXf4SIGXRF9ysLwl53C7Jg==
Date: Tue, 8 May 2018 12:08:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/3] tty: implement led triggers
Message-ID: <20180508100851.GY2285@localhost>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-4-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180508100543.12559-4-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 12:05:43PM +0200, Uwe Kleine-König wrote:
> The rx trigger fires when data is pushed to the ldisc by the driver. This
> is a bit later than the actual receiving of data but has the nice benefit
> that it doesn't need adaption for each driver and isn't in the hot path.
> 
> Similarly the tx trigger fires when data was copied from userspace and is
> given to the ldisc.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx25-logitech-baby.dts | 192 ++++++++++++++++++++++

Looks like you included more than intended in this patch.

>  drivers/tty/Kconfig                       |   7 +
>  drivers/tty/tty_buffer.c                  |   2 +
>  drivers/tty/tty_io.c                      |   3 +
>  drivers/tty/tty_port.c                    |  32 +++-
>  include/linux/tty.h                       |  22 +++
>  6 files changed, 256 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx25-logitech-baby.dts

Johan
