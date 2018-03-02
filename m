Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2196896-1520014996-2-10586679940402909651
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520014995; b=GUzWnKgUumBbKKeyiUGAxYn6AcE53qY+J88eqoBnpIwAC09
    UBk5wH6eL4YU0uJHT9xKM6k9HxUJU5poSmbIxmaf3Mi+HLZdxMy7nIn4moKIF75u
    A+AQx7ZWyPFDftF2TXACxKBDvCwt4G8Xbh4KJeGSj/ziqM5/B497plcTjtNE+paq
    TKI+DGJZnSM2oGpsHFC4gfyw3YjBbQLNJCYGIVC7ZU9sWd12sLiPcZrZII7qgZsC
    MGOQMiuo/+TGLFWpFw3ZLpq8ibeTwsDusvdisVS0+Zv0oddFvMwdevhTl7/LtCn8
    VT1ny3Qi+SgXQcp6aV0mS8DYThXZifuZuEln0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520014995; bh=4XCJ8RzxbaJu5WmC9Go5HKp8UaifZMQJQ8Ppv2
    pP0xU=; b=g70iFtFPgcEVL5HZtvzJs2KOFSTOtaOXF+uiT5m48M4TcVe3OOuLaD
    2wYOvJLYiYq9cxT7gb/YfoILnItfGwrN1VtTzjkqrsIJcB6oxNBNa7V1FT/SW9HL
    3BBAedWmilpFQr96a/8h1uvV7DzBeNOv2UvWnZyeG4Dbms3PTpuQSgOK3t3844Hn
    uMi8sZMVIH3HyvGGVXwp4ydSO2h3XT+D6JmTMcYPwZcuiatEVNnUNqgmvxD46vLG
    z5+I1oJ+R1meNuKKTGIPlB+yJNlpS6hpS3HDmSc5aTFZekPAQ6P8MUqnjtuahJmM
    z8q1r0RCsmiFrI5NvVAXNqMNC1vxiv2g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=qWPCc93W x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=o+WOezx9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=qWPCc93W x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=o+WOezx9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947198AbeCBSXM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 13:23:12 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36093 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947193AbeCBSXL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 13:23:11 -0500
X-Google-Smtp-Source: AG47ELvcLanwEK5C8mQ9EJta24H/4W82K7YI/1FhWng8mW2EiaOj8p/fDADbgp+yD1viKURf8+edHFZob9AMkuvYKZs=
MIME-Version: 1.0
In-Reply-To: <1516375450-30575-3-git-send-email-geert+renesas@glider.be>
References: <1516375450-30575-1-git-send-email-geert+renesas@glider.be> <1516375450-30575-3-git-send-email-geert+renesas@glider.be>
From: Todd Kjos <tkjos@android.com>
Date: Fri, 2 Mar 2018 10:23:10 -0800
Message-ID: <CAD0t5oMGrJu_9D_8wvLoQPPs-fJ7Qot4W-P_qYE7ikJQGKRSOA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: amba: Fix race condition with driver_override
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Russell King <linux@armlinux.org.uk>,
        Antonios Motakis <a.motakis@virtualopensystems.com>,
        Adrian Salido <salidoa@google.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

+stable

what is the status of this patch? We'd like to get it into the android
common branches to fix possible double free.

On Fri, Jan 19, 2018 at 7:24 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The driver_override implementation is susceptible to a race condition
> when different threads are reading vs storing a different driver
> override.  Add locking to avoid this race condition.
>
> Cfr. commits 6265539776a0810b ("driver core: platform: fix race
> condition with driver_override") and 9561475db680f714 ("PCI: Fix race
> condition with driver_override").
>
> Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/amba/bus.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 6ffd778352e6d953..36c5653ced5742b7 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -69,8 +69,12 @@ static ssize_t driver_override_show(struct device *_dev,
>                                     struct device_attribute *attr, char *buf)
>  {
>         struct amba_device *dev = to_amba_device(_dev);
> +       ssize_t len;
>
> -       return sprintf(buf, "%s\n", dev->driver_override);
> +       device_lock(_dev);
> +       len = sprintf(buf, "%s\n", dev->driver_override);
> +       device_unlock(_dev);
> +       return len;
>  }
>
>  static ssize_t driver_override_store(struct device *_dev,
> @@ -78,7 +82,7 @@ static ssize_t driver_override_store(struct device *_dev,
>                                      const char *buf, size_t count)
>  {
>         struct amba_device *dev = to_amba_device(_dev);
> -       char *driver_override, *old = dev->driver_override, *cp;
> +       char *driver_override, *old, *cp;
>
>         if (count > PATH_MAX)
>                 return -EINVAL;
> @@ -91,12 +95,15 @@ static ssize_t driver_override_store(struct device *_dev,
>         if (cp)
>                 *cp = '\0';
>
> +       device_lock(_dev);
> +       old = dev->driver_override;
>         if (strlen(driver_override)) {
>                 dev->driver_override = driver_override;
>         } else {
>                kfree(driver_override);
>                dev->driver_override = NULL;
>         }
> +       device_unlock(_dev);
>
>         kfree(old);
>
> --
> 2.7.4
>
