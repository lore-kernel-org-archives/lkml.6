Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DD2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C377420866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C377420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeIJW5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:57:42 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45788 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbeIJW5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:57:42 -0400
Received: by mail-oi0-f66.google.com with SMTP id t68-v6so41879641oie.12;
        Mon, 10 Sep 2018 11:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jDtueIPbWPR76ivf/5H0WcfneS2KAnjV4dOpmmHUQmc=;
        b=A7I+Q3xwXbwqbxzwXUuxtAzISUXHh4adjxmKJZCBP/2fTmHcsNjDFiNpyh9hh4C+LR
         jR1wDRuFFqKoaQnd9YZpEfnqYWEkSPTM4wid4YC242M+i4S2ZIHB3Pn0QZ+SZIrWcvxJ
         d16hwVXJbbxrKhMncDq/+ij8dtpUnhxU3BQGwfkvoFssfvYasenLo+VY1xUu00D1xg7P
         kbJUY5zJ401OfKZpqI6wRyD0It1zUqR3NppSQ6FrTXBiNOfzuCA+JhF8XwQijLOFr/YD
         XQ8iZ5t7eJqCEEvs2iNA4jQS0nywlpYIngyzr6DGqG6ajcPcP36Z3m9JeCrwBKj9nq/7
         pN2g==
X-Gm-Message-State: APzg51CHMDX6v3X0xE5JHsf2NHijwFsCHpP6mDtpuMK9zk2EVpdNDTuE
        DIVkdd2ZK5+HRh7+CyOmog==
X-Google-Smtp-Source: ANB0VdYBYCdBSLr/cqi59kH09/oJmWQeIagk9aaL6I5HU9wuCZt0SxIIvLpSKZvB6Dd7KQnlMgu/0A==
X-Received: by 2002:aca:3c02:: with SMTP id j2-v6mr23608102oia.50.1536602545291;
        Mon, 10 Sep 2018 11:02:25 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w84-v6sm12833923oie.40.2018.09.10.11.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 11:02:24 -0700 (PDT)
Date:   Mon, 10 Sep 2018 13:02:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com,
        will.deacon@arm.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, robdclark@gmail.com, linux-pm@vger.kernel.org,
        freedreno@lists.freedesktop.org, sboyd@kernel.org,
        tfiga@chromium.org, jcrouse@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v16 4/5] dt-bindings: arm-smmu: Add bindings for
 qcom,smmu-v2
Message-ID: <20180910180224.GA22566@bogus>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-5-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830144541.17740-5-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 20:15:40 +0530, Vivek Gautam wrote:
> Add bindings doc for Qcom's smmu-v2 implementation.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.txt         | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
