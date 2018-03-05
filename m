Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1903134-1520263731-2-1240258974977217403
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520263729; b=d7XkHcrIgFPMIsVVQ2oq7hD9elRqqnO1tgQGjOm9+B00BFj
    x1AgOBGzBjoJ9VQDIlQim3t3EImQJRKtRpnWqTTYMyVlAGrOsQsnx2ldrAwY/+6q
    F8NiWhql+o2onk/5sKP5IFrh/27NdQusuObNyO2vVEuL7bBlSSCUnyz/WIuqpo0p
    AcJMnG61DfM6UhdDZsdZ7adrfzrng+fnwZS5UDFAFeaGH4shJ2SdRZ4E+wYcIqjJ
    IoAI3PEogyehFq2ZxV4WZnKPntM8KrJPIjy3m5CnAYhQ0FgLlhDin5nSipkhe7la
    epqW9vblKD1KVJzePvzI9SQpuwPAJK9UmTsxrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520263729; bh=dT0JpGSlh54W7LHxcJjBUJd/u3wBcZ3A9cov7p
    +J3no=; b=EISFz9+tdiU2X6hpX4hSIvVmf9LR9iEWNQK5pQi84C1IOudj6nI5gX
    4bpJLxjqNk+jr8E0SqrZCC6R0ZQDwloOwvsMGOg1LdoM9JSNmU5jiQ3H9jBndw9f
    VywNXSQ6fwZM9v0ol1Kx/oTRTDo2IgSpfcvidgqG2dkv49PfUFFj6LHsl6w0PT47
    hsFjP0eFVpnkBTbTU50e/muqDFhI/zWFkq87apZcEonGwjDK5T5SicSxvyjWSMki
    LXav/xFYaq4+28DJ0zDT4fqRqd4MaWEKFu277mryyG4Y5vGzRZS0IepXmtOEUYZA
    RPFKASCy+x6Jmyp53UvKtpanLVRZDh1g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbeCEP2d (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 10:28:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752136AbeCEP2b (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Mar 2018 10:28:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6F220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AG47ELtAN1obK88S9VUqOC323cjVGyG1UXQ7pRn2HvK3x/48kWS44crWcYN+wq44GwQz+IgtZ83u1i6fDLTiu4/tlmM=
MIME-Version: 1.0
In-Reply-To: <1520262025-21088-2-git-send-email-patrice.chotard@st.com>
References: <1520262025-21088-1-git-send-email-patrice.chotard@st.com> <1520262025-21088-2-git-send-email-patrice.chotard@st.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 5 Mar 2018 09:28:08 -0600
X-Gmail-Original-Message-ID: <CABGGiszEcvKHGE54vOXPBUJeReAKbgmrxRyRxNfQQoL6D54GCw@mail.gmail.com>
Message-ID: <CABGGiszEcvKHGE54vOXPBUJeReAKbgmrxRyRxNfQQoL6D54GCw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: STi: Fix aliases property name for STi boards
To: patrice.chotard@st.com
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux@armlinux.org.uk,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jslaby@suse.com, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 9:00 AM,  <patrice.chotard@st.com> wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> Since dtc v1.4.6-9-gaadd0b65c987, aliases property name must
> be lowercase only.
> This allows to fix following warnings when compiling dtb
> with W=1 option :

I'm so glad to see fixes before the dtc update landed in the kernel tree!

> arch/arm/boot/dts/stih418-b2199.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
> arch/arm/boot/dts/stih407-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
> arch/arm/boot/dts/stih410-b2260.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
> arch/arm/boot/dts/stih410-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>  arch/arm/boot/dts/stih407-b2120.dts | 4 ++--
>  arch/arm/boot/dts/stih410-b2120.dts | 4 ++--
>  arch/arm/boot/dts/stih410-b2260.dts | 4 ++--
>  arch/arm/boot/dts/stih418-b2199.dts | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
> index c8ad905d0309..fa1186af6574 100644
> --- a/arch/arm/boot/dts/stih407-b2120.dts
> +++ b/arch/arm/boot/dts/stih407-b2120.dts
> @@ -14,7 +14,7 @@
>         compatible = "st,stih407-b2120", "st,stih407";
>
>         chosen {
> -               bootargs = "console=ttyAS0,115200 clk_ignore_unused";
> +               bootargs = "console=ttyas0,115200 clk_ignore_unused";

The kernel change for this is an ABI breakage both DT <-> kernel and
kernel <-> userspace.

Really, if you are okay with doing this, you should change it to ttySx IMO.

>                 linux,stdout-path = &sbc_serial0;

And since you have this, you don't even need the console praram.

>         };
>
> @@ -24,7 +24,7 @@
>         };
>
>         aliases {
> -               ttyAS0 = &sbc_serial0;
> +               ttyas0 = &sbc_serial0;

The correct fix is use "serialN" for aliases.

I have a check for only known alias names which would give a better
warning, but David thought it was too restrictive.

>                 ethernet0 = &ethernet0;
>         };
>
