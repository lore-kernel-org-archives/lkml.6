Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AB9ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446592147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EluyBPq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446592147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeGMFzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 01:55:03 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:44800 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeGMFzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 01:55:03 -0400
Received: by mail-yb0-f194.google.com with SMTP id a2-v6so12308536ybe.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 22:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z0BGb08OI0rBw2/4MCgTOB6m4BpdhaB5TDAAlTmN0eU=;
        b=EluyBPq6EZptxObeyLWn04McJH6tOrSy81qmD59qAJHgA5A3JQFE1VvZaPPYzvEfwE
         /v5Wt1QWoUvSVOCuA7HXpV5e9K86h5HkbTmqLHQeW6rIQ2hyL7JGv+5g+LXk0cben5fo
         8rOOiQ/03EiKdko+QytRtGL+HAu7AayRzCdIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z0BGb08OI0rBw2/4MCgTOB6m4BpdhaB5TDAAlTmN0eU=;
        b=fwpVIav0HMl+sMiryGF3ztBZd36LCZ+NxS/AW7YdswdBTcEKI+EGsRS76Ew800L45O
         n+Abe7er0Jf83NCoisfnlBiXdW7t6EnfT/DfN9t2RAlhOe6h9265cTMW/iMJK8y+U7ka
         LR0vOYM7uMdpM4jQvEyW2KQIxvhgf7EkEFKRhASwzhtGENiG2wPUUaToWNeYARa/HyQR
         2oVeTyoStsr3aPS995OuFHvOUakvjAp8hbyh/NIM/X4+TZKmiFtATz4h45IsjYM4Ubge
         z532+k3YtvVzeD3P1mxLkQ7zve3QmF0dBYR705qRyTIRMUeR5Yoy4b+R1nzfKURalhuA
         Fwxw==
X-Gm-Message-State: AOUpUlHvsF7xy1ww+X2iCAw6S7/Yb3OxhlrW+67vAOTfl+7fwiu1pLX4
        2uusr8VNovZJA1B5ESeXmXrxw6uf9MwO3XJCZT0zxw==
X-Google-Smtp-Source: AAOMgpfMEEERPipu7IYvnsl4kFL1Wd0ShWdJy/oIuCVIyvX83f2D5WsPiiMdBAVVHFXGQSH/RgXusbcgcQIuNXrdrWc=
X-Received: by 2002:a25:4754:: with SMTP id u81-v6mr2772714yba.54.1531460523028;
 Thu, 12 Jul 2018 22:42:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e716:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 22:42:02
 -0700 (PDT)
In-Reply-To: <20180713030204.884-1-yuehaibing@huawei.com>
References: <20180713030204.884-1-yuehaibing@huawei.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Thu, 12 Jul 2018 22:42:02 -0700
Message-ID: <CACKFLinEnvFqJm6QRaS2GS1obXNa6jAfR8MtX+k3+y7RgY3Uiw@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: remove redundant debug register dma mem allocation
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 8:02 PM, YueHaibing <yuehaibing@huawei.com> wrote:
> hwrm_dbg_resp_addr and hwrm_dbg_resp_dma_addr are never used
> and can be removed.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks.

Acked-by: Michael Chan <michael.chan@broadcom.com>
