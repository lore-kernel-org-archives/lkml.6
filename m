Return-Path: <tfiga@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520940237; cv=none;
        d=google.com; s=arc-20160816;
        b=LkPPqf5z2Z77js4ShWthkfJLX++z2w27hnQvHITbjFDUbhniGg+p/+VJY69lQ4KhmM
         wrATWMNZmV1Se6S+YEOk/ta3evk3Hdjddx9orNotFcl3ngKEhkOZ8PJR6+TJ2p5FMht4
         gRHGGkrolXGSgCNZ72CRJ/ruWA5e3lr5dH4CFNc+bCulHHdFlnXIdnm77Gz1baPYFC97
         IwP6bYgkwFNerLvQPqQQvUf0ew5C88G89cPnu48jWgKyMJMgArGvDbTEvqnL1y9gcT8B
         mgojsEx2aR0yaYm2N2J0j5WKoZdxowkb19wnDNXHi3yuqpsy3j0BdOaLfiFRvmGmTkut
         V4/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=E1KH3tONd4AhJ8+XrYnDe5dmUgw/tq+gCnHIs9n0dgA=;
        b=mTft+NxPbhHNMf0jEj4x9F9GW9Qmc78nFCwJVAHabWutnwrZ329aix3s9usMHWIH+7
         9bu8QwZp9mgynpcR85EaNCbnuoos4p2dPjX8sIaWySnKGuIp5G6WdMPaNhvaVoD+UebX
         oQmPtI9WOwbBiIZoWB0EhBbe9UmKjbcfNE08YIkTrs5XBxTZwR5R48EfyOAYUV7f3dX3
         AxmVZj5/Twvub71XCPAec5ts3KKPYmnizW+Q+7X4oX3/S3m7XAYnpkDD23xndaMvo4Up
         kVoQhVgklUMRpKsZgqJ1RNYi353UBP6ZMV0Fj6WlKAOgPcJM1w/FgdArjFQu/cygPo7K
         1qKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=KA3J1Qe9;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=KA3J1Qe9;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELtTKx3nOdjEdXnBG3F6IaYVAJGNe1RD8Bkk2id2cpoSHJ7JMOzsL9GagUSVDy743JsCgziXzA==
MIME-Version: 1.0
In-Reply-To: <CAFp+6iH3R2j0_vboSV6-0k7vQFaZ66iNiTcV3_qSbBGXdM=S_A@mail.gmail.com>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <20180313085534.11650-2-vivek.gautam@codeaurora.org> <CAAFQd5DXvnjaFw4Ct1Xn90nQZ4F4dLtov0ymG-tycQt5oLNpiQ@mail.gmail.com>
 <CAFp+6iH3R2j0_vboSV6-0k7vQFaZ66iNiTcV3_qSbBGXdM=S_A@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 13 Mar 2018 20:23:34 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A5Rj1KAZjUc5ZUKuKnbkA5Q6aLw9z0H3_kfyBQOOF-gw@mail.gmail.com>
Message-ID: <CAAFQd5A5Rj1KAZjUc5ZUKuKnbkA5Q6aLw9z0H3_kfyBQOOF-gw@mail.gmail.com>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two devices
To: Vivek Gautam <vivek.gautam@codeaurora.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Lukas Wunner <lukas@wunner.de>
Cc: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
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
X-GMAIL-MSGID: =?utf-8?q?1594821430575590583?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 7:34 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> Hi Tomasz,
>
> On Tue, Mar 13, 2018 at 3:45 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>> Hi Vivek,
>>
>> Thanks for the patch.
>>
>> On Tue, Mar 13, 2018 at 5:55 PM, Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:
>>> The lists managing the device-links can be traversed to
>>> find the link between two devices. The device_link_add() APIs
>>> does traverse these lists to check if there's already a link
>>> setup between the two devices.
>>> So, add a new APIs, device_link_find(), to find an existing
>>> device link between two devices - suppliers and consumers.
>>
>> I'm wondering if this API would be useful for anything else that the
>> problem we're trying to solve with deleting links without storing them
>> anywhere. Perhaps a device_link_del_dev(consumer, supplier) would be a
>> better alternative?
>
> Yea, that sounds simpler i think. Will add this API instead of
> find_link(). Thanks.

Perhaps let's wait for a moment to see if there are other opinions. :)

Rafael, Lucas, any thoughts?

Best regards,
Tomasz
