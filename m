Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F215CC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B941208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOGuEGuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B941208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965983AbeFNO3u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:29:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965867AbeFNO3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:29:42 -0400
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com [209.85.223.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E0E4208DD;
        Thu, 14 Jun 2018 14:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528986582;
        bh=/gdIE/vnYAljSjYUn+hh1gc6Z58YSjbDPeLWd2UfQb0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=AOGuEGuYWj64h7K+gYPJ6Xjx3Zi/ewevzD8reTZmVjVwfqtvJSKFaObJ925mDJJQP
         FeD0vAWCdbE9gJcs3r19RA5BsQ/CON8u34VHwoRRY/dVbzbmqlNTMzZX1YlSRu8pPN
         5haFKHtk+NnQP6wV/03QZwIIGDKT5BEXW6swy8+c=
Received: by mail-io0-f171.google.com with SMTP id f1-v6so7326879ioh.6;
        Thu, 14 Jun 2018 07:29:42 -0700 (PDT)
X-Gm-Message-State: APt69E2Iyqy0enupnzMh1qpoagqSWp+H2dHu0pR+Ie6uZ4jZbjiGnA8O
        SRKOofx1F/ssfc3S1VPpldh4CMkARFbhwrUdzA==
X-Google-Smtp-Source: ADUXVKJVuq8GwaB4ea4lKdtkJ24BFBY1/lIyV8kHeQ0FPcN15f++/w4vHLDTW2UW5kRrY2AiDxzLps128DSryOWfzZQ=
X-Received: by 2002:a6b:c689:: with SMTP id w131-v6mr2468142iof.79.1528986581472;
 Thu, 14 Jun 2018 07:29:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 07:29:20
 -0700 (PDT)
In-Reply-To: <000101d403d3$87210d20$95632760$@codeaurora.org>
References: <1528455990-24572-1-git-send-email-sayalil@codeaurora.org>
 <1528455990-24572-2-git-send-email-sayalil@codeaurora.org>
 <20180612192636.GA31725@rob-hp-laptop> <000101d403d3$87210d20$95632760$@codeaurora.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Jun 2018 08:29:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLsdEGEjPo8yh5dGoGWTes41QxUiJ4NN0Q9qsgLBaTpjw@mail.gmail.com>
Message-ID: <CAL_JsqLsdEGEjPo8yh5dGoGWTes41QxUiJ4NN0Q9qsgLBaTpjw@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] scsi: ufs: set the device reference clock setting
To:     sayali <sayalil@codeaurora.org>
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
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 5:33 AM, sayali <sayalil@codeaurora.org> wrote:
> Comment inline.
>
> Thanks,
> Sayali
> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Wednesday, June 13, 2018 12:57 AM
> To: Sayali Lokhande <sayalil@codeaurora.org>
> Cc: subhashj@codeaurora.org; cang@codeaurora.org;
> vivek.gautam@codeaurora.org; rnayak@codeaurora.org; vinholikatti@gmail.com;
> jejb@linux.vnet.ibm.com; martin.petersen@oracle.com;
> asutoshd@codeaurora.org; evgreen@chromium.org; linux-scsi@vger.kernel.org;
> Mark Rutland <mark.rutland@arm.com>; Mathieu Malaterre <malat@debian.org>;
> open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH V2 1/3] scsi: ufs: set the device reference clock
> setting
>
> On Fri, Jun 08, 2018 at 04:36:28PM +0530, Sayali Lokhande wrote:
>> From: Subhash Jadavani <subhashj@codeaurora.org>
>>
>> UFS host supplies the reference clock to UFS device and UFS device
>> specification allows host to provide one of the 4 frequencies (19.2
>> MHz,
>> 26 MHz, 38.4 MHz, 52 MHz) for reference clock. Host should set the
>> device reference clock frequency setting in the device based on what
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
>>  -lanes-per-direction : number of lanes available per direction - either 1
> or 2.
>>                         Note that it is assume same number of lanes is
> used both
>>                         directions at once. If not specified, default is 2
> lanes per direction.
>> +- dev-ref-clk-freq   : Specify the device reference clock frequency, must
> be one of the following:
>> +                       0: 19.2 MHz
>> +                       1: 26 MHz
>> +                       2: 38.4 MHz
>> +                       3: 52 MHz
>> +                       Defaults to 26 MHz if not specified.
>
> I must have misunderstood your last response. I thought you could handle
> things without DT. If not, my question remains.
> [Sayali]: Ref clk frequency setting could vary from
> platfrom-to-platform(vendor specific). Hence we need to pass it via DT.
>         Currently in DT we do not set/mention any ref clk frequency
> parameter. Hence I have added one new DT entry to configure
>         required ref clk freq.

The clocks property contains "ref_clk". Is that not the same clock?
Why can't you read what that frequency is? Or you need to be able to
change it to a specific frequency? These all look like typical
oscillator frequencies, so I wouldn't expect you could change them
(other than divide by 2 maybe).

Rob
