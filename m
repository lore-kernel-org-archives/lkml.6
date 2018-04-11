Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1563688-1523429874-2-8336545276066739029
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523429873; b=bQt/9HnwylT281YjxeBUJ21/pi1MU+tCKAEzP3NTxNcpMaDJac
    BDIo8SISnBjUtEWf47nTlOtk5kkb7cqNtHmv4zNULvdyyQo5uqDyBvXwRzlBfx/R
    WT/msDnMU8W4o6YU0J9y6kH0Qd+9GeXPIelY1vg7yIG7RZXa3ADgRnjfJeQt6I58
    KOrHy2Pvl0TZlTlSBm8GAArcc+sY53kaSVw5Cc8QrKhSz9A6h7KEscYxod4QqdWp
    LRrGDNDFiryZnlpzidztwLQXZttast2yTTiPnL6bS6FeZ9oHcKEamz1g5Beo+DnV
    8bbDUj7QPNLg3qyWx0/G3GfgjxHWmqEC8zfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523429873; bh=tveSgTimU8HnoGKsVVQruMb3Sq4/6J
    AZDB18kvnVAWg=; b=rbg7jJBwXvXIalDhcYu2ziKCuMmvxPDzuuESok10DAaoCW
    8VbEcAlwGAkVDb6eD3D9w8TCm0qnn49PzpCEyAT87JSOqqU5SpjjPw0fpSzTtr1C
    dQ5VomZwzWAYnAu2ch7ctpiX1cOjRzTh5dI2K6CNQRW42phj+/3mH0OUiYpTN18V
    6nlVy+B7s+Y8p2UYXIYDW1X+SxL3RmzwDCOs06gvPYBEqHV1maS2OqcqZ0Vl5V2z
    0rM5srGG3QCl3VeSfFY/+hwAgkwNcb4OZ/OvbXpL1yVKKmYZLOfUsUSuWgkPqTlu
    cSGghX/SBZlLz9v2Li4l5URFv6XT2X/w5Fxzcnnw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=p/HJcu0h x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uCy/gUVQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=p/HJcu0h x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uCy/gUVQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBOnny9YSKJer1c5ejt02e6cCkgI4j+71Q1ad6d8J9++vgLaGqfG/n+OFey1ciExxBPBGnWXq42w7iqHmWT3sTM7bLEeT6PNeEhCVQvtUr6tlFTemRkB
    ys4rSsirx2dSPt95G3CBnHAo3rI5kroHjZVB7/kwoz4whNpFU6pHtmVROFDEVzjPmXTZtlt0zM0ZP1jCZtir7sVhDndS/oKgb6k8XlQLkLS3LNpgmoVWViaP
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=sERwSIleJAFW-xwVAWYA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeDKG4v (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 02:56:51 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44155 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeDKG4u (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 11 Apr 2018 02:56:50 -0400
X-Google-Smtp-Source: AIpwx4+8GOiTINuvzk294na9+AiWgy8LWGAhiMhfcYfTEc3qBRNxg6o/tZq2YEhOtpbWIXaXGRZyTg==
Date: Wed, 11 Apr 2018 08:56:43 +0200
From: Johan Hovold <johan@kernel.org>
To: Edward Chang <edward.chang.mcs@gmail.com>
Cc: johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: serial: option: add HP LT4220 support
Message-ID: <20180411065643.GD10795@localhost>
References: <1523428612-2911-1-git-send-email-edward.chang.mcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523428612-2911-1-git-send-email-edward.chang.mcs@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 02:36:52PM +0800, Edward Chang wrote:
> This patch adds support for HP LT4220
> 
> Signed-off-by: Edward Chang <edward.chang.mcs@gmail.com>
> ---

Thanks for the update. Please always include a changelog here when
revising patches so we know what has changed since the previous
version(s). Also include the patch version in the subject line (e.g.
"[PATCH v2] USB: ...").

>  drivers/usb/serial/option.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index c3f2522..d866cc0 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -1927,6 +1927,8 @@ static int  option_probe(struct usb_serial *serial,
>  	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_6802, 0xff, 0xff, 0xff) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_WMD300, 0xff, 0xff, 0xff) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0x421d, 0xff, 0xff, 0xff) }, /* HP lt2523 (Novatel E371) */
> +	{ USB_DEVICE_INTERFACE_CLASS(0x03f0, 0x0857, 0xff), /* HP lt4220 */
> +	  .driver_info = (kernel_ulong_t)&telit_le920a4_blacklist_1 },

So you dropped the id defines, but this still would not compile due to
the updated blacklist mechanism I mentioned. Take a look at the commit I
referred to for examples of how to specify the blacklist masks.

Thanks,
Johan
