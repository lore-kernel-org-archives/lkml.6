Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B1BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823422084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823422084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeJEVbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:31:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42875 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbeJEVba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:31:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id z8-v6so13945209qto.9;
        Fri, 05 Oct 2018 07:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2dCcMiR8N7A7vGN9qBj3bWsUUXL+S7I9i2nYkLbK8gM=;
        b=HAeE8EPvEsG/uVMsELe0z4+1mlMSXJPgU1z1vhRAFnbyR3VcfNrou5Hah3JwvpVRLk
         HazllxB4B3hzIBDR2yOTzkmBJZgZY+h4hva95e5HSZ90+SO4Y6yOks9GPLnPJjt0sfTl
         /qoCUF6HglUZeLa7Ubkaf2rfPOsNAFR5GDxTr1PXUGJURRFAiyE2AUJiziHmI2jBVCl/
         16l0jlIWXcqiwobuIsoUIahgaxT58MBptiPx+g9JAx0cIoHpBSs30JXSR5Nxm3PX9csN
         lOLOC0hlYoP40va1LghzikcOoDDTWh33WxDRYOblm2nVDCk8+sqfDzSEK1lgIBh6Y+cM
         nUSg==
X-Gm-Message-State: ABuFfoj9v74TRhRugtFiZ1SrPs7VvLI3yU6xPBDNZRocyUhuaIWAw8lg
        rZkmrr7ZICfN44lwrShjaf0JwuOuSvD1fBYLodo=
X-Google-Smtp-Source: ACcGV60tGrbKPVA9JCy4AmFEaEZ2FZJlQ7EP/D2zkfNM/WYfUyIfhWuSOw6//xXzgdhE7OPGMAgjGhd2yE2Xuwhzg4o=
X-Received: by 2002:aed:2bc6:: with SMTP id e64-v6mr9593894qtd.132.1538749914735;
 Fri, 05 Oct 2018 07:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <1538332682-12018-1-git-send-email-andy.gross@linaro.org>
 <1538332682-12018-5-git-send-email-andy.gross@linaro.org> <CAK8P3a3SVftnc83sxe1NCsLbu23Buc+SHOpn9JUQJCZ=MXDuJw@mail.gmail.com>
 <20181005142831.GB15665@hector.nxp.com>
In-Reply-To: <20181005142831.GB15665@hector.nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 5 Oct 2018 16:31:38 +0200
Message-ID: <CAK8P3a3abKSJEKbrqFjP2Wikvx_OQETr3qiAqgSShsF7wE-JXA@mail.gmail.com>
Subject: Re: [GIT PULL] Qualcomm Device Tree updates for 4.20
To:     Andy Gross <andy.gross@linaro.org>
Cc:     arm-soc <arm@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Olof Johansson <olof@lixom.net>, linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 4:28 PM Andy Gross <andy.gross@linaro.org> wrote:
> On Tue, Oct 02, 2018 at 11:36:11AM +0200, Arnd Bergmann wrote:
> > On Sun, Sep 30, 2018 at 8:38 PM Andy Gross <andy.gross@linaro.org> wrote:
> > I also get this one warning (both with and without your patches):
> >
> > arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dtb: Warning
> > (graph_endpoint): /soc/mdp@5100000/ports/port@3/endpoint: graph
> > connection to node '/soc/hdmi-tx@4a00000/ports/port@0/endpoint' is not
> > bidirectional
>
> We may very well drop the sd600.  It was not distributed in any large numbers,
> was only used for development.  I am in the process of determining whether or
> not to send the patch removing this entirely.

Ok, fair enough, but please send either the removal or a patch to address
the warning before the merge window.

           Arnd
