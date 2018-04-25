Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-778319-1524664617-2-9707890194034790569
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524664616; b=ALZ7xPjuoZd1TI6ciU05vYuwW30GK53lHnLZ8+WqoiXFcpGH1U
    fp/rlaqktM8U2il+lLzJZLkJ7bzuvkiy0eUbmNbHOKg3H7ywW1lhZ66K7UKQl8Xo
    he/Kgw2BDG9olPlFCeRaDkxPiQU6TF4esdeKZibxqBG1a58y+MdlPd4ZkiXkQ3KP
    eaGUFucEFiVih6hjHx1W45zKQQUNBKYBU5DM2NEG6gd3NzSNVQoY9dAKVhjpaCTw
    EyZKe7oy978qCjyqAt470QD6epG5soWPl2Xv/mJYh3aSCHTHW0eXY/4JfKDDibMN
    RELGA/N86u6x4WsXWFVnLxn8OVz3X/OfuJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524664616;
    bh=2YcJ1itYH+iQp6ODFKap3gsLpjfvDYS6CRP2UoGLP2E=; b=ECTSXURN42/9
    p8TWa7+r79AyDz3Ezi0hahlZtJPmNIOjvBROOz5cAEYI6XoolkoJfPbwV3foTSxB
    YOgUM/w9t9n0yE0vn9vJ02OweRbQy7T/lidPqB83vr7uHe2LiPlZu3+5DoRSCGru
    9uQjEIXVZ/r1fXKWiynbvgtAo0qbuJxLrayj7LsGtdcPC0sBdEjIUkfLaXDZM4D8
    930y+42TaDuTB2jDqyOFxWVZrdwmm3YDQAQ1lWJerPRPKl2ZdGkyQtqC8TTrloh5
    vA+1DcXozIToszhYaNxHmTaHjR8NMjg7esJPKBIMRyMu6baFQqubeNc6sJLjNjyz
    tB3h8Za/Rw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lwn.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lwn.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lwn.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lwn.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJIwbj8Mvll1Naj1iF6aJh/+7pEKS/jzDlECl9esGjBFmG/qm3mHgdwDXzc4IE+sibxJMScrKrIDBBtYEqnVFG9hn/y2FEPgMCN4KTHQwPNF243/mgaD
    vtJab+5oUuf16vfkc+QZajI3aRpUARNf0+h652b9/GHnKrIRbju2b23McTNvDDrrDQPhFHF0DICs6h5u5BchOKdjvZ0XDZgjhCfoJVzzDrdgLKQzEgi0hXOQ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=i3X5FwGiAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=07d9gI8wAAAA:8 a=qzQhh1wPqL8joUARQg8A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=mmqRlSCDY2ywfjPLJ4af:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=e2CUPOnPG4QKp8I52DXD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753919AbeDYNzo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 09:55:44 -0400
Received: from ms.lwn.net ([45.79.88.28]:33270 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753399AbeDYNzo (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 25 Apr 2018 09:55:44 -0400
Date: Wed, 25 Apr 2018 07:55:41 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Markus Heiser <markus.heiser@darmarit.de>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: typec.rst: Use literal-block element
 with ascii art
Message-ID: <20180425075541.1c846dc2@lwn.net>
In-Reply-To: <87604fcsa2.fsf@intel.com>
References: <20180406124122.70676-1-heikki.krogerus@linux.intel.com>
        <87604fcsa2.fsf@intel.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 25 Apr 2018 16:47:01 +0300
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> On Fri, 06 Apr 2018, Heikki Krogerus <heikki.krogerus@linux.intel.com> wrote:
> > Using reStructuredText literal-block element with ascii-art.
> > That prevents the ascii art from being processed as
> > reStructuredText.
> >
> > Reported-by: Masanari Iida <standby24x7@gmail.com>
> > Fixes: bdecb33af34f ("usb: typec: API for controlling USB Type-C Multiplexers")
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>  
> 
> Jon, this fixes a documentation build failure in v4.17-rc1. It's not
> just a warning, it's a complete fail. Our docs builder at 01.org is
> failing, apparently the same at kernel.org. Please pick it up soon.

Sorry, I'd seen the attached and was assuming Greg would ship it
Linusward.  I'll get it upstream soon.

jon

From: Greg KH <gregkh@linuxfoundation.org>
To: changbin.du@intel.com
Cc: corbet@lwn.net, linux-doc@vger.kernel.org,         linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: fix reST markup error in  driver-api/usb/typec.rst
Date: Sun, 8 Apr 2018 09:19:58 +0200
Sender: linux-kernel-owner@vger.kernel.org

On Sun, Apr 08, 2018 at 10:47:12AM +0800, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
> 
> There is an format error in driver-api/usb/typec.rst that breaks sphinx
> docs building.
> 
> reST markup error:
> /home/changbin/work/linux/Documentation/driver-api/usb/typec.rst:215: (SEVERE/4) Unexpected section title or transition.
> 
> ------------------------
> Documentation/Makefile:68: recipe for target 'htmldocs' failed
> make[1]: *** [htmldocs] Error 1
> Makefile:1527: recipe for target 'htmldocs' failed
> make: *** [htmldocs] Error 2
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> ---
>  Documentation/driver-api/usb/typec.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)  

Thanks, someone else already sent this, sorry.  I'll be sending it
onward after 4.17-rc1 is out.

greg k-h
