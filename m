Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-767234-1520354983-2-3122519688677242273
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520354983; b=i30otCHhE9gHOSnqThOf9qy8k7Ftk4B0J61uNixEQXM3cdN
    XwAleJKulqtsnaYaMsOZemhmXphlKQccafJz7E8sUeYc6SIoBQqTkULS8OmBqLbi
    1y2RteXlRK5QUEY0fs0/vAedThrTT0zYZTLojMOOW+8lYAwJbREbcD8HyIgZSplE
    6wRDt0XXL0cDW0BKMLTlsINvzz6Qw9oqeSyJuOXCoJSYTA2jxb1NaHiXATuGha5U
    37MLOhqvGCsEk1eJWzQEUJqMTh7XlyQXXXgfFu2uWtDeuHsaq+r7/SZPLofb7bga
    X7EeW9khyim5iEbFQJIDlZd3vsdpDDo1nnVK8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520354983; bh=kM2QYY1b599LDBzpi1GQzLNdi0
    lueqNGcA9yT6wmGco=; b=Wavxjhi9iFDmEFD8ZzhKGrq/JmPadF8AQZG66eDu/X
    aL2gQm7PYh99y9MuxKw6T/nk5yyznPm4HaVCKq22O7w09E2JIV6l7/k7+QNnsgix
    P8otzJRYTwtqFOU0l95tdbMTWetPDGu6F0DTJLMGalVkmHcLc2sKa3p5hfNLLbdW
    U9z0OcjFe2eZ5Msn9vAXMoy4jPhdCiJp6cRp20rjEwzLvs3jXMCMWu+oTsEiiZyO
    WfmjwwBktwqEhWQI5IpbArs2ntazFJGWc+WvZp7Vbu/hvnt09qRkTdS8S1AMfxgs
    ntEwWUAQ31+7PcqwZGHpAwIxyEi1cosE92lEIQ20TUYw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IhXS29En;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IhXS29En;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753863AbeCFQtb (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 11:49:31 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:53928 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752055AbeCFQt3 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 6 Mar 2018 11:49:29 -0500
X-Google-Smtp-Source: AG47ELvZSF2dWWcO3vyCPHRApr9zXsQICcN9cAY1av2nr8IJ8dU2XPzrkE+ipAGd/G+y6bnokA1eww==
Date: Tue, 6 Mar 2018 17:49:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 3/6] arm64: dts: exynos: add micro-USB connector node
 to TM2 platforms
Message-ID: <20180306164924.fvwx72pmobn67h7z@kozik-lap>
References: <20180227071134.28063-1-a.hajda@samsung.com>
 <CGME20180227071139eucas1p1d28b39a6636a7e6625aeb3a16091f81a@eucas1p1.samsung.com>
 <20180227071134.28063-4-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180227071134.28063-4-a.hajda@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 08:11:31AM +0100, Andrzej Hajda wrote:
> Since USB connector bindings are available we can describe it on TM2(e).
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof

