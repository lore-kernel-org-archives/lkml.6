Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E219ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 02:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B8F2064D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 02:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+05t3WY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B8F2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeGUDda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 23:33:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44226 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbeGUDda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 23:33:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id f23-v6so11158600edr.11;
        Fri, 20 Jul 2018 19:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWF+1WJ9mLKURF+92PQYadBqpaRQ/CmzrYmn/8NLj/0=;
        b=m+05t3WY82uYSFtfc9T2nu0fSMegtJ0XSTeG7lf7CAMh6sYUcFQtHOGluVi6ysdPfB
         uRDfYgN4H89QmibuUDOr1y/DX3uJUbiyMkDCdgao0T+5yxK+oXjng8aRjgSQ8rv7TU21
         JvFvBxZ+pSBdhXcihaHHvloJEp9t1p9wv57CLO7TywMVUfcBh0xm30zEd2nAtH3Ld2Df
         5WSXLQxx16y7eU6tUDFVLU+/ZH75bjkWGw/IN4cEGA6g87+hj4O0WDM2ogqxom6FeWA5
         7GaNgZ7lGDmSFJYQ8O8mAuo5jQxxhY1rVXrqhnCQalwFCihv5HQfxMCzG6URxKMhmZcg
         gzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWF+1WJ9mLKURF+92PQYadBqpaRQ/CmzrYmn/8NLj/0=;
        b=DUJlL8FBVjy/fFh3bMuXUc0fvWzABTAHIanBbc2zmIiy2vwAhWU8DYZEhv0izzxaZb
         CG54SzM7B/cp0PltjgfXlyU6ZJ4kEVQCdSDcffFtLFRrgoSD2++HxV+h3rBWeuuFkllG
         CDtvpXVA6DCT/rVhLtB0F6AulS4evbQKDDt/XBYUWCQwVvvlhCp45iTVZc8MPpTp0CMv
         DhlisrQTQpzl0F1KNOoshCqR+WvDId7obbHLixFq8K3PfzXD28FhsrHqi8U6uW1iMVek
         p+utcvBDCUmKgmEhnueYIfAPZbLdudfpNuDQpZkkFElLOzkielQgp3Z5K7d2zoEQL9c2
         Qoqw==
X-Gm-Message-State: AOUpUlHty3SCTU65gm6R/I5oQXiwf/YLPjUo4LxKvSR8fGlRpBmtSGph
        u7GCIIbgghLhB31NX3LA2jI5JeFpzjlMdmrmuF0=
X-Google-Smtp-Source: AAOMgpc1PiNSmCtG/Lc5JbqitRa4mq1jO1JHyCekhSJj+uWl/nNmEW0vRS0qlBvD9w7nCAFG2Npc5+G4U02wLksefcI=
X-Received: by 2002:a50:d7cb:: with SMTP id m11-v6mr4764247edj.19.1532140949033;
 Fri, 20 Jul 2018 19:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000076e6dc057131d87c@google.com> <CAF=yD-L0G2VC2-sCgsUmX=qmj5ukq6HS7Td1LDWitJkEUYdkHA@mail.gmail.com>
In-Reply-To: <CAF=yD-L0G2VC2-sCgsUmX=qmj5ukq6HS7Td1LDWitJkEUYdkHA@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 20 Jul 2018 21:41:48 -0500
Message-ID: <CAF=yD-LEJwZj5a1-bAAj2Oy_hKmGygV6rsJ_WOrAYnv-fnayiQ@mail.gmail.com>
Subject: Re: KMSAN: kernel-infoleak in put_cmsg
To:     syzbot+9adb4b567003cac781f0@syzkaller.appspotmail.com
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 12:32 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Tue, Jul 17, 2018 at 6:25 AM syzbot
> <syzbot+9adb4b567003cac781f0@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    123906095e30 kmsan: introduce kmsan_interrupt_enter()/kmsa..
> > git tree:       https://github.com/google/kmsan.git/master
> > console output: https://syzkaller.appspot.com/x/log.txt?x=166dafa0400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=848e40757852af3e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9adb4b567003cac781f0
> > compiler:       clang version 7.0.0 (trunk 334104)
> > syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=164e4ab0400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a41e40400000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+9adb4b567003cac781f0@syzkaller.appspotmail.com
> >
> > random: sshd: uninitialized urandom read (32 bytes read)
> > random: sshd: uninitialized urandom read (32 bytes read)
> > random: sshd: uninitialized urandom read (32 bytes read)
> > random: sshd: uninitialized urandom read (32 bytes read)
> > ==================================================================
> > BUG: KMSAN: kernel-infoleak in copy_to_user include/linux/uaccess.h:184
> > [inline]
> > BUG: KMSAN: kernel-infoleak in put_cmsg+0x5ef/0x860 net/core/scm.c:242
> > CPU: 0 PID: 4501 Comm: syz-executor128 Not tainted 4.17.0+ #9
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0x185/0x1d0 lib/dump_stack.c:113
> >   kmsan_report+0x188/0x2a0 mm/kmsan/kmsan.c:1125
> >   kmsan_internal_check_memory+0x138/0x1f0 mm/kmsan/kmsan.c:1219
> >   kmsan_copy_to_user+0x7a/0x160 mm/kmsan/kmsan.c:1261
> >   copy_to_user include/linux/uaccess.h:184 [inline]
> >   put_cmsg+0x5ef/0x860 net/core/scm.c:242
> >   ip6_datagram_recv_specific_ctl+0x1cf3/0x1eb0 net/ipv6/datagram.c:719
>
> > Bytes 2-3 of 24 are uninitialized
> > Memory access starts at ffff8801bde1f8a8
>
> This socket requests IPV6_ORIGDSTADDR.
>
> According to
>
>   > Uninit was stored to memory at:
>   >   ip6_datagram_recv_specific_ctl+0x1c3e/0x1eb0 net/ipv6/datagram.c:713
>   >   ip6_datagram_recv_ctl+0x41c/0x450 net/ipv6/datagram.c:733
>
> It is reading two uninitialized bytes at line
>
>                         sin6.sin6_port = ports[1];
>
> But this access is after the check
>
>                 __be16 *ports = (__be16 *) skb_transport_header(skb);
>
>                 if (skb_transport_offset(skb) + 4 <= (int)skb->len) {
>
> and the sent packet is 725B.
>
> The socket was opened with SOCK_RAW and protocol NEXTHDR_DEST.
>
>   r0 = socket$inet6(0xa, 0x3, 0x3c)
>
> so this is not a normal packet. Need to take a look at the contents.

The packet is generated in two stages with MSG_MORE. The first call
creates a zero-length packet, the second call appends the actual data.
Appends always happens in a frag (unless !SG). The existing test does
not catch this.

               if (skb_transport_offset(skb) + 4 <= (int)skb->len) {

Something like the following would be needed to ensure that the bytes
lie in the head.

-               __be16 *ports = (__be16 *) skb_transport_header(skb);
-
-               if (skb_transport_offset(skb) + 4 <= (int)skb->len) {

+               int off = skb_transport_offset(skb) + 4;
+
+               if (off <= 0 || pskb_may_pull(skb, off)) {
+                       __be16 *ports = (__be16 *) skb_transport_header(skb);

Here off can be negative, if the transport headers have already been
pulled, as in the case of UDP.

Casting the first four bytes to ports is really also not correct for
arbitrary protocols. This repro, for instance, has proto NEXTHDR_DEST.
This interface was perhaps not implemented with SOCK_RAW in mind;
either way, it's too late to exclude it now. But we can avoid the
__pskb_pull_tail and simply fail on odd packets like these:

-               if (skb_transport_offset(skb) + 4 <= (int)skb->len) {
+               if (skb_transport_offset(skb) + 4 <= (int) skb_headlen(skb)) {

From a quick read, IPv4 appears susceptible to this, too. Will take a look.
