Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A86C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE44214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQjDg9CJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeLZTl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:41:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35934 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbeLZTl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:41:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so16443564wrp.3;
        Wed, 26 Dec 2018 11:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=36pEah6QZLjkR5d3CgHwBrLC0xsY+3u5513RC5sgjtk=;
        b=qQjDg9CJbIbqmA163j6hfoNNjahm83bNUCQu8bmJQeHYao4sNFu50A9bLYBRAFMWeg
         +5xxsUWTbDxcwJZ6NBN+TRd51jXgXXBUO1xv2o7HchALGnjr1DZQXT0doyZWGIjEooOu
         MKetmaQDrA/Uq/6Bb/UmzyirEg0yv33f3G9YwYGAnXyIqVs9uN0/fR/fxsrnmqWkzjmd
         Yu+09AeCytwiv13UTe7H1nqpp2ZILQGz7axEvNukOCDaucJGHPRxylA49lDStnzuv6QH
         SIZtLh83PXOR6VQKDjfG1RDOPOWGbjuyGeu68hAkT+lyx77MDGBKPjoanKAen+wAP7ux
         E6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=36pEah6QZLjkR5d3CgHwBrLC0xsY+3u5513RC5sgjtk=;
        b=enKEOGGYY98jBMuQ+5ENHuydKw9TfmIriCXXgs+QgTs35sq/kHaobNs18R2OIpXust
         EhwqV25ntK4DnLdlOfc7pj+HoqR2w18nAbOA1/u6g1Jm29WZyPA3juJ1TLetMnS2afzn
         lzORKNpfn7EYYykaDmrnsDzS4H2MzzWMVe4wS0DS+ca/kO5wnBWNOfjuvBRmcT/CakSJ
         16sunKDCWdHobq66CqlElnjtNf5HYpJu+9oPTFaSks/hJg8CU0lD+qR19x2fCayq52I3
         VeJ4AeDGOIqIPCWJqGmVdGSFWaCf0hYKLa5h1/RZt3+s+ZxyJJV2Z4r0KHOL6lcwJJbj
         ee+w==
X-Gm-Message-State: AJcUukdwaVyxAU5BBjW6rzlPBoCkYtPAOFhwerLvI5I0ZkKlcRfIQn2n
        CLKlkeAwP1HKOEh3Ro6m/rfVLawD
X-Google-Smtp-Source: ALg8bN55ZQ+eoKsktA80Qr5rAd5gW53HkUyuRTBIE7DtI0cZheZgBlQLpMQuusgi6EydPkm1GK1Z6Q==
X-Received: by 2002:adf:f848:: with SMTP id d8mr20800779wrq.178.1545853314017;
        Wed, 26 Dec 2018 11:41:54 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:6194:598:7f5e:b2e? (p200300EA8BCFE300619405987F5E0B2E.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:6194:598:7f5e:b2e])
        by smtp.googlemail.com with ESMTPSA id l14sm68234853wrp.55.2018.12.26.11.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 11:41:53 -0800 (PST)
Subject: Re: [PATCH] net: dsa: bcm_sf2: Propagate error value from mdio_write
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Aditya Pakki <pakki001@umn.edu>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <20181226182132.76798-1-kjlu@umn.edu>
 <4f6199de-51c4-4446-3ad3-6b036a09a63c@gmail.com>
 <CAK8KejrSvuFF546cSTwN_XWD6N8FxbSCjxCUsqaQ_N6S8nTA5A@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <9d5f9506-fc2f-cf17-1fe5-3b1977e2fdf9@gmail.com>
Date:   Wed, 26 Dec 2018 20:41:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8KejrSvuFF546cSTwN_XWD6N8FxbSCjxCUsqaQ_N6S8nTA5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.12.2018 20:32, Kangjie Lu wrote:
> 
> 
> On Wed, Dec 26, 2018 at 1:13 PM Heiner Kallweit <hkallweit1@gmail.com <mailto:hkallweit1@gmail.com>> wrote:
> 
>     On 26.12.2018 19:21, Kangjie Lu wrote:
>     > Both bcm_sf2_sw_indir_rw and mdiobus_write_nested could fail, so let's
>     > return their error codes upstream.
>     >
>     > Signed-off-by: Kangjie Lu <kjlu@umn.edu <mailto:kjlu@umn.edu>>
>     > ---
>     >  drivers/net/dsa/bcm_sf2.c | 7 +++----
>     >  1 file changed, 3 insertions(+), 4 deletions(-)
>     >
>     > diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
>     > index 2eb68769562c..236815700fba 100644
>     > --- a/drivers/net/dsa/bcm_sf2.c
>     > +++ b/drivers/net/dsa/bcm_sf2.c
>     > @@ -303,11 +303,10 @@ static int bcm_sf2_sw_mdio_write(struct mii_bus *bus, int addr, int regnum,
>     >        * send them to our master MDIO bus controller
>     >        */
>     >       if (addr == BRCM_PSEUDO_PHY_ADDR && priv->indir_phy_mask & BIT(addr))
>     > -             bcm_sf2_sw_indir_rw(priv, 0, addr, regnum, val);
>     > +             return bcm_sf2_sw_indir_rw(priv, 0, addr, regnum, val);
>     This is wrong. Please get familiar with what the function does.
>     And test changes before submitting them!
> 
>  
> bcm_sf2_sw_indir_rw() doesn't return an error code, so we don't propagate its return value but return 0 after it.
> 
> For mdiobus_write_nested(), since it does return an error code, we propagate its error code upstream. 
> 
> Does this sound right to you?
>  
Better. You should test a change before submitting (and better not only compile-test).
And please no HTML mails. Get familiar with the basics of kernel development
before submitting. Read document "SubmittingPatches" and the following for netdev:
https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt
By the way: net-next is closed currently.

> 
> 
>     >       else
>     > -             mdiobus_write_nested(priv->master_mii_bus, addr, regnum, val);
>     > -
>     > -     return 0;
>     > +             return mdiobus_write_nested(priv->master_mii_bus,
>     > +                             addr, regnum, val);
>     >  }
>     > 
>     >  static irqreturn_t bcm_sf2_switch_0_isr(int irq, void *dev_id)
>     >
> 
> 
> 
> -- 
> Kangjie Lu
> Assistant Professor
> Department of Computer Science and Engineering
> University of Minnesota
> Personal homepage <https://www-users.cs.umn.edu/~kjlu>

