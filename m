Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-176773-1518788057-2-16241480742725858473
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518788057; b=h0/lUuSNvEk4zMAVGAGhQFTZfg2iBuUfZZyZbpdcQKUmJly
    L5BaLnyyQbkIAdcgiLyuQGXrLX5JRXPf9nfOCKL2e4uYqHPHOdkS3dVE9mrImbg8
    JBmmKTYzPO4JpBy/3FatnQh7Op3r6Mk8WF1/vczCGHixlVFcD8SqiqzVYwzzVmFC
    Mi1+jM0ZbrnL8Exh3d+b7Ut4hYpRp0Y6r66JWfcPzspfHgVjMWpsy66Z+UU0DoRJ
    O/Hb+dOWJ9Y9D2N5H4sfbFfFl2k9gB0NGT6WibFTI5BClQmWUG+p6EjXLI2lpZEb
    JsjebmhnUb0iEVLecu93gn2Voc5I86wLg20TNrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518788057; bh=Wa7h45FtLhlikxmaDX9UGJVBMXFekRh1y6nwXN
    Dzpb8=; b=ZwuIfzsRmjznD5aZdIKh+eWgnj9QluS0Q++oN1v2FNUNWhX8+D3m25
    cfgLtPImwYW1l1rXE3po9mAl8UAxLiiN8f0Z/eJWL/EO6KsZ5BJ0kist07NyOfT9
    iv/SbZE6VP7ECGx+LIh755Sn0151fCTmVigPsybYm5jMEHF4aMGP9ueXJAbM+3jB
    jjVrPtbPqyOit7YQcgMlqLlOx711P5dMU9oJGB5H2tGkNQFTpmLa78gSPs+mVbm1
    b4WsrDt+ZX253RP4zkbDlwZ/HgLlo3ZbmejgUMICR+x3PIXQaraoxGBTi2wfg2de
    aaWTMAb0Nj8YkQWvtvSMbS04BrsxewRA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KtSgsKP4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uc1fwPfV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KtSgsKP4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uc1fwPfV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031346AbeBPNeC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 08:34:02 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36904 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031222AbeBPNeA (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Feb 2018 08:34:00 -0500
X-Google-Smtp-Source: AH8x226S9SpyULs7GthzeGbvdggNR/yZ3ZgPL3+TC80PYcKXZzq/HfgyYupGs9hHl3paDfpJBkTEi9ilwAIhPujVPgU=
MIME-Version: 1.0
In-Reply-To: <20180216104751.8371-11-hdegoede@redhat.com>
References: <20180216104751.8371-1-hdegoede@redhat.com> <20180216104751.8371-11-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 15:33:59 +0200
Message-ID: <CAHp75VdboZ==0iWW8vTxfjJrVnqKiGA_abJkJANWCjUjb7MOZA@mail.gmail.com>
Subject: Re: [PATCH 10/12] usb: typec: driver for Pericom PI3USB30532 Type-C
 cross switch
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 12:47 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Add a driver for the Pericom PI3USB30532 Type-C cross switch /
> mux chip found on some devices with a Type-C port.


> +static int pi3usb30532_set_conf(struct pi3usb30532 *pi, u8 new_conf)
> +{
> +       int ret = 0;
> +
> +       if (pi->conf == new_conf)
> +               return 0;
> +
> +       ret = i2c_smbus_write_byte_data(pi->client, PI3USB30532_CONF, new_conf);

> +       if (ret == 0)
> +               pi->conf = new_conf;
> +       else
> +               dev_err(&pi->client->dev, "Error writing conf: %d\n", ret);

Usual pattern, please.

if (ret) {
 ...
 return ret;
}

return 0;

> +
> +       return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko
