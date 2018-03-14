Return-Path: <tfiga@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521028278; cv=none;
        d=google.com; s=arc-20160816;
        b=N/rxJyFxeRu5WxBEwfBCPlhwnYZprxxR7Uyiur8HA17bvuQHL2suN4+LAQtI9Km+6m
         bydB9fo+/P4gHNRAWeaXj38TUa5uxU/t+iuMYrAYa4lxNGe1Cfzd/DPPkTbJ89gDmN0t
         BDcf7XPxbcSu+M7fSvrQ6erx84ywPtQIlFt2cxp1bNSrJyX4mRILD0G18OB12+MFxDof
         9xc/m8Hv06BN8onuRfCM2k47fVSG7rKyDLeRRPPfiCnksvDXcPGYWjO0d95X3r6P8iwI
         a7V/WY7daYIJA0LhcZ6t5hXQ8Lsl1qE75jBzDnceXrtTLmKGQVTEWNOScdRTrIOI5xIK
         lTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=HvYfP3YUuMdY9DDeYK1V3JFqAZQIIBqsiSsT1+Rp55o=;
        b=0KgcYajrr6ChSBGiijvg4P4NCDZIlF55/qsF7t4aSJWO7T/kikmfLygV3t/xZGN0bj
         xchelfGhUfWxn753+ZzaVTiM1TidyAaHihClt9XcRf6sSgZOF9hrmi0dzMTXH5JfAI4W
         VniShWl22ewX7OtVhD2zKiiUk9V6uHYnzTeC7UIIHNI53iMEhxg0vs05nLypUESq1gBF
         7PHuf6b1xVzyeunnKfBQnYvxCRYzK0w8nth3HiIA1zXk6I9VDaTOGTIAgKJ/d7QTdin7
         RM3xIimcJlOZc+ZCqmKq2iN/N4g/pO1BaWzRPdgLNYFR8Y4qkO9YP/RiiPjMmM1qUcf5
         qBiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Dhg+JRX2;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Dhg+JRX2;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELvkO7Ry6FaJGzPPNj0U47uJ/PXDimPryoDrbOB7n6ljRwebUjReNWCEXuXARL5IzHcwqqyj0w==
MIME-Version: 1.0
In-Reply-To: <2217404.A2W3Iek6du@aspire.rjw.lan>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <CAFp+6iH3R2j0_vboSV6-0k7vQFaZ66iNiTcV3_qSbBGXdM=S_A@mail.gmail.com>
 <CAAFQd5A5Rj1KAZjUc5ZUKuKnbkA5Q6aLw9z0H3_kfyBQOOF-gw@mail.gmail.com> <2217404.A2W3Iek6du@aspire.rjw.lan>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 14 Mar 2018 20:50:54 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CQXY0Efv+2MC1kTVW5q4eZjJ=gwVaR-LA=3agnSSHzUw@mail.gmail.com>
Message-ID: <CAAFQd5CQXY0Efv+2MC1kTVW5q4eZjJ=gwVaR-LA=3agnSSHzUw@mail.gmail.com>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two devices
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>, Lukas Wunner <lukas@wunner.de>,
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>,
	Sricharan R <sricharan@codeaurora.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
	Archit Taneja <architt@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594812129788829883?=
X-GMAIL-MSGID: =?utf-8?q?1594913747965912919?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 8:12 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, March 13, 2018 12:23:34 PM CET Tomasz Figa wrote:
>> On Tue, Mar 13, 2018 at 7:34 PM, Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:
>> > Hi Tomasz,
>> >
>> > On Tue, Mar 13, 2018 at 3:45 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>> >> Hi Vivek,
>> >>
>> >> Thanks for the patch.
>> >>
>> >> On Tue, Mar 13, 2018 at 5:55 PM, Vivek Gautam
>> >> <vivek.gautam@codeaurora.org> wrote:
>> >>> The lists managing the device-links can be traversed to
>> >>> find the link between two devices. The device_link_add() APIs
>> >>> does traverse these lists to check if there's already a link
>> >>> setup between the two devices.
>> >>> So, add a new APIs, device_link_find(), to find an existing
>> >>> device link between two devices - suppliers and consumers.
>> >>
>> >> I'm wondering if this API would be useful for anything else that the
>> >> problem we're trying to solve with deleting links without storing them
>> >> anywhere. Perhaps a device_link_del_dev(consumer, supplier) would be a
>> >> better alternative?
>> >
>> > Yea, that sounds simpler i think. Will add this API instead of
>> > find_link(). Thanks.
>>
>> Perhaps let's wait for a moment to see if there are other opinions. :)
>>
>> Rafael, Lucas, any thoughts?
>
> It is not clear to me what the device_link_del_dev(consumer, supplier) would do.

It would delete a link between consumer and supplier.

Best regards,
Tomasz
