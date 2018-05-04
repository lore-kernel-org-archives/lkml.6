Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-450558-1525456760-2-15266339253270787347
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525456760; b=WSnDlQsBaNJxvOQh2Zm7ZLqShQPWE5U8Q3QczlHx0/ZTsrcFtR
    jE232KT/fZf+dSMBknsdb86wXCMKby0LK80D5SCMZrN/xnrzASbHXRHhLzIGOiKd
    gQfgv4+BU4uymkxI7/lqouBuWqxz9XxOFEKExZEc2pD7prPkc0k6ykKlZGpRLVV2
    GRrom4KOW1Gvkgox3hDHZpMKyHM0GrOS/HYoyfvRak9ZwFPqYcEPHgEXCABzoZet
    EfsiCUI0xCxl7s7yHUSSAauU9EwZ7d4aBKoT+lhs3as9jw9/XT/eh+RGohtsPC76
    8c14wlGZZ00I7MvUUJFjmGhEFTp7dJLfL4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525456760; bh=M79OnA3EU9v84lmYvB1sIt171PnnhV
    hMP8Ifx6Cnp2A=; b=WlDCjjIItIcPQSCyhyz7Xf3hspxQwhkUlFS9OsrYWPzkpN
    L5iYy4RqSWN1zrFhirMe6dOa9HHhQWJy9hP226QD8Zz87DrwGBhyYNb4+kkRHDEv
    NQRhB2DvluHpm7SoW8Cp3NRPRUQyX63y3tK3lNKaOYmtqev03OjseEGNnL2NX/U8
    S6aK5k0abIt0UZLZ3GeteiutfW02Wxl0Ng4egMYKyjoLHnOszmFK9MKGvXDLN//D
    kH45y/HlbivFwDfDc4413JKRct0HjOBUiXfnZ0u7Q0t/7PUB66hCF2aE0Lx/ntgL
    iX1qombxLVfMc3apfLXPRTkeWUHGwclKWISxLjwA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFDgIt7SBUaICggfzoW3TuYJTOY12RZSIPwBc4zZRrsZcSDDK0wNjhOghl2Xh27oLQGjBTot2Rg7T39QwIOR7Cnlvuf/87rdf0OrDL7HrcWvnRjLnL3J
    yycIb7IN0jiyuJWCHqh84iRJoALvGGs8DSxqSFy60iWs85eZIchFGvFnCbOCrZ/u0yiR3hWcE0kk/WCwPNT0aPp/ZW+4TnxSV9asIdGieeQWQqGgWpxUYY3f
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=aeZuFUSzbFher4D2y3AA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeEDR6x (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 13:58:53 -0400
Received: from muru.com ([72.249.23.125]:40468 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751307AbeEDR6w (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 May 2018 13:58:52 -0400
Date: Fri, 4 May 2018 10:58:48 -0700
From: Tony Lindgren <tony@atomide.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Hurley <peter@hurleysoftware.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vignesh R <vigneshr@ti.com>, linux-serial@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>,
        Matthijs van Duin <matthijsvanduin@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2] serial: 8250: omap: Fix idling of clocks for unused
 uarts
Message-ID: <20180504175848.GE98604@atomide.com>
References: <20180504173103.73881-1-tony@atomide.com>
 <20180504173931.GD98604@atomide.com>
 <20180504174826.b7hls2c6v7gukdgl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504174826.b7hls2c6v7gukdgl@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [180504 17:50]:
> On 2018-05-04 10:39:31 [-0700], Tony Lindgren wrote:
> > Uhh sorry I managed to commit also a patch I was testing while
> > updating patch comments.. Will send out v3 shortly, this can be
> > ignored.
> 
> I assumed you were helping out to sneak a patch in.

Heheh, at least it proves I did have it applied before I replied
with my Boot-tested-for-few-times-by :)

Tony
