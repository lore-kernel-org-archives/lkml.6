Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B64C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4B62084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4B62084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeJFAzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:55:42 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38658 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbeJFAzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:55:42 -0400
Received: by mail-oi1-f194.google.com with SMTP id u197-v6so11097370oif.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 10:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Actcao52kN4yvUWS3osNoAYY9fZKWCRjXjHWiTR8jik=;
        b=Mv3gC/9PGeSOyuyqQg2FLuDtNsN9imttb1kToIGdSGgswN0XYNWvQ3YOnlkIH8u8ic
         bMvwFfoieRI+QKo3YqHT4DdZTDxQBfq+QfEhlR/TJDeFiI23u21clk0pLD2DbLOSFERV
         SUTd6lzcQYZwU7itVcxr8fj/oH5bHKAI5b/ZOMlMupt5szrvCe+ia84ajJRhqIqTbpY0
         BX7KX4if1L+Pi1TgHqHLI4sSX8+nDTtU7k0WWWFVgx2DAe32t/E3jImHud7FJ5GoWDeD
         tyd1+shafS1Lb+qsl1yuxcR0295N7cNbp88G6gbmiCMy04jlLiIYyqZBqBqi9PWH+7/l
         14ow==
X-Gm-Message-State: ABuFfoiODvQrBt9lU0ksGpHmY/iSPE9ejpZXS5+oxdLoSLa8K6CVHWoP
        Ex6HW/75xG8kT9J3I2Y4v9/Zk5Me
X-Google-Smtp-Source: ACcGV61eMe3aT2gtapHLKny9BQrhwzw0+yVtpsg1eF9tG9JurkmnfFhwnk0fzqTDDF0nWBHijhSWCg==
X-Received: by 2002:aca:f341:: with SMTP id r62-v6mr22238oih.230.1538762153515;
        Fri, 05 Oct 2018 10:55:53 -0700 (PDT)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com. [209.85.167.177])
        by smtp.gmail.com with ESMTPSA id u63-v6sm2958391ota.75.2018.10.05.10.55.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 10:55:53 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id p125-v6so11096888oic.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 10:55:53 -0700 (PDT)
X-Received: by 2002:aca:a6d1:: with SMTP id t78-v6mr4840oij.293.1538762152743;
 Fri, 05 Oct 2018 10:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181004164715.14646-1-leoyang.li@nxp.com> <CAK8P3a3uM0_wO-wf7h+1UkUXUSTVtWSrmX_RLVzAC8e3LCuseg@mail.gmail.com>
In-Reply-To: <CAK8P3a3uM0_wO-wf7h+1UkUXUSTVtWSrmX_RLVzAC8e3LCuseg@mail.gmail.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 5 Oct 2018 12:55:41 -0500
X-Gmail-Original-Message-ID: <CADRPPNS458HcoCAQYj+jzm1O5BmVemxK4o4gdVBU2q1atJJVag@mail.gmail.com>
Message-ID: <CADRPPNS458HcoCAQYj+jzm1O5BmVemxK4o4gdVBU2q1atJJVag@mail.gmail.com>
Subject: Re: [GIT PULL] for-next updates for soc/fsl drivers for v4.20 take 2
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm@kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 10:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Oct 4, 2018 at 6:47 PM Li Yang <leoyang.li@nxp.com> wrote:
> >
> > Hi arm-soc maintainers,
> >
> > Please merge the following updates for next.
> >
> > PS.  One of the patches is depending on the last pull request for fixes to build
> > https://patchwork.kernel.org/patch/10622883/
> > I didn't include the fix patches directly in this pull request to prevent a
> > complicated merge.  Please let me know if there is a more preferred approach
> > to deal with dependencies between pull requests.
>
> Sorry, I'd rather not pull it like this, because that would result in a
> broken branch on my side that fails to build until it gets merged with
> the other one.
>
> I think the best way to handle this is for you to:
>
> - start a branch on the afa86d264a7c commit that you already sent me
>   for 4.20.
> - merge the soc-fsl-fix-v4.19-2 branch that you sent me for 4.19 into
>   that branch
> - rebase all patches from tags/soc-fsl-next-v4.20-2 on top of the merge
> - resend the pull request with the new branch

Thanks Arnd!   Will resubmit with this approach.

>
> This will result in a bisectable (i.e. each commit builds and works) branch
> that also merges cleanly with my fixes branch.
>
> Generally speaking, every branch you send must work standalone,
> and each commit in that branch can only depend on work that
> comes earlier in that branch.
>
>        Arnd
