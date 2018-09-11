Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B536C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C682086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Vx2WdvKZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hOWp0wJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C682086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeIKNcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:32:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36628 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeIKNcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:32:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3036660912; Tue, 11 Sep 2018 08:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536654872;
        bh=I+yOhxMqQ9lDLN/lPOttFRUvW8BpJCnjSlsvPt1RE0o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vx2WdvKZgwJNH8/C7RiBKhw7klFaBUskyZsnDppkJPuNfNfXT0wZPnX+LcM3BADHw
         onwMQ6Xnz2i/34AeEYCpqK1eDQ4t4IOdT7+a+4JBsYeulMELJf4zee4FPbShx7LEcZ
         PedQlvwrqqrMnxitG+aGSpg7G/ujq91Jb/G5lLf0=
Received: from mail-qt0-f173.google.com (mail-qt0-f173.google.com [209.85.216.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 88D1260912;
        Tue, 11 Sep 2018 08:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536654870;
        bh=I+yOhxMqQ9lDLN/lPOttFRUvW8BpJCnjSlsvPt1RE0o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hOWp0wJQqgqY8dAu9B5JTpsRIHEcjyFgN2YE0H4Af4xFNojjly3DVh4mvS40iJ7cP
         ZszvUd2vkLvc+93piZSAnq5bG1cOfdlBguood9e/f7mqSCShJJy5mqBhaMSACuD/BP
         +g+3YFsjLr0ElANMJwHITRiI8VngYIHW1cgQf+9U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88D1260912
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt0-f173.google.com with SMTP id h4-v6so27330309qtj.7;
        Tue, 11 Sep 2018 01:34:30 -0700 (PDT)
X-Gm-Message-State: APzg51DQgCHKr2MCnvO7BoAAqwx8lOGa7j58MebOqwIH24jfrd7GM9N4
        oDEtv8O/t24Nqg7+tnTVWhZAbt6UnFkHRPkwJOI=
X-Google-Smtp-Source: ANB0VdalKJS8ihHVfEOywsldBzDUk2WbGTiod7Ttag5HUA7ps17U98fhoaenPdCcL39l2lGITorPAYnKaFjRcA6ZYL0=
X-Received: by 2002:a0c:ada8:: with SMTP id w37-v6mr17778859qvc.107.1536654869752;
 Tue, 11 Sep 2018 01:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-5-vivek.gautam@codeaurora.org> <20180910180224.GA22566@bogus>
In-Reply-To: <20180910180224.GA22566@bogus>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 11 Sep 2018 14:04:19 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHxe2bRY57ZhpOKbXuR9E9+9JtMhuO-PazRPTsiSZDnQg@mail.gmail.com>
Message-ID: <CAFp+6iHxe2bRY57ZhpOKbXuR9E9+9JtMhuO-PazRPTsiSZDnQg@mail.gmail.com>
Subject: Re: [PATCH v16 4/5] dt-bindings: arm-smmu: Add bindings for qcom,smmu-v2
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alex.williamson@redhat.com,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "robh+dt" <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 11:32 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, 30 Aug 2018 20:15:40 +0530, Vivek Gautam wrote:
> > Add bindings doc for Qcom's smmu-v2 implementation.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >  .../devicetree/bindings/iommu/arm,smmu.txt         | 39 ++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks Rob.

Best regards
Vivek


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
