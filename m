Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A220C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BEF2243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GjhAhuFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BEF2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbeKMG15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:27:57 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41774 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeKMG15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:27:57 -0500
Received: by mail-oi1-f194.google.com with SMTP id g188-v6so8320972oif.8;
        Mon, 12 Nov 2018 12:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ckjSFKg/lh0WeB/cGKjk8cu9IdidiLk1AKv7r+ToooE=;
        b=GjhAhuFFeJjhzqSYiDVlmJWMjCpAtMJTj2/AM+W4QU10a6AMJpcaJLCZmJlkHHYlrq
         j4XVp6fBFuyN4skEW5MJnIyzJx3E2B6e0fiF//dlF+koW3CL/Oa2zKWW6rWRsRoWLvAp
         Ienf3xDaU/L7Y9W1B6vOBJFawBk6GK69Oy6KpuQxFMFPgL7vLKxiN2+ie4wDq3JHPH4Y
         RFtKc42m6rB71xdRLjkVxyEamBkxkO8Up71DEk1IrASnZiaX/T06Z+NGFAWAi7sj9lOQ
         ODFTFutS/BlU7A2yG2nLpA71wNAsGWwj1CyJTF5qqS3UhHSCLbM/g5hGnK9oK2Ybt3lD
         RnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ckjSFKg/lh0WeB/cGKjk8cu9IdidiLk1AKv7r+ToooE=;
        b=OdtRlM1svTAhLKAjIeeriTE2G9m+MjRdcI1dd2nIj4pJRhY1WRVzF1Jeq8FMpc9N63
         6qiYKLQPZzYrDlL/fu3gcjnNcStYn8ZYCye5KBtIx9ws8xFcH/A1nUe4PeB4nlwnbFO4
         mPE2B8rWLebHgeXtOUAM9VQAI1dU+F/ZxfAvnFJ+iP6PVg/13twez6NrXcbQaA8ZGJgX
         PgHv+TE8qB0gkAu2seUeNH9WYzB5F/BDb95f7bg3T1t5SmIwKyCKPqiWAb13jxZvmH1Q
         SgZ7K4VMQt7YvTp+nzR7Sd5mJOGoza0elgTOgHx8GedUfqawHMDNif1iFxzb5hA0C9yX
         MSlw==
X-Gm-Message-State: AGRZ1gITFk0K6xCcCrRr181i5xQfNY//bPlhzSr1CAHLEfMRpeeQEp78
        9sTUoc+DSStW938AkrhJu912EKUJcShn2bQ+rdQ=
X-Google-Smtp-Source: AJdET5e9Vp3YELgo8E7HX6JCXxXTRDo2+dvE9DNJTN+qk6ZzGQQBSDYAD6Ir8pOVpez2ZganwtBrTKbKa4ZVcO3snE0=
X-Received: by 2002:aca:6c87:: with SMTP id h129-v6mr1482554oic.140.1542054785235;
 Mon, 12 Nov 2018 12:33:05 -0800 (PST)
MIME-Version: 1.0
References: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
 <fd9674b3-4033-95c6-a93e-10c8b5ba2e6a@gmail.com> <20181109201307.GV5259@lunn.ch>
 <44b503b8-9f2a-50ac-c4c9-d25258d98ef5@gmail.com> <4330cb5b-b1a5-5004-af51-39199943639d@gmail.com>
 <c067d321-c69e-706d-304a-04e1e477b47c@gmail.com>
In-Reply-To: <c067d321-c69e-706d-304a-04e1e477b47c@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 12 Nov 2018 21:32:54 +0100
Message-ID: <CAFBinCCmNYGp8kzy45ojjr27tEaPVs-QwMsLRrfXHCvw_taDOw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] net: phy: replace PHY_HAS_INTERRUPT with
 a check for config_intr and ack_interrupt
To:     hkallweit1@gmail.com
Cc:     f.fainelli@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org,
        richardcochran@gmail.com, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, khilman@baylibre.com,
        carlo@caione.org, linux-amlogic@lists.infradead.org,
        davem@davemloft.net, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiner,

On Fri, Nov 9, 2018 at 9:56 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 09.11.2018 21:33, Florian Fainelli wrote:
> > On 11/9/18 12:22 PM, Heiner Kallweit wrote:
> >> On 09.11.2018 21:13, Andrew Lunn wrote:
> >>> Hi Heiner
> >>>
> >>>> +static bool phy_drv_supports_irq(struct phy_driver *phydrv)
> >>>> +{
> >>>> +  return phydrv->config_intr || phydrv->ack_interrupt;
> >>>> +}
> >>>
> >>> Should this be && not || ? I thought both needed to be provided for
> >>> interrupts to work.
> >>>
> >>>        Andrew
> >>>
> >> I've seen at least one driver which configures interrupts in
> >> config_init and doesn't define a config_intr callback
> >> (ack_interrupt callback is there)
> >
> > That driver should probably be fixed, while it most likely does not make
> > any significant difference during probe/connect, since config_init() and
> > config_intr() are virtually happening at the same time, this is not
> > necessarily true when disconnecting from the PHY where we really want
> > config_intr() to effectively disable the interrupts and not leaving
> > something enabled that would now become unmaskable, because no more
> > driver attached.
> >
> Found the driver: It's the IP101A/G in icplus.c
> It should be easy to fix the behavior and move the interrupt config
> to a config_intr callback. But the last real changes to the driver
> have been done 6 years ago, so I'm not sure there's anybody out
> there who can test.
if you want I can take care of the IP101A/G code.
I have at least one board with an IP101A/G (PHY ID: 0x02430c54,
according to the schematics it's an IP101GR-GP) where the interrupt is
routed to the SoC.

please let me know whether you'd like to work on it or if I should
give it a try.


Regards
Martin
