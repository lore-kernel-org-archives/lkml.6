Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53339C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9524208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="QnRUKAGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9524208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wp.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbeGaCXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:23:06 -0400
Received: from mx4.wp.pl ([212.77.101.12]:39555 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbeGaCXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:23:05 -0400
Received: (wp-smtpd smtp.wp.pl 10582 invoked from network); 31 Jul 2018 02:38:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1532997530; bh=3P7kOdgN3SLEyIHP/MjFVYbBlFxIvqyjCYXFLQVb0a4=;
          h=From:To:Cc:Subject;
          b=QnRUKAGk8QzI5/Yp64Wkx40QjzI1hOl9Bi9WYJKpP01IYeZkAV3gFWIrUNfLAC6FD
           wKZBoAi9M53CPMaBw2DBPVgFyuVEeOFrlCNpSGx40hMJxdxJiSWSNcoTT2huEEXNOi
           SoyazoWg3UD3tkgEdFZv+zXctT/l2yTHljCdZLPQ=
Received: from 014.152-60-66-biz-static.surewest.net (HELO cakuba.netronome.com) (kubakici@wp.pl@[66.60.152.14])
          (envelope-sender <kubakici@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <jiri@resnulli.us>; 31 Jul 2018 02:38:50 +0200
Date:   Mon, 30 Jul 2018 17:38:43 -0700
From:   Jakub Kicinski <kubakici@wp.pl>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [RFC PATCH net-next v2 00/17] ethtool netlink interface (WiP)
Message-ID: <20180730173843.797f59e0@cakuba.netronome.com>
In-Reply-To: <20180730130747.GH2058@nanopsycho>
References: <cover.1532953989.git.mkubecek@suse.cz>
        <20180730130747.GH2058@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-WP-MailID: 4c13904483b475fc1edc223a6790e65e
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [YYOE]                               
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 15:07:47 +0200, Jiri Pirko wrote:
> >- find reasonable format for data transfers (e.g. eeprom dump or flash);
> >  I don't have clear idea how big these can get and if 64 KB limit on
> >  attribute size (including nested ones) is a problem; if so, dumps can
> >  be an answer for dumps, some kind of multi-message requests would be
> >  needed for flashes  
> 
> This is another thing that should go into devlink as it is not
> netdev-handled. We have now a "region" facility there which can be
> re-used.

+1 regions should cover the current use cases and are a better API IMHO.
