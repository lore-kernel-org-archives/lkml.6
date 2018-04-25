Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-650525-1524660711-2-3447870010237491582
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524660711; b=HVKH8SWDHlvTQGjexlOa9DiCBITROqHtJ9k1aQLs4TCz0kXh37
    /JGcDSW3T4sVlA0g8APmnkClmh7RnCDhoJ6AnHwYbP8KyFWStnWqF5KtOoc40YKf
    +SJfNnFsy1H1cC/aPptBGXxlRfh6KsUnAfH/zH+gaUXmyGOFIFrdid9Io+Gkntnu
    3h1MXvpK/I3kJ3rwf241DUdgFBqM6gMadd742rNUSHr2Cvt4r3RwYC6K9wX3H/WK
    RymADT0C416U4bpW5OLumXExDXYnukq4/Wzpe9DuwDslqoi5Ui0WvGTe96Q4wcxU
    /is864jVZ2jRhwRIfEKVHUDoUsmhWwjcyJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524660711; bh=n0sQqowXZq41lq5C9NNIJWMfGkNlyE
    +TPwDCnhM7X2U=; b=UTT3KPmxepRrr3OSpuPZVLFWTVYn4ZRU+dhmiwUz8ZL8nK
    1vnXgkcpKtM9b6+CiO5GR68M4ncy7ML0GcXbcbbfflZVwUmMaPTPX+YYBc9Efq0k
    smNoPn9re41J1uHunoF9V9YSuv57p1DNs4l05n1iz/GMEEk2bd3OihTXCh0pSx5z
    FJxaTGVtGhXE1Nlwo8mx2wTz5EkP+rVmWAtyxpdHQFS6d/QzIMsLPpbECZ8DCbR/
    mPxFUG/UB7fW6u6VkHk6S9KykHdp6F7f90lHF7se/B2fQx49X7Vm1v0PBBvrL9lh
    IiJPvRj5IqPk5xZB/ux2nNaw89xw2bpI7gc2aZkw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIoL/UKldQEFTGZSmILeVeW6snUrbzEnlj6FMsHcotzUz86wRuMXyIsuVF5cBF/USVNY8KDDakDiKXKTPAMtcy5p0g7uYTauc0Mu6eNatRzwlDNoL2lr
    kqa0uuDRtU5hLVY82hfhxeihTxU/PcKIpdz8fiFbXI1NifGA4+7KZmCH/HVI86yJs6AI99OQYbL5msVrqFa1JN/vi3uDdViV5g6lS+LJaeybDXnpfukGddOh
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=WKGNTzToUg2xAN-aeHMA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753435AbeDYMvs (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 08:51:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34848 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbeDYMvq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Apr 2018 08:51:46 -0400
Date: Wed, 25 Apr 2018 14:51:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        stable <stable@vger.kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Jiri Slaby <jslaby@suse.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-serial@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] serial: 8250_early: Setup divider when uartclk is passed
Message-ID: <20180425125137.GA30021@kroah.com>
References: <93a7871c8654a6273b1ab35a8071e9f830e2a0c8.1524475087.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93a7871c8654a6273b1ab35a8071e9f830e2a0c8.1524475087.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 11:18:11AM +0200, Michal Simek wrote:
> device->baud is always non zero value because it is checked already in
> early_serial8250_setup() before init_port is called.
> 
> Fixes: 0ff3ab701963 ("serial: 8250_early: Only set divisor if valid clk & baud")
> Cc: stable <stable@vger.kernel.org>

This isn't "fixing" anything, as the logic is identical before, or
after, this patch is committed.  So I'll apply this, but will drop these
two tags.

thanks,

greg k-h
