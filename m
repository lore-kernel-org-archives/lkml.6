Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5324BC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC59120834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=python.org header.i=@python.org header.b="XLSIDzIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC59120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=python.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeJZO7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 10:59:19 -0400
Received: from mail.python.org ([188.166.95.178]:37222 "EHLO mail.python.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeJZO7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 10:59:19 -0400
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com [66.111.4.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.python.org (Postfix) with ESMTPSA id 42hDTM3HzzzFqvK;
        Fri, 26 Oct 2018 02:23:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=python.org; s=200901;
        t=1540535016; bh=9aq3fRbViv2LKcrQdSoD22BCFsHbW2QvMiQTlsihiLc=;
        h=From:To:Cc:Date:References:Subject:In-Reply-To:From;
        b=XLSIDzISnSZ4Sjhxnyp+ZiZ9j8YuhFYZMyQV9TzGbQK81eDW6znUxW8xh/z6iskc2
         IZ5AuwJwU3BnLdSRdsvkgG1Iicc7qMmeToYQ6Riof1FFVHyjUR4sF+5wIrzD6ohyqT
         DeW6/Y8RAHE2PgDSFXUIghnEt624MQxqNa4K6C/U=
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1296D21B87;
        Fri, 26 Oct 2018 02:23:34 -0400 (EDT)
Received: from web4 ([10.202.2.214])
  by compute4.internal (MEProxy); Fri, 26 Oct 2018 02:23:34 -0400
X-ME-Sender: <xms:5bLSW75R7qE13fPWILT3ctHhgEt7lM0UYFJCxtxa8YH0LCMYELqnpA>
X-ME-Proxy: <xmx:5bLSW1CJQwPsfkemhev4eYnAjBXzrqKdRqiVK-avte2FXWx5NLTrUg>
    <xmx:5bLSW-NcjOXfCbfZNTw5OzZkCJ1_Ubyi4XRnXUa9CuwOaaiiYkC28g>
    <xmx:5bLSW5RI_QAelSh9SucM6O6CgcCq1sO7O3-N5wlN2RWkBbBvDS5SnA>
    <xmx:5bLSW26BcvUowtKNa1y_WgmfHJPCuEsF1WFKyGcddib3cqqyPsBNZQ>
    <xmx:5bLSW72utmDQElFMYDjtGnMwbr-CzerHQlBm6FvafpsJoB55gv2_BQ>
    <xmx:5rLSW-xNGofv8wQ4jL2adr9uFxn0uFod9DE-PA5kNf_LduO8eSqX-g>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 7C1E5BA7CD; Fri, 26 Oct 2018 02:23:33 -0400 (EDT)
Message-Id: <1540535013.1635199.1555208904.5BD00E7A@webmail.messagingengine.com>
From:   Benjamin Peterson <benjamin@python.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-63008d4f
Date:   Thu, 25 Oct 2018 23:23:33 -0700
References: <20180828035344.31500-1-benjamin@python.org>
 <20180830182848.GE6097@kernel.org>
 <1535665851.2058334.1491869472.4E860103@webmail.messagingengine.com>
 <1539143546.2716467.1536750504.65ADF11A@webmail.messagingengine.com>
 <20181010125506.GH10775@kernel.org>
 <1540262435.2865915.1551182688.3057DD9D@webmail.messagingengine.com>
 <20181024201804.GG15106@kernel.org>
Subject: Re: [PATCH] perf trace beautify: Beautify flags of mount(2) and
 umount(2).
In-Reply-To: <20181024201804.GG15106@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Oct 24, 2018, at 13:18, Arnaldo Carvalho de Melo wrote:
> Em Mon, Oct 22, 2018 at 07:40:35PM -0700, Benjamin Peterson escreveu:
> > 
> > 
> > On Wed, Oct 10, 2018, at 05:55, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Oct 09, 2018 at 08:52:26PM -0700, Benjamin Peterson escreveu:
> > > > Hi Arnaldo,
> > > > Did you get a chance to look at this again?
> 
> > > Thanks, for pinging me about it, will check.
>  
> > Will the main part of my patch manage to make the cut for 4.20?
> 
> The functionality will, but I'm implementing it differently, the model
> you used to create the patch is being phased out, now we're unsing a
> model that create tables from the header files where those flags are
> defined, so that when a new one gets added, we get it included
> automatically, please take a look at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=tmp.perf/trace.mount_flags
> 
> More specifically this one:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=tmp.perf/trace.mount_flags&id=341628af5643adbaa78097d528f34b4b16aa908f
> 
> That will be used by one like tools/perf/trace/beauty/pkey_alloc.c, that
> goes looking if the bits are set and if so, get the strings from the
> table, etc.
> 
> In time pkey_alloc__scnprintf_access_rights() will be further
> generalized, as all it needs is a strarray + the flags integer to
> produce a simbolic or-ed flags string.
> 
> Sorry for taking so long, kept being sidetracked with other stuff...

Thanks for explaining the new implementation. I'm excited to see these improvements to perf trace.
