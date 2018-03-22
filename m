Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2215319-1521708319-2-2019713286432036053
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
    t=1521708318; b=HnRNI3untJhQEXfMtZY+H34XO+Brvw+F5kE39PwfeLoQr9v
    dRn//3sCAsA2Q4Q1LQ/XfvruWQzpPS6AudKvS3WvBv73B1OmNVL2Qqm85q7kXlX5
    bZf3NI5k1UqAxNckEvFJKHXUwPX51aQyRX0zmXXUGpQu/GWsjmVqpzh3gYNjpA1W
    7Rv1yqsIMsi/rRbrmibac6pTiOsTkBo2aBJ5J3awOiQYhLpBIHJlj3iTD4k5t9hU
    YBxHrLEqVkCFgstfOXXp3qva7jLuqWUQJ3GgMZY4Pvl5zwNp4CRM3TmtPjWJxcK+
    jcTjJIpOref8AwlqSjBYmM2XuhsN7E98m3qlFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521708318; bh=dFAvOhdCgbrAuDhvSAmnIRewxm
    U/MVElSndwEn6ShcA=; b=Ezpy3iLa2/bgIaTwXiD/IFvF+yX9w5SX/rqNqU5NOM
    ZQJkHE2aXOIvmRygEc1vrLebD6pa0MZdSZJNPc67nqX4HzYHwJLfGOELAff9Dtxw
    d9VLHnv5JfTrhYlK9lT0UTW9TzyOLtFMIE75IjOgbR9cZwGfYRSOG6BRyVYqtTmE
    TUibQmrl7eMuiY1UbPr6m4iCg4PMJs1ZWaJJyycJy/+91LsVKyBMDWgnCqCN2Fv4
    73bIgafaeO2Qhlai9UyDptI0bgspPuhahKl9B7rZDnHFdK79URRYUG08nx1unu73
    BrLKGLAepz/SffaKHIsqj6BrYyYJAXyuFfknu83P0/sQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752811AbeCVIpQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 04:45:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41090 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752551AbeCVIpO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Mar 2018 04:45:14 -0400
Date: Thu, 22 Mar 2018 09:45:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "y.k.oh" <y.k.oh@samsung.com>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: samsung: macros with complex values should be
 enclosed in parentheses
Message-ID: <20180322084511.GA6211@kroah.com>
References: <CGME20180314021710epcas1p3766602fe312f87d916cab69af2acf203@epcas1p3.samsung.com>
 <1520993825-8605-1-git-send-email-y.k.oh@samsung.com>
 <20180314135804.GA21350@kroah.com>
 <2f2dcf3c-2432-3dc7-5fd4-f9326ef48455@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f2dcf3c-2432-3dc7-5fd4-f9326ef48455@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 01:37:45PM +0900, y.k.oh wrote:
> 
> 
> On 03/14/2018 10:58 PM, Greg KH wrote:
> > On Wed, Mar 14, 2018 at 11:17:05AM +0900, YOUNGKEUN OH wrote:
> >> Cleanup checkpatch error:
> >> ERROR: Macros with complex values should be enclosed in parentheses
> >>
> >> Signed-off-by: YOUNGKEUN OH <y.k.oh@samsung.com>
> >> ---
> >>  drivers/tty/serial/samsung.c | 16 ++++++++--------
> >>  1 file changed, 8 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> >> index 3f2f8c1..da9bddb1 100644
> >> --- a/drivers/tty/serial/samsung.c
> >> +++ b/drivers/tty/serial/samsung.c
> >> @@ -1455,7 +1455,7 @@ static int __init s3c24xx_serial_console_init(void)
> >>  }
> >>  console_initcall(s3c24xx_serial_console_init);
> >>
> >> -#define S3C24XX_SERIAL_CONSOLE &s3c24xx_serial_console
> >> +#define S3C24XX_SERIAL_CONSOLE (&s3c24xx_serial_console)
> > 
> > That's not a complex macro!
> > 
> > Please use checkpatch as a hint, not the "truth".
> > 
> > thanks,
> > 
> > greg k-h
> > 
> Dear Greg.
> 
> Yes! Of course that's not a pretty complex macro. However, I think it is
> important to make a small effort to modify the minimum standard,
> Checkpatch ERROR, to ensure consistency in the Linux code.
> Starting with this Checkpatch error of samsung.c, I would like to start
> my efforts on contribution from a small point.  Please review it again.

Why would I review something again that is not correct?

If you wish to start out in kernel development, please start in
drivers/staging/*/TODO, not in "core" kernel code.  That is what the
drivers/staging/ code is there for.

good luck!

greg k-h
