Return-Path: <rjw@rjwysocki.net>
X-Google-Smtp-Source: AG47ELvQfEY3Y4lsgnyhQUCL2vyXzP3aYRpgnBSkrBb2rL4dBGpuRt3FNlSmCR7tab0ijmPVjuPy
ARC-Seal: i=1; a=rsa-sha256; t=1521025891; cv=none;
        d=google.com; s=arc-20160816;
        b=kbAkLtr7+x7CzEh6UMrFNtwSHB5TQipFhQmeEKonqR70ZuELEtXli5dDO11e/uwy7j
         mYkW7bdHF/OVYcyWfDMpWt0bLl191TGS+d8AYIYeXddHqSVuFIZWcPwRvzB15TI5XFoC
         H1NAkm+XlC+k6OWJ/SSIlDIr3cAsnBBLlV4kAycIGPNivDahPQj75FOLXAYuUjle0tWV
         8ZOhRHD93LPkjt4B/Q3zNl90ng1h84g4gXmnSghZR1Q81/qsuhSMfS+/wpqYY3AsYwzw
         772+oxg4mUbeIDYDbK/6efBR0aQqoAZcLROZ15LkNACaJpJbEAJdKQ0zyrg+nwJldPs8
         MNQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=1hP80c7DKu8O+UYVLQxnw4xTB1YG2bCc4Pq0R9LwwvM=;
        b=ooE99aPd7KWEyKGDS3kraSKJWYnowlP7r6/iwwkFI0tdP0JtE8LeyHsO4LJ1ul2eJ+
         hufnOLDuZvn6zEw1P6N/J6ZwUdGFSRbGdxYJ/PtymB5+Iz+O8OfQ7dkg5NAfmiKia3BI
         mSQNl57MLydWAk9geq6G0ijXY5iDL9EBNHtCiL5yuTIZQcxQBYexruk7yfCLVurwyFa3
         cvBBJuBcrb3phIRQsm0bE7P8qPbQal+lfyezdv2aeJ2gd1GfGeGHBdHVdJDPx7EJoMF7
         bqYzsM9/3oDhbpyTc+4lntCo2kyQ3saDbBzN+uuj85Hc7UaLNQX3uJLtyNWAWgErmx7m
         fQXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Tomasz Figa <tfiga@chromium.org>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>, Lukas Wunner <lukas@wunner.de>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>, Sricharan R <sricharan@codeaurora.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Archit Taneja <architt@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two devices
Date: Wed, 14 Mar 2018 12:12:05 +0100
Message-ID: <2217404.A2W3Iek6du@aspire.rjw.lan>
In-Reply-To: <CAAFQd5A5Rj1KAZjUc5ZUKuKnbkA5Q6aLw9z0H3_kfyBQOOF-gw@mail.gmail.com>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org> <CAFp+6iH3R2j0_vboSV6-0k7vQFaZ66iNiTcV3_qSbBGXdM=S_A@mail.gmail.com> <CAAFQd5A5Rj1KAZjUc5ZUKuKnbkA5Q6aLw9z0H3_kfyBQOOF-gw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594812129788829883?=
X-GMAIL-MSGID: =?utf-8?q?1594911245146664742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tuesday, March 13, 2018 12:23:34 PM CET Tomasz Figa wrote:
> On Tue, Mar 13, 2018 at 7:34 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
> > Hi Tomasz,
> >
> > On Tue, Mar 13, 2018 at 3:45 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> >> Hi Vivek,
> >>
> >> Thanks for the patch.
> >>
> >> On Tue, Mar 13, 2018 at 5:55 PM, Vivek Gautam
> >> <vivek.gautam@codeaurora.org> wrote:
> >>> The lists managing the device-links can be traversed to
> >>> find the link between two devices. The device_link_add() APIs
> >>> does traverse these lists to check if there's already a link
> >>> setup between the two devices.
> >>> So, add a new APIs, device_link_find(), to find an existing
> >>> device link between two devices - suppliers and consumers.
> >>
> >> I'm wondering if this API would be useful for anything else that the
> >> problem we're trying to solve with deleting links without storing them
> >> anywhere. Perhaps a device_link_del_dev(consumer, supplier) would be a
> >> better alternative?
> >
> > Yea, that sounds simpler i think. Will add this API instead of
> > find_link(). Thanks.
> 
> Perhaps let's wait for a moment to see if there are other opinions. :)
> 
> Rafael, Lucas, any thoughts?

It is not clear to me what the device_link_del_dev(consumer, supplier) would do.

Thanks,
Rafael
