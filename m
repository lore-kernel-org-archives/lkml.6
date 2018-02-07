Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-876777-1518039839-2-12442173961300833514
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518039839; b=T+t1G80wRbgz5v0rrT8bA/fUXLMqrlkh1sMlFDLdMw+woxM
    RvbQSQ78P6JMQ1nZ+9hTFvhW8P3RpZ7TXr8K7/kmlXS2M8xsDB7HEItKpIWCv4wn
    9RJE6V5wf/0HuUwOgRyx2xz8ViJgM02X8zfqKUKXNUX85D3LaqbGFET6Fvxy4Z0j
    kdDWNAkn5F3cR9bmjShFcr2sOGJZ4SGPG+KfuGNhCzN0f333/QCAz2dymAE+euVT
    9uWRjStFF/iCqnWCnltJJkhalp8Qi5tnxfrgfc3+hCneXXJoH8LXaZuDge42AVi4
    Ly3kpEKNbQecNY3WiyQ5T9f0jNq394GD8zXb2uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1518039839; bh=76f2jZq
    dxnkdNf/ZVISz8xsUqeph9jFP970LGTHCrsw=; b=he/JJrlEosBQ4iOM1OfSdSy
    o5taEDVzSmRcHWH3433AMxwSJwS2DMvP7/WDlyHYxYVuXQ/6hno83vA1Fh14yeMQ
    Z8Ge7p0QNwfX/4G/Xpq2XugDysVwlpTz/k09I6kQRosNdliBnIWWPTHCxlXXOft7
    f0zsueL3tT+fmb+HkDTYE4Ly5zEGNovYNYCIfAr2Qs2zorE2d2fcKxyyVTbbSxVa
    C9gp+Lb6ZGAcz/UiDwF9FdKDpku5TUi/UlNrBeoXkaa59RtV5Ue+FqXK5UPK5Rp5
    tAR21Uf3bz138YXzSMzDWhZeXq/0D/XE6G9VRmS1z3cL0Hiyg3dgpN7hNHNLZ4A=
    =
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=llp8xrLL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=llp8xrLL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeBGVnn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 16:43:43 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41914 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeBGVnl (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 7 Feb 2018 16:43:41 -0500
X-Google-Smtp-Source: AH8x224hj7QzcgGr94dxyWSmgVkyf9xcrwtrA+IWRK+kACXewEVISJy+bYl0SD7+JywE4OjXjO5uBQ==
Date: Wed, 7 Feb 2018 15:43:38 -0600
From: Rob Herring <robh@kernel.org>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/5] dt-bindings: add bindings for USB physical
 connector
Message-ID: <20180207214338.7n2somaul2msgf2a@rob-hp-laptop>
References: <20180131134435.12216-1-a.hajda@samsung.com>
 <CGME20180131134457eucas1p128394aef86e0d76cfc6ccb72ee22d4b1@eucas1p1.samsung.com>
 <20180131134435.12216-2-a.hajda@samsung.com>
 <20180205060836.pybxzt5e2kdu2wew@rob-hp-laptop>
 <a9745020-602b-8274-e2d6-63295f5b3caa@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9745020-602b-8274-e2d6-63295f5b3caa@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 05, 2018 at 10:06:35AM +0100, Andrzej Hajda wrote:
> On 05.02.2018 07:08, Rob Herring wrote:
> > On Wed, Jan 31, 2018 at 02:44:31PM +0100, Andrzej Hajda wrote:
> >> These bindings allow to describe most known standard USB connectors
> >> and it should be possible to extend it if necessary.
> >> USB connectors, beside USB can be used to route other protocols,
> >> for example UART, Audio, MHL. In such case every device passing data
> >> through the connector should have appropriate graph bindings.
> >>
> >> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> >> ---
> >> v2:
> >> - moved connector type(A,B,C) to compatible string (Rob),
> >> - renamed size property to type (Rob),
> >> - changed type description to be less confusing (Laurent),
> >> - removed vendor specific compatibles (implied by graph port number),
> > How so? More below...
> >
> >> - added requirement of connector being a child of IC (Rob),
> >> - removed max-mode (subtly suggested by Rob, it should be detected anyway
> >>   by USB Controller in runtime, downside is that device is not able to
> >>   report its real capabilities, maybe better would be to make it optional(?)),
> >> - assigned port numbers to data buses (Rob).
> >>
> >> Regards
> >> Andrzej
> >>
> >> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> >> ---
> >>  .../bindings/connector/usb-connector.txt           | 48 ++++++++++++++++++++++
> >>  1 file changed, 48 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
> >> new file mode 100644
> >> index 000000000000..02020f5d760a
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
> >> @@ -0,0 +1,48 @@
> >> +USB Connector
> >> +=============
> >> +
> >> +USB connector node represents physical USB connector. It should be
> >> +a child of USB interface controller.
> >> +
> >> +Required properties:
> >> +- compatible: describes type of the connector, must be one of:
> >> +    "usb-a-connector", "usb-b-connector", "usb-c-connector",
> > Nit: one per line.
> >
> >> +
> >> +Optional properties:
> >> +- label: symbolic name for the connector
> >> +- type: size of the connector, should be specified in case of USB-A, USB-B
> >> +  non-standard (large) connector sizes: "mini", "micro"
> >> +
> >> +Required nodes:
> >> +- any data bus to the connector should be modeled using the OF graph bindings
> >> +  specified in bindings/graph.txt, unless the bus is between parent node and
> >> +  the connector. Since single connector can have multpile data buses every bus
> >> +  has assigned OF graph port number as follows:
> >> +    0: High Speed (HS), present in all connectors,
> >> +    1: Super Speed (SS), present in SS capable connectors,
> >> +    2: Sideband use (SBU), present in USB-C,
> >> +    3: Mobile High-Definition Link (MHL), present in 11-pin Samsung micro-USB
> > This is un-muxed unlike Type-C where the signals are muxed with USB SS. 
> > That makes me think the Samsung connector should have its own compatible 
> > string.
> 
> Do you mean, sth like:
>     connector {
>             compatible = "samsung,usb-connector-11pin";
>             label = "micro-USB";
>             ports {
>                     #address-cells = <1>;
>                     #size-cells = <0>;
> 
>                     port@3 {
>                             reg = <3>;
>                             musb_con_mhl_in: endpoint {
>                                     remote-endpoint = <&mhl_out>;
>                             };
>                     };
>     };

Yes, basically.

> 
> Or should I add "usb-b-connector" extra compatible and "type" property?

type would be micro? I think type and "usb-b-connector" are fine if this 
is a superset like a USB3 SS micro connector.

> I slightly prefer my approach(less different bindings), but I am also OK
> with the above.

How do you know it is a Samsung connector then? Just because you have 
port 3? I think it is better to be explicit.

> 
> >
> > Can we go ahead and define the video modes of Type-C? Normally, if 2 
> > data streams are mutually exclusive, then they are a single port with 2 
> > endpoints. So we'd either have 2 endpoints on port 1 or we stick with 
> > port 3 is always video. We can still know what is mutually exclusive 
> > based on the compatible. 
> 
> I am sorry, I do not understand what you mean. Port 3 is present only in
> 11-pin Samsung micro-USB, USB Type-C has only ports 0, 1, 2.

So video on Type C would be on port 1 (SS), endpoint ? ? That's not 
defined in the binding and I want to define it.

> Here is list of possible ports depending on connector type:
> - USB 2.0: HS
> - 11-pin Samsung micro-USB: HS,MHL
> - USB 3.x type A,B: HS,SS
> - USB-C: HS,SS,SBU
> 
> All ports have separate lines, so they can work simultaneously.
> 
> And regarding MHL on standard micro-USB connector. MHL and MUIC will
> share HS port, but there will be mux somewhere before connector:

That's another case I hadn't considered. I was mainly thinking just how 
to handle Type C.

> - in MUIC, in this case MUIC will be the parent of the connector, and
> there will be graph from MHL to MUIC to describe MHL link,
> - in MHL, in this case MHL will be the parent of the connector, and
> graph between MUIC and MHL to describe HS link,
> - dedicated mux to MUIC and MHL, controlled by gpio pin, it could be
> handled by MUIC's external-mux gpio property for example, or (probably)
> less hacky by separate node for mux,
> or as additional property in the connector (who should be the parent of
> the connector then? Probably MUIC?).
> 
> Regards
> Andrzej
