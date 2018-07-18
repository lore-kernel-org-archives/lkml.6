Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4100CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52562084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N6droNBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52562084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbeGRUbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:31:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40262 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbeGRUbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:31:35 -0400
Received: by mail-wm0-f66.google.com with SMTP id z13-v6so4031853wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 12:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ik88jvua83lJaJuyOka0SAqBIas4Dz+tNkfHIbxrunI=;
        b=N6droNBxFgGTU0p7P0SuxhNyIu5JwOOJTSCqWE2cAHIbyBNJgQUmdBHJqVpNghrwYP
         SVy4dtcm9PnS1/D+Z008mBcDvSV/PT9Af3KVA9bPqczgk2PWMM96b0S/ZQA+zLxnf146
         Qt6H1jPFo9JpNXbddvAmT+5hY5wVvTTTGg0HKEry7hv6axMc0j59IzzFg0WiHb9NRVdJ
         Ltvqo4Z2Ly/CpwY2X4FXUxOsMtJa79YMbMCuGc8gBfgTib5vldUMPSPiWPhtgAWgDC6L
         TGdvBP+9kcjY6NOmUsHn5smaFjecXfDTdD95PjXN0gdJc5e3RVXHY6AHxgQEvLV1JnPD
         njAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ik88jvua83lJaJuyOka0SAqBIas4Dz+tNkfHIbxrunI=;
        b=Jc4O/R8cXxFkjXIGy6adzhlhyu28o5770zVB3oMvvq/MhMPoplG1vlM3sTvp13bCRs
         enSynF9xOrpLHjfw3rZn0nF8iaqFmUBvkwNM6NaaBtRiidJlnL8KqhauXMwCGzLx03vo
         qLY3lKGeM4jN2AtoJeDNmcv7GmEgyBg3DPPh9HI+Yayf1Dho2Oi1Mh9osowuTAEztrz5
         WZ9Zo36riMaB5l0f6eaQNB7Zt83CKF6fVSp950taxrpqJmd1qY6/L63afo6iv9lA4WsI
         rSNKJY2Hf8yJadroEJDENYy8DyykJtLFCIHsxuN+6mZ5Kw88DQEjZEvuKX7cSGCD9K69
         FhvQ==
X-Gm-Message-State: AOUpUlGK/EPsdXVpk5xDJbTSSHdONI3wTR9A3UiPwb/jOozJDmalLdYY
        86bCZvH0t5ImiUcEybLYFuX14id1k6UJvILsahbmWY4U
X-Google-Smtp-Source: AAOMgpc3p6XxMFxsTsY3Wj5909jUIvcUFNR+OVIZCtcEmcjI/wCaH+hSRpHlXKaV1JIzBvcrysG0T9s+ov7nHC/qhvc=
X-Received: by 2002:a1c:9947:: with SMTP id b68-v6mr2311048wme.159.1531943528297;
 Wed, 18 Jul 2018 12:52:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:f703:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 12:51:47
 -0700 (PDT)
In-Reply-To: <20180718184936.16037-1-jarod@redhat.com>
References: <20180718184936.16037-1-jarod@redhat.com>
From:   =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= 
        <maheshb@google.com>
Date:   Wed, 18 Jul 2018 12:51:47 -0700
Message-ID: <CAF2d9jgCxvXaGo3E0hSc7i78vXStXM=BuhHFDjs817b19yT0WA@mail.gmail.com>
Subject: Re: [PATCH net] bonding: set default miimon value for non-arp modes
 if not set
To:     Jarod Wilson <jarod@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S . Miller" <davem@davemloft.net>,
        linux-netdev <netdev@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 11:49 AM, Jarod Wilson <jarod@redhat.com> wrote:
> For some time now, if you load the bonding driver and configure bond
> parameters via sysfs using minimal config options, such as specifying
> nothing but the mode, relying on defaults for everything else, modes
> that cannot use arp monitoring (802.3ad, balance-tlb, balance-alb) all
> wind up with both arp_interval=0 (as it should be) and miimon=0, which
> means the miimon monitor thread never actually runs. This is particularly
> problematic for 802.3ad.
>
> For example, from an LNST recipe I've set up:
>
> $ modprobe bonding max_bonds=0"
> $ echo "+t_bond0" > /sys/class/net/bonding_masters"
> $ ip link set t_bond0 down"
> $ echo "802.3ad" > /sys/class/net/t_bond0/bonding/mode"
> $ ip link set ens1f1 down"
> $ echo "+ens1f1" > /sys/class/net/t_bond0/bonding/slaves"
> $ ip link set ens1f0 down"
> $ echo "+ens1f0" > /sys/class/net/t_bond0/bonding/slaves"
> $ ethtool -i t_bond0"
> $ ip link set ens1f1 up"
> $ ip link set ens1f0 up"
> $ ip link set t_bond0 up"
> $ ip addr add 192.168.9.1/24 dev t_bond0"
> $ ip addr add 2002::1/64 dev t_bond0"
>
> This bond comes up okay, but things look slightly suspect in
> /proc/net/bonding/t_bond0 output:
>
> $ grep -i mii /proc/net/bonding/t_bond0
> MII Status: up
> MII Polling Interval (ms): 0
> MII Status: up
> MII Status: up
>
This doesn't seem correct since the MII interval set is 0. It should
set to 100 by default for this mode. This may be the side effect of
brining up the bond with default more (balance-rr) and then bringing
bond-down before configuring it. You can probably get away by just not
bringing down the bond (step 'set ip link bond0 down) in your recipe
above. But irrespective of that step, this mode  needs miimon and
should have been set correctly.


> Now, pull a cable on one of the ports in the bond, then reconnect it, and
> you'll see:
>
> Slave Interface: ens1f0
> MII Status: down
> Speed: 1000 Mbps
> Duplex: full
>
> I believe this became a major issue as of commit 4d2c0cda0744, which for
> 802.3ad bonds, sets slave->link = BOND_LINK_DOWN, with a comment about
> relying on link monitoring via miimon to set it correctly, but since the
> miimon work queue never runs, the link just stays marked down.
>
> If we simply tweak bond_option_mode_set() slightly, we can check for the
> non-arp modes having no miimon value set, and insert BOND_DEFAULT_MIIMON,
> which gets things back in full working order. This problem exists as far
> back as 4.14, and might be worth fixing in all stable trees since, though
> the work-around is to simply specify an miimon value yourself.
>
> Reported-by: Bob Ball <ball@umich.edu>
> CC: Jay Vosburgh <j.vosburgh@gmail.com>
> CC: Veaceslav Falico <vfalico@gmail.com>
> CC: Andy Gospodarek <andy@greyhouse.net>
> CC: Mahesh Bandewar <maheshb@google.com>
> CC: David S. Miller <davem@davemloft.net>
> CC: netdev@vger.kernel.org
> CC: stable@vger.kernel.org
> Signed-off-by: Jarod Wilson <jarod@redhat.com>
Acked-by: Mahesh Bandewar <maheshb@google.com>
> ---
>  drivers/net/bonding/bond_options.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index 98663c50ded0..4d5d01cb8141 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -743,15 +743,20 @@ const struct bond_option *bond_opt_get(unsigned int option)
>  static int bond_option_mode_set(struct bonding *bond,
>                                 const struct bond_opt_value *newval)
>  {
> -       if (!bond_mode_uses_arp(newval->value) && bond->params.arp_interval) {
> -               netdev_dbg(bond->dev, "%s mode is incompatible with arp monitoring, start mii monitoring\n",
> -                          newval->string);
> -               /* disable arp monitoring */
> -               bond->params.arp_interval = 0;
> -               /* set miimon to default value */
> -               bond->params.miimon = BOND_DEFAULT_MIIMON;
> -               netdev_dbg(bond->dev, "Setting MII monitoring interval to %d\n",
> -                          bond->params.miimon);
> +       if (!bond_mode_uses_arp(newval->value)) {
> +               if (bond->params.arp_interval) {
> +                       netdev_dbg(bond->dev, "%s mode is incompatible with arp monitoring, start mii monitoring\n",
> +                                  newval->string);
> +                       /* disable arp monitoring */
> +                       bond->params.arp_interval = 0;
> +               }
> +
> +               if (!bond->params.miimon) {
> +                       /* set miimon to default value */
> +                       bond->params.miimon = BOND_DEFAULT_MIIMON;
> +                       netdev_dbg(bond->dev, "Setting MII monitoring interval to %d\n",
> +                                  bond->params.miimon);
> +               }
>         }
>
>         if (newval->value == BOND_MODE_ALB)
> --
> 2.16.1
>
