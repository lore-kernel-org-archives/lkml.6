Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3734533-1521630180-2-10642229341207681466
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521630180; b=AJ79N2zm3mZd2swrPATkyKX/fyEWdkV3R91OBuZ0CD/Tg/W
    +TAyA6Nxx8978gMzrnDJuaGP9Mc34bgEPraDUvIDMunwvnItMKT3lDsWQhDIE/VK
    4lXTVTdn0g+4y1EN30/DKrEbPK/364LaFobbd54r+h5YIx+o4HbMzn7MzHC0QDUx
    6UoctPxXzpPKaYqnqF05e02FNm2DdxzcX+RIN/mbpucm9ZuCIb/6Du5HqFZWTMeS
    Dfpat2aGRSeHoA3bcdnbwthzUJP9+bxogIDg0D4Lve7c5/BvMfIuOXYrbZ5MUvaa
    rRvEYyAJ1hA0r3xV1f9A+V8a5KIcZrqEr8c14gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521630180; bh=tRS5kgd1cWNnKkwU2BItwJVSiS
    FeGOl7oOxtJsqx1Wk=; b=d3ASgTF8gkHtBksjFJiIy5Fletz5+m+GRhOJQjXv3w
    Cwe3xsCAtNcXVU7hMn+oNB8cFROBKnG04Ihssk0FbRNOfw9U4t68Gf+TAafvlIQz
    6LniKgdIW+xRlWZWAdsHzkJlT17J4x2SvE27vnHyuUL/VDEBIF7DLwNj0iTbHAKc
    jw0znGpGqrc0qQDcgUQb5Wawvh/qcjQwUyGy3ENc9emXkLXl1KCT6H23lMQILLdS
    kpUs5WSRKT8aNKbbKqY0DuSc5RyzKyHmocuAeuBbJbFwTmSjfWR+OZscylh8fw7X
    P9Os9XciSVAk9snFYeM/8vSsiw2BViAjdsk3KfTnzgxw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeCULC5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 07:02:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41006 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeCULC5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 07:02:57 -0400
Date: Wed, 21 Mar 2018 12:02:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Roger Quadros <rogerq@ti.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 3.18 22/68] ARM: DRA7: hwmod_data: Prevent
 wait_target_disable error for usb_otg_ss
Message-ID: <20180321110255.GA24810@kroah.com>
References: <20180319171827.899658615@linuxfoundation.org>
 <20180319171830.959470467@linuxfoundation.org>
 <15d675de-3e93-07cf-4c7d-aa700e38b4bb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15d675de-3e93-07cf-4c7d-aa700e38b4bb@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 12:37:47PM +0200, Roger Quadros wrote:
> Hi Greg,
> 
> On 19/03/18 20:06, Greg Kroah-Hartman wrote:
> > 3.18-stable review patch.  If anyone has any objections, please let me know.
> > 
> 
> Please drop this from 3.18-stable as well. Thanks.

Now dropped, sorry for the mess.

greg k-h
