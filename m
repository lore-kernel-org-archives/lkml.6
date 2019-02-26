Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D37CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70CE21848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YBMRshAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfBZRW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:22:29 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36885 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfBZRW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:22:29 -0500
Received: by mail-lf1-f68.google.com with SMTP id z196so9533194lff.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 09:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ee5tEawJoSYU2cgGBdtgCey4p8fJZGBDqNL20phEhQM=;
        b=YBMRshAsDJZ2+ws1yoOX/4x3CLvx+YZ8prWmPVYKr00ozly/scXkWxd7qksbJVzhMz
         fIRep/gJXj4j9RWASgZez83zNfl2AuZeH7GzaTF4Dw9e2ySXTiqOk7SlxSCGFOlehH9z
         ElFpeSu1zKNUWCl7Sde1gjEt8UhnmAukik/kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ee5tEawJoSYU2cgGBdtgCey4p8fJZGBDqNL20phEhQM=;
        b=gkQyK17gZWrxC7k6lcN06oNm9iv0wx36YCWEtd5nG9nE5GSk4taXLWLRQ5WTnxcOlD
         UNtPorf2HkccpHzP0VizY8c3z+0wY/1dMXJ7Vo7xvgGkPdutuXuaZ5tthSLiPaXsWixe
         ckFFxbGukmZ7QgkJ9QOChyDsSQ975tbbc1g7YNQi9VLDFvcPdgRaQ6YXByoPPVWTKCTN
         kH14GHNfE+7hB1YHtjwCTT5h0Z627VBeUJv51h+DrwirMqFnW3Jb/kKvVP6ImNQeTj+0
         zmug/+z4Wjc33zjgbMHFJMr6WEkDke+K9j3IfJGdV06yrbj0GWfARWEg0DXbYPVcF1yR
         mVDQ==
X-Gm-Message-State: AHQUAuZQjX/S+itzELNorhugihQMu2vOkdEuhBJn2QKejI7+X1HfvOCk
        ivyxpgree/ijqi+pHTVjditSmGmflOA=
X-Google-Smtp-Source: AHgI3IYeBrBE94oUY62s5bsd1LEsMa6gmjBzhH4fyskAP+3LRnuoj2ILGjwScpoacqLIx+07N//uNQ==
X-Received: by 2002:a19:3f44:: with SMTP id m65mr9917464lfa.136.1551201746763;
        Tue, 26 Feb 2019 09:22:26 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 2sm2996254ljh.41.2019.02.26.09.22.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 09:22:26 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id q128so11455904ljb.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 09:22:26 -0800 (PST)
X-Received: by 2002:a2e:2ce:: with SMTP id y75mr13584850lje.126.1551201313742;
 Tue, 26 Feb 2019 09:15:13 -0800 (PST)
MIME-Version: 1.0
References: <494cd639-89a7-8868-b63a-ea7cdcba9777@free.fr> <43265449-30e1-d514-3ffd-fc38530dac67@free.fr>
In-Reply-To: <43265449-30e1-d514-3ffd-fc38530dac67@free.fr>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 26 Feb 2019 09:14:35 -0800
X-Gmail-Original-Message-ID: <CAE=gft5VNr58yzp82GOAmLDGReRUaY3ZGp8aeRc0yRrF3WTW3g@mail.gmail.com>
Message-ID: <CAE=gft5VNr58yzp82GOAmLDGReRUaY3ZGp8aeRc0yRrF3WTW3g@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] scsi: ufs: Remove unused device quirks
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Ohad Sharabi <ohad.sharabi@wdc.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Gilad Broner <gbroner@codeaurora.org>,
        Raviv Shvili <rshvili@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, Kyuho Choi <kyuho.choi@sk.com>,
        Martin Petersen <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 5:36 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> The UFSHC driver defines a few quirks that are not used anywhere:
>
> UFS_DEVICE_QUIRK_BROKEN_LCC
> UFS_DEVICE_NO_VCCQ
> UFS_DEVICE_QUIRK_NO_LINK_OFF
> UFS_DEVICE_NO_FASTAUTO
>
> Let's remove them.
>
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Whoops, I lost track of this. Thanks for cleaning this up, Marc.

Reviewed-by: Evan Green <evgreen@chromium.org>
