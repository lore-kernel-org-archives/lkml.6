Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F19AC282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5111420989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfAUHfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:35:30 -0500
Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:54605 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728037AbfAUHf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:35:29 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl2.internode.on.net with ESMTP; 21 Jan 2019 08:43:41 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1glLLW-0000Bx-Vp; Mon, 21 Jan 2019 09:13:39 +1100
Date:   Mon, 21 Jan 2019 09:13:38 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jann Horn <jannh@google.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v4 1/3] fs: hoist EFSCORRUPTED definition into uapi header
Message-ID: <20190120221338.GY4205@dastard>
References: <20190118161440.220134-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118161440.220134-1-jannh@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 05:14:38PM +0100, Jann Horn wrote:
> Multiple filesystems can already return EFSCORRUPTED errors to userspace;
> however, so far, definitions of EFSCORRUPTED were in filesystem-private
> headers.
> 
> I wanted to use EUCLEAN to indicate data corruption in the VFS layer;
> Dave Chinner says that I should instead hoist the definitions of
> EFSCORRUPTED into the UAPI header and then use EFSCORRUPTED.
> 
> This patch is marked for stable backport because it is a prerequisite for
> the following patch.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Jann Horn <jannh@google.com>

Looks fine to me.

Acked-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
