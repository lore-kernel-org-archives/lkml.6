Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3646879-1520439377-2-17005197086153831947
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
    t=1520439376; b=RlZCG3iFXOXMUcvHKgFBdnEAozYUa8iObvXXqHjhx150sGn
    Wato/U6pg2T1zWzwOD9ajOi0mmhxPWogauhX3lsIxVqeDEDQmJNl/aOsRZrwkJrq
    Y7z2QsG/ILLlA1B1oby7XvbQF1iuw4DtCf8e+zJBwsQG3EyaKT3lGLbYX1Gd1fLb
    qYlIB6NryYWOBvdYOzsZqAcpITVvRMIkJBDb5hB7HLTvNy8mlGxfX3ulniRRAF8p
    QCY/R3kacGr8OjBgyeS8lPbcIMRU7+J5dUrqjp/uMBrsJzEmHOhmNfTJws5RAoqM
    PuxA9dk8Lv5XAPPk2WUxH765Zt44/rmuSSal2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520439376; bh=lDvPV3jMmiBRYq0T/VLcD0Rev5OUtmuZMN0e/u
    MaKDI=; b=mT24E0pDvkg1+IhB7mS0bkOth8xgu8ub8TFsKLxOvjuP8k/Xd6JlF3
    vaYET1i9VBPwAjeRDWisiuIVap3Oe6tS0dtTCOiQFri/fdltS/lvonMstDmCjLAQ
    viUlmr5OOn7VYIEGRUkN4es/mudp0WUEm3fXB/g6cpnjIEhKQ3ftQjC7VnjaTUnO
    In4etY3MTSWUVkNALuI8987pI3N7hNYcZmTaLXJFXytUGefS5aaebSIRZY2HL+jv
    zx7RncMcluUESCvjmqFkLJxwG6Y9NKEvBELV6Wr9+KMnaafPkDLviTkFJ1X6PglE
    6fTGRsGS5Cjr1eAB7qXZ2IPjvjsCJrtQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S933665AbeCGQQP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 11:16:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:49600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933335AbeCGQQO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Mar 2018 11:16:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289B42133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AG47ELu1H8VMFllxjlDbHTknH8/L+onnJRY3MhmB+x7T7w3nZxz8f0nVu5IwSYFwYrSMJLD+5ETNzkMVyrbD5b4nzZY=
MIME-Version: 1.0
In-Reply-To: <1520412597-30545-2-git-send-email-patrice.chotard@st.com>
References: <1520412597-30545-1-git-send-email-patrice.chotard@st.com> <1520412597-30545-2-git-send-email-patrice.chotard@st.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 7 Mar 2018 10:15:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKBkfCsx4pyjUebwkV0q+S5LhwePWw59-7ibt77qdAGbw@mail.gmail.com>
Message-ID: <CAL_JsqKBkfCsx4pyjUebwkV0q+S5LhwePWw59-7ibt77qdAGbw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ARM: dts: STi: Fix aliases property name for STi boards
To: Patrice Chotard <patrice.chotard@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 2:49 AM,  <patrice.chotard@st.com> wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> Update serial aliases from "ttyASN" to more common "serialN".
>
> Since dtc v1.4.6-9-gaadd0b65c987, aliases property name must
> be lowercase only. This allows to fix following dtc warnings:
>
> arch/arm/boot/dts/stih418-b2199.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
> arch/arm/boot/dts/stih407-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
> arch/arm/boot/dts/stih410-b2260.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
> arch/arm/boot/dts/stih410-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>
> v3: _ none
> v2: _ use serialN instead of ttyasN aliases to not break ABI
>
>  arch/arm/boot/dts/stih407-b2120.dts | 4 ++--
>  arch/arm/boot/dts/stih410-b2120.dts | 4 ++--
>  arch/arm/boot/dts/stih410-b2260.dts | 4 ++--
>  arch/arm/boot/dts/stih418-b2199.dts | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
> index de3c8bf129b5..2c4d6033b448 100644
> --- a/arch/arm/boot/dts/stih407-b2120.dts
> +++ b/arch/arm/boot/dts/stih407-b2120.dts
> @@ -14,7 +14,7 @@
>         compatible = "st,stih407-b2120", "st,stih407";
>
>         chosen {
> -               bootargs = "console=ttyAS0,115200 clk_ignore_unused";
> +               bootargs = "console=serial0,115200 clk_ignore_unused";

These hunks for bootargs are still wrong. You wouldn't boot with a
console if you only apply patch 1. These hunks should be squashed with
patch 2.

>                 stdout-path = &sbc_serial0;
>         };
>
> @@ -24,7 +24,7 @@
>         };
>
>         aliases {
> -               ttyAS0 = &sbc_serial0;
> +               serial0 = &sbc_serial0;
>                 ethernet0 = &ethernet0;
>         };
>
> diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
> index 0a59b7b0f4b2..5422850641e8 100644
> --- a/arch/arm/boot/dts/stih410-b2120.dts
> +++ b/arch/arm/boot/dts/stih410-b2120.dts
> @@ -14,7 +14,7 @@
>         compatible = "st,stih410-b2120", "st,stih410";
>
>         chosen {
> -               bootargs = "console=ttyAS0,115200 clk_ignore_unused";
> +               bootargs = "console=serial0,115200 clk_ignore_unused";
>                 stdout-path = &sbc_serial0;
>         };
>
> @@ -24,7 +24,7 @@
>         };
>
>         aliases {
> -               ttyAS0 = &sbc_serial0;
> +               serial0 = &sbc_serial0;
>                 ethernet0 = &ethernet0;
>         };
>
> diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
> index feb8834478fa..ca347160e35d 100644
> --- a/arch/arm/boot/dts/stih410-b2260.dts
> +++ b/arch/arm/boot/dts/stih410-b2260.dts
> @@ -15,7 +15,7 @@
>         compatible = "st,stih410-b2260", "st,stih410";
>
>         chosen {
> -               bootargs = "console=ttyAS1,115200 clk_ignore_unused";
> +               bootargs = "console=serial1,115200 clk_ignore_unused";
>                 stdout-path = &uart1;
>         };
>
> @@ -25,7 +25,7 @@
>         };
>
>         aliases {
> -               ttyAS1 = &uart1;
> +               serial1 = &uart1;
>                 ethernet0 = &ethernet0;
>         };
>
> diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
> index 39b4db2e3507..dbf7bb704a1a 100644
> --- a/arch/arm/boot/dts/stih418-b2199.dts
> +++ b/arch/arm/boot/dts/stih418-b2199.dts
> @@ -14,7 +14,7 @@
>         compatible = "st,stih418-b2199", "st,stih418";
>
>         chosen {
> -               bootargs = "console=ttyAS0,115200 clk_ignore_unused";
> +               bootargs = "console=serial0,115200 clk_ignore_unused";
>                 stdout-path = &sbc_serial0;
>         };
>
> @@ -24,7 +24,7 @@
>         };
>
>         aliases {
> -               ttyAS0 = &sbc_serial0;
> +               serial0 = &sbc_serial0;
>                 ethernet0 = &ethernet0;
>         };
>
> --
> 1.9.1
>
