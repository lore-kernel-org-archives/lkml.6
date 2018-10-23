Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA5CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6618B207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbQlXGMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6618B207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeJWTsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:48:06 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:40117 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbeJWTsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:48:05 -0400
Received: by mail-wm1-f44.google.com with SMTP id b203-v6so1375191wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 04:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=c+K06DMNlm3imluQG1Mxtt0OkrRdkZAgx0HLHemQHwI=;
        b=PbQlXGMS0xoQxO8oCH+LzGIoQiWb2xzbaJW6H38MsheoskANTOyUA7JV2NEIYVsWr5
         C6iIEQBfrNSuDl+v6D/ZKxjo/hNGykruk/lS03ZFcoYEjJc7ijIDD3ZiPcdPy51mHw65
         ZEhUvSA9rTyed6w9d4PZ4T03mm5AZ0DIKk+iU9ZIcE6h4Uu8kAsjnfdEyWaLXFaghVg6
         DfZb8j83RctogWRhyD+6HEd8vMnx3F0DF1TuNyXF4pvrOGqWBvzTmlSqb9aoLD26kNB5
         UJ7hNQaf+OLAfzy4D+yoZw7H3FcDQ/X8qOi/UTugloFDF+FmJzJply6Xjv2IGyAj6aYT
         FAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=c+K06DMNlm3imluQG1Mxtt0OkrRdkZAgx0HLHemQHwI=;
        b=LBJXiL21dgXgG7Hlli0NkWvLuiN9YLT4O5jPS8GXFO0LwfVT0v1HO4Ey6zQuMrqGTw
         3zzy5pkOHHaim+6qKJxCaqQXYBaTUV5HamouyVyVeKv5YnqcUHBH3RbfYqjGyNB+D+hA
         SEaeXKCpDUsxo6gJZrDXFgINB2idZus2BleCLEVuMvHTbc9K2+9VfJNEjun8XUe2BBFq
         PVS9v6o35KGc0oIz0IzG0I29xIeiAXXP7qT0H6HZBjdvTSk65BeZGMaBbh0ZXLydXv5o
         SQeq3QIWXLZ/KQNp3w6lWynu6fEdII3Dw9EHLHqSvxZ2iaLSStOULBF12ld+N+cGp38l
         twOw==
X-Gm-Message-State: AGRZ1gJceT2pD4a8pw2dwknup6keScbqlXhwA1RM2CfYVAbdYLGk36h/
        +zRuN2+SCSONMPGkbk3eZMg=
X-Google-Smtp-Source: ACcGV61m35gkJFd3zywLRJB7/LxgKdzjaeYYKhl7kiBn6w0kzHx+3FjuBBNk/ScFqXGGB750IJVCOw==
X-Received: by 2002:a1c:a851:: with SMTP id r78-v6mr15323199wme.97.1540293901252;
        Tue, 23 Oct 2018 04:25:01 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u76-v6sm910521wmd.10.2018.10.23.04.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 04:25:00 -0700 (PDT)
Date:   Tue, 23 Oct 2018 13:24:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [GIT PULL] x86/build change for v4.20
Message-ID: <20181023112458.GA55895@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-build-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus

   # HEAD: b3569d3a4b4fe93ee33eaa3c69ec3ed2cd3b276a x86/kconfig: Remove redundant 'default n' lines from all x86 Kconfig's

A small cleanup to x86 Kconfigs.

 Thanks,

	Ingo

------------------>
Bartlomiej Zolnierkiewicz (1):
      x86/kconfig: Remove redundant 'default n' lines from all x86 Kconfig's


 arch/x86/Kconfig       | 7 -------
 arch/x86/Kconfig.debug | 1 -
 arch/x86/xen/Kconfig   | 1 -
 3 files changed, 9 deletions(-)

