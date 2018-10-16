Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789BEC169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2D42089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zn815+Kt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2D42089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeJPSih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbeJPSih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:38:37 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7408420881;
        Tue, 16 Oct 2018 10:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539686928;
        bh=nuifoULSBSkKKA36wbLiw6d/3CPThk/LivF7NJm2A0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zn815+Kt/tkbDfPLdRRhbBPYT+gO4WABUHpfxsDPWbJ9MubkEd8dmbAUH73vVNLlb
         umLGv8mnkI6N8v4OgpRC8fhSGHWRBiQHNaygai2HTPBxN3EXrNtWWAeZWZhveiF6g1
         31UkcR5JkdnYSAsAHK6TCGrGInsITGoAA5kfeWyg=
Date:   Tue, 16 Oct 2018 12:48:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] sysfs: constify sysfs create/remove files harder
Message-ID: <20181016104845.GB4768@kroah.com>
References: <20181004143750.30880-1-jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004143750.30880-1-jani.nikula@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 05:37:49PM +0300, Jani Nikula wrote:
> Let the passed in array be const (and thus placed in rodata) instead of
> a mutable array of const pointers.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  fs/sysfs/file.c       | 4 ++--
>  include/linux/sysfs.h | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
