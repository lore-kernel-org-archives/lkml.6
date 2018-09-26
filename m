Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC85C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D712E2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DAI/fxoh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DAI/fxoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D712E2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeIZM2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:28:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44082 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeIZM2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:28:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BF59F60A9B; Wed, 26 Sep 2018 06:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537942655;
        bh=2CCMDOlpsMMbp1mQj+KRpjV7Is/a5oI1Pwn7B7lNveg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DAI/fxohgqggCpF42aplHpTwr8HXyf2TO5qM6FORAavY72uKfVWcXqHBf00MMLSY6
         uUT7W+7p7/iNc/VJd1K2ozCDv84enZcVfnPeO0OIFrh2sdUh5vZ76LxcTVB7akEWgD
         FDEgtdzxYiP01pTd7bhsbfGUtEtQ997GZ1akXvcY=
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DBE2560AD8;
        Wed, 26 Sep 2018 06:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537942655;
        bh=2CCMDOlpsMMbp1mQj+KRpjV7Is/a5oI1Pwn7B7lNveg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DAI/fxohgqggCpF42aplHpTwr8HXyf2TO5qM6FORAavY72uKfVWcXqHBf00MMLSY6
         uUT7W+7p7/iNc/VJd1K2ozCDv84enZcVfnPeO0OIFrh2sdUh5vZ76LxcTVB7akEWgD
         FDEgtdzxYiP01pTd7bhsbfGUtEtQ997GZ1akXvcY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DBE2560AD8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f180.google.com with SMTP id c126-v6so15007481qkd.7;
        Tue, 25 Sep 2018 23:17:34 -0700 (PDT)
X-Gm-Message-State: ABuFfoifuU88HPpnJO9tSWNAonDh10pLN7fTfZI1pCS2gje0tbaHLgIm
        FGzxlCIe+92BQd16ifsyg3dXRrpPbizUj6jPinM=
X-Google-Smtp-Source: ACcGV60Tfmh6XSh5JwdGDSD7kuxm6Q2cNn1GNjUuzckcn25oY5q4zVSCB6r6u+A+LIAdwt43yjC5anXAI0jOEPgpW1s=
X-Received: by 2002:a37:4b82:: with SMTP id y124-v6mr3185190qka.118.1537942654094;
 Tue, 25 Sep 2018 23:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180807174739.23379-1-vivek.gautam@codeaurora.org>
 <CAE=gft5ONyVQ6qkP41G_vx-Djo0MqHhXZ6pjTOZjTDpPgwukZQ@mail.gmail.com>
 <CAFp+6iEpZThehq4896dmYifvbNF5wa3ESyw7yBv7vpUbtQKzhA@mail.gmail.com>
 <CAFp+6iFVQKvWj7o+nmoJVhgQpOz2gZ_Eo+e8c8qdoc18waJ+zw@mail.gmail.com> <yq1lg7pgjb4.fsf@oracle.com>
In-Reply-To: <yq1lg7pgjb4.fsf@oracle.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Wed, 26 Sep 2018 11:47:21 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGr6w3BLz14LYS=DVDhBSeE=Z6dSC8pFjpFHa5OWGAJbQ@mail.gmail.com>
Message-ID: <CAFp+6iGr6w3BLz14LYS=DVDhBSeE=Z6dSC8pFjpFHa5OWGAJbQ@mail.gmail.com>
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

On Wed, Sep 26, 2018 at 6:36 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Vivek,
>
> >> > > Bjorn, Subhash,
> >> > > I am not certain of some of these devfreq, and clk_scaling bits
> >> > > that are moved as part of this patch. Please help in reviewing the
> >> > > change in the light of these features, and related sequence should
> >> > > be followed.
> >> > > Thanks.
> >> > >
> >> >
> >> > You're right, there is a lot of logic moving around here. I think this
> >> > looks okay to me.
> >> >
> >> > Reviewed-by: Evan Green <evgreen@chromium.org>
> >>
> >> Thanks Evan.
> >>
> >> Best regards
> >> Vivek
> >
> > Gentle ping. Will you please consider picking this patch for the
> > merge?
>
> I was waiting for some feedback from Bjorn or Subhash.
Sure.

Bjorn, Subhash, gentle ping. How does this change look to you?
Would appreciate if you could please review this. Thanks.

Best regards
Vivek
>
> --
> Martin K. Petersen      Oracle Linux Engineering



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
