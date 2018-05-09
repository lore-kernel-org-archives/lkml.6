Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934747AbeEIMIL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:08:11 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40063 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeEIMIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:08:10 -0400
X-Google-Smtp-Source: AB8JxZqcWfYYnAriCz8dYk1PvYyMN8zjefSA6pP/ZkvVXt1X+7kZl42IW6ykuXFeXRxt46lULjVISg==
Date: Wed, 9 May 2018 08:08:06 -0400
From: Vivek Unune <npcomplete13@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: hauke@hauke-m.de, zajec5@gmail.com, jonmason@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: BCM5301X: Make usb3 phy use mdio phy driver
Message-ID: <20180509120806.7a37jpcqcby7ryku@osboxes>
References: <20180315135647.48456-1-npcomplete13@gmail.com>
 <20180409223153.41893-1-npcomplete13@gmail.com>
 <68519de5-9a47-9cb5-064c-dc4703aaa508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68519de5-9a47-9cb5-064c-dc4703aaa508@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 03:31:17PM -0700, Florian Fainelli wrote:
> On 04/09/2018 03:31 PM, Vivek Unune wrote:
> > Currently, usb3 phy in bcm5301x.dtsi uses platform driver which
> > requires register range "ccb-mii" <0x18003000 0x1000>. This range
> > overlaps with mdio cmd and param registers (<0x18003000 0x8>).
> > Essentially, the platform driver partly acts like a mdio bus
> > driver, hence to use of this register range.
> > 
> > In some Northstar devices like Linksys EA9500, secondary switch
> > is connected via external mdio. The only way to access and
> > configure the external switch is via mdio bus. When we enable the
> > mdio bus in it's current state, the mdio bus and any child buses
> > fail to register because of the register range overlap.
> > 
> > On Northstar, the usb3 phy is connected at address 0x10 on the
> > internal mdio bus. This change moves the usb3_phy node and makes
> > it a child node of internal mdio bus.
> > 
> > Thanks to Rafał Miłecki's commit af850e14a7ae
> > ("phy: bcm-ns-usb3: add MDIO driver using proper bus layer") the
> > same usb3 platform driver can now act as usb3 phy mdio driver.
> > 
> > Tested on Linksys Panamera (EA9500)
> > 
> > Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
> > ---
> > v2: Disabled usb3_phy by default, then enabled in dts where
> >     necessary
> 
> Rafal, Hauke, this looks good to me, can you review? Thanks
> -- 
> Florian

Rafał, Hauke,

I'm sure you are super busy :) Just want to bring this to your
attention. 

Thanks,

Vivek
