Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D626FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3DB2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3DB2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeIDORq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:17:46 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43649 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeIDORq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:17:46 -0400
Received: by mail-qt0-f194.google.com with SMTP id g53-v6so3213447qtg.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 02:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EKhOAflbjSkVcgqo/SiyOIWORqvb9yUQ2/d5GbDajuE=;
        b=GUr7WfqsQhZhToWW3oZuOBJTMuf0PILZWgs5ZcP0mAG5vh8maicsNAs8jRjtSUnwrZ
         /8n9hEptS6nbkdh7gVcSThozoBkOc8Ga1dZyMGkl5bt6gtxM4F7v24sNNMV6nXpE+0xH
         rHp6jxBC/6nBdE0p+x+p+YLXRpCqZR0C+qwelufchDmJgLswxUl+LPgs8YbNuqclDGWG
         aT6N5rFEdDVnIb5NiWxmG5UQdtQtQsJ0Phyh3GYrGUEvrLMmLxFtidWFdFCqFAAmMp67
         Zy5nJWcWm5EPCUfRvQyHmkRVxW5kHG2VAbgF72QFx4IaNIF4n1xamD9Lw5lYqZ3KCV+M
         ERZA==
X-Gm-Message-State: APzg51CgSj5mZ5IYTau1w6ESlcVAQYJBoUZGeq+r2gAD8fwVrf5n+N2E
        9ljQPkbwNZXZPBHwAJM3SIDHyqCjQsHb9EZ4pGIXoQ==
X-Google-Smtp-Source: ANB0VdafFKvG6IU5TbmvA0bMUQyY+svN2QlMGIOvv96cQSuTz+RN14BqYltP6l2dpgnDZm2dmvTkG5S1rEt6VK4Ps+I=
X-Received: by 2002:ac8:6056:: with SMTP id k22-v6mr28898917qtm.94.1536054804377;
 Tue, 04 Sep 2018 02:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180831093604.5915-1-benjamin.tissoires@redhat.com> <SN6PR02MB4864D83F3B3FD94CB4741732ED0F0@SN6PR02MB4864.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4864D83F3B3FD94CB4741732ED0F0@SN6PR02MB4864.namprd02.prod.outlook.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 4 Sep 2018 11:53:12 +0200
Message-ID: <CAO-hwJL20efqKS3MP_UttgwgoUxPRW6CaGUDy9=CsqbgHndGWg@mail.gmail.com>
Subject: Re: [PATCH] Partially revert "HID: generic: create one input report
 per application type"
To:     Terry.Junge@plantronics.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "3.8+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Terry,

On Fri, Aug 31, 2018 at 7:48 PM Junge, Terry
<Terry.Junge@plantronics.com> wrote:
>
> For what it's worth the Report Descriptor is a little questionable
> which could be causing the collection to split in two
>
> >-----Original Message-----
> >From: linux-input-owner@vger.kernel.org [mailto:linux-input-
> >owner@vger.kernel.org] On Behalf Of Benjamin Tissoires
> >Sent: Friday, August 31, 2018 2:36 AM
> >To: Jiri Kosina <jikos@kernel.org>; Dmitry Torokhov
> ><dmitry.torokhov@gmail.com>
> >Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Benjamin
> >Tissoires <benjamin.tissoires@redhat.com>; stable@vger.kernel.org
> >Subject: [PATCH] Partially revert "HID: generic: create one input report per
> >application type"
> >
> >This partially reverts commit f07b3c1da92db108662f99417a212fc1eddc44d1.
> >
> >It looks like some mice are not correctly treated by
> >HID_QUIRK_INPUT_PER_APP. Those mice have the following
> >report descriptor:
> >
> >0x05, 0x01,                    // Usage Page (Generic Desktop)        0
> >0x09, 0x02,                    // Usage (Mouse)                       2
> >0xa1, 0x01,                    // Collection (Application)            4
> >0x85, 0x01,                    //  Report ID (1)                      6
> >0x09, 0x01,                    //  Usage (Pointer)                    8
>
> This physical collection is associated with Generic Desktop:Pointer (0x0001:0x0001)
>
> >0xa1, 0x00,                    //  Collection (Physical)              10
> >0x95, 0x05,                    //   Report Count (5)                  12
> >0x75, 0x01,                    //   Report Size (1)                   14
> >0x05, 0x09,                    //   Usage Page (Button)               16
>
> We are now in the Button page
>
> >0x19, 0x01,                    //   Usage Minimum (1)                 18
> >0x29, 0x05,                    //   Usage Maximum (5)                 20
> >0x15, 0x00,                    //   Logical Minimum (0)               22
> >0x25, 0x01,                    //   Logical Maximum (1)               24
> >0x81, 0x02,                    //   Input (Data,Var,Abs)              26
> >...
> >0xc0,                          //  End Collection                     57
> >0x85, 0x02,                    //  Report ID (2)                      58
> >0x09, 0x01,                    //  Usage (Consumer Control)           60
>
> This physical collection is associated with Button:Button 1 (0x0009:0x0001)
> not Generic Desktop:Pointer (0x0001:0x0001)
>
> >0xa1, 0x00,                    //  Collection (Physical)              62
> >0x75, 0x0c,                    //   Report Size (12)                  64
> >0x95, 0x02,                    //   Report Count (2)                  66
> >0x05, 0x01,                    //   Usage Page (Generic Desktop)      68
>
> Now we're back in the Generic Desktop page

You are missing one bit in the HID specification. The report
descriptor is both a stack and a machine with states. The 'usage page'
can be considered as a 'register' that needs to be associated to the
'usage' to provide the final usage.
For example, Usage Page 0x01 (Generic Desktop) plus Usage 0x30 gives
you the "X" usage.
While Usage Page 0x0d (digitizer) plus the same Usage 0x30 gives you
the "Tip Pressure".

So here, there is nothing wrong.

The stack part concerns the collections. You open a collection type
(physical, or application), and you can close it.

So here, the problem is that the 2 reports with Ids 1 and 2 are part
of the same application collection "mouse" and should be tied to the
same input device (at least that is how I thought of the code).
Unfortunately, the bug makes that these 2 reports each have an input
node, and this is where things start to mess up.

Cheers,
Benjamin

>
> >0x09, 0x30,                    //   Usage (X)                         70
> >0x09, 0x31,                    //   Usage (Y)                         72
> >0x16, 0x01, 0xf8,              //   Logical Minimum (-2047)           74
> >0x26, 0xff, 0x07,              //   Logical Maximum (2047)            77
> >0x81, 0x06,                    //   Input (Data,Var,Rel)              80
> >0xc0,                          //  End Collection                     82
> >0xc0,                          // End Collection                      83
> >...
> >
