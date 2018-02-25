Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3386012-1519549325-2-2127686000154160219
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519549325; b=TpBLtPuyczxBZz6v/ml7ZC+WWu9+N0GQDMEzwhRqS/IY8bq
    FAlUw7RLwtLAQc0rSyCXjdDXEIW3Fiji4UA7P+2OXeyZ2EHhXqvliV9iEi4/fnKh
    Js0NI3oAFCjo9w7ao1J0ALOv2jLZ1Psc3AJcin//eob1JqyLLYZsJSNGh2kOYkZC
    aA1HdC9QWo5UAkq2n+03qzxgyaH8q4vjxBfcI6B+yKKsHj4fQKUD4EadTt+axlqo
    OKHuwmel/vTiyKs0GY4FPkso/hAQBdpBXiouZulaJN+O0VdSE355umPMnohJuFsY
    bPFN2Ix6Fejwm2lSYG3a3ZTJw/oJ5XoeveSmfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519549325; bh=iHfHZI30eanuN2Z9X3LcCJ86qDQ8Rm3eyetO6IpgN1g=; b=c
    5t1ITGNRdXP3jOzPKN9wIQCM+Bwzuc0IMl8ywdqXqxX065Hy35PWgSz+jxRUkeEX
    yZx5f/em0cuzt9gmfUirdwjG90Uj0PYN6it1oocfvVaAsXADHO/vB2UPLyOal2kb
    bBE+Z42G7xf08mYy0AM19zEY31HD5IsCI6LD4/lbMA07wSshCQ4KjzQAOp3whcQQ
    ClpoQWkucIhfjC4u+x5QR34qVqpj7ACyH80seUUhbp3g4PYtGu4XBzPQIBD9cw5r
    kbojGEQ4aaNetGq8PLiSmJq1/uXvXJqkxk9NxBhF4bGXTXyHDv5Aji7yk87ggpuw
    0AbW/hIfnr3M3mKV8V0uQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=lQasykER x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cogentembedded.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EXRRNWR0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cogentembedded.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=lQasykER x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cogentembedded.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EXRRNWR0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cogentembedded.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeBYJBt (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 04:01:49 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:44226 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbeBYJBs (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 25 Feb 2018 04:01:48 -0500
X-Google-Smtp-Source: AG47ELuNS3t3vXWR5AbJCuVyb0Xw/4YX2le4IN/4h3tWY35iJsoRM39Kj+bWeXooaZSd4spcdCmaEA==
Subject: Re: [RFC PATCH] usb: musb: call pm_runtime_{get,put}_sync before
 reading vbus registers
To: Merlijn Wajer <merlijn@wizzup.org>, linux-omap@vger.kernel.org
Cc: tony@atomide.com, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180224205151.12079-1-merlijn@wizzup.org>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <aba8fd1c-5bb4-ca12-ee73-b0ee50392889@cogentembedded.com>
Date: Sun, 25 Feb 2018 12:01:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180224205151.12079-1-merlijn@wizzup.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!

On 2/24/2018 11:51 PM, Merlijn Wajer wrote:

> Without pm_runtime_{get,put}_sync calls in place, reading
> vbus status via /sys causes the following error:
> 
> Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab060
> pgd = b333e822
> [fa0ab060] *pgd=48011452(bad)
> 
> [<c05261b0>] (musb_default_readb) from [<c0525bd0>] (musb_vbus_show+0x58/0xe4)
> [<c0525bd0>] (musb_vbus_show) from [<c04c0148>] (dev_attr_show+0x20/0x44)
> [<c04c0148>] (dev_attr_show) from [<c0259f74>] (sysfs_kf_seq_show+0x80/0xdc)
> [<c0259f74>] (sysfs_kf_seq_show) from [<c0210bac>] (seq_read+0x250/0x448)
> [<c0210bac>] (seq_read) from [<c01edb40>] (__vfs_read+0x1c/0x118)
> [<c01edb40>] (__vfs_read) from [<c01edccc>] (vfs_read+0x90/0x144)
> [<c01edccc>] (vfs_read) from [<c01ee1d0>] (SyS_read+0x3c/0x74)
> [<c01ee1d0>] (SyS_read) from [<c0106fe0>] (ret_fast_syscall+0x0/0x54)
> 
> Solution was suggested by Tony Lindgren <tony@atomide.com>.
> 
> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
> ---
>   drivers/usb/musb/musb_core.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index ea5013aa69e2..182611f76af3 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
[...]
> @@ -1767,6 +1769,9 @@ musb_vbus_show(struct device *dev, struct device_attribute *attr, char *buf)
>   			vbus = 1;
>   		else
>   			vbus = 0;
> +
> +		pm_runtime_put_sync(dev);
> +

    Empty line not needed here.

>   	}
>   	spin_unlock_irqrestore(&musb->lock, flags);
>   

MBR, Sergei
