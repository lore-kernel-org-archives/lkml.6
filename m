Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C65C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D062087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbfA3Q3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:29:47 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:39719 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731156AbfA3Q3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:29:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 09BF218525;
        Wed, 30 Jan 2019 17:29:45 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id zkJhc9yuw9zT; Wed, 30 Jan 2019 17:29:42 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id E2C78184FC;
        Wed, 30 Jan 2019 17:29:42 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0BFC1E072;
        Wed, 30 Jan 2019 17:29:42 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C50E11E070;
        Wed, 30 Jan 2019 17:29:42 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Wed, 30 Jan 2019 17:29:42 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id B8B0825F7;
        Wed, 30 Jan 2019 17:29:42 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id B59AB80C3B; Wed, 30 Jan 2019 17:29:42 +0100 (CET)
Date:   Wed, 30 Jan 2019 17:29:42 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sysctl: Add panic-fatal-signals
Message-ID: <20190130162942.ppapys75ffvjgfct@axis.com>
References: <20190128084959.13060-1-vincent.whitchurch@axis.com>
 <20190128100545.b62193aa8f49e1de8d6ea8b7@linux-foundation.org>
 <20190130144851.GK11489@garbanzo.do-not-panic.com>
 <CAFLxGvyUpWRE3SWD2eX+M-TGKv7+6At0zsYYTTWw0y6gs3M4iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvyUpWRE3SWD2eX+M-TGKv7+6At0zsYYTTWw0y6gs3M4iw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 04:02:36PM +0100, Richard Weinberger wrote:
> Hmm, why can't this be a core dump helper?
> Such as:
> 
> #!/bin/sh
> # Usage:
> # echo "|/root/crash.sh %p %e %s" > /proc/sys/kernel/core_pattern
> 
> PID="$1"
> COMM="$2"
> SIGNAL="$3"
> 
> echo "$COMM ($PID) died by signal $SIGNAL, killing kernel" > /dev/kmsg
> echo c > /proc/sysrq-trigger

Yes, that looks like it should work.  Thanks.
