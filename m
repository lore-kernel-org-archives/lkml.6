Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3003911-1519010171-2-1443809946968317283
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519010171; b=m1jxnVvo3Sv3sjdmJezAAZiY5GOI8nXPhUCdiaLl8qw+cIo
    xSWzcYAoO3fgqVuGzHsMoglNZSSMeveqoIW3T86vwmgstKCPjgPTZdAz5WwhJM9N
    C2zdWhhgMbsyNWKBrv/Shexafefd/o3ylD+mJFF0/4LSYYNHnL1c/iwKZGZKBXFo
    x5bZMi+rs989u/i+5UJmVkSdZFiQOSa6NcLFm2C8AMomRGrncQXrSl401ggCJ+ZN
    LFZQdanmM02if0O9HhpRMl3MPxE4Ef4UsiFC4oAE5fCWyPbTjJXgG0pnxepWzLMT
    TG4jZwUapNIzPZI7BcI/OF+6UlOS09njbZ3ouMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519010171; bh=QL4NORJnodAC9MB9g/zXKqiJgK
    nZzAtbgr2R5KMNJ40=; b=DldWw0kdq7qaiEgv9u8nP/svgs3gD//efuHEQuzOXZ
    fcESkBUT9laUFgtgvaTTtLSm/WAvfU6XDkRHpdomkptKQIvn6sp14OhUhcFTI2YI
    bu4BU1fF+z83H7WNfMA3/4a73kHtxidnl/Jt1AsX77Bv0V+/nyZGGL8SJv7/DVJw
    0cLNk3vIeMDhtrog/ILjHso0dwBIJvizSvVYNon3AcO41PVsP+yOCeWE0z0IKIss
    vhcvbO8TOJs3AYovDZ2eBa+h6OFR6gdxwLYhY9YtqZqL/8ynvv+dicL5F57rejEK
    9JkcqhWQFi1BEjEBIPRPzGAvH9BxfJVlk/yat0BCI7vg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tUqdeyGq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tUqdeyGq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbeBSDQJ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Feb 2018 22:16:09 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33123 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbeBSDQJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 18 Feb 2018 22:16:09 -0500
X-Google-Smtp-Source: AH8x224VzjeCs4Co4XEOmBEK2SanF6fMpB6C3QjCYbOJufBuHpi4RKvzxpfLVGK4cUkLESSfye1j4A==
Date: Sun, 18 Feb 2018 21:16:07 -0600
From: Rob Herring <robh@kernel.org>
To: Joel Stanley <joel@jms.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomer Maimon <tomer.maimon@nuvoton.com>,
        Avi Fishman <Avi.Fishman@nuvoton.com>,
        Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH v2] serial: 8250: Add Nuvoton NPCM UART
Message-ID: <20180219031607.u4bdjygddjt7tddc@rob-hp-laptop>
References: <20180215021720.14870-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215021720.14870-1-joel@jms.id.au>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 12:47:20PM +1030, Joel Stanley wrote:
> The Nuvoton UART is almost compatible with the 8250 driver when probed
> via the 8250_of driver, however it requires some extra configuration
> at startup.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2:
>  Remove redundant whitespace
>  Use port number 40 to fill in a gap
> 
>  Documentation/devicetree/bindings/serial/8250.txt |  1 +

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/tty/serial/8250/8250_of.c                 |  1 +
>  drivers/tty/serial/8250/8250_port.c               | 29 +++++++++++++++++++++++
>  include/uapi/linux/serial_core.h                  |  3 +++
>  include/uapi/linux/serial_reg.h                   |  5 ++++
>  5 files changed, 39 insertions(+)
