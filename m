Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3802465-1520709506-2-15022683712234910755
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='ch',
  MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520709505; b=J1eJ9t3rtmEkqOs2/REsMAMNOD6xvqBSewvU92nll9rAj27
    uSflonuoApeJyYL7H8FLYMen5wmntyfxvDo2SJVASS1k2E1GSrPpZT+Q/bFJ7IwM
    zEdbm8OutOGPP7E7QrJb68WUu+2Yzrhg9hpaC6Hm7888qGWf+2vpsU4tJ0gFRFEo
    TfhTrTVIIA/yUj29JdIVlRA+4QBuF7qdreL1h7NvgRMF0hjqx7UyA5vVr18lFOI/
    twZjnReVm1SjRTn/yvwkUFSPtbeSELfXMVp44a2UsaKYGR40hEti6vC5uQI9yQsw
    thB04+RCG+tdhtLw9Ni9Y2YxAs/xSXLhgHf7jDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520709505; bh=FTqXHCgMw3hfOD4dXCebvMv1oH
    agNHnoBX87pzOVpN8=; b=ix85ci/LK/yWwV95FZ0Wl/uWuRyOdec/1qQuij5NBU
    vnk9ZdTHrRfoNA+09FmDkxDoOuhcCdcejyi/+ELrgUTF7lZNCi5E+qWc14oLrSoh
    li1WDYjr0AbuJWOI+Ib+mEpFUt1B2zB/wieP1dKZEtMZnzIiMOdxyZXX8PczAiF0
    b1dxl02bmxTppthnTih7wLUcJGjam8B5Huu9hlAPdo/7w05oyz9bp07m2gbZP8xc
    fOdO+IlNqCMC/ln5X1mI8BXZbtRIqL3aTCSMjfHmFdi3/WmtY2ywOjmpKgaUFi4P
    Zf0jdC9PWfM26xiDT/1+yvhp3ZKgNsx7861p5bUXaZow==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=fwnFr3Sd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=fwnFr3Sd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbeCJTSH (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 14:18:07 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:54092 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbeCJTSG (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sat, 10 Mar 2018 14:18:06 -0500
Date: Sat, 10 Mar 2018 20:17:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        "Andrew F. Davis" <afd@ti.com>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>,
        Philippe Reynes <tremyfr@gmail.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/2] net/usb/ax88179_178a: Adjustments for
 ax88179_chk_eee()
Message-ID: <20180310191744.GN27783@lunn.ch>
References: <b92bebdb-c1dc-a9d3-2e3a-845d8dc4998f@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b92bebdb-c1dc-a9d3-2e3a-845d8dc4998f@users.sourceforge.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 07:22:55PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 10 Mar 2018 19:05:45 +0100
> 
> Two update suggestions were taken into account
> from static source code analysis.

Hi Markus

How about re-writing this driver to use phylib. The whole of
ax88179_chk_eee() would then go away, since it is a duplication of
phy_init_eee().

	Andrew
