Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AG47ELty0sUhiLoYADOviFsEkDW4T8H/yANvljpc22+HKqhTTgS2uChJQcz5xdkcd3XvOKZqZKbP
ARC-Seal: i=1; a=rsa-sha256; t=1520937252; cv=none;
        d=google.com; s=arc-20160816;
        b=CbTpE75F3Gn9fWqBFiHodofJLUOLLj2IrEloRQSrXBdwKo5c117qmtU0p8XbUA/fJn
         iy3u0S5fopvfQ02iIAxOptJ5ziqF+5jwRP9aO3l/2oRcMtAYLvP5OeYxvEebJdZLaH/S
         ARDQdfJuySXPvKm6awjalFqzm3lUJqq/nAiL1ZhLIW6FlItDPbT0+q7wNrFIjhCDBgq0
         h1XWObaHzZ43tqACuc+s1eyARL/32UCrj5FjKVfg8/tSP65wGcTHX2Bt9A28Tk3MX/nQ
         UacUXHaSLZL21NT558NuNYce99QGB+F2G4LPhOlS3AAFIpCwfx2Sh646njbBT8gbwqOo
         typQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=lLU1CSLaii/nvVLpGYZAsDlRQsT7+GIdxUH+R2/yabk=;
        b=xiWC0f0CkBiTXgFWoMsI80wrCskbg3nI2UmSnRTlvQm8xam62BjE5W3gJuPTPfrgM5
         6I8G31E0tBljm55Ud2poeBtd0vL8+1yS7pvBgw8nRuZTnDFkGfVkKswSLZt2H0BGLoJP
         tl9Olkd6F0Cu9vNYRQoz+5pHuBVvNpEY9mJdYnvfgJQu3E96khyEobX2Sg5o4UR3Uo4I
         L84/YHirJ/aqh6vKD9Zp38UnIrq1XTxKmTHE0LIHpnWeNmDdpcrrl9odogyin8cLmobL
         q+EAkc9gnbXMmSdCnbVvQVuJCuxQhZTrOrqnMR/ZS1z2UAjGgo+gtUdVY2aOBz2QC3c7
         ZbQw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=aPVHvofv;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=aPVHvofv;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=aPVHvofv;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=aPVHvofv;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43B2760590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
MIME-Version: 1.0
In-Reply-To: <CAAFQd5DXvnjaFw4Ct1Xn90nQZ4F4dLtov0ymG-tycQt5oLNpiQ@mail.gmail.com>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <20180313085534.11650-2-vivek.gautam@codeaurora.org> <CAAFQd5DXvnjaFw4Ct1Xn90nQZ4F4dLtov0ymG-tycQt5oLNpiQ@mail.gmail.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Tue, 13 Mar 2018 16:04:09 +0530
X-Gmail-Original-Message-ID: <CAFp+6iH3R2j0_vboSV6-0k7vQFaZ66iNiTcV3_qSbBGXdM=S_A@mail.gmail.com>
Message-ID: <CAFp+6iH3R2j0_vboSV6-0k7vQFaZ66iNiTcV3_qSbBGXdM=S_A@mail.gmail.com>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two devices
To: Tomasz Figa <tfiga@chromium.org>
Cc: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>,
	Sricharan R <sricharan@codeaurora.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
	Archit Taneja <architt@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594812129788829883?=
X-GMAIL-MSGID: =?utf-8?q?1594818299816088471?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Tomasz,

On Tue, Mar 13, 2018 at 3:45 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> Hi Vivek,
>
> Thanks for the patch.
>
> On Tue, Mar 13, 2018 at 5:55 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> The lists managing the device-links can be traversed to
>> find the link between two devices. The device_link_add() APIs
>> does traverse these lists to check if there's already a link
>> setup between the two devices.
>> So, add a new APIs, device_link_find(), to find an existing
>> device link between two devices - suppliers and consumers.
>
> I'm wondering if this API would be useful for anything else that the
> problem we're trying to solve with deleting links without storing them
> anywhere. Perhaps a device_link_del_dev(consumer, supplier) would be a
> better alternative?

Yea, that sounds simpler i think. Will add this API instead of
find_link(). Thanks.

regards
vivek
>
> Best regards,
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
