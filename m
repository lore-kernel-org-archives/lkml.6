Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ABEECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2EC2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CE1wX3cr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2EC2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJYGkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:40:36 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38686 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYGkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 02:40:36 -0400
Received: by mail-yw1-f66.google.com with SMTP id d126-v6so2759763ywa.5;
        Wed, 24 Oct 2018 15:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R3iifL9R31ocbu8SnJEtZSkw4cBQXPcZsFrOXutGdUg=;
        b=CE1wX3cr4iXPApTzks3Bzp92Lnpe7HRZIn/SU7YkFZz6txYemdYZlTHPnF9d8mqhSh
         BsN1rCTUjIs11IDNv0pDLCZcLYdVxJ2rwa3U8Uv2BcDNPviTDuhSqooR/o4QowhJUY/N
         3Yl79GzrHpAn6ah2rvueeVKO6q3Kynci7tc3U07XF03yQGxi6cb7bU9e7zwwmh0XkB2t
         oAcbYTTJo5NgIZ7m5FyXeR4Ne30hfU1Eq8MdX9EJkX9eD9ipOxi9c5e8LukGEjGsQ3Rz
         2jKDCmWE4YK7xKaGCNk5gaVR19df1TXAP0g6ymb2tmOcL/6Ly7yYJ4cZ/h1lalGsRNab
         lLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=R3iifL9R31ocbu8SnJEtZSkw4cBQXPcZsFrOXutGdUg=;
        b=n4mV2rjWt3dx7hTDYXo1aojtUHkTbmED0NLiN2KBXDRHR1wpJ0aaxjilvwD6BuyAYa
         FpD4JPX9jiYNTs2aObqNZjn03zk9JmL+sj6/q0gpxQe/8AoJnpxhBe8Nh+weAbCVUKkO
         awIIiIUbPQ4sS8EVn3BuAMtktGYqmWaH5o5iamk8uY1okmUZU6L1tfmZIvgywnPWGiIo
         xnN+kazIkj8xG7V/lkUJspAhiiB7spQUcSIKzgPE+r79BX9fLUiC2OqBuOj77NGIg1RW
         UdlAiw4WAFiFF5QVXZD9ykbT5buq/t3HOkFNx5EoDHGOye+jpvx8/51q3oxnf+xPFpvk
         2MJQ==
X-Gm-Message-State: AGRZ1gKs/YPokTDNUdhv5xl/YMrRtQTy9VtzADQIw5rgqQZSjMPKKmM/
        xd1l/kuVNeZjZUNOcB0NqnQznJeHtm0=
X-Google-Smtp-Source: AJdET5cf1P3dZsBsj6+bbzM2NkvW0WlKxB0NUgBYx7ADqNlfisnxEeHRronAHNT2Q8L88NUAhYJVpg==
X-Received: by 2002:a81:2bc6:: with SMTP id r189-v6mr4139478ywr.118.1540419044280;
        Wed, 24 Oct 2018 15:10:44 -0700 (PDT)
Received: from [10.67.49.121] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id x185-v6sm5514497ywd.40.2018.10.24.15.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 15:10:43 -0700 (PDT)
Subject: Re: [PATCH RFC] net: dsa: Make switches VLAN aware when enslaved into
 a bridge
To:     netdev@vger.kernel.org
Cc:     jiri@mellanox.com, petr@mellanox.com, idosch@mellanox.com,
        privat@egil-hjelmeland.no, Woojung.Huh@microchip.com,
        tristram.ha@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
References: <20181024193657.24012-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <c72f8b0d-ea6d-6f33-0719-31420b013f36@gmail.com>
Date:   Wed, 24 Oct 2018 15:10:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181024193657.24012-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18 12:36 PM, Florian Fainelli wrote:
> Commit 2ea7a679ca2a ("net: dsa: Don't add vlans when vlan filtering is
> disabled") changed the behavior of DSA switches when the switch ports
> are enslaved into the bridge and only pushed the VLAN configuration down
> to the switch if the bridge is configured with VLAN filtering enabled.
> 
> This is unfortunately wrong, because what vlan_filtering configures is a
> policy on the acceptance of VLAN tagged frames with an unknown VID.
> 
> vlan_filtering=0 means a frame with a VLAN tag that is not part of the
> VLAN table should be allowed to ingress the switch, and vlan_fltering=1
> would reject that frame.
> 
> Fixes: 2ea7a679ca2a ("net: dsa: Don't add vlans when vlan filtering is disabled")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Andrew,
> 
> I checked with Jiri and he confirmed that our interpretention of
> vlan_filtering in DSA was incorrect and that it does denote whether the
> switch should be doing VID ingress policy checking.
> 
> You mentioned in the commit message some problems without being too
> specific about them which is why I am putting the same checks in
> mv88e6xxx in order not to break your use cases. Let me know if you want
> to drop that hunk entirely.
> 
> Thanks!
> 
>  drivers/net/dsa/mv88e6xxx/chip.c |  7 ++++++-
>  net/dsa/port.c                   | 10 ++--------
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 8da3d39e3218..df411e776911 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -1684,13 +1684,14 @@ static int _mv88e6xxx_port_vlan_add(struct mv88e6xxx_chip *chip, int port,
>  static void mv88e6xxx_port_vlan_add(struct dsa_switch *ds, int port,
>  				    const struct switchdev_obj_port_vlan *vlan)
>  {
> +	struct dsa_port *dp = &ds->ports[i];

This should obviously be port instead of i, but I would still appreciate
a review, thanks!
-- 
Florian
