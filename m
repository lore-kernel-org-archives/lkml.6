Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2332106-1517709083-2-6286515217017587699
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517709082; b=B7fe/fjsC91Ut8KUSkbL5z0W4k1G9zOk4DErSF8zW5R9dVj
    79czUry2DQUyzU7GXfEnu5v+MewUpIfbjrbfgQCLAt2bHfFPcUJU7Nkt1AtboXZK
    N4L1peG9q44QBhfGAc0GcZ66Sobvpz5EEmGeX7UUcAqu62Ye+zZko4jtyE3I9KoK
    P//ZFO/PcZwqNnBP401qtpzLxrspigh3uWVW4H67IsIVbzSN0Ot9pfz+IoomJNl2
    HFj50sZuOMhcOpvhAE+IQEzOBAvEEis6oFNRiDPemh7yP2UJLEV0kCXOTWg219na
    fziKbcnSexeSZtQwwkszNSwQz+IBwhYkqaNMdHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1517709082; bh=pV41KYo
    +GxkIIM9Wx1AuaI7K42tH5rUsa8i9zua8At0=; b=kZ6K/a8eoxtmHlW/ArudwpG
    ulqIVItsxXVDLp+3bIFD7dKxwzBeyEqZXzy81c25bd7yl3JwUNL6fgh/m6ezZUF6
    K9EIRsxZk0dJeLyUMx8Lzi+wlGJHzsp2hy5c38zvMzf22FqyBmfhBbEBjEEQHHgH
    /FPxX9RBIB5T9WELAvv5Ykaso+rsnhRI6qIZ94toZZjuWKz4EJJApNLZfV27CnQe
    qjzqiOlTTlTBt9BRFDFjRpmIY+35KetMRr8izQjH9xuZe3qQOCFdPH58Mf/M0iXQ
    ExR6TeqR/HFoqTiFfeqoy9myQ5TAohMTIiuWV+Xzq4j2jyiKVr/CSwhpQCEiWBg=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fXopzZN7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TwM+YLKH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fXopzZN7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TwM+YLKH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750995AbeBDBvS (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 20:51:18 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:43593 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeBDBvR (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sat, 3 Feb 2018 20:51:17 -0500
X-Google-Smtp-Source: AH8x225WggDyRjnQtcvBoS4DuPcv67AOd1HSxtns81Wc/IkLH3cQ73mlJWgEqT4zSb5Q8cJGF4F+sw==
X-Google-Original-Sender: <johan@kernel.org>
Date: Sun, 4 Feb 2018 12:50:26 +1100
From: Johan Hovold <johan@kernel.org>
To: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH 5/5] USB: serial: f81232: fix bulk_in/out size
Message-ID: <20180204015026.GC28684@localhost>
References: <1516607927-8887-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1516607927-8887-5-git-send-email-hpeter+linux_kernel@gmail.com>
 <20180130041150.GC3434@localhost>
 <840d55b0-9ce2-846d-9bf5-8d0e67b8739e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <840d55b0-9ce2-846d-9bf5-8d0e67b8739e@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 01:50:55PM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Hi Johan,
> 
> Johan Hovold 於 2018/1/30 下午 12:11 寫道:
> > On Mon, Jan 22, 2018 at 03:58:47PM +0800, Ji-Ze Hong (Peter Hong) wrote:
> >> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> >> index a054f69446fd..f3ee537d643c 100644
> >> --- a/drivers/usb/serial/f81232.c
> >> +++ b/drivers/usb/serial/f81232.c
> >> @@ -769,8 +769,7 @@ static struct usb_serial_driver f81232_device = {
> >>   	},
> >>   	.id_table =		id_table,
> >>   	.num_ports =		1,
> >> -	.bulk_in_size =		256,
> >> -	.bulk_out_size =	256,
> >> +	.bulk_out_size =	16,
> > 
> > So it seems you should really be setting bulk_in_size to 64 here (and
> > possibly leave bulk_out_size unset) as that would appear to match your
> > device buffer sizes.
> 
> Yes, we want to set the bulk_in_size as 64. The public datasheet has
> some error with bulk in/out, the correct size is 64.
> 
> We had test the bulk_out_size set the same with internal TX FIFO will
> make the best performance in tests, but it's ok to set 64. In my opinion
> , I'll prefer to set 16.

Having larger URB buffers than the endpoint size is typically more
efficient, but sometimes there are hardware issues that needs to be
worked around.

Johan
