Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CDEC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C153920892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="QsXSfk8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C153920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeG3VOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:14:39 -0400
Received: from imap.thunk.org ([74.207.234.97]:44110 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731722AbeG3VOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IfqG0OkmDfJgFxgeXuFmrKFknmYtarMEy6K/qjpMssk=; b=QsXSfk8pAygWpHwlVgc+YJKJ62
        G9NcDNbAP0S6rSXeHhzZaVqJa/MS3GLt5iYhL+PFR811/O7mgBviUv81ajK7e3a0DZ6kYFML/A8VG
        Rym9YsuHDrRFn/I5hH2d6El6fQHfcaGkWCFoGwZ9ZWTqiR9VF/JfG0YsctpXgIFAXniw=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fkDzb-0006o0-BV; Mon, 30 Jul 2018 19:38:07 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6068B7A614A; Mon, 30 Jul 2018 15:38:06 -0400 (EDT)
Date:   Mon, 30 Jul 2018 15:38:06 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] ext4: mballoc: Fix spectre gadget in
 ext4_mb_regular_allocator
Message-ID: <20180730193806.GW21725@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jeremy Cline <jcline@redhat.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, stable@vger.kernel.org
References: <20180730180747.25200-1-jcline@redhat.com>
 <20180730183615.GU21725@thunk.org>
 <3f954645-e6b5-55d8-0ccd-2d1dd5ddb80e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f954645-e6b5-55d8-0ccd-2d1dd5ddb80e@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 02:46:59PM -0400, Jeremy Cline wrote:
> I dropped patch 1/3 and 2/3 from the original series because they can
> both be covered by some sanitation in fs/quota/quota.c, so the this is
> only patch from the v1 series that should be applied.
> 
> Sorry for not being more clear!

Great, thanks for the clarification!  I'll review the patch posthaste!

      	      	      		      	   	  - Ted
