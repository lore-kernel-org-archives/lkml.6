Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C46C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 05:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D07E20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 05:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D07E20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbeIBKAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 06:00:36 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:60193 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeIBKAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 06:00:36 -0400
Received: by mail-it0-f70.google.com with SMTP id a10-v6so9326183itc.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 22:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lh5uiGxRESp7cH5CH/z1eWukMXvXDnxfuySVk+aMVxI=;
        b=H67yYz7mxbkiiF5OsATqasaAAC4SInDGmKqsHlpTIJ1h6ZOudEWjWnPIEIXgw1KXcZ
         JUhUzrJeCAve+7OM7DU1/TZZHx7SaEmcU/qYtDsByBKg7gPVi6Ea4hRg54/GjxG2+t5G
         L/nrAPFQMd5kDExqd4IXom/8GUdD1g/hPWDl8EBqtwNAsJoZy1cph+CheMttl3GD7Lhi
         NKEdN/p5jB6zx2L+Ls55PO3mXs2d3yp5j+lr4ghoht6eavv6NPBy8wVzocqKYCR2kun+
         sZSCyXC8ZdzTMe9YN4XC2i6pwFLE22NX5EH6J/bqnyPsVtjtMcc5wt0gr02x+RRa/PX+
         1jbw==
X-Gm-Message-State: APzg51AxyPaWPS6pl3MH7Rq8HlMnwdmX/A7YXdDcOFgxg42FOpxUq7Xx
        UBveQ4/gPIZ64ZiWW06ImpCSjOqH7zn1g3MOI14hS4Ihgnjh
X-Google-Smtp-Source: ANB0Vdb7ZxBONDBY/Nx34DMSaYmF/Cb26Bbm3qo6Ohb8tNjhl5KtWsB83YHAzlwgY03HdEMFOyjLsxZiKD4r/g2o2TPYZI8iIPx4
MIME-Version: 1.0
X-Received: by 2002:a24:691:: with SMTP id 139-v6mr1687729itv.53.1535867161966;
 Sat, 01 Sep 2018 22:46:01 -0700 (PDT)
Date:   Sat, 01 Sep 2018 22:46:01 -0700
In-Reply-To: <CACT4Y+Y-wWVPYU0auia=u+XM9AS+JTxf1n8JfGLF-KTCBvNGvw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c848f0574dcf06c@google.com>
Subject: Re: WARNING in apparmor_secid_to_secctx
From:   syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>
To:     dvyukov@google.com, jmorris@namei.org, john.johansen@canonical.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
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
syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com

Tested on:

commit:         22dad84baabf apparmor: fix apparmor_secid_to_secctx incorr..
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor.git/4.18-syzbot-secid
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7c5a36688323465
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Note: testing is done by a robot and is best-effort only.
