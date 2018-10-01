Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D13CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7CD2146D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7CD2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbeJARUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:20:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46780 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbeJARUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:20:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB59118A;
        Mon,  1 Oct 2018 03:43:35 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.Emea.Arm.com [10.4.12.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E99D33F5B3;
        Mon,  1 Oct 2018 03:43:33 -0700 (PDT)
Date:   Mon, 1 Oct 2018 11:43:31 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steve McIntyre <93sam@debian.org>
Cc:     Will Deacon <will.deacon@arm.com>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        oleg@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org,
        dave.martin@arm.com, linux-arm-kernel@lists.infradead.org,
        viro@zeniv.linux.org.uk
Subject: Re: [RESEND PATCH 0/2] Don't use SIGMINSTKSZ when enforcing
 alternative signal stack size for compat tasks
Message-ID: <20181001104330.GC131162@arrakis.emea.arm.com>
References: <1536158083-30166-1-git-send-email-will.deacon@arm.com>
 <20180926103627.b6kxzdmqqsj3545h@arm.com>
 <20180928131805.aunjzciyvaad7z5a@tack.einval.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928131805.aunjzciyvaad7z5a@tack.einval.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 02:18:11PM +0100, Steve McIntyre wrote:
> On Wed, Sep 05, 2018 at 03:34:41PM +0100, Will Deacon wrote:
> >Hi all,
> >
> >This is a resend of:
> >
> >  http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593559.html
> >
> >now based on 4.19-rc2.
> >
> >The Debian folks have observed a failure in the 32-bit arm glibc testsuite
> >when running under a 64-bit kernel. They tracked this down to sigaltstack(2)
> >enforcing the alternative signal stack to be at least SIGMINSTKSZ bytes,
> >which is higher for native arm64 tasks than compat 32-bit tasks.
> >
> >These patches resolve the issue by allowing an architecture to define
> >COMPAT_SIGMINSTKSZ for compat tasks, which is then used by the sigaltstack
> >checking code.
> >
> >Feedback welcome,
> 
> Apologies for the delayed response here - conference travel etc . got
> in the way... I've just tested and I can confirm that this patchset
> fixes our reported bug (as in https://bugs.debian.org/904385). Thanks
> Will!
> 
> Tested-by: Steve McIntyre <93sam@debian.org>

Thanks for confirming Steve.

As there is no functional change for other architectures, I'll queue
both patches through the arm64 tree. If anyone objects, please let me
know before the merging window.

-- 
Catalin
