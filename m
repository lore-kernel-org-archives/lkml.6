Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3033004-1520297615-2-2769099989724023296
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520297615; b=LnKOpL5ojelDxd+zIc5Hi1naKjg6ivQeOoxLMw3PlTIVyze
    /C1Hhej9g9oP7bqe4YRXttuEAB4Yl7pBmVDKOqZplFSDAzJ8i3ndqO1yGvzOXCKA
    fCyTlPOGgj8rwR0URRXiaDLOoGLvl/Fsc9WhVOS0STJdc/r9w+3gIHPnLCWs++d1
    wrh/Gf8zcErY4rWrWTRPt5fpFR8gUYegd9oVyeoW+UkfJlQCUvFh5/CWLGejLA0m
    XLW3ArvvDJMwveDpzaFoTRAC33g4DOswMLkr4ASclsvd3ulCVLdSDnPNlQsB+Umd
    JZuLeb/BEvs9ii1AVwcL7XL1hlBVc9X709bSGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520297615; bh=3+RTG+VuCVAryMVXoRlhGwFbvg
    IqOZkkRsp+TpWidt8=; b=Y8jjnUvJfDnbm5EK2PkPXDikqMyiWCxdW0sKz6aHai
    HFB5BdK3N3jcI2jgJ40K4jMhSPaSdAOJcO+qicLQR5H7I6tFuju+MX5LbcjX+JvT
    9QFSI74yG/UMR+HKKf7WY4gWE0c/x+baO9mbFJljvONgb7TwnrDykkSiX8OAHdwm
    SrZQ4uM+zwYvbaaWXwP1RUuNd81AEjj9/FlNfGnk7/fR6dcdSbRi4p+p/j+vMcX9
    HEfXDH14J9ndx28ZICi+x9klJOyySlSxe/bJyTj2caij8y97DyusSZoi1fUJxm6u
    i93RQs+JSFIeJeme4r6p/IYsaTakuc29Ywkqh8RUBdUw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eV3+h2wj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eV3+h2wj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbeCFAxc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 19:53:32 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:45032 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeCFAxc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Mar 2018 19:53:32 -0500
X-Google-Smtp-Source: AG47ELsX87C8T3ivHakRjVmHbwMvyZNHYp32PhucCUEMUNGjQoWJl2f99CScq6owHhgjI3OeWkAT4w==
Date: Mon, 5 Mar 2018 18:53:30 -0600
From: Rob Herring <robh@kernel.org>
To: Bich HEMON <bich.hemon@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: serial: stm32: add RS485 optional
 properties
Message-ID: <20180306005330.qym4abxbs7x3z27j@rob-hp-laptop>
References: <1519815373-22940-1-git-send-email-bich.hemon@st.com>
 <1519815373-22940-2-git-send-email-bich.hemon@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519815373-22940-2-git-send-email-bich.hemon@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 10:56:18AM +0000, Bich HEMON wrote:
> Add options for enabling RS485 hardware control and configuring
> Driver Enable signal:
> - rs485-rts-delay
> - rs485-rx-during-tx
> - rs485-rts-active-low
> - linux,rs485-enabled-at-boot-time
> 
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> ---
>  Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
