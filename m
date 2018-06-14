Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 01D87C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84D6208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vqu3UHu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84D6208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754843AbeFNHhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:37:35 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43080 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754812AbeFNHhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:37:33 -0400
Received: by mail-pl0-f68.google.com with SMTP id c41-v6so3041299plj.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 00:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AJGqtxtOpabTG+mU8E5hrdM61P/IobeJFiga3nMYWCw=;
        b=vqu3UHu1mNsn46LoJ9mRkCZraJ2rTMs7iKpvxxobzur6zZJyN4BloJ1F0YZ/c3hPGB
         pvYLJDZeqPhihAD1Yv99JdKPwkOjqMzuOIQrdtphJwDktGsspHEtZCCw89hWhH+FjMAB
         Iu8iES+0RGEdMHqw4iF0oK8G7ggfZcPCKLs+MAHfsFRPqhhl8oMd2QxyketQLAzM3Ols
         QLGdWulGdI7yDVYJVw2KbFW0OJMi7qplVL5wLWEDEeQ1Uvszq0WWMouCQiGlnHRd9NLC
         g0OJfNLJ9AXaCrLiXMRQbxc4Y/duhL9CUkZzc8Zasm4IsJtysabn/2sIszOL1ksybdu7
         9FvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AJGqtxtOpabTG+mU8E5hrdM61P/IobeJFiga3nMYWCw=;
        b=O6M2VSP5BmwLXSdzGBU6Ozg7Fv5pSNIkFIh9aOM/2/EnnQoCzh3+xfGux8YeqUcEtS
         i1i37W0ZkK0cuVotvWhw9w2QDcssaJO6xAZbklKwpE+eM+7wAb5cdzKe2/ImxiBvD8ze
         nVDMps+GGWRji0tVPSE7FHVL4NPQHIlY9vC0H5JS0iboxoujyDhVYZcMAwRSCmu3RNdb
         PL8pL0TzdpKu4i4+XnljZ7wjrtk472Pd4Ne7+u5F+7MaxtXGm1l7CjvVHwFVjBJc6rZN
         CnfDN9vyW2R9WorQRvJv77n/oJOpnkun86NGcla8GPBYGdU4vfFl8VW3QRQaT+mw4BZl
         3iUg==
X-Gm-Message-State: APt69E2Z7dRo16Gm9QSKc5wVAZa1BBjXbyeZieHlQfSuddVayXje8Lm8
        lu9DYCJ8CXmqgi7/plSA6Xfg+atAqVBrvAD+BkRA81Ne
X-Google-Smtp-Source: ADUXVKLa05NcV3PGDG7PYCh5YAUHc+xjs6+ajrSAhtB6Jlu4AZpw46J8vvvU/eEzTUBGYwOKO83nqPx2gh0sG8DYks4=
X-Received: by 2002:a17:902:bb81:: with SMTP id m1-v6mr1753396pls.117.1528961852832;
 Thu, 14 Jun 2018 00:37:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Thu, 14 Jun 2018 00:37:12
 -0700 (PDT)
In-Reply-To: <26c434ee-0a0a-fbba-282c-dabddfac652e@iogearbox.net>
References: <000000000000402477056e89f067@google.com> <26c434ee-0a0a-fbba-282c-dabddfac652e@iogearbox.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 14 Jun 2018 09:37:12 +0200
Message-ID: <CACT4Y+ZhMnjMd0E7V7Tv7HwFKqoeP078n-Q=ZScGMp3tLkrqmA@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bpf_skb_vlan_push
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     syzbot <syzbot+76de61614cb1abdd73fc@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 8:15 PM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> On 06/13/2018 08:13 PM, syzbot wrote:
>>> On 06/13/2018 06:17 PM, syzbot wrote:
>>>> Hello,
>>
>>>> syzbot found the following crash on:
>>
>>>> HEAD commit:    75d4e704fa8d netdev-FAQ: clarify DaveM's position for stab..
>>>> git tree:       bpf-next
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1754783f800000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=a601a80fec461d44
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=76de61614cb1abdd73fc
>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12c1e1bf800000
>>
>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>> Reported-by: syzbot+76de61614cb1abdd73fc@syzkaller.appspotmail.com
>>
>>>> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
>>>> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
>>>> 8021q: adding VLAN 0 to HW filter on device team0
>>>> 8021q: adding VLAN 0 to HW filter on device team0
>>>> ==================================================================
>>>> BUG: KASAN: slab-out-of-bounds in skb_at_tc_ingress include/net/sch_generic.h:535 [inline]
>>>> BUG: KASAN: slab-out-of-bounds in bpf_push_mac_rcsum net/core/filter.c:1625 [inline]
>>>> BUG: KASAN: slab-out-of-bounds in ____bpf_skb_vlan_push net/core/filter.c:2446 [inline]
>>>> BUG: KASAN: slab-out-of-bounds in bpf_skb_vlan_push+0x6b7/0x720 net/core/filter.c:2437
>>>> Read of size 5 at addr ffff8801b77347d0 by task syz-executor6/6529
>>
>>> Should be fixed already by:
>>
>>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=58990d1ff3f7896ee341030e9a7c2e4002570683
>>
>>
>>> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>
>> want 2 args (repo, branch), got 1
>
> Fair enough ... assumed default would have been master. ;-)

There is an issue with making defaults. Some email clients reflow
emails and split lines and git repo address can be lengthy and trigger
such reflow. To work around this syzbot currently looks for 2 "tokens"
after syz test, not necessary on the same line. The default for branch
will cause ambiguity in parsing: is it only repo without branch, or is
it repo with branch on the next line? Engineering hits reality...

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
