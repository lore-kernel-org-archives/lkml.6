Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3186700-1522944680-2-10224291260351490497
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522944679; b=JCkifUpexw3O2StkCbymOCXF5ZwMG6iYk/s8+fUuKAZevfhjx9
    0ygL+Bry/MbYgGYKqGHreeQh6pWbJAUzdsjMttJDjIlbhC7E1mp/pTdprF1UvgLd
    d1que4YdINd8UjKW/Y1JPcTRQZU2qWiUDVTsXQFPCY6jiB6IajdIxHbjmwHV0D55
    XdBjjpq2Wo7EM9jzBvBQ6yiFkIuClQE1jeybAaoNviOQGUrFXd4T1zZ4zjoVWhLa
    bFTxJ77HX1T2CaCP+YgmlYTGWxzVBt4H6rBXTGOpkWQZT271ko2h7J3J/KS/nGW5
    LL9rQP5oZbLNbuVu5KF0VDRIMJPjRtWeEEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522944679; bh=RMMjExioYaiCOhsFcvKNS7r3hVCrCI
    scgbYTNSYRaYc=; b=MeM2/NQclyPBjuDZKhpT8fBVSd5FZ5l8LdTUee/hVoVjmt
    8g7OqTfawVYa8rhgmEX4yy2/bvTeR0B5oGsp8XR6RS9vQMGM217b4iS9luS0Q/tz
    hugTOvPfoeKBR1vHKno1VG0uUuy8JR4zapib97V62TDLMiCDRi/mTcqettBPYfAj
    v2vYGdBOXbKfKp+9pqR0Ae7mIM8IeS1yZYHa0fdjeiHIzgDz6Jocao9fSbQ6/B7W
    +1XWEO1e8MgMXV51uEHvoalLdW7jv21WWFm5w9qxVklx/4K2IgnQnUvxcW8J4Aqe
    f75A2OeVaYXvjUqEc0+oq9Us1tIxN+Ww0NjBlNow==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEs5ONUgOw7Q5XjWlCYOHLfqhOpa4/s2ERA1vWgAFvfmNV3KGvRtqT53+yf3vHn2HZJMu6xQx3tC0tf46UtJExVa/oG1Njqwf/r2UGSWXa36UDI0RPls
    rPRYw3vOFLu0Jkrxxj/XgdpkoWCADjiD0Q4c0EQqdcB5rJh6uXRisv72edpCBVSir3LD5mzI2OLc4B2RpWE+tSpewpDY1xjVBEnJOdzDfyKrHiFp/Wbw9hRU
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=IlGpMoz5pPBLaa5lwikA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbeDEQLQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 12:11:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34390 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeDEQLQ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 5 Apr 2018 12:11:16 -0400
Date: Thu, 5 Apr 2018 18:11:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Marius Cirsta <mforce2@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gabriel C <nix.or.die@gmail.com>
Subject: Re: Logitech webcam USB audio breakage during the 4.10 merge window
Message-ID: <20180405161114.GA9976@kroah.com>
References: <CANO0Vk63RYFRU1Yr+vhktQ+xsnqH+a=4sV_jR-sHfFJMH9jLLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANO0Vk63RYFRU1Yr+vhktQ+xsnqH+a=4sV_jR-sHfFJMH9jLLw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 05, 2018 at 07:05:29PM +0300, Marius Cirsta wrote:
> Adding the linux-usb mailing , maybe someone from there will be able
> to help with this.

Can you run 'git bisect' to find the offending patch?

thanks,

greg k-h
