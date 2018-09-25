Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C50C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E4220C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hB3pElGl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hB3pElGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E4220C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeIYP5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:57:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40240 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeIYP5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:57:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B5FBD605FD; Tue, 25 Sep 2018 09:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537869056;
        bh=kQvKEIHLMYZsK8z5rn3EZZrFn+b4HNnkA2Xag4M8UNQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hB3pElGl+lergE6W6cCo8NJGVTJlUILleVOYYC92Hx+maXrRfGHcNrQdrCXAG5AIJ
         uPG3PD+ojXZSniXV3h07h1dnu0Yt3UKSvDGO4CZkOb4uxR0AG0Yhc1TduazFUfDzZ7
         W8kdEuTJQVG2bSoQXsd/64+gAVEhYWpfUldcK9zc=
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 14FE66029D;
        Tue, 25 Sep 2018 09:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537869056;
        bh=kQvKEIHLMYZsK8z5rn3EZZrFn+b4HNnkA2Xag4M8UNQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hB3pElGl+lergE6W6cCo8NJGVTJlUILleVOYYC92Hx+maXrRfGHcNrQdrCXAG5AIJ
         uPG3PD+ojXZSniXV3h07h1dnu0Yt3UKSvDGO4CZkOb4uxR0AG0Yhc1TduazFUfDzZ7
         W8kdEuTJQVG2bSoQXsd/64+gAVEhYWpfUldcK9zc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14FE66029D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f182.google.com with SMTP id n3-v6so12588562qkn.8;
        Tue, 25 Sep 2018 02:50:56 -0700 (PDT)
X-Gm-Message-State: ABuFfogRFbFOuxLpWEWgn+hBdakD4wpd/80VaztbadlOSmABC7Cf2pAK
        l2x2YJLZ24t6W+o9bnTd/0wtUdc3zSsHv5IptgI=
X-Google-Smtp-Source: ACcGV62SiMM16WZCKkP8EBBx2aYsFAwS602j+IG2YorepMuJA0aRvaWcDWIkvtIrlLT+wGMgMVXepGiw7k50tc8C2AA=
X-Received: by 2002:a37:9904:: with SMTP id b4-v6mr145593qke.102.1537869055370;
 Tue, 25 Sep 2018 02:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180807174739.23379-1-vivek.gautam@codeaurora.org>
 <CAE=gft5ONyVQ6qkP41G_vx-Djo0MqHhXZ6pjTOZjTDpPgwukZQ@mail.gmail.com> <CAFp+6iEpZThehq4896dmYifvbNF5wa3ESyw7yBv7vpUbtQKzhA@mail.gmail.com>
In-Reply-To: <CAFp+6iEpZThehq4896dmYifvbNF5wa3ESyw7yBv7vpUbtQKzhA@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 25 Sep 2018 15:20:43 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFVQKvWj7o+nmoJVhgQpOz2gZ_Eo+e8c8qdoc18waJ+zw@mail.gmail.com>
Message-ID: <CAFp+6iFVQKvWj7o+nmoJVhgQpOz2gZ_Eo+e8c8qdoc18waJ+zw@mail.gmail.com>
Subject: Re: [PATCH 1/1] scsi/ufshcd: Fix NULL pointer dereference for in ufshcd_init
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jejb@linux.vnet.ibm.com, evgreen@chromium.org,
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

Hi Martin,

On Wed, Aug 29, 2018 at 1:50 PM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> On Wed, Aug 29, 2018 at 1:13 AM Evan Green <evgreen@chromium.org> wrote:
> >
> > On Tue, Aug 7, 2018 at 10:48 AM Vivek Gautam
> > <vivek.gautam@codeaurora.org> wrote:
> > >
> > > Error paths in ufshcd_init() ufshcd_hba_exit() killed clk_scaling
> > > workqueue when the workqueue is actually created quite late in
> > > ufshcd_init().
> > > So, we end up getting NULL pointer dereference in such error paths.
> > > Fix this by moving clk_scaling initialization and kill codes to
> > > two separate methods, and call them at required places.
> > >
> > > Fixes: 401f1e4490ee ("scsi: ufs: don't suspend clock scaling during clock
> > > gating")
> > >
> > > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Cc: Subhash Jadavani <subhashj@codeaurora.org>
> > > Cc: Matthias Kaehlcke <mka@chromium.org>
> > > Cc: Evan Green <evgreen@chromium.org>
> > > Cc: Martin K. Petersen <martin.petersen@oracle.com>
> > > ---
> > >
> > > Bjorn, Subhash,
> > > I am not certain of some of these devfreq, and clk_scaling bits
> > > that are moved as part of this patch. Please help in reviewing the
> > > change in the light of these features, and related sequence should
> > > be followed.
> > > Thanks.
> > >
> >
> > You're right, there is a lot of logic moving around here. I think this
> > looks okay to me.
> >
> > Reviewed-by: Evan Green <evgreen@chromium.org>
>
> Thanks Evan.
>
> Best regards
> Vivek

Gentle ping. Will you please consider picking this patch for the merge?
Thanks
Vivek

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
