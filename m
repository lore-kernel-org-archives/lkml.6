Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-757654-1519324092-2-2965964700874527077
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519324091; b=TlzWDV+dwwb1VdlLkIX24Xndix0zEnrnocl6z4ERMkMy0tU
    8whguYA4OZSpfB1rTJybs9EJFqGtXCPlJuBD5tD3yPjE3GWyS4bOxabcwGlkry+F
    FbGGO3UrBEezo7in0ImYLjxuvYz/PTiDvPuLBmQJErnViZcbxZfl+MqMj3AEdx+8
    Dnmikxdt9XBDCcqXM7YaFFQUfjVe+NKkgkr6V0+VIH1WqNB0h61DVtTshT4xDGxx
    6iYZRtCZJzXhQJUqNnk60YzxtYodmBM7JJFg9ZqrXXmLlRBhUk9B63dGmtLV2FjX
    jC+lT4OBjbF290LBUjaugrXXgg/Xq24z1m/JdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=arctest;
    t=1519324091; bh=dWYUPctTyz+RhMal7QO/1wYfWA+fucgDSfsLsPbMEiU=; b=
    uQuUEWWXK8RDI21dD08hBEUMuJRclpd8XgAHSFojN3Morzh2Bd/DCsHc8YyyZmGx
    7pUpSRME8oONGtDwgPuoUHXBcY+bctnJ9RGUkNUmJUFysvJWhm1Y0q6OginZNQzC
    nDuTCzPmpAABymzxa54zsAHR5Mc1u9srx7VtlaOm0HvwDEjR0uYW24e60q9NxPYi
    2T3xXO24b3HUxYTOxbZ8gbW5mxfffmcwh9ddAmqtvOqAUar49OmCNFaTTVXhUim+
    aDoheaYfC/Cjea7f3tG+0VPJRJQoJ7shwx0RT4j9g9hCbVCKQTXxQ1Ta024DLHGh
    SqTtu5g+KnJ5OMuZ8087Jg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933759AbeBVS15 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 13:27:57 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:48394 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S933521AbeBVS14 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Feb 2018 13:27:56 -0500
Date: Thu, 22 Feb 2018 13:27:54 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Amelie DELAUNAY <amelie.delaunay@st.com>
cc: Roger Quadros <rogerq@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] usb: host: ehci-platform: add support for optional
 external vbus supply
In-Reply-To: <ec064186-9b0b-eeb4-5501-6bbc1e90da79@st.com>
Message-ID: <Pine.LNX.4.44L0.1802221325220.1295-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 22 Feb 2018, Amelie DELAUNAY wrote:

> >>>>> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
> >>>>> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> >>>>> @@ -19,6 +19,7 @@ Optional properties:
> >>>>>     - phys : phandle + phy specifier pair
> >>>>>     - phy-names : "usb"
> >>>>>     - resets : phandle + reset specifier pair
> >>>>> + - vbus-supply : phandle of regulator supplying vbus
> >>>>>    
> >>>>
> >>>> Can platforms have more than one regulator e.g. one regulator per port?
> >>>>
> >>>
> >>> I imagine that yes, platforms could have one regulator per port.
> >>> Regulator consumers bindings impose a <name>-supply property per
> >>> regulator, so, what do you think about :
> >>> vbus0-supply for port#0
> >>> vbus1-supply for port#1
> >>> ...
> >>> vbusN-supply for port#N
> >>>
> >>> And then in probe, allocate 'struct regulator *vbus_supplies' with a
> >>> size corresponding to 'HCS_N_PORTS(ehci->hcs_params) * sizeof(struct
> >>> regulator *)'.
> >>> And loop to get optional regulator vbus0, vbus1,..., vbusN.
> >>> And then enable/disable the corresponding regulator in
> >>> ehci_platform_port_power thanks to portnum.
> >>
> >> Looks fine to me but we need to get Alan's opinion if this is worth the effort.
> >> If there isn't a single platform needing it we could probably do without it
> >> but the DT binding must be scalable to add this feature in the future.
> > 
> > I agree that for now there don't seem to be any platforms requiring
> > more than one regulator, but this should be implemented in a way that
> > could be expanded if necessary.
> > 
> > Anyway, the basic idea is reasonable.  I don't know to what extent
> > people want to power-off their EHCI ports, but if they do then we ought
> > to turn off external regulators at the same time.
> > 
> > Is there a real-life use case for this?
> > 
> > Alan Stern
> > 
> 
> On my setup I have the following:
> 
>                   regulator_____vbus
>   _________________             \
> | EHCI controller |-port0-----[USB connector]
> |_________________|-port1-----X
> 
> So, I have one regulator only for port0. But I could I have one more if 
> port1 was connected. My current regulator could also supplies port1.
> 
> To allocate a vbus_supplies array depending on N_PORTS, I have to move 
> this initialization from probe to ehci_platform_reset, after ehci_setup 
> is done.
> Then, I have to define each regulator id depending on the port number.
> This imposes a binding like
> - portN_vbus-supply : phandle of regulator supplying vbus for port N
> But I don't know if we can describe it like this in dt-bindings ?
> 
> &ehci {
> 	...
> 	port0_vbus-supply = <&vbus_reg>;
> 	port1_vbus-supply = <&vbus_reg>; //Could be another regulator, or not 
> specified if port is not connected.
> 	...
> };
> 
> Is it ok to move vbus_supplies initialization in ehci_platform_reset ?

Yes, it's okay to move the code if you need to.

However, I can not speak on the DT implications.  Someone who knows
more about it should chime in.

Alan Stern

