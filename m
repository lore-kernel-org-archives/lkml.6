Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE97C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AEB206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AEB206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeJDXiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:38:50 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45850 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeJDXiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:38:50 -0400
Received: by mail-oi1-f196.google.com with SMTP id e17-v6so8005125oig.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 09:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfSf23CyrdvLboKCsO0qwmoIGpAxMa+h9eokTDQ3zo0=;
        b=IxH5C8v/2RXfOJizY8ockFkSI2Mdva+NKTnFYpuntiSbNCrRBhpl+9Zh3UtVIC+woC
         qqXbLezSvRDmY5OuVvWij+N8fAxbtzroKiGwyUx2b0Ag+VtBmVLo2MP5TIRqXI1Gyicp
         ssNjochGl9Wcyvt/qero/3loY0aNyIWm56xalVCaDCQndRkEI+0fWOjbIEwPlGEgZRUg
         SfEOc+LzadtfM93UfquDNXo5kVwsOBA0rzKHbQdJbSVIH9QciVXxSAsOxfr1lIrkiZEi
         Gc9ESbKye05qEkgnJe5WyymZ/CEWZ+iWxmCdkNFtIEFQ2EN+ua0ODLxrwqfwUXK1UqTP
         02CQ==
X-Gm-Message-State: ABuFfoip2kOTDcACQiK5C80p2CRTYShpcEy7NIyfY34vYnfdY+NOuUI1
        7raLVBz68w5FFtgspr3BmxKZMBHk
X-Google-Smtp-Source: ACcGV61Un/OGmIOBxiz1gVut4oUkHgnfNRquacNFDYmCwOJA+1TVPowgyxHZlm3qmOnsB+xZ/Ydclw==
X-Received: by 2002:aca:6896:: with SMTP id o22-v6mr3254330oik.96.1538671485471;
        Thu, 04 Oct 2018 09:44:45 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id l200-v6sm402555oig.20.2018.10.04.09.44.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 09:44:45 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id o13-v6so9820786otl.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 09:44:45 -0700 (PDT)
X-Received: by 2002:a9d:186:: with SMTP id e6mr3947653ote.68.1538671484818;
 Thu, 04 Oct 2018 09:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181001225827.21946-1-leoyang.li@nxp.com> <f1847dd8-0cbc-3be6-303f-73e5dac5e5d1@nxp.com>
In-Reply-To: <f1847dd8-0cbc-3be6-303f-73e5dac5e5d1@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 4 Oct 2018 11:44:33 -0500
X-Gmail-Original-Message-ID: <CADRPPNR4TjiYkTavm5brm-0BKF=SaY7PZsjyPjV4DyGFU-TN3A@mail.gmail.com>
Message-ID: <CADRPPNR4TjiYkTavm5brm-0BKF=SaY7PZsjyPjV4DyGFU-TN3A@mail.gmail.com>
Subject: Re: [GIT PULL] fixes for soc/fsl drivers for v4.19 take 2
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     arm@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 4:40 AM Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
>
> Hi Leo,
>
> On 02.10.2018 01:58, Li Yang wrote:
> > Hi arm-soc maintainers,
> >
> > Please merge the updated fix for the following issue.
> >
> > Regards,
> > Leo
> >
> > The following changes since commit 96fc74333f84cfdf8d434c6c07254e215e2aad00:
> >
> >    soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift() (2018-09-25 13:57:26 -0700)
> >
> > are available in the Git repository at:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git soc-fsl-fix-v4.19-2
> >
> > for you to fetch changes up to 5a1eb8b9542884592a018829bb1ff20c9695d925:
> >
> >    soc: fsl: qman_portals: defer probe after qman's probe (2018-10-01 17:47:43 -0500)
> >
> > ----------------------------------------------------------------
> > NXP/FSL SoC driver fixes for v4.19 round 2
> >
> > - Fix crash of qman_portal by deferring its probe if qman is not probed
> >
> > ----------------------------------------------------------------
> > Laurentiu Tudor (2):
> >        soc: fsl: qbman: add APIs to retrieve the probing status
> >        soc: fsl: qman_portals: defer probe after qman's probe
>
> There's a similar fix for bman portals [1]. I was under the impression
> that you plan to pick that up too.
>
> [1] "soc/fsl/bman_portals: defer probe after bman's probe", found here:
> https://lore.kernel.org/patchwork/patch/992009/

As mentioned in the patch description, it doesn't trigger a crash
right now.  It might not be qualified as a fix, so on a second
thought, I move it to the for-next pull request.

Regards,
Leo
