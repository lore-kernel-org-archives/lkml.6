Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95095C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381672084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O0qWuwr+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O0qWuwr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381672084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeH2MQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:16:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52444 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbeH2MQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:16:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6EAD960540; Wed, 29 Aug 2018 08:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535530858;
        bh=HYRyEVDJKABCwiAqI+nx6S2ihze80aeLmn0/Y2s1scU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O0qWuwr+YlJvPHo7rVEx6fcPRJPBCMDvmpBJlYuCB3oJKpMkCjCliU94/kJplzmYN
         fUNhc9O5jmY5Uf1lvUnXTEFIwHI2YUq32eEjKI8V8mLgM8Xtcmjy5NtJB6F+MnVJFQ
         07lSwQ6jAfUIG/ykmd4MY1wSLNdxGzKmcXvEOUFk=
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com [209.85.220.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DAF2660265;
        Wed, 29 Aug 2018 08:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535530858;
        bh=HYRyEVDJKABCwiAqI+nx6S2ihze80aeLmn0/Y2s1scU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O0qWuwr+YlJvPHo7rVEx6fcPRJPBCMDvmpBJlYuCB3oJKpMkCjCliU94/kJplzmYN
         fUNhc9O5jmY5Uf1lvUnXTEFIwHI2YUq32eEjKI8V8mLgM8Xtcmjy5NtJB6F+MnVJFQ
         07lSwQ6jAfUIG/ykmd4MY1wSLNdxGzKmcXvEOUFk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DAF2660265
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk0-f182.google.com with SMTP id d15-v6so2819455qkc.1;
        Wed, 29 Aug 2018 01:20:57 -0700 (PDT)
X-Gm-Message-State: APzg51AOHCuxNIlY4JzHQyu50/HITOUNkbJ/MOLGFTQjOWlW6lwRLqKL
        nBTFoKSNfTvw+IYeGr9HgXJRlk408EkORZt5vQQ=
X-Google-Smtp-Source: ANB0VdbcbxpFSQWc8WaEuKeCGI68pC8p8ASqjCXLQ++EqQCcgFuxtM0vaOjzwkBT0U2rrW3YmVub3mPnhEdo7KrMb9E=
X-Received: by 2002:a37:6306:: with SMTP id x6-v6mr5264175qkb.118.1535530857144;
 Wed, 29 Aug 2018 01:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180807174739.23379-1-vivek.gautam@codeaurora.org> <CAE=gft5ONyVQ6qkP41G_vx-Djo0MqHhXZ6pjTOZjTDpPgwukZQ@mail.gmail.com>
In-Reply-To: <CAE=gft5ONyVQ6qkP41G_vx-Djo0MqHhXZ6pjTOZjTDpPgwukZQ@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Wed, 29 Aug 2018 13:50:44 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEpZThehq4896dmYifvbNF5wa3ESyw7yBv7vpUbtQKzhA@mail.gmail.com>
Message-ID: <CAFp+6iEpZThehq4896dmYifvbNF5wa3ESyw7yBv7vpUbtQKzhA@mail.gmail.com>
Subject: Re: [PATCH 1/1] scsi/ufshcd: Fix NULL pointer dereference for in ufshcd_init
To:     evgreen@chromium.org
Cc:     jejb@linux.vnet.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Subhash Jadavani <subhashj@codeaurora.org>, mka@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 1:13 AM Evan Green <evgreen@chromium.org> wrote:
>
> On Tue, Aug 7, 2018 at 10:48 AM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
> >
> > Error paths in ufshcd_init() ufshcd_hba_exit() killed clk_scaling
> > workqueue when the workqueue is actually created quite late in
> > ufshcd_init().
> > So, we end up getting NULL pointer dereference in such error paths.
> > Fix this by moving clk_scaling initialization and kill codes to
> > two separate methods, and call them at required places.
> >
> > Fixes: 401f1e4490ee ("scsi: ufs: don't suspend clock scaling during clock
> > gating")
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Subhash Jadavani <subhashj@codeaurora.org>
> > Cc: Matthias Kaehlcke <mka@chromium.org>
> > Cc: Evan Green <evgreen@chromium.org>
> > Cc: Martin K. Petersen <martin.petersen@oracle.com>
> > ---
> >
> > Bjorn, Subhash,
> > I am not certain of some of these devfreq, and clk_scaling bits
> > that are moved as part of this patch. Please help in reviewing the
> > change in the light of these features, and related sequence should
> > be followed.
> > Thanks.
> >
>
> You're right, there is a lot of logic moving around here. I think this
> looks okay to me.
>
> Reviewed-by: Evan Green <evgreen@chromium.org>

Thanks Evan.

Best regards
Vivek

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
