Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3521456-1518120276-2-9094034157462562062
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
    t=1518120275; b=AR2lqonSj1svRT30tHIAucep7R+UKBLFoNHa1GmKaIvISWk
    sMp/gj+K9Ftx2Q3c85IgVFMtrayM4fTHjcDvVi40DoZZArbqInjnnZ9ljQW996Lo
    OIwvFt6su3LUM5ok/hma0ahHrVv1DwP5c7maIxZpSuo1iNlxD3L/veZyfKhrt7Tk
    n7BuMjtYpjgRGXjez9x6a3w41hngFPGIQwn0c+wxrBkx6fV9soqz+MUu3sIWA4mV
    fvrZZDzbugqdlkQVp9KYCrvRmCn6VEm9Us55yvsC+1Qt+aac0iwNXQ6TTxaUUg1r
    vaWl0y0fn4JaF9/v/zScS4YGbNSIFkvsgVPcqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1518120275; bh=PzKWbkH
    yHgmE6oWJHH/qAH2sorOmqPtOxxMwV+retw4=; b=cZSGs3JVBItJxb8/ymvbpSw
    MEIUSbLsGSl3M1+lAg2c6GF9ZuAAM98nT6+IfIfm663Kgjro4py6XsrXdxcA1XaX
    c5ZEvQrB652qiSZaDWadPHeum3cRmtqTqoBMBC69KcJ5wobfZv1OZYXFkt27An08
    0L3EXf8Qz3lLYa08O7FBFDQtoW/pDflfHm+QPBe+ghgba/gEKNnZ44mlrCLqsx5N
    2GhOmNFmCNxfcctxLKe2fEvxnQrIbjTKbm59dpmrAC8xQaIYArIMGl9qca9Gj38D
    Rg4WxyEFm+2WsBBGUCeHLEMwQV05namXTvon6vvfgBTN5VZODZdjQ2zSymjGGNg=
    =
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cIxsFgpj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cIxsFgpj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeBHUEV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 15:04:21 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42860 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbeBHUES (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 8 Feb 2018 15:04:18 -0500
X-Google-Smtp-Source: AH8x225qd0oTa9SgFFj650S2RJnrueTXkq7jixjkUaMammf8161h5Hm79sFk3tSPpA+DBDUtNTpURg==
Date: Thu, 8 Feb 2018 14:04:15 -0600
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
Message-ID: <20180208200415.fargr6l33ge7ap22@rob-hp-laptop>
References: <20180131134435.12216-1-a.hajda@samsung.com>
 <CGME20180131134457eucas1p128394aef86e0d76cfc6ccb72ee22d4b1@eucas1p1.samsung.com>
 <20180131134435.12216-2-a.hajda@samsung.com>
 <20180205060836.pybxzt5e2kdu2wew@rob-hp-laptop>
 <a9745020-602b-8274-e2d6-63295f5b3caa@samsung.com>
 <20180207214338.7n2somaul2msgf2a@rob-hp-laptop>
 <0810d6fc-dd82-dda8-8c35-d37e8a346599@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0810d6fc-dd82-dda8-8c35-d37e8a346599@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 10:27:54AM +0100, Andrzej Hajda wrote:
> On 07.02.2018 22:43, Rob Herring wrote:
> > On Mon, Feb 05, 2018 at 10:06:35AM +0100, Andrzej Hajda wrote:
> >> On 05.02.2018 07:08, Rob Herring wrote:
> >>> On Wed, Jan 31, 2018 at 02:44:31PM +0100, Andrzej Hajda wrote:
> >>>> These bindings allow to describe most known standard USB connectors
> >>>> and it should be possible to extend it if necessary.
> >>>> USB connectors, beside USB can be used to route other protocols,
> >>>> for example UART, Audio, MHL. In such case every device passing data
> >>>> through the connector should have appropriate graph bindings.
> >>>>
> >>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> >>>> ---
> >>>> v2:
> >>>> - moved connector type(A,B,C) to compatible string (Rob),
> >>>> - renamed size property to type (Rob),
> >>>> - changed type description to be less confusing (Laurent),
> >>>> - removed vendor specific compatibles (implied by graph port number),
> >>> How so? More below...
> >>>
> >>>> - added requirement of connector being a child of IC (Rob),
> >>>> - removed max-mode (subtly suggested by Rob, it should be detected anyway
> >>>>   by USB Controller in runtime, downside is that device is not able to
> >>>>   report its real capabilities, maybe better would be to make it optional(?)),
> >>>> - assigned port numbers to data buses (Rob).
> >>>>
> >>>> Regards
> >>>> Andrzej
> >>>>
> >>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> >>>> ---
> >>>>  .../bindings/connector/usb-connector.txt           | 48 ++++++++++++++++++++++
> >>>>  1 file changed, 48 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
> >>>> new file mode 100644
> >>>> index 000000000000..02020f5d760a
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
> >>>> @@ -0,0 +1,48 @@
> >>>> +USB Connector
> >>>> +=============
> >>>> +
> >>>> +USB connector node represents physical USB connector. It should be
> >>>> +a child of USB interface controller.
> >>>> +
> >>>> +Required properties:
> >>>> +- compatible: describes type of the connector, must be one of:
> >>>> +    "usb-a-connector", "usb-b-connector", "usb-c-connector",
> >>> Nit: one per line.
> >>>
> >>>> +
> >>>> +Optional properties:
> >>>> +- label: symbolic name for the connector
> >>>> +- type: size of the connector, should be specified in case of USB-A, USB-B
> >>>> +  non-standard (large) connector sizes: "mini", "micro"
> >>>> +
> >>>> +Required nodes:
> >>>> +- any data bus to the connector should be modeled using the OF graph bindings
> >>>> +  specified in bindings/graph.txt, unless the bus is between parent node and
> >>>> +  the connector. Since single connector can have multpile data buses every bus
> >>>> +  has assigned OF graph port number as follows:
> >>>> +    0: High Speed (HS), present in all connectors,
> >>>> +    1: Super Speed (SS), present in SS capable connectors,
> >>>> +    2: Sideband use (SBU), present in USB-C,
> >>>> +    3: Mobile High-Definition Link (MHL), present in 11-pin Samsung micro-USB
> >>> This is un-muxed unlike Type-C where the signals are muxed with USB SS. 
> >>> That makes me think the Samsung connector should have its own compatible 
> >>> string.
> >> Do you mean, sth like:
> >>     connector {
> >>             compatible = "samsung,usb-connector-11pin";
> >>             label = "micro-USB";
> >>             ports {
> >>                     #address-cells = <1>;
> >>                     #size-cells = <0>;
> >>
> >>                     port@3 {
> >>                             reg = <3>;
> >>                             musb_con_mhl_in: endpoint {
> >>                                     remote-endpoint = <&mhl_out>;
> >>                             };
> >>                     };
> >>     };
> > Yes, basically.
> >
> >> Or should I add "usb-b-connector" extra compatible and "type" property?
> > type would be micro? I think type and "usb-b-connector" are fine if this 
> > is a superset like a USB3 SS micro connector.
> >
> >> I slightly prefer my approach(less different bindings), but I am also OK
> >> with the above.
> > How do you know it is a Samsung connector then? Just because you have 
> > port 3? I think it is better to be explicit.
> 
> OK.
> 
> >
> >>> Can we go ahead and define the video modes of Type-C? Normally, if 2 
> >>> data streams are mutually exclusive, then they are a single port with 2 
> >>> endpoints. So we'd either have 2 endpoints on port 1 or we stick with 
> >>> port 3 is always video. We can still know what is mutually exclusive 
> >>> based on the compatible. 
> >> I am sorry, I do not understand what you mean. Port 3 is present only in
> >> 11-pin Samsung micro-USB, USB Type-C has only ports 0, 1, 2.
> > So video on Type C would be on port 1 (SS), endpoint ? ? That's not 
> > defined in the binding and I want to define it.
> 
> USB type C does not have dedicated video lines, it has only: HS, SS, SBU
> (and optionally CC) data lines[1] and in my RFC I have modeled data
> lines as graph ports. If USB-C interface controller supports alternate
> mode (currently there are specs for DisplayPort, HDMI, MHL alternate
> modes, but there can be more), SS lines can be used to transmit video
> data (or any other type of data defined by alternate mode), but it means
> there will be SS mux somewhere before connector, for muxing USB-SS and
> alternate lines. So yes, video will be at port 1, but this is still port
> for SS lines:

Yes, I know all this.

> 
> USB3 --> MUX --> CONNECTOR
> DP -------^
> 
> I do not see why we would need separate video port.

Yes, agreed. I just want to define how we are supporting it. Otherwise, 
someone may just think video is on port 3 for Type C too. 

Rob
