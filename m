Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449B1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F392086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Wct0SNFK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JCRbds+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F392086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeIZM0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:26:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39538 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeIZM0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:26:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5627960818; Wed, 26 Sep 2018 06:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537942506;
        bh=vcYth/JOz+rABiPGkaCPhIZvb1vrvSCMEULfNDaceEg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wct0SNFKaHQWx7e4qkKKTPYe1u4dCcVl/WjtPkHPuhSQvYDcEmyngROysG7pRiLf1
         I0v4nQo9UpdwTvrO4xHhvp9jc0NXIcSoKOSrZHThoqYqJvzzzdZEnWTFU753fPDGIR
         UtHKSxgTuYulam8LUVbbH1UHr0zfnmsjRLL4Unp4=
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A350360A98;
        Wed, 26 Sep 2018 06:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537942505;
        bh=vcYth/JOz+rABiPGkaCPhIZvb1vrvSCMEULfNDaceEg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JCRbds+SeL5PsslmDWiQY8vnqQwPW4gK1EpIEfcH1ZQOhgNOsHermb7bcEW0Zmr21
         JGzwZ6fnP0KLyXWVWQD8CvHW+Zf8r6f9iHlFvdhbekih/KGwBHuqY+qN/4ZQrO+oK/
         nS1SnAmijxdEwvQuGhl4wLcz8n5hz6BrGmfl8+S0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A350360A98
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f174.google.com with SMTP id v18-v6so5438459qka.10;
        Tue, 25 Sep 2018 23:15:05 -0700 (PDT)
X-Gm-Message-State: ABuFfoiKR+9guH+Z5CNeXA4twb9y6i7PNoLjCWBN7NxyLCZkC4zTdIz0
        PgWqmF1pcBExrNahEuo0kp9KoYWx9ddmYhrC35g=
X-Google-Smtp-Source: ACcGV62ihDPt9K6cmJmRh7Ia6LrbpVglIsmdBqy6e9AbFKHkS2pDUi5A5wfft1zWxghG7sy3x0Uu5L1LX8JrZp2ftXU=
X-Received: by 2002:a37:c44c:: with SMTP id h12-v6mr3199404qkm.279.1537942504955;
 Tue, 25 Sep 2018 23:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180904101719.18049-1-vivek.gautam@codeaurora.org>
 <20180904101719.18049-3-vivek.gautam@codeaurora.org> <20180924172432.GL1367@tuxbook-pro>
 <CAFp+6iFPOGRAToBrV44VDNYG4DP2c6_+8QZbKsDmM4SF57NGfQ@mail.gmail.com> <yq1efdhhzkr.fsf@oracle.com>
In-Reply-To: <yq1efdhhzkr.fsf@oracle.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Wed, 26 Sep 2018 11:44:52 +0530
X-Gmail-Original-Message-ID: <CAFp+6iF=teknfvdaWeiNdwVtVybjrKQyQXcLHKNKETdJftykQw@mail.gmail.com>
Message-ID: <CAFp+6iF=teknfvdaWeiNdwVtVybjrKQyQXcLHKNKETdJftykQw@mail.gmail.com>
Subject: Re: [PATCH 2/3] scsi/ufs: qcom: Remove ufs_qcom_phy_*() calls from host
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     kishon <kishon@ti.com>, Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, open list <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org,
        Subhash Jadavani <subhashj@codeaurora.org>,
        evgreen@chromium.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 5:59 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Vivek,
>
> > Kishon is looking to pick this series through linux-phy tree.
> > Will you please consider giving your ack for this patch? Thanks.
>
> Looks fine.
>
> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

Thanks Martin.

Best regards
Vivek
>
> --
> Martin K. Petersen      Oracle Linux Engineering



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
