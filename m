Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7cVYO21lGVv1CAAAmS7hNA
	; Thu, 07 Jun 2018 17:04:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 49F9B606DD; Thu,  7 Jun 2018 17:04:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	MAILING_LIST_MULTI,SORTED_RECIPS autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C88C960290;
	Thu,  7 Jun 2018 17:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C88C960290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933882AbeFGREF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:04:05 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:37552 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753234AbeFGREC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:04:02 -0400
Received: by mail-io0-f199.google.com with SMTP id g20-v6so7999130ioc.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 10:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jWrcbCghHy+FtOI2lMql2ROEVMLMi3AU+yJwoFTMWc0=;
        b=okPrnJZJw7eHID+5JrznZlzNnlKcaBlE4MzXczZ5PSv4ugeUd+xH4p8JeH3ubZQRxw
         LksVvRqL/d6ZVCtp4t5nCFnXjslmr77NEIVk0q85mSRx1Taq/50fS3Zom824A/+LD5XF
         2aldxYXPPFK01vT5rj/AJRWLG79Gb9Gf7s0cwdCaMtEKlrc5KvabPT4sPM1SLZKwVpK7
         017Q0QjG84M/TzYL4DxyEhmaYWI7TK+4SFxrW/07W5gkSQXAU/pX9mw5Gtk3GgaYG04b
         7B39W+Cb+83I36PpXIIY76wZrRr/7Hv2GzTgv2V78tP7MmiXKVf9SyqR0h50OgiqCWBL
         FogQ==
X-Gm-Message-State: APt69E3OfvJ0vBMd7RQ6CjmGgOWkB2GN1qg98Ar7mT64SMlLUEYCM8wX
        4Yemg9qzdPQuOeBp+oG7nNM4fGFY2UX/8TKZVshMSDD3FSXk
X-Google-Smtp-Source: ADUXVKL5TLbrbhzdyYEXCXOg8uRF4ZCsB5wKRevdM6NpnqtsNdH2l1f2lKBT/Dkm6tXlKdbWS0G9ahJTSBAzjcoX9LSvnzGP9rVN
MIME-Version: 1.0
X-Received: by 2002:a6b:91d7:: with SMTP id t206-v6mr1167098iod.36.1528391042245;
 Thu, 07 Jun 2018 10:04:02 -0700 (PDT)
Date: Thu, 07 Jun 2018 10:04:02 -0700
In-Reply-To: <CACT4Y+btyLi+z09EO0JU-7AS_OfRbWiZvGn-KP9fndevh+xFNw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026a983056e1045b4@google.com>
Subject: Re: KMSAN: uninit-value in _copy_to_iter (2)
From: syzbot <syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com>
To: avagin@openvz.org, davem@davemloft.net, dingtianhong@huawei.com,
        dvyukov@google.com, edumazet@google.com, elena.reshetova@intel.com,
        jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew@mjdsystems.ca,
        mingo@kernel.org, mst@redhat.com, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, virtualization@lists.linux-foundation.org,
        willemb@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com

Tested on:

commit:         c6a6aed994b6 kmsan: remove dead code to trigger syzbot build
git tree:       https://github.com/google/kmsan.git/master
kernel config:  https://syzkaller.appspot.com/x/.config?x=848e40757852af3e
compiler:       clang version 7.0.0 (trunk 334104)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17dc3a8f800000

Note: testing is done by a robot and is best-effort only.
