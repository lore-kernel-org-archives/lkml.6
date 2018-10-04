Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4132C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36E421470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36E421470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeJDNGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 09:06:23 -0400
Received: from ozlabs.org ([203.11.71.1]:38533 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbeJDNGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 09:06:22 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42QjKF4NXnz9s8T; Thu,  4 Oct 2018 16:14:41 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8a03e81cb14712f986c5d5fa42a30ff2cbe3237c
In-Reply-To: <20180926122430.13924-1-msuchanek@suse.de>
To:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Haren Myneni <haren@linux.vnet.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/64s: consolidate MCE counter increment.
Message-Id: <42QjKF4NXnz9s8T@ozlabs.org>
Date:   Thu,  4 Oct 2018 16:14:41 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-26 at 12:24:30 UTC, Michal Suchanek wrote:
> The code in machine_check_exception excludes 64s hvmode when
> incrementing the MCE counter only to call opal_machine_check to
> increment it specifically for this case.
> 
> Remove the exclusion and special case.
> 
> Fixes: a43c1590426c ("powerpc/pseries: Flush SLB contents on SLB MCE
> 		errors.")
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8a03e81cb14712f986c5d5fa42a30f

cheers
