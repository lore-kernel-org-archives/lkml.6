Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCDFC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B15214D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EV0jDXXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B15214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeJITxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:53:40 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39510 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeJITxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 15:53:39 -0400
Received: by mail-oi1-f193.google.com with SMTP id y81-v6so1064703oia.6;
        Tue, 09 Oct 2018 05:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E8l90IDZRsf+UE4xdWQoHWSJiqsRMCpene1hc8ltqOs=;
        b=EV0jDXXDZUMr91jYDQHBl3vEiPzC1qVngBdFBpPMceS/0Lhqre3Ndh46qQ9t+XjV2b
         hsZQztGPgqVNHvuscGJiK2XDi00tpOSt9ZVw+oKHWZ0WUEb+VXX4odBGYRJwYoRb6pUs
         Q3o4dUZ+6vsBiROEd7HMVZm4Na/+8AczTCbgVWPG25sAYotMc3lHtId4ZTvmz7MRHu70
         d4AsWKQlqWOIDd7glcYBa3vXI97l0KbUWOzEAMqwJqEs5Z+QUX7yb8fgDEx7Q5Hk7fXg
         QusHsuWshfGQMRrzZTNDq7LFaFtZtLJ6MLezQ054L2mJeMZoa3QRvuwvM5Yp4blGeLU8
         nERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E8l90IDZRsf+UE4xdWQoHWSJiqsRMCpene1hc8ltqOs=;
        b=Nclz5Cr9s71XRjYetcx2mnIBVEQMSB3ohTDjkVmR/ZRrVLhuaohSILCodk6s/S0Reg
         5HmHcIl3Om7gGwBEx1yn9IlZWbXCtWC/WyrRmwJO+eimjVBzgAg8fawUuKIzyaGMtCPJ
         H/w7/ATH/FnK+XeKEJ8NG+CnswFyGZWZfIYWUStgOCkjKuX35Rlx3LjBTsB/PJ4DxjOg
         QEO2/EhcrhlOWY+kFuASC+8WynqzrF4+fCzSrz2J2LbS4DXqFOnU05kHmpGVPcvD4vPT
         MB8OGEH8HF4uDqZC7iRxA7/Pmt0v14QYPuMhoD+o1fOPEOnsXRutUN33p/jMogU5EgAH
         sTqQ==
X-Gm-Message-State: ABuFfog/xy+zopEJ91mAt6PzN9OZ5i1LS4vxyYmtXDuEQFtcEp4C6AEQ
        VRtgQ/kS8PFMKkBfSLxzfGmrYKdyVAoYVsaI/Ng=
X-Google-Smtp-Source: ACcGV60DdvwDFmF5ExpuSG83gtKNE3PGTUqLXfY9yLj5hEKkNqWiEwG/iSaTjsfLDDwtmIN9Nao65EVMdU7jHQg29rM=
X-Received: by 2002:aca:e385:: with SMTP id a127-v6mr7390893oih.261.1539088614090;
 Tue, 09 Oct 2018 05:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
 <1538040281-21319-3-git-send-email-michal.vokac@ysoft.com>
 <68f4da21-6f0d-5bf9-b352-cdc423269080@ysoft.com> <CGME20181009002056epcas5p24207204c9e65e8f34382de6672adb993@epcas5p2.samsung.com>
 <20181009002031.GU3587@dragon> <20181009075145eucas1p2691c7d04aa8328080af7cbc4ab5e03b9~b4WFAVFkx0235802358eucas1p2c@eucas1p2.samsung.com>
 <bfbfd490-3872-2fd9-e088-3add596b987c@ysoft.com>
In-Reply-To: <bfbfd490-3872-2fd9-e088-3add596b987c@ysoft.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 9 Oct 2018 09:36:51 -0300
Message-ID: <CAOMZO5DdV9Sm9z6wX8e4LTvbokjnOMqtgOJQOvVvysVvzaBKGw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 3/3] ARM: dts: imx28-cfa10036: Fix the reset
 gpio signal polarity
To:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <Michal.Vokac@ysoft.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Tue, Oct 9, 2018 at 5:30 AM Vok=C3=A1=C4=8D Michal <Michal.Vokac@ysoft.c=
om> wrote:

> Sorry for the inconvenience :( Lesson learned..
>
> So in other words (no offense): broken drivers need to stay broken becaus=
e
> users may already get used to the broken behavior?

In order to keep the old dtb's working you could introduce a new
property (like reset-gpio-active-low, for example).

Then the driver behavior can be made untouched for the old dtb's and
only new dtb's with this new property would have the correct GPIO
reset behavior.
