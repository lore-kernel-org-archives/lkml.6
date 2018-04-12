Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-375971-1523517999-2-3630072364988090479
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523517998; b=ddvyus/IIjlNbkupgFHBRrg8CUbL6JMAIWZVxObJ/XDDKt8ih8
    SvqswAe7kry9cVKNgfXvbixJAEvUBMP2NyXe3xzypF2zQJ3a2rYJwSUF85sQurTo
    FpsASGt68XEEQm4oHiNMr8B7m7ABCX+9WQV/MHWAQ7GWu295GCdk59lwPTWSJjgR
    a6woa1Du4kQdS+VhWtHUgBO6buoec0sgGU1R676HjKA26F61BOJ/e3VRKhuhekAU
    XPdlEi7r2tUcdJr7K19GXKn7wA1nQgF8BqohYjAImJUi9hzBMJHzR+MivoQPrBbM
    L0TTEyJiT0vA+INs5N4PEv8wr41FlSN1+OFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523517998; bh=vwwYVWQs7w+idsiUGaqK0kuUnHi53C
    6xrxg4TJ30uHs=; b=ZZRukwdUo4niM49EyUVW7bmA0Dxkc4D/bZ9jlpjKsNE8NN
    mtibED/ArTEt5QYnwAEaB5Nc+f9hTIYfAOJYMRQYkjF44adc2l/IzMZ+qfa6IgLM
    9MbpLWiPfRHmML5gSGMhJ23HpTJ8gEwrPLWYz/li8+LUHT4UIVrB5iCnn8bJxvRS
    6k8e2quLCNU9kBWb3DN2SLszyv37GysbA43iYkes/BjGYX9vzr1Y0nYCM6kSMK5+
    EK78oAhUuieU9cyoF7LxtGfr9Y6a8v550F0reXrUoEedl2rZJpl+l42cweJkwKED
    lc+Jy08CLL74QRDbkYCIkkERYe/xw9ehT4hPFXKw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAj9kJfzyGaBilCgJLcoJ2xMBhOoc64UlkoFmmSLvvb73dMLUXNqs1crM9ajQYx+4UjxhAflR6gYmqoiCvd5QkOMYha8DVPBQmOZut/d8+/d+PENPa2m
    uYmaObH0As7eGTVwEf7fs+2DJHDSrhSVa9eQe8BxaiVrFs2EFYpQcX436FCwOWQqLzpuC5PipS3ih3sAOIFYlbGobVXDV0k9gf2nsnkMK37CqLAGAjVc14sL
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag8Pb0K1rpgMWccruAcA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750817AbeDLH0Y (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 03:26:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:27989 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbeDLH0X (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 12 Apr 2018 03:26:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,440,1517904000";
   d="scan'208";a="46285648"
Date: Thu, 12 Apr 2018 10:26:19 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Tobias Regnery <tobias.regnery@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: fix tracepoint related build error
Message-ID: <20180412072619.GF7517@kuha.fi.intel.com>
References: <20180410083806.27874-1-tobias.regnery@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410083806.27874-1-tobias.regnery@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 10:38:06AM +0200, Tobias Regnery wrote:
> There is the following build error with CONFIG_TYPEC_UCSI=m, CONFIG_FTRACE=y
> and CONFIG_TRACING=n:
> 
> ERROR: "__tracepoint_ucsi_command" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
> ERROR: "__tracepoint_ucsi_register_port" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
> ERROR: "__tracepoint_ucsi_notify" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
> ERROR: "__tracepoint_ucsi_reset_ppm" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
> ERROR: "__tracepoint_ucsi_run_command" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
> ERROR: "__tracepoint_ucsi_ack" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
> ERROR: "__tracepoint_ucsi_connector_change" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
> 
> This compination is quite hard to create because CONFIG_TRACING gets selected
> only in rare cases without CONFIG_FTRACE.
> 
> The build failure is caused by conditionally compiling trace.c depending on
> the wrong option CONFIG_FTRACE. Change this to depend on CONFIG_TRACING like
> other users of tracepoints do.
> 
> Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
> Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


Thanks,

-- 
heikki
