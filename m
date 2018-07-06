Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD3EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB7D22AAE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB7D22AAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933713AbeGFPzE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:55:04 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:56950 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933458AbeGFPzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:55:02 -0400
Received: by mail-io0-f199.google.com with SMTP id n11-v6so9869423ioa.23
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 08:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6v11xnMBAvX3bd2+8JBuq69QhTfUuuZONJONW6MEXgo=;
        b=ev1j5szcSJAvipQzUozqLYEXSkeE3LfS1OpP+6DjhMDCCxNHFvT/cfr8WDjB87Af+D
         vfEZSgMVmbgvzwi0LEvvK6VfTTGGcFsQrRP/miKHGdJ1DaSAMURZhvQvdPdEd+ptyzq6
         +gFdN3bVFRGklLdvQrW9MHqyQsW4Xa838IB9dpVtgrFOwxV7dsTgbNRcNJJYUShhoVnR
         kAStfPHsphZG/4naN+1/zlboENydU0KLuv0L29sydj5FfivnUT1Ps7HCPsKLPAPmJHXH
         4HSv1csyJM+mH4Oie73OgYZ4s9xHLnUNZWFycBq7et8qInnJ1VjpNN1GEh+VmhS6iQli
         RxxQ==
X-Gm-Message-State: APt69E0a6s0WE3QWicxUCmNNCXoJya0191uDAww8MbfLL54lytVLSS8f
        fM39JfgVrQKwhLcYRiXJxHmHtvxMJk2IN/7p1PJ348cJK/K4
X-Google-Smtp-Source: AAOMgpfr+HO/6Vme9do2mzJx8XTiNgun5Ce55/f6b/cybyoLNH3i9iR1AHka+VGIzZVR5U+8k/BlzdFC43VoGM/7UIs+SS0JMuN5
MIME-Version: 1.0
X-Received: by 2002:a6b:3042:: with SMTP id w63-v6mr4537921iow.5.1530892501528;
 Fri, 06 Jul 2018 08:55:01 -0700 (PDT)
Date:   Fri, 06 Jul 2018 08:55:01 -0700
In-Reply-To: <CACT4Y+bMV5bU9tJodF50fu2VZ0AH3ZE0WZsinNs7whEumMRWRA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be3779057056af41@google.com>
Subject: Re: KMSAN: uninit-value in af_alg_free_areq_sgls
From:   syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, smueller@chronox.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com

Tested on:

commit:         a00de5aa4da3 kmsan: delete some dead code
git tree:       https://github.com/google/kmsan.git/master
kernel config:  https://syzkaller.appspot.com/x/.config?x=b11f4cfb262ee607
compiler:       clang version 7.0.0 (trunk 334104)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13194968400000

Note: testing is done by a robot and is best-effort only.
