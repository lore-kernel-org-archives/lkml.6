Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AC2C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878DF2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlPSkNUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878DF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeH2LJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:09:50 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37164 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbeH2LJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:09:49 -0400
Received: by mail-oi0-f66.google.com with SMTP id p84-v6so7414993oic.4;
        Wed, 29 Aug 2018 00:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=knHWNLuHiAiY6CfjrIZbRufy6MlYSDYklcqFTdjsHHA=;
        b=AlPSkNUKp0EyIANfMD8UY4bQNzsRnXGf7gCmCJAr7mFBY+9vGowC+90YoTiuBUJpuj
         fBO9B8+/K6yy4CdDazPGMTCJ1I4IkHALfW9ouhNfIYPH0ZMxLs79ILP50+C7dYuqCHFr
         kPQYs3UI0vV9+ceB59qgP6W9h55iMSeZK8ntXf6IXz3vs47SBXxpVQtV+lysCOSpMdcI
         RA4Es4QOGJaqmklSDPscp48sASJqBHAUdX+xF7fz0f6GbKamPhLWUUa+mBB+/zSJHk2s
         7C2cn0HRJvsBnikIqSUAk5A4NyRQzzyaP+eMABS0omjq0RNAUytctqnEw6ZmP0F5oof5
         933Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=knHWNLuHiAiY6CfjrIZbRufy6MlYSDYklcqFTdjsHHA=;
        b=TYrZDLV51qywWZXsKiK9dBmIkJWNztocsMsrKxCvnkYTuqJ9enfW5jnMrxGU9qA7x8
         SSpKAz3xTypzrodks1iLTMlUq/8yft5JzUUWqI8iRFrXZIXsYxB6QuIeHLSDxIXyEiQr
         Y3qcqxYVue78b8pero9LrsT1Pzxmb3SFDK8VoII7fV4YgQq38Qa5NmO8kLiM6kTJfEAF
         NxV+g1lJMmW2AjRpXv/AW1ALgiD70I3WMelFw0FZLEJKIc3TooK7suHs2wZqrdSqrVVn
         Zf8m3H95b78s7sgS64ZnUXfTCNEK6NyxRwdbahWxKdY5ae6fhCBFXdfoz+Znqcy3/qI7
         g7oA==
X-Gm-Message-State: APzg51BaU2GrOzTHCLA/xP+Pk2eyX18FTgOBRsFMwfQDCn0r+UbBdngC
        ww4tIX2yBXRCLfezEQBjBxUYvp0MhmiT/oZWtWE=
X-Google-Smtp-Source: ANB0VdZNDW4yo8+nyMntOoo36YcWDRKpA9lHVVWkDDkcuTezITuBGahF0xqgu8iMsUIwi8hNMKq+aXPCeB6ishuyiVs=
X-Received: by 2002:aca:5652:: with SMTP id k79-v6mr1678234oib.296.1535526861367;
 Wed, 29 Aug 2018 00:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180624153339.13572-1-f.fainelli@gmail.com> <wih4lhrgrfd.fsf@dev-r-vrt-156.mtr.labs.mlnx>
 <20180625091713.GA13442@apalos> <9ce291a4-b40d-81d8-1c1a-c4311e5cc113@gmail.com>
 <20180828083257.GA10872@apalos> <da1a9896-94aa-589c-3fd2-023b1586bb15@gmail.com>
 <CAJGZr0JaqBt0BdoCAmjnMT9zN8cjBnJKJJGzWrThTjBKtwp-vA@mail.gmail.com> <25821da3-b923-485f-0991-e1dc943aefec@gmail.com>
In-Reply-To: <25821da3-b923-485f-0991-e1dc943aefec@gmail.com>
From:   Maxim Uvarov <muvarov@gmail.com>
Date:   Wed, 29 Aug 2018 10:14:10 +0300
Message-ID: <CAJGZr0+YJrkjD5jz2cjySZAvgict1f7EeqhVQV6_M0HEB5Ddkw@mail.gmail.com>
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

=D0=B2=D1=82, 28 =D0=B0=D0=B2=D0=B3. 2018 =D0=B3. =D0=B2 22:17, Florian Fai=
nelli <f.fainelli@gmail.com>:
>
> On 08/28/2018 12:08 PM, Maxim Uvarov wrote:
> > =D0=B2=D1=82, 28 =D0=B0=D0=B2=D0=B3. 2018 =D0=B3. =D0=B2 20:00, Florian=
 Fainelli <f.fainelli@gmail.com>:
> >>
> >> On 08/28/2018 01:32 AM, Ilias Apalodimas wrote:
> >>> On Fri, Aug 10, 2018 at 04:58:10PM -0700, Florian Fainelli wrote:
> >>>> On 06/25/2018 02:17 AM, Ilias Apalodimas wrote:
> >>>>> On Mon, Jun 25, 2018 at 12:13:10PM +0300, Petr Machata wrote:
> >>>>>> Florian Fainelli <f.fainelli@gmail.com> writes:
> >>>>>>
> >>>>>>>   if (netif_is_bridge_master(vlan->obj.orig_dev))
> >>>>>>> -         return -EOPNOTSUPP;
> >>>>>>> +         info.port =3D dp->cpu_dp->index;
> >>>>>>
> >>>>>> The condition above will trigger also when a VLAN is added on a me=
mber
> >>>>>> port, and there's no other port with that VLAN. In that case the V=
LAN
> >>>>>> comes without the BRIDGE_VLAN_INFO_BRENTRY flag. In mlxsw we have =
this
> >>>>>> to get the bridge VLANs:
> >>>>>>
> >>>>>>    if (netif_is_bridge_master(orig_dev)) {
> >>>>>>            [...]
> >>>>>>            if ((vlan->flags & BRIDGE_VLAN_INFO_BRENTRY) &&
> >>>>>>            [...]
> >>>>>>
> >>>>>> This doesn't appear to be done in DSA unless I'm missing something=
.
> >>>>> Petr's right. This will trigger for VLANs added on 'not cpu ports' =
if the VLAN
> >>>>> is not already a member.
> >>>>>
> >>>>> This command has BRIDGE_VLAN_INFO_BRENTRY set:
> >>>>> bridge vlan add dev br0 vid 100 pvid untagged self
> >>>>> I had the same issue on my CPSW RFC and solved it
> >>>>> exactly the same was as Petr suggested.
> >>>>
> >>>> Humm, there must be something obvious I am missing, but the followin=
g
> >>>> don't exactly result in what I would expect after adding a check for
> >>>> vlan->flags & BRIDGE_VLAN_INFO_BRENTRY:
> >>>>
> >>>> brctl addbr br0
> >>>> echo 1 > /sys/class/net/br0/bridge/vlan_filtering
> >>>> brctl addif br0 lan1
> >>>>
> >>>> #1 results in lan1 being programmed with VID 1, PVID, untagged, but =
not
> >>>> the CPU port. I would have sort of expected that the bridge layer wo=
uld
> >>>> also push the configuration to br0/CPU port since this is the defaul=
t VLAN:
> >>>>
> >>>> bridge vlan show dev br0
> >>>> port vlan ids
> >>>> br0  1 PVID Egress Untagged
> >>>>
> >>>> But it does not.
> >>>>
> >>>> bridge vlan add vid 2 dev lan1
> >>>>
> >>>> #2 same thing, results in only lan1 being programmed with VID 2, tag=
ged
> >>>> but that is expected because we are creating the VLAN only for the
> >>>> user-facing port.
> >>>>
> >>>> bridge vlan add vid 3 dev br0 self
> >>>>
> >>>> #3 results in the CPU port being programmed with VID 3, tagged, agai=
n,
> >>>> this is expected because we are only programming the bridge master/C=
PU
> >>>> port here.
> >>>>
> >>>> Does #1 also happen for cpsw and mlxsw or do you actually get events
> >>>> about the bridge's default VLAN configuration? Or does the switch dr=
iver
> >>>> actually need to obtain that at the time the port is enslaved someho=
w?
> >>> As long as ports are attached you get the events (one event per attac=
hed port
> >>> iirc)
> >>> if the event is checked against BRIDGE_VLAN_INFO_BRENTRY, the only wa=
y to add a
> >>> VLAN to the cpu port is via 'bridge vlan add vid 3 dev br0 self'
> >>
> >> Do we have a guarantee that upon port enslavement, whatever default_pv=
id
> >> is configured on the bridge master device also happens to be the port'=
s
> >> default_pvid settings as well?
> >
> > I think default pvid is per port thing. I.e. each port can have it's
> > own pvid (i.e. it will tag with vlan id not tagged incoming packet to
> > that port),
>
> We are talking about the bridge master device's default_pvid which can
> be set prior to any port being enslaved into the bridge. As of today, if
> you enslave a port of a switch into a bridge, you need to properly
> configure the CPU/management port as well otherwise things just wont' be
> working. At the time we enslave the first port into the bridge, there is
> no notification AFAICT that is generated to tell us about what the
> bridge master device's default_pvid is.
>
> > I did not exactly understand use case. With adding vlan filtering to
> > cpu port you filter out packets from other vlan groups to cpu port.
> > This might be useful
> > only for multicast packes or missing fbd entry on some dsa port. Is
> > filtering multicast a main problem to solve here?
> > Linux is missing vlan ingress policy. I.e. filtering (echo 1 >
> > /sys/br0/vlan_filter) has to be case of 3 policies: secure (default
> > now), check and fallback. With current secure mode it
> > might work, but with check mode it will be needed to add all vlans to
> > cpu port. Btw, on some hardware vlan ingress policies are also per
> > port, not per bridge.
>
> The general use case is that the CPU port on switches that have such a
> thing is just a normal port on which you should be able to configure
> exactly the VLAN membership and attributes.
>

that has to be good feature to add.

> With DSA switches today, we cannot do that, because there is no network
> interface exposed for the CPU port (and there should not be one), so
> when you target the bridge master device, e.g: br0, we can generate
> events towards the switch driver that map to the CPU port.
>
> There are many reasons for trying to do that, if we don't support such a
> thing, then we need to have the CPU port be part of all VLAN IDs that
> get added to ports, as a tagged member (because if untagged, you can't
> differentiate traffic anymore).
>
> Regarding your suggestion, we could certainly change vlan_filtering to
> take several values:
>
> 0: disabled
> 1: secure
> 2: check
>
> Or something like that.

I think that will work.

Maxim.

> --
> Florian



--=20
Best regards,
Maxim Uvarov
