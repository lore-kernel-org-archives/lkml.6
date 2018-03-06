Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-343908-1520342808-2-4418907510263802524
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520342807; b=JnY27ClsexG/sYRR/KE2CYaZeKv9BIcWz9u5wfi+aeK3G1o
    a3VJhNWr3D3VSO+ok12nEqoX4n4U1JcTZ1kVq3Qxn93LNnX/eCglK153HDAcyhwW
    lEHXw3IJ7eH1J6ECCud8Sn0FBLth5jlbi34Vh+NDSc51Em6XdunccP8BB0uhKY2i
    gXgzlhY0HW8z5yKthS0JYvd4r/kwPURJ8iNKlQPt2VxDh6iqH/yWZuF8EA6dumO/
    lcEcgC6zhcBIm7SwmxjOZoI9Zw3HARVDdw1pfzyaRV1iKOjBcZi2KLtXuWlrAXMU
    AYYbvVEzXoJbjLSwCU/9tSZO1FDLxv0Z8TqMZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520342807; bh=aV7E1xCp1NXp8BO3xLxUaCpbDa0S/hMZlWuMZq
    ztv2s=; b=gAptfF0BzBK5OwFAkLjVIBztXeyv/f2xL1dg4uCDNBiN+2LhgzfL5z
    eFpZ70GOctCcGhRVSdwG3W+7hHAlhGNOFoMNvMXAqsaI5n6a2/chC1R5osuZdj7B
    LI7X/5TWTk7Ig0EE2b88+Q0uozjllGQT0Lrjo3ar4NO2unNPs1EU5fBA6hkb1Pb8
    IVakgX9AyqrUvULVC2D2rtwlQABhd/S8+KzTu8fzDF3+i3sRJMRNdCU0J8UWDoqE
    TqE1Oc6FzwJ308fEWF8vi2phjepdCC+66LRRindhrvx64HwCRTd8JQw6Ha2rnzav
    B+uhJmy7rFLq/0lukAoxPC8AyiaOCASQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S1753500AbeCFN0p (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 08:26:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753497AbeCFN0o (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Mar 2018 08:26:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98E22179F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AG47ELsC7c1hUH/3Z03izGSU5r+lEE5GOyvj7uSZjNy7hiqDX7X6DtaK5Ud0a4GjzsfwGN0IzfeJltZG80kNNBCFKiY=
MIME-Version: 1.0
In-Reply-To: <1520323650-11030-3-git-send-email-patrice.chotard@st.com>
References: <1520323650-11030-1-git-send-email-patrice.chotard@st.com> <1520323650-11030-3-git-send-email-patrice.chotard@st.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 6 Mar 2018 07:26:22 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+-C5h1-xLOB39bhSsn9JR31UaEQL+cRwydD0a4w6sYNw@mail.gmail.com>
Message-ID: <CAL_Jsq+-C5h1-xLOB39bhSsn9JR31UaEQL+cRwydD0a4w6sYNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ARM: dts: STi: Remove useless stdout-path for STi boards
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

On Tue, Mar 6, 2018 at 2:07 AM,  <patrice.chotard@st.com> wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> As serial interface is already specified into bootargs,
> stdout-path can be removed.

Wrong way around. stdout-path is preferred over using console in bootargs.

>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>
> v2: _ none
>
>  arch/arm/boot/dts/stih407-b2120.dts | 1 -
>  arch/arm/boot/dts/stih410-b2120.dts | 1 -
>  arch/arm/boot/dts/stih410-b2260.dts | 1 -
>  arch/arm/boot/dts/stih418-b2199.dts | 1 -
>  4 files changed, 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
> index 2c4d6033b448..074b4cd0ca89 100644
> --- a/arch/arm/boot/dts/stih407-b2120.dts
> +++ b/arch/arm/boot/dts/stih407-b2120.dts
> @@ -15,7 +15,6 @@
>
>         chosen {
>                 bootargs = "console=serial0,115200 clk_ignore_unused";
> -               stdout-path = &sbc_serial0;
>         };
>
>         memory@40000000 {
> diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
> index 5422850641e8..eae3050984d0 100644
> --- a/arch/arm/boot/dts/stih410-b2120.dts
> +++ b/arch/arm/boot/dts/stih410-b2120.dts
> @@ -15,7 +15,6 @@
>
>         chosen {
>                 bootargs = "console=serial0,115200 clk_ignore_unused";
> -               stdout-path = &sbc_serial0;
>         };
>
>         memory@40000000 {
> diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
> index ca347160e35d..c26e388bd1a4 100644
> --- a/arch/arm/boot/dts/stih410-b2260.dts
> +++ b/arch/arm/boot/dts/stih410-b2260.dts
> @@ -16,7 +16,6 @@
>
>         chosen {
>                 bootargs = "console=serial1,115200 clk_ignore_unused";
> -               stdout-path = &uart1;
>         };
>
>         memory@40000000 {
> diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
> index dbf7bb704a1a..d948f774fee7 100644
> --- a/arch/arm/boot/dts/stih418-b2199.dts
> +++ b/arch/arm/boot/dts/stih418-b2199.dts
> @@ -15,7 +15,6 @@
>
>         chosen {
>                 bootargs = "console=serial0,115200 clk_ignore_unused";
> -               stdout-path = &sbc_serial0;
>         };
>
>         memory@40000000 {
> --
> 1.9.1
>
