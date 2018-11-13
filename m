Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C28C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2263820896
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejuX9FDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2263820896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbeKNHyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 02:54:32 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37722 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeKNHyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 02:54:31 -0500
Received: by mail-ua1-f66.google.com with SMTP id u19so4932231uae.4;
        Tue, 13 Nov 2018 13:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vjJHPxd2xEFo+/+ErU1OFCTFpKQcDZm/g53cmtbx70g=;
        b=ejuX9FDFA47NZ/zU9LERpEUsdomplT/za47LCrqOuox9cLXet6xtYB3X6mXtYbGNi1
         EfQsE2x53q8NH/7xCFf21vvMBzu3bHHi+c1HEob2Zggx3yONWcE4U5PwFWIew//YSLTA
         gV9+vwjxLYZteSdDqT3Il1r9ya0pP8A2AMFNyG7NDeli74E8Tbei8eOAo9/iuxGRD5mz
         oeRSlkJzTGP7BzJLj4qs9ZVUFA0HMLGXIx+TsDEOaDYc3rlozah+5yLOdSB7GodUBbdO
         Le9P73FmlbVroIfH0y7FxCNnc+ZW5sznIPkWyPzHzlOo7rnsumRsh8B0/zFSEGzGbWRv
         9f3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjJHPxd2xEFo+/+ErU1OFCTFpKQcDZm/g53cmtbx70g=;
        b=AKA43QT5vskVA/AbJHYnNxNRcjDuSlVgqR1WvIl53Vw5eeieUV3GqvFwE70gSGt0jB
         F24Ql+H5S/B95/gNA78PE1j1qh3+JiUucGsMXGZVJcs2CzKjFDqPERQtYQV/lRoaxfOM
         IiSR22sK7VBtXxHGWckJsQvsf52jr2RKGZSfn/BVUIRRvDVyxWIe3y6upeHkQFtPbxQH
         UM+9iMbTYN8QfWVMpcJ4xMuc2IYBoH2ED4xQahZX9gh+2P04A86xAv1PRj08TaNxm7dW
         h/wRpFALq5jDLsvTmn39oMBcrK7WYj/AhIDnLRKQBHZaanKj//KpMCVWZyIyazZV8HNV
         T42A==
X-Gm-Message-State: AGRZ1gIUMM9EUUB6nXEqdGvVX2djWI0XiWlvLr2tNAdA+z44Gl9MllcV
        PZXnx9FjqhbcB8PN9oNUJIDJRxfSgjNZ6/ZFYGo=
X-Google-Smtp-Source: AJdET5cSibKtPvPuS+BaaoyeUaoAYaRB1WE6xTnSShz3uUuLOlldIRCuxGpj+3inW1X7Z8HZkwcTplPgbHPvaO42pOY=
X-Received: by 2002:a9f:3703:: with SMTP id z3mr3356958uad.86.1542146062611;
 Tue, 13 Nov 2018 13:54:22 -0800 (PST)
MIME-Version: 1.0
References: <Pine.LNX.4.44L0.1811071124260.1542-100000@iolanthe.rowland.org>
 <16a80878-58f7-1584-058e-0e0e49da61cb@gmail.com> <45134862-4b72-be72-533c-942c2bf70400@broadcom.com>
 <c551a2e2-c494-04d3-53cf-f027b02906ed@gmail.com> <20181112174532.GA14682@bogus>
In-Reply-To: <20181112174532.GA14682@bogus>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Tue, 13 Nov 2018 16:54:18 -0500
Message-ID: <CAOGqxeW93_O6TkSPycCPiAUSWa4ep2PBuBNz3UhUXEHa+tOXag@mail.gmail.com>
Subject: Re: [PATCH V3 4/6] usb: ohci-platform: Add support for Broadcom STB SoC's
To:     Rob Herring <robh@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, al.cooper@broadcom.com,
        Alan Stern <stern@rowland.harvard.edu>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Alban Bedel <albeu@free.fr>, Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        chunfeng yun <chunfeng.yun@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        DTML <devicetree@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        USB list <linux-usb@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Roger Quadros <rogerq@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 6:37 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 07, 2018 at 10:11:59AM -0800, Florian Fainelli wrote:
> > On 11/7/2018 9:40 AM, Al Cooper wrote:
> > > On 11/7/18 12:29 PM, Florian Fainelli wrote:
> > >> On 11/7/18 8:27 AM, Alan Stern wrote:
> > >>> On Wed, 7 Nov 2018, Al Cooper wrote:
> > >>>
> > >>>> On 11/7/18 10:23 AM, Alan Stern wrote:
> > >>>>> On Tue, 6 Nov 2018, Florian Fainelli wrote:
> > >>>>>
> > >>>>>> On 11/6/18 1:40 PM, Al Cooper wrote:
> > >>>>>>> On 11/6/18 11:08 AM, Alan Stern wrote:
> > >>>>>>>> On Mon, 5 Nov 2018, Al Cooper wrote:
> > >>>>>>>>
> > >>>>>>>>> Add support for Broadcom STB SoC's to the ohci platform driver.
> > >>>>>>>>>
> > >>>>>>>>> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > >>>>>>>>> ---
> > >>>>>>>>
> > >>>>>>>>> @@ -177,6 +189,8 @@ static int ohci_platform_probe(struct
> > >>>>>>>>> platform_device *dev)
> > >>>>>>>>>             ohci->flags |= OHCI_QUIRK_FRAME_NO;
> > >>>>>>>>>         if (pdata->num_ports)
> > >>>>>>>>>             ohci->num_ports = pdata->num_ports;
> > >>>>>>>>> +    if (pdata->suspend_without_phy_exit)
> > >>>>>>>>> +        hcd->suspend_without_phy_exit = 1;
> > >>>>>>>>
> > >>>>>>>> Sorry if I missed this in the earlier discussions...  Is there any
> > >>>>>>>> possibility of adding a DT binding that could express this
> > >>>>>>>> requirement,
> > >>>>>>>> instead of putting it in the platform data?
> > >>>>>>>>
> > >>>>>>>> Alan Stern
> > >>>>>>>>
> > >>>>>>>
> > >>>>>>> Alan,
> > >>>>>>>
> > >>>>>>> That was my original approach but internal review suggested that
> > >>>>>>> I use
> > >>>>>>> pdata instead. Below is my original patch for:
> > >>>>>>
> > >>>>>> And the reason for that suggestion was really because it was
> > >>>>>> percevied
> > >>>>>> as encoding a driver behavior as a Device Tree property as opposed to
> > >>>>>> describing something that was inherently and strictly a hardware
> > >>>>>> behavior (therefore suitable for Device Tree).
> > >>>>>
> > >>>>> Right.  The best way to approach this problem is to identify and
> > >>>>> characterize the hardware behavior which makes this override
> > >>>>> necessary.
> > >>>>> Then _that_ can be added to DT, since it will be a property of the
> > >>>>> hardware rather than of the driver.
> > >>>>>
> > >>>>>>> Add the ability to skip calling the PHY's exit routine on suspend
> > >>>>>>> and the PHY's init routine on resume. This is to handle a USB PHY
> > >>>>>>> that should have it's power_off function called on suspend but
> > >>>>>>> cannot
> > >>>>>>> have it's exit function called because on exit it will disable the
> > >>>>>>> PHY to the point where register accesses to the Host Controllers
> > >>>>>>> using the PHY will be disabled and the host drivers will crash.
> > >>>>>
> > >>>>> What's special about this PHY?  Why does the exit function mess the
> > >>>>> PHY
> > >>>>> up?  Or to put it another way, why doesn't the exit function mess up
> > >>>>> other PHYs in the same way?
> > >>>>>
> > >>>>> For that matter, can we change the code so that suspend doesn't call
> > >>>>> the exit function for _any_ PHY?  Will just calling the power_off
> > >>>>> function be good enough?  If not, then why not?
> > >>>>>
> > >>>>> Alan Stern
> > >>>>>
> > >>>>
> > >>>> In our USB hardware the USB PHY supplies a clock for the EHCI/OHCI and
> > >>>> XHCI host controllers and if the PHY is totally shut down the EHCI,
> > >>>> OHCI
> > >>>> and XHCI registers will cause an exception if accessed and cause the
> > >>>> EHCI, OHCI and XHCI drivers to crash. There is always talk of fixing
> > >>>> this in the hardware by adding an aux clock that will takeover when the
> > >>>> PHY clock is shut down, but this hasn't happened yet. It seems like
> > >>>> "exit on suspend" still makes sense on systems that don't have this
> > >>>> problem (additional power savings?) so removing the exit on suspend for
> > >>>> all systems is not a good idea.
> > >>>
> > >>> Then in theory you should be able to add a Device Tree property which
> > >>> says that the PHY provides a clock for the USB host controller.  That
> > >>> is strictly a property of the hardware; it has nothing to do with the
> > >>> driver.  Therefore it is appropriate for DT.
> > >>
> > >> The very compatible string that is being allocated/defined for this
> > >> controller carries that information already, that is, if you probe a
> > >> "brcm,bcm7445-ohci" compatible then that means the controller has a
> > >> dependency on the PHY to supply its clock.
> > >>
> > >> Adding a property vs. keying on the compatible string makes sense if you
> > >> know there is at least a second consumer of that property (unless we
> > >> make it a broadcom specific property, in which case, it really is
> > >> redundant with the compatible string).
> > >>
> > >> Anyway, my grudge with that property was the name chosen initially,
> > >> which included an action to be performed by an implementation as opposed
> > >> to something purely descriptive. E.g: 'phy-supplies-clock' might be okay.
> > >>
> > >>>
> > >>> Wouldn't this solve your issue?
> > >>
> > >> It would not change much except that there is no need to much with
> > >> ohci-platform.c anymore, but ultimately that property needs to be read
> > >> by ohci-hcd.c and acted on, which would likely lead to the same amount
> > >> of changes as those present in patch #2 currently.
> > >>
> > > We also need this functionality in the EHCI and XHCI drivers and it's
> > > not the ohci-hcd.c module that needs to know, it's the core/phy.c module
> > > called from core/hcd.c.
> >
> > So in that regard the Device Tree property would actually scale a bit
> > better in that you would no longer need to modify the various
> > *hci-plat*.c files, if that is the way to go, then sure.
>
> Sounds like the phy needs to be a clock provider to the USB controller.
> Maybe that's a bit of overkill, but would be the most accurate.
>
> Otherwise, my preference is using the compatible string. IOW, we already
> have properties to handle this. If you don't want to use them, then use
> compatible rather than inventing something new and custom.

My previous commit used the compatible string to set the HCD flag
instead of a device tree property, but Alan Stern ask me to use a DT
binding instead. This has the advantage of having the code in one
place in the phy.c module instead of having to add it to the OHCI,
EHCI and XHCI platform drivers.

>
> At least last time I looked, there's a lack of support in the PHY API to
> handle various handshakes needed between phys and controllers like this.
> It's fairly easy for the controller to fetch info from a phy node, but
> the opposite is not so easy. It seems to me some API for controllers to
> set flags in the phy driver is needed.

The Generic PHY subsystem allows the PHY provider to export
phy_power_on/phy_power_off and phy_init/phy_exit functions for use by
the PHY consumer. The exact functionality of these routines seems to
vary among the different PHY provider drivers. The Broadcom USB PHY
driver expects the phy_power_on/phy_power_off to be used on
suspend/resume and the phy_init/phy_exit to be used by the consumer
driver's probe/remove routines. The new USB PHY consumer code does not
do this, instead it calls both power_off AND exit for both suspend
(not wakable) and remove. If you look at other PHY provider/consumer
implementations in the kernel tree you'll find examples of both these
methods but there are more examples that behave like the Broadcom PHY.
What I was trying to do was to use a DT property to tell the USB PHY
consumer code which method to use.

I guess the problem is that the current generic PHY api only allows
the consumer to put the PHY in 1 of 3 states, EXIT, OFF or ON. The
current USB PHY consumer code is using OFF for "suspend with wakeup"
and EXIT for "suspend without wakeup". The Broadcom PHY driver wants
OFF for either "suspend with wakeup" or "suspend without wakeup" and
EXIT when there are no consumers using the PHY. If the PHY API allowed
for 4 states, EXIT, OFF_NOT_WAKABLE, OFF_WAKABLE and ON then the
individual PHY provider could hide the differences, but this seems
hard to retrofit into the PHY subsystem.

Al

>
> Rob
>
