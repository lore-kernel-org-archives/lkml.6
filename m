Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4118280-1518778848-2-4300809604634520723
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
    t=1518778848; b=rxSJmXNpw+GIZf/4tvbZOrbO5yzrYyZmEhBB096JhfICF1R
    t1t3Fuen/r02PRAcLLbg1XDREViBcUNgMeTJRPrf2aOwYD8N/vPorwPaSB5mEeCQ
    Iz+88wHtYF359L3m5TJpm/rSvBHMCF4J0nY803SbTnwDuUwT/7jE+VUcbL8Z0Idg
    SpF5fOUtDl62oromvFJz2GB/qlefyeftYAdlGEPtZ0go1yBvPyKNNDiE8B+Hov0u
    brVwJEVkHWnxC6LhQ3/wVJ3eO8nL4YvULlrC29G9Vf/Tbj4wurNQ3bdWawoCyGZO
    dZ9TWZx8CCSz6uad6dnldu7CmMwaTmYDsW5eltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518778848; bh=BlVpFRER/A4pr7DABqLhnSG8VWP5CW7mQDDmTD
    wXFKg=; b=Wmt0L8gx6XpfoNOUV2yoZwLOszyO7o3OKKB+qqqBTIcaKD9ZBjOhi4
    r+9nU9xxfwi0i8V4wOBRZ5+Ve9vT/Cbwq0T99UsCmDydnjx75RLacUgCUEfsd4Zp
    +/mBZl8S4yRqkqlbotzaINvaBKgvTX8KaHMHL3I+T+wZTEEcxWwMIjxn8TslBIvZ
    ajzAG/LJJQ3vO0I3ehnsYo7M8iV/qZFOFMpLfuHsfl20+UkUHu/J5rG0DlnZBe9y
    G/mbOncPcfK6z6leyzCp0nw5fTH7YPjbe1d5AVE6UmD+PJocmO3Itj2xdTiLIW1D
    85kDqb9aSideM9NTEBO5PQd1OHmxDXJw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tWDVtj3o x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RzD834qw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tWDVtj3o x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RzD834qw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934800AbeBPLAh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 06:00:37 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:44464 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeBPLAe (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Feb 2018 06:00:34 -0500
X-Google-Smtp-Source: AH8x225jLUkXrXixuMob/STgEn/amDo5jFAEEoT2AEjWSZ6eYbd5wGmzSJfeEAmiR5IekYIsPggkJCyN3Tb5+SERg9Y=
MIME-Version: 1.0
In-Reply-To: <20180216104751.8371-2-hdegoede@redhat.com>
References: <20180216104751.8371-1-hdegoede@redhat.com> <20180216104751.8371-2-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 13:00:32 +0200
Message-ID: <CAHp75VcyrUvPzojY1J2cUheuYz6mRCP_VppSx740ELanNaQ+Hw@mail.gmail.com>
Subject: Re: [PATCH 01/12] drivers: base: Unified device connection lookup
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
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> Several frameworks - clk, gpio, phy, pmw, etc. - maintain
> lookup tables for describing connections and provide custom
> API for handling them. This introduces a single generic
> lookup table and API for the connections.
>
> The motivation for this commit is centralizing the
> connection lookup, but the goal is to ultimately extract the
> connection descriptions also from firmware by using the
> fwnode_graph_* functions and other mechanisms that are
> available.

> +void *__device_find_connection(struct device *dev, const char *con_id,

> +                              void *data,
> +                              void *(*match)(struct devcon *con, int ep,
> +                                             void *data))

Perhaps swap them, since data is dependent parameter to match.

And put match function on one line disregard 80 character limit?

> +/**
> + * struct devcon - Device Connection Descriptor
> + * @endpoint: The names of the two devices connected together
> + * @id: Unique identifier for the connection
> + */
> +struct devcon {
> +       const char              *endpoint[2];
> +       const char              *id;
> +       struct list_head        list;
> +};
> +

> +void *__device_find_connection(struct device *dev, const char *con_id,
> +                              void *data,
> +                              void *(*match)(struct devcon *con, int ep,
> +                                             void *data));

Ditto.

> +
> +struct device *device_find_connection(struct device *dev, const char *con_id);
> +
> +#define DEVCON(_ep0, _ep1, _id)                { { _ep0, _ep1 }, _id, }

Please use (struct devcon) here to make it possible to do like

struct devcon foo;

foo = DEVCON(...);


-- 
With Best Regards,
Andy Shevchenko
