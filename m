Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8BBC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176E724943
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="imZfR/GR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176E724943
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934447AbeGCSEb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934194AbeGCSE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:04:28 -0400
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com [209.85.214.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 290832497B;
        Tue,  3 Jul 2018 18:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530641068;
        bh=zSoQHGqc2or15+dTmk2vgAA/muHbFXLjYcBsoef9JzA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=imZfR/GRo5KHb5ScvPHVEGOTXiX6DrRiS/JnEDqAyFVPYFErCWdWbjcefOVokrdxT
         LNGlllWJ42xwSuB5Rzf0LrEwTM7zECvYrChBcvSPCOUSx/MQTm77x1K2hhkP3HTxF/
         YSHLbosXhN+9lZmxGsSbVj783Zi4GRLk9m1epHLw=
Received: by mail-it0-f53.google.com with SMTP id o5-v6so4386333itc.1;
        Tue, 03 Jul 2018 11:04:28 -0700 (PDT)
X-Gm-Message-State: APt69E0IZ0GcPB3uNRkgsMxqr7hxF/TSN/JHIFbrurIcrV1cl+SUmNG8
        ryYmLBV9N7hIXZOuX0ufy0UG8dopnQibRBLJog==
X-Google-Smtp-Source: AAOMgpeNpguoEo2qKaK8twrIQpjD1LuO2oFJN6aqPkb3RA5J9iNwWTCm3YTUBcoTIv6Ltq/YsBXG5KPR2LWwcJgkaeE=
X-Received: by 2002:a02:986d:: with SMTP id x42-v6mr25642289jaj.131.1530641067474;
 Tue, 03 Jul 2018 11:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <1528455990-24572-1-git-send-email-sayalil@codeaurora.org>
 <1528455990-24572-2-git-send-email-sayalil@codeaurora.org>
 <20180612192636.GA31725@rob-hp-laptop> <000101d403d3$87210d20$95632760$@codeaurora.org>
 <CAL_JsqLsdEGEjPo8yh5dGoGWTes41QxUiJ4NN0Q9qsgLBaTpjw@mail.gmail.com> <002401d4093d$256fdc90$704f95b0$@codeaurora.org>
In-Reply-To: <002401d4093d$256fdc90$704f95b0$@codeaurora.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 3 Jul 2018 12:04:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJUBQ2d1mV8ep_h3iZ-ka73ZGEJ3kZ8VkJmb8gDd_R7Sw@mail.gmail.com>
Message-ID: <CAL_JsqJUBQ2d1mV8ep_h3iZ-ka73ZGEJ3kZ8VkJmb8gDd_R7Sw@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] scsi: ufs: set the device reference clock setting
To:     Sayali Lokhande <sayalil@codeaurora.org>
Cc:     Subhash Jadavani <subhashj@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        asutoshd@codeaurora.org, Evan Green <evgreen@chromium.org>,
        linux-scsi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mathieu Malaterre <malat@debian.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 2:52 AM sayali <sayalil@codeaurora.org> wrote:
>
> Hi Rob,
>
> Please check my comment inline.

As mentioned in the back and forth comments previously in this thread,
please fix your email client (hint: you can't use Outlook) and
properly quote your replies (i.e. the leading ">")

> Thanks,
> Sayali
> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Thursday, June 14, 2018 7:59 PM
> To: sayali <sayalil@codeaurora.org>
> Cc: Subhash Jadavani <subhashj@codeaurora.org>; Can Guo <cang@codeaurora.=
org>; Vivek Gautam <vivek.gautam@codeaurora.org>; Rajendra Nayak <rnayak@co=
deaurora.org>; Vinayak Holikatti <vinholikatti@gmail.com>; James E.J. Botto=
mley <jejb@linux.vnet.ibm.com>; Martin K. Petersen <martin.petersen@oracle.=
com>; asutoshd@codeaurora.org; Evan Green <evgreen@chromium.org>; linux-scs=
i@vger.kernel.org; Mark Rutland <mark.rutland@arm.com>; Mathieu Malaterre <=
malat@debian.org>; open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDIN=
GS <devicetree@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH V2 1/3] scsi: ufs: set the device reference clock set=
ting
>
> On Thu, Jun 14, 2018 at 5:33 AM, sayali <sayalil@codeaurora.org> wrote:
> > Comment inline.
> >
> > Thanks,
> > Sayali
> > -----Original Message-----
> > From: Rob Herring [mailto:robh@kernel.org]
> > Sent: Wednesday, June 13, 2018 12:57 AM
> > To: Sayali Lokhande <sayalil@codeaurora.org>
> > Cc: subhashj@codeaurora.org; cang@codeaurora.org;
> > vivek.gautam@codeaurora.org; rnayak@codeaurora.org;
> > vinholikatti@gmail.com; jejb@linux.vnet.ibm.com;
> > martin.petersen@oracle.com; asutoshd@codeaurora.org;
> > evgreen@chromium.org; linux-scsi@vger.kernel.org; Mark Rutland
> > <mark.rutland@arm.com>; Mathieu Malaterre <malat@debian.org>; open
> > list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> > <devicetree@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH V2 1/3] scsi: ufs: set the device reference clock
> > setting
> >
> > On Fri, Jun 08, 2018 at 04:36:28PM +0530, Sayali Lokhande wrote:
> >> From: Subhash Jadavani <subhashj@codeaurora.org>
> >>
> >> UFS host supplies the reference clock to UFS device and UFS device
> >> specification allows host to provide one of the 4 frequencies (19.2
> >> MHz,
> >> 26 MHz, 38.4 MHz, 52 MHz) for reference clock. Host should set the
> >> device reference clock frequency setting in the device based on what
> >> frequency it is supplying to UFS device.
> >>
> >> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> >> Signed-off-by: Can Guo <cang@codeaurora.org>
> >> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> >> ---
> >>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  7 +++
> >>  drivers/scsi/ufs/ufs.h                             |  9 ++++
> >>  drivers/scsi/ufs/ufshcd-pltfrm.c                   | 24 ++++++++++
> >>  drivers/scsi/ufs/ufshcd.c                          | 52
> > ++++++++++++++++++++++
> >>  drivers/scsi/ufs/ufshcd.h                          |  1 +
> >>  5 files changed, 93 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> >> b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> >> index c39dfef..4522434 100644
> >> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> >> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> >> @@ -41,6 +41,12 @@ Optional properties:
> >>  -lanes-per-direction : number of lanes available per direction -
> >> either 1
> > or 2.
> >>                         Note that it is assume same number of lanes
> >> is
> > used both
> >>                         directions at once. If not specified, default
> >> is 2
> > lanes per direction.
> >> +- dev-ref-clk-freq   : Specify the device reference clock frequency, =
must
> > be one of the following:
> >> +                       0: 19.2 MHz
> >> +                       1: 26 MHz
> >> +                       2: 38.4 MHz
> >> +                       3: 52 MHz
> >> +                       Defaults to 26 MHz if not specified.
> >
> > I must have misunderstood your last response. I thought you could
> > handle things without DT. If not, my question remains.
> > [Sayali]: Ref clk frequency setting could vary from
> > platfrom-to-platform(vendor specific). Hence we need to pass it via DT.
> >         Currently in DT we do not set/mention any ref clk frequency
> > parameter. Hence I have added one new DT entry to configure
> >         required ref clk freq.
>
> The clocks property contains "ref_clk". Is that not the same clock?
> Why can't you read what that frequency is? Or you need to be able to chan=
ge it to a specific frequency? These all look like typical oscillator frequ=
encies, so I wouldn't expect you could change them (other than divide by 2 =
maybe).
> [Sayali] : It is the same "ref_clk", but we need to be able to change it =
to a specific frequency as per requirement. Thus, we need new DT entry to s=
pecify/override reference clock frequency as per need.

That is not what your patch does. It just tells the device what the
frequency is. If you need to get the rate, use "clk_get_rate" on
"ref_clk". If you need to actually set it to a specific frequency,
then we have properties for that already (assigned-clock-rates).

Seems to me that by the time you get to Linux, the bootloader would
have already set this. Otherwise, how do you boot? Seems like you
would want to read the attr and ensure "ref_clk" freq matches.

Rob
