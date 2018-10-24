Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD1FC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254A02082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254A02082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gherkin.frus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeJXXOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:14:54 -0400
Received: from gherkin.frus.com ([192.158.254.49]:57938 "EHLO gherkin.frus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeJXXOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:14:54 -0400
Received: by gherkin.frus.com (Postfix, from userid 500)
        id 11B5D3D005; Wed, 24 Oct 2018 09:46:29 -0500 (CDT)
Date:   Wed, 24 Oct 2018 09:46:29 -0500
From:   Bob Tracy <rct@gherkin.frus.com>
To:     linux-alpha@vger.kernel.org
Cc:     debian-alpha@lists.debian.org, linux-kernel@vger.kernel.org
Subject: vmlinux ld relocation errors on Alpha
Message-ID: <20181024144629.GA6338@gherkin.frus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back in January of 2017, a patch set was created for the 4.9.0 kernel and
*hopefully* sent upstream to address the subject issue.  The patch
implemented a workaround: defining a new "alphalib" section for all the
Alpha-specific library functions to be linked into the final vmlinux.
The patch was definitely not implemented in a vacuum: Helge Deller and
Michael Cree suggested the fix approach, and both Maciej W. Rozycki and
Matt Turner provided significant input along the way.

At this late date, I was forced to resync my Alpha build tree with the
one from "kernel.org", and noticed the patch set never made it into
mainline.  There's a definite possibility it was never submitted
upstream, and a further possibility it was NACK'd for some reason.

Am currently attempting a native 4.19.0 build with an up-to-date debian
"sid" toolchain.  If the build succeeds, than the issue became OBE for
whatever reason.  Otherwise, it would be nice to know what happened to
the patch set.  Should know either way as far as the build in a few more
hours.

--Bob
