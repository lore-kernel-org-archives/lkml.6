Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70648C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2325324ED0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2325324ED0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbeFXMgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 08:36:04 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:43686 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeFXMgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 08:36:03 -0400
Received: by mail-io0-f200.google.com with SMTP id n18-v6so5287230iog.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 05:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Q38Byr3N2SZKzGu0Q1vqY4zvJjDt6TIYEfTPnIHMYSk=;
        b=M9ITBBy4HSenNb789Dsp+5RIWnsnpSil1AzoYOuHAfNMat7kvyTDbIl7BWl/PkUD2G
         HvLUO7yI/3io9wbbA8n0skgMhRJmnm2jxS4RfX1UgNFRn08mNBRlcLzfyFQSw5eO/YS8
         qkoToHJQUlrHyTXJbVx/io6NvvpYpGolPImQqam+Cj4IZMXTrORLIGeT0tjrUIeY94wB
         BGMewSxby0o6fPXkP5l0PYjgQ/r/Ka9kKdXhh4C1O2aXOu8pOdbYpSQbyg/CjuT34pCn
         /SDQTSHIYR9VhsIh9RH1Eogub1Xp2ONPvUas0Ya/YiSnLVjbbPYDCQJtNfPG4V7YGxrN
         +KZA==
X-Gm-Message-State: APt69E2dxe2YEusZmpHjmQFOoABQBPU+2KB4RCfcgQSC+K8AeLI8NqsF
        33ogreXVNY4WZqaCakPH6VgyCC+3SXMJwnPhMhSUOS7868rJ
X-Google-Smtp-Source: AAOMgpcl75Nc6lw0okwSnGNafxD9nxdCe9t6MvHXmk/BR9lDWFth5wwwa1JNyWthSgph/z2GnOR1fEadSTc846eR3diwtMAKCIE1
MIME-Version: 1.0
X-Received: by 2002:a5e:8804:: with SMTP id l4-v6mr1140842ioj.25.1529843762572;
 Sun, 24 Jun 2018 05:36:02 -0700 (PDT)
Date:   Sun, 24 Jun 2018 05:36:02 -0700
In-Reply-To: <001a1142766c7793080569dc017b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007b7ba056f628249@google.com>
Subject: Re: BUG: unable to handle kernel paging request in corrupted
From:   syzbot <syzbot+bb6ed94ce15c5cd0be00@syzkaller.appspotmail.com>
To:     dvyukov@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    77072ca59fdd Merge tag 'for-linus-20180623' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12abe040400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=befbcd7305e41bb0
dashboard link: https://syzkaller.appspot.com/bug?extid=bb6ed94ce15c5cd0be00
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1762ec7f800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1556ee38400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+bb6ed94ce15c5cd0be00@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device bond0
IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
BUG: unable to handle kernel paging request at ffffc90001e1ee68
PGD 1da947067 P4D 1da947067 PUD 1da948067 PMD 1ad8b7067 PTE 0

