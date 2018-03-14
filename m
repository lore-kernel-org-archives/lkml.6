Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1800801-1521035889-2-7210398310294760192
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521035888; b=rJiyafYTWs961pkVLT2saGetLamig0/aaXRTpePFpA47uoO
    5y6ACvMqzYvhWl8iFYYSYyy13u+o2d6c6HemPYxwR1cMCeeAatrScLwooNfEeffR
    k2sMQ6tYmQSw6EC6pL9IVnHlk3fECZl4HlRsHX+AxH9bzelEKOJ+6yTuJkA5nmdd
    yT/FelTd80/u9OXPCXpIPaGtk/X8XRe/+S3/j+UjACA/YJGY/eW15aXMyqObHd0d
    t7uW+oG2X/TjumNLECi4RwwDG8jyiRZB1alRi0Vt757wsB4TfS36/rREceiMF5dZ
    L0P4mPlK+FXGSP9LeWwCvJ5F0Z3Jt5qp+4edOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521035888; bh=UGlnaDoNCbYBvmoGhe4op25vLl
    frTIIpRbqPJsnVN7U=; b=ZyJzVjNYDAe8Z9jE3h5f98hWnsEj2gUMNKR2t4T5zI
    pBlIYHnAZukKt8lkJ7W+kBjR/AXj9GEG+eoQPBj/7UZrdwhbyMuCDflLi1KJYZ4L
    pvniXjlCwAltjBon5XFlw2Sj+l5TigPdNGBiWnsjYfZmOoRh1XCSkveOZsxH7DsS
    cpX/GG29gjzczp5cJDhJtYqL3TF4AfaRTXqIL76NHpQOSTdPzFvP7BDA5ylcj7Vt
    hjPF+PxRqmjRE5wOwQ6ab1u1LPETjRhKAE008OjGFiTsylJDCvUZGZWKEE+KcjIC
    X7vBAeIjmzYtP7Dl/o71H59DLJ7sWBgqw6FfoR4EtbWw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeCNN6G (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 09:58:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37544 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNN6F (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 09:58:05 -0400
Date: Wed, 14 Mar 2018 14:58:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: YOUNGKEUN OH <y.k.oh@samsung.com>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: samsung: macros with complex values should be
 enclosed in parentheses
Message-ID: <20180314135804.GA21350@kroah.com>
References: <CGME20180314021710epcas1p3766602fe312f87d916cab69af2acf203@epcas1p3.samsung.com>
 <1520993825-8605-1-git-send-email-y.k.oh@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520993825-8605-1-git-send-email-y.k.oh@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 11:17:05AM +0900, YOUNGKEUN OH wrote:
> Cleanup checkpatch error:
> ERROR: Macros with complex values should be enclosed in parentheses
> 
> Signed-off-by: YOUNGKEUN OH <y.k.oh@samsung.com>
> ---
>  drivers/tty/serial/samsung.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index 3f2f8c1..da9bddb1 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -1455,7 +1455,7 @@ static int __init s3c24xx_serial_console_init(void)
>  }
>  console_initcall(s3c24xx_serial_console_init);
> 
> -#define S3C24XX_SERIAL_CONSOLE &s3c24xx_serial_console
> +#define S3C24XX_SERIAL_CONSOLE (&s3c24xx_serial_console)

That's not a complex macro!

Please use checkpatch as a hint, not the "truth".

thanks,

greg k-h
