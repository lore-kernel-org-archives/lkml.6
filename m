Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC04C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70129218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SjUmPh5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfAXQwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:52:47 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43274 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfAXQwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:52:46 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2-v6so5842752lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 08:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OhnX21LR5IFTaJhnCOdLXb9BeznZ1d+nd23qWL+puCA=;
        b=SjUmPh5lu6dFy0OBzDdqMCoI2UNH6D+UHTohtiK7v8G1kR3Ie+WtPS6nuGXaacsGUc
         btz8IjI66s0y/PYVLjs13ZKhVr/nvB44ud/lxwuvPGu5491aWX+Dc3TjaOZ+4uLBOfGB
         Z+/74I4ZaTYAzjbG1LRafIQ7ZSg4awkDb09ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OhnX21LR5IFTaJhnCOdLXb9BeznZ1d+nd23qWL+puCA=;
        b=ZTeD0G6eGreGPU6yTXjDPQl4JFQ0Io0RF1WPHpSBMVBda414/7K+P+PYzjzkAOO+2m
         bEckXA4G7DPkt/wOciRv9//ghWZl+GiUCW+qRgNeGIvJTib1dAET9/uhSNvhiQi71Nzm
         VTDIXGKXoN+gcyREvZNcDUp3Dopro+wjgULP69riKKtdhiYItfafDtsa14JYS3PELSMl
         ONRv2dwTkfiH/I+B5fHuVju/RO8Lu1+BezDD557dAvciR26DKll5u4iAaiiM7eDakexn
         1HtaZMDIVAnxbnqIJHrj3B64cbD2ONQvQMUDhQ9f8As7Bm5uG7BzrRPN4SNXmw0SQGhc
         UTAQ==
X-Gm-Message-State: AJcUukfELQOiCx5h8PYW5gftVOxy+ieFsLPbDsqhSkW9D/z7ZozeYonN
        7X98qjgvx4SlId4VoQSAQeSbnwO8LgY=
X-Google-Smtp-Source: ALg8bN5P0thPG+9YH7kr3ZAcCS8528fuyLvSmmk7i5MyJxxKE42FuhgDb1KNOVTpcg6lMJsAeds/4A==
X-Received: by 2002:a2e:21a9:: with SMTP id h41-v6mr6234990lji.103.1548348764377;
        Thu, 24 Jan 2019 08:52:44 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id y24-v6sm1054611ljd.20.2019.01.24.08.52.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 08:52:42 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id b20so4808714lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 08:52:41 -0800 (PST)
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr6098975lfc.27.1548348760722;
 Thu, 24 Jan 2019 08:52:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548312692.git.asutoshd@codeaurora.org> <d6aa4d9bd29bbb2c3ee78e6635d4704e4113a26e.1548312692.git.asutoshd@codeaurora.org>
In-Reply-To: <d6aa4d9bd29bbb2c3ee78e6635d4704e4113a26e.1548312692.git.asutoshd@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 24 Jan 2019 08:52:03 -0800
X-Gmail-Original-Message-ID: <CAE=gft6P9ssNp_GRUFJT7BvJUHduorg=-bvi0KytDMWTd0pGew@mail.gmail.com>
Message-ID: <CAE=gft6P9ssNp_GRUFJT7BvJUHduorg=-bvi0KytDMWTd0pGew@mail.gmail.com>
Subject: Re: [<PATCH v1> 1/1] scsi: qcom-ufs: Add support for bus voting using
 ICB framework
To:     Asutosh Das <asutoshd@codeaurora.org>
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 11:02 PM Asutosh Das <asutoshd@codeaurora.org> wrote:
>
> Adapt to the new ICB framework for bus bandwidth voting.
>
> This requires the source/destination port ids.
> Also this requires a tuple of values.
>
> The tuple is for two different paths - from UFS master
> to BIMC slave. The other is from CPU master to UFS slave.
> This tuple consists of the average and peak bandwidth.
>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> ---
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  12 ++
>  drivers/scsi/ufs/ufs-qcom.c                        | 234 ++++++++++++++++-----
>  drivers/scsi/ufs/ufs-qcom.h                        |  20 ++
>  3 files changed, 218 insertions(+), 48 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> index a99ed55..94249ef 100644
> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> @@ -45,6 +45,18 @@ Optional properties:
>  Note: If above properties are not defined it can be assumed that the supply
>  regulators or clocks are always on.
>
> +* Following bus parameters are required:
> +interconnects
> +interconnect-names
> +- Please refer to Documentation/devicetree/bindings/interconnect/
> +  for more details on the above.
> +qcom,msm-bus,name - string describing the bus path
> +qcom,msm-bus,num-cases - number of configurations in which ufs can operate in
> +qcom,msm-bus,num-paths - number of paths to vote for
> +qcom,msm-bus,vectors-KBps - Takes a tuple <ib ab>, <ib ab> (2 tuples for 2 num-paths)
> +                           The number of these entries *must* be same as
> +                           num-cases.

I think we can do away with all of the qcom* ones, right? This should
be achievable with just interconnects and interconnect-names.

Also, is this patch based on a downstream tree? I don't recognize a
lot of the context. We'll need a patch that's based on an upstream
tree.

I'll wait to review the rest of the patch until rev 2, since it's hard
to reason about the patch with all the downstream stuff in there.
-Evan
