Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6069C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679662082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679662082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeJCCws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:52:48 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43056 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeJCCws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:52:48 -0400
Received: by mail-ot1-f68.google.com with SMTP id e21-v6so3201561otk.10;
        Tue, 02 Oct 2018 13:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qd8fzAmrC/jqxriN94pkjCNMaBeuTJeXX6kZurrzyCg=;
        b=c7HAl+Rsrs3La6W4PrAV7GciQr48/WCO0cRmkP3lAhwz/ygoQVcz78RoFpOo24wm0r
         ppv+omvneGVctPDnqgPyHgZP6M/7J9FO/WHmfSmStfUqJ5PE3ZsjrJ4V6y76Glnq88Pm
         buTlD0jzdoVMrqx3QGYo42DSYaIwHFp+2vlT3HCN8Cx4BAlls04us0ZB8fWFHzNEmuXc
         amJmbmyvf/BiHFsRGZ7nZqQZvVEAJZRPbRJZE9TLu6+rsVCdvd30pfYCY/IC08I7zHka
         tirH5zzJRok84twNIOKxm0JPMELfTiMxY9SS2Hi7lo6jdBODkxtEpw5zhPEhhceaLtzJ
         RhvA==
X-Gm-Message-State: ABuFfogs8yuxsQkuOJe+RXhpUkpqWG8uhxCLSIHJwSPbv3LN9gD+Jg6h
        bdrIeM3teZs7OzIEfZWeLbbMOlLC2fk=
X-Google-Smtp-Source: ACcGV62a9TVJfj6kezXdH+zUUnfY4LGcDCrrA81Ar7wgzGHJJXagUh+XOZVDpXBlpv6QhqsK6RqvjA==
X-Received: by 2002:a9d:3ea4:: with SMTP id b33-v6mr5463259otc.267.1538510864020;
        Tue, 02 Oct 2018 13:07:44 -0700 (PDT)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id t103-v6sm2650692ota.10.2018.10.02.13.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 13:07:42 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id o13-v6so3218700otl.4;
        Tue, 02 Oct 2018 13:07:42 -0700 (PDT)
X-Received: by 2002:a9d:186:: with SMTP id e6mr967421ote.68.1538510861803;
 Tue, 02 Oct 2018 13:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
 <1538124204-31406-6-git-send-email-madalin.bucur@nxp.com> <CADRPPNQgGAYTCmppyxPwQnnC433QLm21D5iq_4EvSj0LrsAxGQ@mail.gmail.com>
 <AM6PR04MB400877EC0C140A7D919AEF41ECE80@AM6PR04MB4008.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB400877EC0C140A7D919AEF41ECE80@AM6PR04MB4008.eurprd04.prod.outlook.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 2 Oct 2018 15:07:30 -0500
X-Gmail-Original-Message-ID: <CADRPPNSNc50K8EcJUuQ-cnBs4NhHnNnhEDwdTSXgxm0j1FMCTw@mail.gmail.com>
Message-ID: <CADRPPNSNc50K8EcJUuQ-cnBs4NhHnNnhEDwdTSXgxm0j1FMCTw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] soc/fsl_qbman: export coalesce change API
To:     madalin.bucur@nxp.com
Cc:     Roy Pledge <roy.pledge@nxp.com>, claudiu.manoil@nxp.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Scott Wood <oss@buserror.net>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 1:08 AM Madalin-cristian Bucur
<madalin.bucur@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Li Yang [mailto:leoyang.li@nxp.com]
> > Sent: Tuesday, October 2, 2018 12:50 AM
> > To: Madalin-cristian Bucur <madalin.bucur@nxp.com>
> > Cc: Roy Pledge <roy.pledge@nxp.com>; Claudiu Manoil
> > <claudiu.manoil@nxp.com>; Catalin Marinas <catalin.marinas@arm.com>; Scott
> > Wood <oss@buserror.net>; moderated list:ARM/FREESCALE IMX / MXC ARM
> > ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; linuxppc-dev
> > <linuxppc-dev@lists.ozlabs.org>; lkml <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH v2 5/5] soc/fsl_qbman: export coalesce change API
> >
> > On Fri, Sep 28, 2018 at 3:45 AM Madalin Bucur <madalin.bucur@nxp.com>
> > wrote:
> > >
> > > Export the API required to control the QMan portal interrupt coalescing
> > > settings.
> >
> > These are new APIs not just old APIs being exported.  What is the user
> > of these APIs?  Is the user being submitted?  We cannot have APIs in
> > kernel that has no users.
>
> Hi,
>
> These are new APIs that will be used in the DPAA Ethernet driver.
> Changes for the DPAA QBMan and DPAA Ethernet follow different paths upstream
> so the Ethernet driver patch that makes use of these APIs will be sent when
> these changes reach the net-next/master tree.

Applied for next after changing from "export API" to "add API" in the
introduction and updated the subsystem prefix.

Regards,
Leo
