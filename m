Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DE1C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2C02168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2C02168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbeI1UEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:04:53 -0400
Received: from cheddar.halon.org.uk ([93.93.131.118]:54218 "EHLO
        cheddar.halon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeI1UEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:04:53 -0400
X-Greylist: delayed 1309 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Sep 2018 16:04:52 EDT
Received: from bsmtp by cheddar.halon.org.uk with local-bsmtp (Exim 4.89)
        (envelope-from <93sam@debian.org>)
        id 1g5sfm-0002V2-RM; Fri, 28 Sep 2018 14:19:10 +0100
Received: from steve by tack.einval.org with local (Exim 4.89)
        (envelope-from <93sam@debian.org>)
        id 1g5sep-0002TO-Dh; Fri, 28 Sep 2018 14:18:11 +0100
Date:   Fri, 28 Sep 2018 14:18:11 +0100
From:   Steve McIntyre <93sam@debian.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arnd@arndb.de, linux@dominikbrodowski.net, ebiederm@xmission.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        oleg@redhat.com, dave.martin@arm.com
Subject: Re: [RESEND PATCH 0/2] Don't use SIGMINSTKSZ when enforcing
 alternative signal stack size for compat tasks
Message-ID: <20180928131805.aunjzciyvaad7z5a@tack.einval.com>
References: <1536158083-30166-1-git-send-email-will.deacon@arm.com>
 <20180926103627.b6kxzdmqqsj3545h@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926103627.b6kxzdmqqsj3545h@arm.com>
X-attached: none
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Re-sending without the corporate footer garbage... ]

On Wed, Sep 05, 2018 at 03:34:41PM +0100, Will Deacon wrote:
>Hi all,
>
>This is a resend of:
>
>  http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593559.html
>
>now based on 4.19-rc2.
>
>The Debian folks have observed a failure in the 32-bit arm glibc testsuite
>when running under a 64-bit kernel. They tracked this down to sigaltstack(2)
>enforcing the alternative signal stack to be at least SIGMINSTKSZ bytes,
>which is higher for native arm64 tasks than compat 32-bit tasks.
>
>These patches resolve the issue by allowing an architecture to define
>COMPAT_SIGMINSTKSZ for compat tasks, which is then used by the sigaltstack
>checking code.
>
>Feedback welcome,

Apologies for the delayed response here - conference travel etc . got
in the way... I've just tested and I can confirm that this patchset
fixes our reported bug (as in https://bugs.debian.org/904385). Thanks
Will!

Tested-by: Steve McIntyre <93sam@debian.org>

-- 
Steve McIntyre  <93sam@debian.org>

