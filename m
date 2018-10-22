Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8D1C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B4B20658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RngxAUWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B4B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeJVPcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 11:32:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42026 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbeJVPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 11:32:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id s10-v6so29471162lfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 00:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dx4KkhvP9GSjmDvZtms1pkxoGnhlR+9a6nvpw+UaXO0=;
        b=RngxAUWGzWTbRTevtu9tnQoRIbJliQgLBUFicTpbFj8GwZtCay9+PajvOnBdiSugof
         9aD2BB1OgPEUrzoYHNS2nf4ffxFVCz5TKj5nnlYT20auMuclmq6VbehO8SAH8YhDWCDu
         AH82EBJUtsYll19VBk9zhhzFncWy8JjtUwxgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dx4KkhvP9GSjmDvZtms1pkxoGnhlR+9a6nvpw+UaXO0=;
        b=uAzkA8D4IRrrvLoFblYS5yhq5qJlv3gdSi8du/Jp/Yr/sac75eEWa1SMdB8FPWb4uR
         d/i/TAZJLg8DrLFPhihHFyoHO98V8tUtLAA5x9vTQl13ElGooAHYRYTNW5aeIBqWB1P4
         /3rjnXShjyhteem5hdk4LyzuLR5M7ilxRn8gP/ZVNL2kAnB0HQ0cUWsFyWwKWqWzdQS5
         cfodSfrQSz2sqBuaafXbyuIASU6yt9gEBjwci7p6zyIP8WmnAuIGCH+CI8+XFnEhlZ7j
         R+pEx3NhltsyuoFBw39Tyf8GQPj3JbuxjxDW0Zmf4TMAHI3AE72t1vFYf85b36UyDxVT
         jb5Q==
X-Gm-Message-State: ABuFfoid/4z3wxDtB01ouORpNSF+fJfWuxNkMvtPT6NutXOGnIY9URye
        ZlCpb7taz4djODSjckaCuC8E7fhvsmTQ53D1E/y5tA==
X-Google-Smtp-Source: ACcGV60OFnpekkGugiBLH8Swe/gIdXQhm/hVj17MFgQeIIS9AS2Y6h9sdzyIIFnu0/OiDopPDXP9D+tUX0ECS1MKH2o=
X-Received: by 2002:a19:2203:: with SMTP id i3mr7999985lfi.2.1540192495177;
 Mon, 22 Oct 2018 00:14:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Mon, 22 Oct 2018 00:14:54
 -0700 (PDT)
In-Reply-To: <20181020163000.GD2894@vkoul-mobl>
References: <cover.1538199697.git.baolin.wang@linaro.org> <CAMz4kuKFtbLMmNEbQ0oVgW87HPRwJuwFJH9cXVymz=6jH7xzOA@mail.gmail.com>
 <20181020163000.GD2894@vkoul-mobl>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 22 Oct 2018 15:14:54 +0800
Message-ID: <CAMz4kuLgOzt1q+Aj1e1Xk07a95RC0iqzDyPeMDqgSgaGw8VgGQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add some fixes and new feature for SPRD DMA
To:     Vinod <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Eric Long <eric.long@spreadtrum.com>,
        Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 October 2018 at 00:30, Vinod <vkoul@kernel.org> wrote:
> On 18-10-18, 17:29, Baolin Wang wrote:
>> Hi Vinod,
>>
>> On 29 September 2018 at 13:48, Baolin Wang <baolin.wang@linaro.org> wrote:
>> > This patchset removes the direction usage from struct dma_slave_config,
>> > and add one new field to save the direction. It also fixes some issues
>> > for link-list transfer. Moreover this patchset adds new 2-stage transfer
>> > support for our DMA.
>>
>> Do you have any comments for this patchset? Thanks a lot.
>
> Sorry bit busy with things and ELC, I should be able to review this
> after monday..

Thanks a lot. :)

-- 
Baolin Wang
Best Regards
