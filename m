Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3379410-1519922822-5-13007027625926635163
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519922822; b=I1Nui0hLtax3hkf4yrwjB4wTcT1DzDdN8xEzbHWakKpARE3
    p8zsKwS73bfz7xWP2FzdBo6fV6MvlhOw1V4vRCXAO/P9/D/CrVIORsxexvMFQCS4
    GeyePbBmdDI4jPDFWALaGCM/tfV9sVWH3soGNK0cpYSXb3/JY28ScxuzVNwAarDu
    gRoCO3tm35YXeA9Lpzla3Pw9xjZzcQ/6X2TIPWfTmgBAShN8aK+v9dLbTN3WeO9r
    uWShpuhiwzzr4AJV2GsZonbPQaQnOMtDPsF4o4VWVy17jO2MBSGk5ngOAIfTbLiv
    dfyZc6xwz6c9oJUBGllSnvWaaBR/T/2v31CEBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519922822; bh=Kg20AsworijyJ1P9iveeKZbQ2c
    FWlXn9A1D9xqDIrrk=; b=BSO8xi37spC2rg1g/grd61Xh5vcRR+LtRLAlrjAhwy
    GwUYqcu/xF/52lG8RHJZl48aWerWER+P10NxJDsRR4X/BQuSVxgSOMBYzArP5/gj
    7LOc9ww2X/8gyCrU2h6wITzvMfD+Vm2ty8Mwh+jfcxpqEFAFAA9cOA/n5WLwX8Zm
    ARteThQz4ZCwG35lIvpEs9CUHU4jy5YuM2GJLPYiIBUIyzMToeXGHS1ElzUWhAMz
    tX/lYuPaFknTG3w1iL9/SOVhOpLqRwhGKzVGFKNaAxKnIO8m3KFw6uPqmKR/6EO8
    HE+AjwYh7tsZ/UNYO1JCc3V2mxFXc7tETw3vcCd+ppZQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=hYuVZj8V x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=hYuVZj8V x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033057AbeCAQqa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 11:46:30 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55759 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1033021AbeCAQq3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 11:46:29 -0500
X-ME-Sender: <xms:ZC6YWtiL2IAJiZ_UU6e-cdpHkBv8TrSxBfD3Ruw4KjoQsPpeutZYdA>
Date: Thu, 1 Mar 2018 17:46:30 +0100
From: Greg KH <greg@kroah.com>
To: Alex Shi <alex.shi@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
Message-ID: <20180301164630.GB23321@kroah.com>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 08:53:37PM +0800, Alex Shi wrote:
> Hi All,
> 
> Resent without non-upstream patches.
> 
> This backport patchset fixed the spectre issue, it's original branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
> A few dependency or fixingpatches are also picked up, if they are necessary
>  and no functional changes.
> 
> No bug found from kernelci.org and lkft testing. It also could be gotten from:
> 
> git://git.linaro.org/kernel/linux-linaro-stable.git v4.9-spectre-upstream-only

Also, how did you test, what platforms did you test, and did you test
that this actually did fix the spectre issue on your platforms?  If so,
what test did you use?

thanks,

greg k-h
