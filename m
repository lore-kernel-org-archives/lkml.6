Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3033004-1520297541-2-9082472132619442837
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520297541; b=tmvE1H1at6XXxz3dQkyqcw+XfakAAooPn0Iy4AZ9N4YliRm
    p4wlDpqLs1pQbIhEVEMGwllv38cVqn+MNa8n99yzBnDxMCqDxxDurV6eWX8v4qh/
    yFqOOd1Hq3M5jOmzKnd8MfRDREKbLBRDIr+an6p1IhGJZuNFG5F4gtsfUIMTdscr
    YucO4VzZz/qAjQtD/up4k3f7wgFD440u+81ERbA9ZyCQkLY1FwMP7+Jh/FE8zqxJ
    V1W8dkUXNFZqXyIC0tZJfTQ8meu/B6ymGX83IHyLEItRzek/GYT6PYe83l7/el2q
    CUHUubQQ39cPXkE2pdywpi/5a/TxlpOW4onVRWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520297541; bh=YsUptTda22BUDjhNapyRxlS2TF
    6LZibS6DLGgfj2aQg=; b=iABF8gvtJAd7RUnpssZf7erNCjXeWO3BPMG4ICPmbt
    0offJABspQ9x5uQBN1cKE0MbnutqZZxwa8Tj1pW7LMmW+2Q1cqiWjBIwbQgk3AuL
    JbYEeTn0k42mOGZh12dbYWlfyxQe19wFjAJR2vQUVdbDhOo3pGP0Wvntfi/PoUfR
    LqYajiMRbk2mxw6qc4Nn3YyBAKiKqXAOawE1VGMR2zczAgtMrcSgtP4/40OFnxoG
    R2TiOUy7exPh6fBOVzt5o/6uWManYjdMPyQr50NwAMrjnPVTa1uk1foVWFH8NjQ3
    kGjiKIJTgRhacf0vXyqhTwv7qqCZQ3pNO4Ch+8p0PqjQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Tu9IIJNL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Tu9IIJNL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932395AbeCFAwU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 19:52:20 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:35192 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932287AbeCFAwT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Mar 2018 19:52:19 -0500
X-Google-Smtp-Source: AG47ELsNUFR6K6w2Ils4GTD1TAcFoTulmD6/UbI3HpKMJ+ncmQneRWBC2YvMm+qIFIkvCIr1D+QZmw==
Date: Mon, 5 Mar 2018 18:52:12 -0600
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
Subject: Re: [PATCH 1/2] dt-bindings: serial: stm32: add wakeup option using
 note
Message-ID: <20180306005212.acwhs2ajr64exf2s@rob-hp-laptop>
References: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
 <1519815044-22669-2-git-send-email-bich.hemon@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519815044-22669-2-git-send-email-bich.hemon@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 10:51:17AM +0000, Bich HEMON wrote:
> Update bindings with interrupt-names and wakeup-source information
> 
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> ---
>  Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> index d150b04..aaeb564 100644
> --- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> +++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> @@ -10,6 +10,7 @@ Required properties:
>  - interrupts:
>    - The interrupt line for the USART instance,
>    - An optional wake-up interrupt.
> +- interrupt-names: Contains "event" for the USART interrupt line.

This should be moved down into optional properties.

>  - clocks: The input clock of the USART instance
>  
>  Optional properties:
> @@ -17,6 +18,9 @@ Optional properties:
>  - st,hw-flow-ctrl: bool flag to enable hardware flow control.
>  - dmas: phandle(s) to DMA controller node(s). Refer to stm32-dma.txt
>  - dma-names: "rx" and/or "tx"
> +- wakeup-source: bool flag to indicate this device has wakeup capabilities
> +- interrupt-names : Should contain "wakeup" if optional wake-up interrupt is
> +  used.
>  
>  Examples:
>  usart4: serial@40004c00 {
> -- 
> 1.9.1
