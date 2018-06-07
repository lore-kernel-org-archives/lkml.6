Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id hhz9LWxrGVtcRgAAmS7hNA
	; Thu, 07 Jun 2018 17:31:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5C705608B8; Thu,  7 Jun 2018 17:31:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	MAILING_LIST_MULTI,SORTED_RECIPS autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DE0AB605A2;
	Thu,  7 Jun 2018 17:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE0AB605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933956AbeFGRbG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:31:06 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:38555 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932959AbeFGRbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:31:02 -0400
Received: by mail-io0-f197.google.com with SMTP id g22-v6so8019494ioh.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 10:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=bz60YAikLzM3YD5cUOBw7joJ25T5UDFeWJRVqoiPH3M=;
        b=hadfhaTYFcMBudYt6FdbGMabBc7a0s7ZaHjEx/8QIbs4eDmfD+R79X5NUqJlzPWxta
         obQxFfu4lPUYkhl6xlwioHOkDcozSTYaVeNUv99k8a/uZGkhA0j2s9jL1ecTrV2Tfucw
         CHK0o0eL0d9AF82Pqqy5viUF3JJwNEEqib9RctyOT+aF8fZ6CujgkEUc3Dbi5nxbyVl0
         SMqXuLdm10THrfIiW28ndXqfvshCXbszUQjl09HgfZ4fRC1DLPZyNlp+CaeTlV29VBWC
         nJ8n2IrafaEh28XsT4xMuOWieqctdwElBxky2tKyxX61R93MJdPo8p60wiveqOlctW+9
         JMmg==
X-Gm-Message-State: APt69E0GYKXOIBYxP9/L2vTtx+3w7ERo5sm3i5pD1zBu6jXCzAl4p28o
        j1JzGqRjVmt3NETsH6JMXQj/RxcfbmoPedkrMcjqyzYTo1iW
X-Google-Smtp-Source: ADUXVKKoNNqQTYrK1zdC94omMNBDOnT20Lkum9wvGNzLpUi4vO517Y0vdHZWHK2z6EKgicOjnbYYaexHYWnSGhioaB0QwTXs7HRm
MIME-Version: 1.0
X-Received: by 2002:a6b:e0d:: with SMTP id 13-v6mr1175613ioo.91.1528392661826;
 Thu, 07 Jun 2018 10:31:01 -0700 (PDT)
Date: Thu, 07 Jun 2018 10:31:01 -0700
In-Reply-To: <20180607183629-mutt-send-email-mst@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af831a056e10a56d@google.com>
Subject: Re: KMSAN: uninit-value in _copy_to_iter (2)
From: syzbot <syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com>
To: avagin@openvz.org, davem@davemloft.net, dingtianhong@huawei.com,
        edumazet@google.com, elena.reshetova@intel.com,
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1119eddf800000

Note: testing is done by a robot and is best-effort only.
