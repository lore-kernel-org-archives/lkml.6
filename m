Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABA6C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19AE2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="badwPffR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19AE2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeH1XBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:01:52 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33968 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1XBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:01:52 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so4856300ois.1;
        Tue, 28 Aug 2018 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BSxVBb4fQeQXpE5T1xguoNWDwc6IZBEWA58+ov3Lm9A=;
        b=badwPffRDgVHAuV1z3+BAzqMnHrixT3TbyOk0hrUioVP+ftLy5JU8zx5vK402wtC6D
         sauR9IGJaOetRYzKho3+ykRiFWvq4wXsEv15varJN8RoqAFhRmjh8vPHthbQM3tRmU7p
         F9HATT1OoEUeF/FNaLtl6fELKC8pRybt0isQKrkuktQZHSE4GBb6E59eHY6xr9IBxKjs
         oOSnLk442OHT06gFkG/dhG/KdnMBKeevBcBH+LLnc3uzrVApK/gZ7uR5dMAGYSYxVMQo
         lKObPjozYxNxIPLBM7G2KPm18H2ZP2YEIkpAMiVABOP48nTFmc2iV+jIwcqzOvMuWeaa
         lV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BSxVBb4fQeQXpE5T1xguoNWDwc6IZBEWA58+ov3Lm9A=;
        b=tjf2pMq8xOHmuL6J4Mlz5r3ODnT1oHzD1ygKXkJ58J6jg513fLxVwAkLsDhga9Q8eF
         4dAicjitc0i7HgtPaLvD8LBQ6yOWwfJ1NIJc+i+IhtHjZM0OgUGqQcs2o4zXnWhJNzFz
         bgwVpHrFGLshGGKSTeo4HsEBYOkY0W5U58qtJIOPKKFhweTtR00j5yddf4O29ygznkON
         KE8z03SdGSz3G5tRtvEiT8QQ9FfEABuZEC3QydFS01H9KNkLPnq7wQz2L0pU9dg0NBGT
         f6hG6dyBYC75pNrZcyUJsZ+xB9oQ6ht/FtAvTAN+4hBZf574wZWveSI/VKj4PS4Ut+eh
         XQTw==
X-Gm-Message-State: APzg51AdIiWBqEddFzDrEqLMZaY+oQ15SKbRSAZdQdBzZcRuSpA7KWbh
        x1oUpwiGEHpikq3ffZUSV2jqU8MMjOoLoWcI+no=
X-Google-Smtp-Source: ANB0VdZK6qwnSOxk/4fc0toE1trU71arUVETjRpKWhNWW5bfmptyTm9vNdL06dVwnlfgAxKwvdIz0gYQ2QApoj/1LgA=
X-Received: by 2002:aca:d9c5:: with SMTP id q188-v6mr2401189oig.239.1535483330631;
 Tue, 28 Aug 2018 12:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180624153339.13572-1-f.fainelli@gmail.com> <wih4lhrgrfd.fsf@dev-r-vrt-156.mtr.labs.mlnx>
 <20180625091713.GA13442@apalos> <9ce291a4-b40d-81d8-1c1a-c4311e5cc113@gmail.com>
 <20180828083257.GA10872@apalos> <da1a9896-94aa-589c-3fd2-023b1586bb15@gmail.com>
In-Reply-To: <da1a9896-94aa-589c-3fd2-023b1586bb15@gmail.com>
From:   Maxim Uvarov <muvarov@gmail.com>
Date:   Tue, 28 Aug 2018 22:08:38 +0300
Message-ID: <CAJGZr0JaqBt0BdoCAmjnMT9zN8cjBnJKJJGzWrThTjBKtwp-vA@mail.gmail.com>
Subject: Re: [PATCH RFT] net: dsa: Allow configuring CPU port VLANs
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>, petrm@mellanox.com,
        netdev <netdev@vger.kernel.org>, jiri@mellanox.com,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        David Miller <davem@davemloft.net>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=B2=D1=82, 28 =D0=B0=D0=B2=D0=B3. 2018 =D0=B3. =D0=B2 20:00, Florian Fai=
nelli <f.fainelli@gmail.com>:
>
> On 08/28/2018 01:32 AM, Ilias Apalodimas wrote:
> > On Fri, Aug 10, 2018 at 04:58:10PM -0700, Florian Fainelli wrote:
> >> On 06/25/2018 02:17 AM, Ilias Apalodimas wrote:
> >>> On Mon, Jun 25, 2018 at 12:13:10PM +0300, Petr Machata wrote:
> >>>> Florian Fainelli <f.fainelli@gmail.com> writes:
> >>>>
> >>>>>   if (netif_is_bridge_master(vlan->obj.orig_dev))
> >>>>> -         return -EOPNOTSUPP;
> >>>>> +         info.port =3D dp->cpu_dp->index;
> >>>>
> >>>> The condition above will trigger also when a VLAN is added on a memb=
er
> >>>> port, and there's no other port with that VLAN. In that case the VLA=
N
> >>>> comes without the BRIDGE_VLAN_INFO_BRENTRY flag. In mlxsw we have th=
is
> >>>> to get the bridge VLANs:
> >>>>
> >>>>    if (netif_is_bridge_master(orig_dev)) {
> >>>>            [...]
> >>>>            if ((vlan->flags & BRIDGE_VLAN_INFO_BRENTRY) &&
> >>>>            [...]
> >>>>
> >>>> This doesn't appear to be done in DSA unless I'm missing something.
> >>> Petr's right. This will trigger for VLANs added on 'not cpu ports' if=
 the VLAN
> >>> is not already a member.
> >>>
> >>> This command has BRIDGE_VLAN_INFO_BRENTRY set:
> >>> bridge vlan add dev br0 vid 100 pvid untagged self
> >>> I had the same issue on my CPSW RFC and solved it
> >>> exactly the same was as Petr suggested.
> >>
> >> Humm, there must be something obvious I am missing, but the following
> >> don't exactly result in what I would expect after adding a check for
> >> vlan->flags & BRIDGE_VLAN_INFO_BRENTRY:
> >>
> >> brctl addbr br0
> >> echo 1 > /sys/class/net/br0/bridge/vlan_filtering
> >> brctl addif br0 lan1
> >>
> >> #1 results in lan1 being programmed with VID 1, PVID, untagged, but no=
t
> >> the CPU port. I would have sort of expected that the bridge layer woul=
d
> >> also push the configuration to br0/CPU port since this is the default =
VLAN:
> >>
> >> bridge vlan show dev br0
> >> port vlan ids
> >> br0  1 PVID Egress Untagged
> >>
> >> But it does not.
> >>
> >> bridge vlan add vid 2 dev lan1
> >>
> >> #2 same thing, results in only lan1 being programmed with VID 2, tagge=
d
> >> but that is expected because we are creating the VLAN only for the
> >> user-facing port.
> >>
> >> bridge vlan add vid 3 dev br0 self
> >>
> >> #3 results in the CPU port being programmed with VID 3, tagged, again,
> >> this is expected because we are only programming the bridge master/CPU
> >> port here.
> >>
> >> Does #1 also happen for cpsw and mlxsw or do you actually get events
> >> about the bridge's default VLAN configuration? Or does the switch driv=
er
> >> actually need to obtain that at the time the port is enslaved somehow?
> > As long as ports are attached you get the events (one event per attache=
d port
> > iirc)
> > if the event is checked against BRIDGE_VLAN_INFO_BRENTRY, the only way =
to add a
> > VLAN to the cpu port is via 'bridge vlan add vid 3 dev br0 self'
>
> Do we have a guarantee that upon port enslavement, whatever default_pvid
> is configured on the bridge master device also happens to be the port's
> default_pvid settings as well?

I think default pvid is per port thing. I.e. each port can have it's
own pvid (i.e. it will tag with vlan id not tagged incoming packet to
that port),
I did not exactly understand use case. With adding vlan filtering to
cpu port you filter out packets from other vlan groups to cpu port.
This might be useful
only for multicast packes or missing fbd entry on some dsa port. Is
filtering multicast a main problem to solve here?
Linux is missing vlan ingress policy. I.e. filtering (echo 1 >
/sys/br0/vlan_filter) has to be case of 3 policies: secure (default
now), check and fallback. With current secure mode it
might work, but with check mode it will be needed to add all vlans to
cpu port. Btw, on some hardware vlan ingress policies are also per
port, not per bridge.

Best regards,
Maxim.

> --
> Florian



--=20
Best regards,
Maxim Uvarov
