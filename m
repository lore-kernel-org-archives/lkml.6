Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2645CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73292089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6PuDCzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73292089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934810AbeFLAza (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:55:30 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45161 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933494AbeFLAz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:55:27 -0400
Received: by mail-ot0-f195.google.com with SMTP id a5-v6so26077972otf.12;
        Mon, 11 Jun 2018 17:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:in-reply-to:references:mime-version:content-transfer-encoding
         :autocrypt:subject:to:cc:from:message-id;
        bh=Yffcd/LcG1ScmQrOUKJ4cQhWZCiPl3GDaxSvBLpGHcs=;
        b=b6PuDCzEF8Cea79JzyDz4sO8fRcVwA199nVvW07ygxnxXwsovWMn4wEBZT0Nwb5Xw/
         41RkLOz7PotkAptQPUPTTWZVRLagP/s+PZ50qYCiDl4gnukSIRgPvWgfDavcALAE4dhz
         /o44IaCqd3sTHDHv/hlyILNpPQFtZGiZ2vDMVFd3c5+I63T2MUKbmrCDy2Zy82dMY/8v
         y5EjVxZx4Z1corHj+cx/9ZiboHZ6DQLXyju+P3plVAZSlIKuDJhG8gDiozuJajzUvxTS
         CeS7lD1+qse34SA5A3ikz3AZgtoA8SCWS23RZBnv01y1cvIfkddC5mcy+nb0H5i+NPfr
         w+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:references:mime-version
         :content-transfer-encoding:autocrypt:subject:to:cc:from:message-id;
        bh=Yffcd/LcG1ScmQrOUKJ4cQhWZCiPl3GDaxSvBLpGHcs=;
        b=OJtEaOErM8i37I1koaUJ0ZHeH2uI6ZrE6TmBa+rBSup5wBnfhncTpjdAeHSYRN0+mv
         pd97yCo++YFC8oM+x9BmrnvJyDta6Pzcq9PD53ejOQh36xofokPM5PSjHV+ZLshAEhGk
         Vc+iNR/Gl6h20A6Cfawza/SWFETM6vZ5in93U9w5QkEPE7Kt2tZ/myPaCngvLiAO32vl
         yn8l5+htp/9/usJ3YtUL3D8hgObylovfkRxq9PujZxlrZn9d3Xw13VwtjUCoB8ymBLiH
         ZUBUJYdTh7LnAed29jp6LH2FwT4kSaHunP9SMIxFl7l3KmFVCDl9kVjDv5kKl/eA+7Mm
         SlQA==
X-Gm-Message-State: APt69E36ApMuqM0fsm3/FAVc1qWn3nKMNW7Zb5ry4HjCLoyyEXXPTbR9
        e3jOo/0Au3ZqxF4RERLnj8k=
X-Google-Smtp-Source: ADUXVKJsqVh5CEV52AYfGgGHPVW/bLBw9FmP6K8Yg8BMeD5fhVTW4R2Fkup0sfkffCVsuU6IwiwJ/w==
X-Received: by 2002:a9d:1dc3:: with SMTP id w3-v6mr1106213otw.20.1528764926847;
        Mon, 11 Jun 2018 17:55:26 -0700 (PDT)
Received: from nexus5x-flo.lan (ip68-109-195-31.pv.oc.cox.net. [68.109.195.31])
        by smtp.gmail.com with ESMTPSA id w39-v6sm22523776otd.13.2018.06.11.17.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 17:55:25 -0700 (PDT)
Date:   Mon, 11 Jun 2018 17:55:20 -0700
In-Reply-To: <522816f9-c33f-ee58-619e-84ee86dba418@broadcom.com>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com> <1527631130-20045-4-git-send-email-ray.jui@broadcom.com> <f5aa804e-3174-affd-1117-31b0a5b59fc5@gmail.com> <522816f9-c33f-ee58-619e-84ee86dba418@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=f.fainelli@gmail.com; keydata=mQGiBEjPuBIRBACW9MxSJU9fvEOCTn
 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
 uUuzv+GKZ6nsysJw==
Subject: Re: [PATCH 3/6] arm: dts: Change PCIe INTx mapping for Cygnus
To:     Ray Jui <ray.jui@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <D95617BA-7C31-4737-9514-BA3F7B09DCE2@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 11, 2018 5:27:20 PM PDT, Ray Jui <ray=2Ejui@broadcom=2Ecom> wrote:
>
>
>On 6/11/2018 3:36 PM, Florian Fainelli wrote:
>> On 05/29/2018 02:58 PM, Ray Jui wrote:
>>> Change the PCIe INTx mapping to model the 4 INTx interrupts in the
>>> IRQ domain of the iProc PCIe controller itself
>>>
>>> Signed-off-by: Ray Jui <ray=2Ejui@broadcom=2Ecom>
>>> ---
>>>   arch/arm/boot/dts/bcm-cygnus=2Edtsi | 18 ++++++++++++++----
>>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/bcm-cygnus=2Edtsi
>b/arch/arm/boot/dts/bcm-cygnus=2Edtsi
>>> index 699fdf9=2E=2E6de21ef 100644
>>> --- a/arch/arm/boot/dts/bcm-cygnus=2Edtsi
>>> +++ b/arch/arm/boot/dts/bcm-cygnus=2Edtsi
>>> @@ -254,9 +254,14 @@
>>>   			compatible =3D "brcm,iproc-pcie";
>>>   			reg =3D <0x18012000 0x1000>;
>>>  =20
>>> +			interrupt-controller;
>>>   			#interrupt-cells =3D <1>;
>>> -			interrupt-map-mask =3D <0 0 0 0>;
>>> -			interrupt-map =3D <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
>>> +			interrupt-map-mask =3D <0 0 0 7>;
>>> +			interrupt-map =3D <0 0 0 1 &pcie0 1>,
>>> +					<0 0 0 2 &pcie0 2>,
>>> +					<0 0 0 3 &pcie0 3>,
>>> +					<0 0 0 4 &pcie0 4>;
>>> +			interrupts =3D <GIC_SPI 100 IRQ_TYPE_NONE>;
>>=20
>> You would want to fix those IRQ_TYPE_NONE values as well because
>since
>> commit 83a86fbb5b56b5eed8a476cc3fe214077d7c4f49 ("irqchip/gic: Loudly
>> complain about the use of IRQ_TYPE_NONE") this is going to create
>some
>> nice warnings on boot=2E
>>=20
>> I am about to send fixes for NSP and HR2 since that's what I have
>access
>> to at the moment, but it would be good if you could send updates to
>the
>> Cygnus and NS2 DTS files?
>>=20
>> Thanks
>>=20
>
>Okay=2E Thanks for letting me know=2E How do you want this to be done for=
=20
>Cygnus and NS2?
>
>I guess I should have the fix patches to DTS done and sent out first,=20
>and then rebase this INTx patch series against the patches with the
>fix=2E
>
>Does that make sense to you?

Yes it does=2E As soon as v4=2E18-rc1 is tagged I will send the Device Tre=
e fixes pull request, if I can have yours for Cygnus and NS2 in the next fe=
w days I could lump those together=2E Then we can either base your changes =
off v4=2E18-rc2 or a later tag that already has the DTS fixes=2E

--=20
Florian
