Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7D1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F9C20867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="LZh8zu9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F9C20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbeIYSQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:16:50 -0400
Received: from 8bytes.org ([81.169.241.247]:35060 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbeIYSQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:16:50 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C845A6FB; Tue, 25 Sep 2018 14:09:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1537877374; bh=Sj2ms+oXr8R8dkF/icXlsxjb66JPSvWIqTRGXHOjUdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LZh8zu9tCWiyJeRlCMXMTS5WNOrPBViqV7mfk+TdYjqGjb2jlk16XKi4DFpqhcr3o
         4T9tULFJoCrAw/CunVYsYy6Wv4SXyKzLV09A09GLju0+fbhdBRtx+HKRj6CHMC9NGI
         Ur1Mr8uxL42Dh25ncobBm1B/9fWpRN309/5Ll5MXemb2iHIMdd8hHrxGGsAS+oK2Uw
         DYQ06J16O+fcF/fetBeVE1LhVqU7Wk7Hagl99FGr8QDr8qeOncWjwyMoH7rS0opyBK
         TUlhYa00JbXhkoe14i0ulBRnYrqPgUs4fKhKcm6mZoy+zblb6A8VrqMXgH1ckTH59o
         MDfRtC6jVkYyg==
Date:   Tue, 25 Sep 2018 14:09:34 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     andy.gross@linaro.org, will.deacon@arm.com, robin.murphy@arm.com,
        bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, david.brown@linaro.org,
        tfiga@chromium.org, swboyd@chromium.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com
Subject: Re: [PATCH v2 0/4] Qcom smmu-500 TLB invalidation errata for sdm845
Message-ID: <20180925120933.54xd72sv65d63tkl@8bytes.org>
References: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 11:55:47AM +0530, Vivek Gautam wrote:
> Vivek Gautam (4):
>   firmware: qcom_scm-64: Add atomic version of qcom_scm_call
>   firmware/qcom_scm: Add atomic version of io read/write APIs
>   firmware/qcom_scm: Add scm call to handle smmu errata
>   iommu/arm-smmu: Add support to handle Qcom's TLBI serialization errata
> 
>  drivers/firmware/qcom_scm-32.c |  17 ++++
>  drivers/firmware/qcom_scm-64.c | 181 +++++++++++++++++++++++++++++++----------
>  drivers/firmware/qcom_scm.c    |  18 ++++
>  drivers/firmware/qcom_scm.h    |   9 ++
>  drivers/iommu/arm-smmu-regs.h  |   2 +
>  drivers/iommu/arm-smmu.c       | 133 +++++++++++++++++++++++++++++-
>  include/linux/qcom_scm.h       |   6 ++
>  7 files changed, 320 insertions(+), 46 deletions(-)

Should this go through the iommu-tree? In that case I need Acked-by's
for the firmware code changes.

Regards,

	Joerg
