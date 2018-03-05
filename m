Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2711254-1520288116-2-12942285604141337322
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
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520288115; b=tlfnCqIpD5otm78WY1q/84PaCKyNvxN16oVr2TmhzCyzFzC
    RF+/dtSvQv4Yieao7iMPblQtfbLL0ZGeQJ2GNvdzFZAMe3xuano8Mec2TPJBxYY0
    DTpsgQxYKLblp3A0U2CILSz7Z696+jGShQjkJBxEoPIl0v+3lrcR8KHRXTeJoGtS
    1TO+jat4vUBZctf2N9chRXEokgOH+Voa6CJDf4HFuK4jB1ekgsrUcIJFqRiiyxLy
    NmGkz7VBCOMNTSFpHfzdgvLnV2dCbAf5SLuOD2twyaaIsW1mU6Wls3vhySg+UpkL
    FCwXJ8Ylsz3/JLBQHDW4E5eHAopQi2O1Ad1RuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520288115; bh=v18zN524EEDQbUppgl/W31UD71
    iq+UeO3xWi8PoiisU=; b=tZZScPJ2NrJH1wpSpKtiw9VcFVEiOqsN4fiUJgn+1d
    hVzma+HBRK4x+6Cyz2JK5H6hptp1ia9ncCdO6peYi4JrE0Ax8w5PzQ36ZKZ6ou0D
    /P5NwcI/g0+TgVzcsYcj/R1MQxz0z5K+Pw575Q+rn1FGUi4MzDNfvztbnySW4ovU
    RDtwgbVl3rj8d4L35kHrcd2x22ptLRLuqpvS6k81+YrNe5HGx5eJ3zg9KJgHQAXk
    NdtaaDq6B/mVJ7MFEEUqL4PMxwKEwLIshDxiZTQCwhx9FE8kfKgxJv4tdY+2EpLq
    Mcuz5deResC/Qou8OR9S2IG/3zZphSAGdoTIhp/a5ehA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=i3S3k8zg;
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
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=i3S3k8zg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbeCEWPC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 17:15:02 -0500
Received: from mail-ot0-f173.google.com ([74.125.82.173]:32958 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932084AbeCEWPA (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 5 Mar 2018 17:15:00 -0500
X-Google-Smtp-Source: AG47ELuhy0talgfxlsB5dl4qDP3Go4Cm01afnmtE7shHHoUyXxly/FuQa8iV5HX9kW71RmwcOEXGnQ==
Date: Mon, 5 Mar 2018 16:14:58 -0600
From: Rob Herring <robh@kernel.org>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-samsung-soc@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: add bindings for USB physical
 connector
Message-ID: <20180305221458.lw5a4wznwjkbubox@rob-hp-laptop>
References: <20180227071134.28063-1-a.hajda@samsung.com>
 <CGME20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f@eucas1p1.samsung.com>
 <20180227071134.28063-2-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227071134.28063-2-a.hajda@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 08:11:29AM +0100, Andrzej Hajda wrote:
> These bindings allow to describe most known standard USB connectors
> and it should be possible to extend it if necessary.
> USB connectors, beside USB can be used to route other protocols,
> for example UART, Audio, MHL. In such case every device passing data
> through the connector should have appropriate graph bindings.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> v4:
> - improved 'type' description (Rob),
> - improved description of 2nd example (Rob).
> v3:
> - removed MHL port (samsung connector will have separate bindings),
> - added 2nd example for USB-C,
> - improved formatting.
> v2:
> - moved connector type(A,B,C) to compatible string (Rob),
> - renamed size property to type (Rob),
> - changed type description to be less confusing (Laurent),
> - removed vendor specific compatibles (implied by graph port number),
> - added requirement of connector being a child of IC (Rob),
> - removed max-mode (subtly suggested by Rob, it should be detected anyway
>   by USB Controller in runtime, downside is that device is not able to
>   report its real capabilities, maybe better would be to make it optional(?)),
> - assigned port numbers to data buses (Rob).
> 
> Regards
> Andrzej
> ---
>  .../bindings/connector/usb-connector.txt           | 75 ++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt

Reviewed-by: Rob Herring <robh@kernel.org>
