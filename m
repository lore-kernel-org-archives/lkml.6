Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490C4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE1421480
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE1421480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeHVNaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:30:30 -0400
Received: from mx.socionext.com ([202.248.49.38]:49419 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbeHVNaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:30:30 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 22 Aug 2018 19:06:15 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id E6C50180237;
        Wed, 22 Aug 2018 19:06:15 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 22 Aug 2018 19:06:15 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 5AAB0403A3;
        Wed, 22 Aug 2018 19:06:15 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 2BBB31202F1;
        Wed, 22 Aug 2018 19:06:15 +0900 (JST)
Date:   Wed, 22 Aug 2018 19:06:14 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 00/14] ata: ahci-platform: add reset control support except for existing drivers
Cc:     Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-ide@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <cd35711a-5308-519d-7064-b82220a36d57@redhat.com>
References: <1534923430-9692-1-git-send-email-hayashi.kunihiko@socionext.com> <cd35711a-5308-519d-7064-b82220a36d57@redhat.com>
Message-Id: <20180822190614.974F.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Thank you for your comment.

On Wed, 22 Aug 2018 11:27:18 +0200 <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 22-08-18 09:36, Kunihiko Hayashi wrote:
> > Add support to get and control a list of resets for the device, and
> > add the flag indicating whether to use the reset. Existing drivers
> > set 0 to this flags.
> > > This series solves the issue of the previous patch [1] that was already
> > reverted [2].
> > [1] https://www.spinics.net/lists/linux-ide/msg55299.html
> > [2] https://www.spinics.net/lists/linux-ide/msg55379.html
> > > Kunihiko Hayashi (14):
> >    ata: ahci-platform: add reset control support and the flag to specify
> >      using reset
> >    ata: ahci_brcm: add second argument of ahci_platform_get_resources()
> >    ata: ahci_ceva: add second argument of ahci_platform_get_resources()
> >    ata: ahci_da850: add second argument of ahci_platform_get_resources()
> >    ata: ahci_dm816: add second argument of ahci_platform_get_resources()
> >    ata: ahci_imx: add second argument of ahci_platform_get_resources()
> >    ata: ahci_brcm: add second argument of ahci_platform_get_resources()
> >    ata: ahci_mvebu: add second argument of ahci_platform_get_resources()
> >    ata: ahci_qoriq: add second argument of ahci_platform_get_resources()
> >    ata: ahci_seattle: add second argument of
> >      ahci_platform_get_resources()
> >    ata: ahci_st: add second argument of ahci_platform_get_resources()
> >    ata: ahci_sunxi: add second argument of ahci_platform_get_resources()
> >    ata: ahci_tegra: add second argument of ahci_platform_get_resources()
> >    ata: ahci_xgene: add second argument of ahci_platform_get_resources()
> 
> When you change a function prototype, you must also change all
> the callers in a single commit, so that all intermediate commits
> will compile without errors, otherwise you will break git bisect.

Surely, these splitted patches will make git bisect fail.
I'll collect them in a single commit.

> Otherwise this looks good.
> 
> I suggest you split this like this:
> 
> 1) Add a flags argument to ahci_platform_get_resources(),
>     without adding support for any flags yet, so this just
>     changes the function prototype and passes 0 for the new
>     flags argument *everywhere* without any other changes
> 2) Add support for a AHCI_PLATFORM_GET_RESETS flag, basically
>     your current first patch, minus the prototype patches
> 3) A patch which passes AHCI_PLATFORM_GET_RESETS for the
>     generic ahci_platform driver (so break this out of your
>     first patch). Also describe in the commit message of this
>     patch why / for which platforms this is necessary.
> 
> The idea of doing 3. separately is that we can easily revert
> it in case of problems while keeping the core functionality
> in place. Note I do not expect this to be necessary.

Your split plan will be very useful for bisecting. I'll try it next.

---
Best Regards,
Kunihiko Hayashi


