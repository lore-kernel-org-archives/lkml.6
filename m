Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B81C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1033920883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LllX5Gib";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gc6raYn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1033920883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754201AbeFUIwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:52:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41742 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeFUIwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:52:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 701A7605FD; Thu, 21 Jun 2018 08:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529571134;
        bh=SKV0O72bzdriqMn3wR6R5sUJwczIFmysHbz/HYa//Qk=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=LllX5Gib7anYzR1Q/u9UnHyNEgtD8yohQ2HNzRurSBhrMHQJ1Du0I50j7ox/vi7HM
         cBaLDjXt9+/3m3S9lqxhu5eoZY1Znulgituv5Txn6LKjRmE6W1quhYk7FzXUp8c5EX
         Dh5v1oHF6XmwnlFMpZ1yVz1Kn5xyLGo5bQLfL6Mw=
Received: from SAYALIL (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6E714604A6;
        Thu, 21 Jun 2018 08:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529571133;
        bh=SKV0O72bzdriqMn3wR6R5sUJwczIFmysHbz/HYa//Qk=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=gc6raYn7NJx2XvWaXAwmFDscVGRO7dqyprsXos4Pi35wVAwup+VmAKil1IpDvOjD8
         uRO5O8bHISkFYu7GhVF06McMsc5BmTlgerCewl92aI55ibSGcxYJxg/vybotpAs6pQ
         wMHGGoFLSgYWwmxa81U6ilue4lEacNwFQ+VlXVgw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E714604A6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   "sayali" <sayalil@codeaurora.org>
To:     "'Rob Herring'" <robh@kernel.org>
Cc:     "'Subhash Jadavani'" <subhashj@codeaurora.org>,
        "'Can Guo'" <cang@codeaurora.org>,
        "'Vivek Gautam'" <vivek.gautam@codeaurora.org>,
        "'Rajendra Nayak'" <rnayak@codeaurora.org>,
        "'Vinayak Holikatti'" <vinholikatti@gmail.com>,
        "'James E.J. Bottomley'" <jejb@linux.vnet.ibm.com>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        <asutoshd@codeaurora.org>, "'Evan Green'" <evgreen@chromium.org>,
        <linux-scsi@vger.kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Mathieu Malaterre'" <malat@debian.org>,
        "'open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS'" 
        <devicetree@vger.kernel.org>,
        "'open list'" <linux-kernel@vger.kernel.org>
References: <1528455990-24572-1-git-send-email-sayalil@codeaurora.org> <1528455990-24572-2-git-send-email-sayalil@codeaurora.org> <20180612192636.GA31725@rob-hp-laptop> <000101d403d3$87210d20$95632760$@codeaurora.org> <CAL_JsqLsdEGEjPo8yh5dGoGWTes41QxUiJ4NN0Q9qsgLBaTpjw@mail.gmail.com>
In-Reply-To: <CAL_JsqLsdEGEjPo8yh5dGoGWTes41QxUiJ4NN0Q9qsgLBaTpjw@mail.gmail.com>
Subject: RE: [PATCH V2 1/3] scsi: ufs: set the device reference clock setting
Date:   Thu, 21 Jun 2018 14:22:04 +0530
Message-ID: <002401d4093d$256fdc90$704f95b0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQH7CPwp+aWAYn25mLDVi5cVOXIbUwKfFWNnAa5me4UBWUrqIAIeT08zo94+ZOA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Please check my comment inline.

Thanks,
Sayali
-----Original Message-----
From: Rob Herring [mailto:robh@kernel.org]=20
Sent: Thursday, June 14, 2018 7:59 PM
To: sayali <sayalil@codeaurora.org>
Cc: Subhash Jadavani <subhashj@codeaurora.org>; Can Guo =
<cang@codeaurora.org>; Vivek Gautam <vivek.gautam@codeaurora.org>; =
Rajendra Nayak <rnayak@codeaurora.org>; Vinayak Holikatti =
<vinholikatti@gmail.com>; James E.J. Bottomley =
<jejb@linux.vnet.ibm.com>; Martin K. Petersen =
<martin.petersen@oracle.com>; asutoshd@codeaurora.org; Evan Green =
<evgreen@chromium.org>; linux-scsi@vger.kernel.org; Mark Rutland =
<mark.rutland@arm.com>; Mathieu Malaterre <malat@debian.org>; open =
list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS =
<devicetree@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/3] scsi: ufs: set the device reference clock =
setting

On Thu, Jun 14, 2018 at 5:33 AM, sayali <sayalil@codeaurora.org> wrote:
> Comment inline.
>
> Thanks,
> Sayali
> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Wednesday, June 13, 2018 12:57 AM
> To: Sayali Lokhande <sayalil@codeaurora.org>
> Cc: subhashj@codeaurora.org; cang@codeaurora.org;=20
> vivek.gautam@codeaurora.org; rnayak@codeaurora.org;=20
> vinholikatti@gmail.com; jejb@linux.vnet.ibm.com;=20
> martin.petersen@oracle.com; asutoshd@codeaurora.org;=20
> evgreen@chromium.org; linux-scsi@vger.kernel.org; Mark Rutland=20
> <mark.rutland@arm.com>; Mathieu Malaterre <malat@debian.org>; open=20
> list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS=20
> <devicetree@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH V2 1/3] scsi: ufs: set the device reference clock=20
> setting
>
> On Fri, Jun 08, 2018 at 04:36:28PM +0530, Sayali Lokhande wrote:
>> From: Subhash Jadavani <subhashj@codeaurora.org>
>>
>> UFS host supplies the reference clock to UFS device and UFS device=20
>> specification allows host to provide one of the 4 frequencies (19.2=20
>> MHz,
>> 26 MHz, 38.4 MHz, 52 MHz) for reference clock. Host should set the=20
>> device reference clock frequency setting in the device based on what=20
>> frequency it is supplying to UFS device.
>>
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
>> ---
>>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  7 +++
>>  drivers/scsi/ufs/ufs.h                             |  9 ++++
>>  drivers/scsi/ufs/ufshcd-pltfrm.c                   | 24 ++++++++++
>>  drivers/scsi/ufs/ufshcd.c                          | 52
> ++++++++++++++++++++++
>>  drivers/scsi/ufs/ufshcd.h                          |  1 +
>>  5 files changed, 93 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>> b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>> index c39dfef..4522434 100644
>> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>> @@ -41,6 +41,12 @@ Optional properties:
>>  -lanes-per-direction : number of lanes available per direction -=20
>> either 1
> or 2.
>>                         Note that it is assume same number of lanes=20
>> is
> used both
>>                         directions at once. If not specified, default =

>> is 2
> lanes per direction.
>> +- dev-ref-clk-freq   : Specify the device reference clock frequency, =
must
> be one of the following:
>> +                       0: 19.2 MHz
>> +                       1: 26 MHz
>> +                       2: 38.4 MHz
>> +                       3: 52 MHz
>> +                       Defaults to 26 MHz if not specified.
>
> I must have misunderstood your last response. I thought you could=20
> handle things without DT. If not, my question remains.
> [Sayali]: Ref clk frequency setting could vary from=20
> platfrom-to-platform(vendor specific). Hence we need to pass it via =
DT.
>         Currently in DT we do not set/mention any ref clk frequency=20
> parameter. Hence I have added one new DT entry to configure
>         required ref clk freq.

The clocks property contains "ref_clk". Is that not the same clock?
Why can't you read what that frequency is? Or you need to be able to =
change it to a specific frequency? These all look like typical =
oscillator frequencies, so I wouldn't expect you could change them =
(other than divide by 2 maybe).
[Sayali] : It is the same "ref_clk", but we need to be able to change it =
to a specific frequency as per requirement. Thus, we need new DT entry =
to specify/override reference clock frequency as per need.

Rob

