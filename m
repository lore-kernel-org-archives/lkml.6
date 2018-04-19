Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-114809-1524181806-2-11950220666475896914
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: to='iso-8859-1', cc='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524181806; b=OA+jPWDXq4AXPyTY5m3BfUjtItrIIWbWtlCcIw7+6zUWGs0Dxk
    kvoHTUb0xLMfX2h17yEfgtzgNlmHeoEotLZ1p5xfOZe9bhXtZS4HLGQ/kmQJEL35
    V3JHzzVebaa9+Syu0UItSzY7xqWPpzzvUvljSuGmHS3/v3e9sR/dV4koVME2roY6
    S7sg68cFmv69vh8sdFb5pmoNiMAOxhZqPIbepv0bYmNVCxKSq9SrRrBVoSWZunhw
    BD0MBD9lMDOP0GdMlwE58q+AfUm8eJwljtiArR/18KicLWB0L2mr7a71weGRCNzb
    aTjuYxOJzCn4T4faBqltP3WKjhtZj3LlU4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524181806; bh=u9iDawfcZin
    JfATyBifLrs+ji4NveS6cmGHfvA7rCq4=; b=XkvXa7WZ7MjI/gzHa+0hQcMisAf
    jNb4uPGOcozQiRcxYh7TG4HGfMYfDXNe+GXoezbw70pyu4QFyrxbSEADPQy/95Gv
    isTo2vNgSnkW3yh7ixST1/uqWmNgY8XwjjmEb/ZHV8MaKlS9nkcvnxURQv4KPYyx
    mARUVFgyvVCroW0TwN3NAl+4Ngay+n+P8Hc4oVaHQ7QKKbSX2dbnHn825oj8tTTV
    pGrFQ1J2LeR/RD0M66rVoxwau1josgViW3CyChW8Erjf/QWgyncc2YRekEs0Srts
    eCXm5w+oMKi5T3QQT4eQlvwLYOwnNMAARWES6vLzUBePJrelZaRdmKx40tQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=YvUd9CM4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=YvUd9CM4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAqJYFPGx0JfYc/JK0J8PprzFmjZxA1N6ey3+dUKoe1b1JYfj7zcYXkRBLkbmdDDXQUCYdhq8KPRyp+/YbktuE13joqZlQQRa+8E8xl7QD6e3l92/50u
    ZnXmK2AaIc+Ly5j8CtOrwWYirxUcXyExe9f8iXGzkPryzlrMdPQv8xPbSnIzX84jMcuBDVAXlIk2d1GG3rqdbg6lvtNKwhCzeFB9i63WEYCgOw4JGRirfnGW
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=Kd1tUaAdevIA:10
    a=x6Se6UaoOFju1KD1qykA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753845AbeDSXtz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 19:49:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35276 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753718AbeDSXty (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 19:49:54 -0400
Date: Thu, 19 Apr 2018 16:49:51 -0700
From: Darren Hart <dvhart@infradead.org>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Cc: Corentin Chary <corentin.chary@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Dun Hum <bitter.taste@gmx.com>,
        =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita
        <jprvita@endlessm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: asus-wireless: Fix NULL pointer
 dereference
Message-ID: <20180419234951.GB11546@fury>
References: <CA+A7VXUb-u9=MDRrZxpwGiuFwQAdYCJoxaZHjLPLAcYc6PTEHQ@mail.gmail.com>
 <20180419140434.15131-1-jprvita@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419140434.15131-1-jprvita@endlessm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 07:04:34AM -0700, João Paulo Rechi Vita wrote:
> When the module is removed the led workqueue is destroyed in the remove
> callback, before the led device is unregistered from the led subsystem.

Queued up, thanks.
-- 
Darren Hart
VMware Open Source Technology Center
