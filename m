Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45A5C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEC12082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEC12082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbeJCCap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:30:45 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36537 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeJCCap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:30:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id c18-v6so3161830otm.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 12:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GL99KgLcEp3HA0hAdM86rhDV2Dm+/tGpMMSlb2PNrVc=;
        b=Aa7rz+vbjrgNSE2zqCWg/o3FENxRrj6m2hu4mwnwwgK4Cpp9ISPdjTOriGPL7Jtx6b
         306SEx0KF0xbK+C+hOl0Ioizm1mz+L5Bcpb563OZo3mZor90WNdxmvFEWkePzgEvfFQa
         tLZquiurvT2isteT9hD6BAiKsN0obIxSFBddEdxaTXEkT3M03BeQtjTKHI6FsfMU5uIz
         y67UMnjGgS3/0fWlx5GaAx0VXxAi1eqVOi5/C7Vtgbb7jJkWvjBWBdyC4ou9uU/NIMrI
         5hf3FDc6qvNyxeFydI26x+hDPToEGdNrQtSpz3L9VhwCUtTs6m1hVjAG1ORuF+cwJ6iz
         1QwQ==
X-Gm-Message-State: ABuFfojGIWtrhk81D6pCA5K0rV1/HRUpDqIBxvMlem2HRo5YL7Jy2WdL
        KPH6ssRi96ullDhsZGspxqvJHwGAkRE=
X-Google-Smtp-Source: ACcGV63uotFqJaCi8aea+ujTQPy26wEi//rNjuG9C711z+2geiPvZeEZaoImC9vz29P+zQ9R5Jd+eQ==
X-Received: by 2002:a9d:41f6:: with SMTP id v51-v6mr9376416oti.8.1538509544892;
        Tue, 02 Oct 2018 12:45:44 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id 19-v6sm5746389oty.16.2018.10.02.12.45.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 12:45:44 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id h26-v6so3134605otl.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 12:45:44 -0700 (PDT)
X-Received: by 2002:a9d:20e1:: with SMTP id x88-v6mr10250691ota.338.1538509544105;
 Tue, 02 Oct 2018 12:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
 <CADRPPNTn99q=6fungYr-xcwY6vFiw9KTUp8UCEQ2u0+sv7vd4Q@mail.gmail.com> <AM6PR04MB40080234BA68140933F6B733ECE80@AM6PR04MB4008.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB40080234BA68140933F6B733ECE80@AM6PR04MB4008.eurprd04.prod.outlook.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 2 Oct 2018 14:45:32 -0500
X-Gmail-Original-Message-ID: <CADRPPNQmCXwxP7xJh_md37TofRivU6w2EyX1rTTtZX4LGjj+ng@mail.gmail.com>
Message-ID: <CADRPPNQmCXwxP7xJh_md37TofRivU6w2EyX1rTTtZX4LGjj+ng@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] soc/fsl/qbman: DPAA QBMan fixes and additions
To:     madalin.bucur@nxp.com, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Roy Pledge <roy.pledge@nxp.com>, claudiu.manoil@nxp.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Scott Wood <oss@buserror.net>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 1:29 AM Madalin-cristian Bucur
<madalin.bucur@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Li Yang [mailto:leoyang.li@nxp.com]
> > Sent: Tuesday, October 2, 2018 1:30 AM
> > To: Madalin-cristian Bucur <madalin.bucur@nxp.com>
> > Cc: Roy Pledge <roy.pledge@nxp.com>; Claudiu Manoil
> > <claudiu.manoil@nxp.com>; Catalin Marinas <catalin.marinas@arm.com>; Scott
> > Wood <oss@buserror.net>; moderated list:ARM/FREESCALE IMX / MXC ARM
> > ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; linuxppc-dev
> > <linuxppc-dev@lists.ozlabs.org>; lkml <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH v2 0/5] soc/fsl/qbman: DPAA QBMan fixes and additions
> >
> > On Fri, Sep 28, 2018 at 3:44 AM Madalin Bucur <madalin.bucur@nxp.com>
> > wrote:
> > >
> >
> > Applied 1-4 to for-next while waiting for clarification on 5/5.   And
> > updated the prefix to "soc: fsl:" style to be aligned with arm-soc
> > convention.  Please try to use that style in the future for soc/fsl
> > patches.
>
> Thank you, I've sent an email about the APIs.
> I'm not sure we need to align the prefix to arm-soc as the soc/fsl does not
> service only ARM but also PPC based SoCs and historically we've been using
> the soc/* format.

There is no kernel wide guideline about the format of subsystem prefix
in the patch subject. Different subsystems have their own
preferrences.  Soc is not considered as a separate subsystem, so we
followed the convention of the architectural subsystem that we merge
patches through.  Since we normally get soc patches through the
arm-soc tree right now, I think it would be better to follow the
convention of arm-soc to make them not looking too different in the
arm-soc pull requests.  Not sure how sensetive ARM-SOC maintainers
feel about this though.

Regards,
Leo
