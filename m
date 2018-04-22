Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2849964-1524414064-2-16152761083927205382
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524414063; b=PJ3xYssKajZ4UmRqZKfFlI1mTu8d9X3WwC5GDqM3bXzGRDXULA
    /vc3GyEYym/uhKyN11jC0FvS2qv1TBZ2NfIRkc1ceb3+Ir85xOWmmvzVlscaxSx8
    IATewZzAGadIUuU0tyRlNEm1RJ2Q5p82H0dOLtkESw38HKbQNI53pWsa98JbKsXk
    Sh1sVMh9qw6gL82bNFGGH6Uxd9MDD6wnsKU5gkG1nLRn1uXTyLOFIepMLsauvz+9
    1EULHxUu4dgRVgDEELPCMjLzRiupYC4srsZwdxwTaP5jC9wyMZo6m3CKFVUzRzlH
    U7HsoxjIZnFG8IjZDG/CmIANlltVyJ5USXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524414063; bh=hS0cvXd9sU
    YFzIz3JQ/vhoovAecDnS/2ByywYH40p4I=; b=tLlYbaTDmoaqGkVFWKs95oQhNV
    SiLbOWPgD5jciXKRh6mhE+qdZWe/z28OI/0hZdPY4xCVkgXXsLoD8nIWQNMzIVzZ
    nE/esQYV8CNSO2pbag2sbu/6NJQUVsg4IoMAEvA1NMnvpoFz+KEqv6/vgHYhv+JO
    bW7ogsZX+lh5tn/C7sgutwnsJwoAO7OeTCKmRd+sZiWDFQ+xePbnOO+xNYmfv7+v
    Da57WSIt7xgvfpOK06FS5rWH8+CqOM/Hvnv9vk2gIhsKzyz37oRetzETA4/PC2qw
    ZBfJja0p5m1+3BLew6rl+BRgovgLLVIycuS49qDRe82ht3B4vLaSQpCx13zA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=klomp.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=klomp.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=klomp.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=klomp.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP4zSHwweLpS4Jtj7hNSFV+qK6agUHSLT0WASWhVtXIuk4U/+CshqBRVdUEKVgQRoq03aNWugK8yV8GQtkk3xGJXQWyG5ZFizMpXf8DUzeowsRY7lpv6
    DIJHKtbzV/NfpQ6v5HgfHSdtD4cwQrIehVB660Gl2ILLQcZ1O+hGecINOHSi6iuJ7QgqyZYDzBZQr86i/FKmMp8QLxflvOqxWjXbzNiPOA3UXsHvgcQ4V9p1
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=2JrL-qRpAAAA:8 a=J1Y8HTJGAAAA:8 a=CCpqsmhAAAAA:8 a=VwQbUJbxAAAA:8
    a=QuCwqiY0Z9-BzR7jcqsA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=u-Ic724avHVFXizCq7cn:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=ul9cdbp4aOFLsgKbc677:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeDVQVC convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Sun, 22 Apr 2018 12:21:02 -0400
Received: from wildebeest.demon.nl ([212.238.236.112]:52132 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbeDVQVC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 22 Apr 2018 12:21:02 -0400
Message-ID: <1524413453.3097.2.camel@klomp.org>
Subject: Re: sendmmsg flags userspace ABI change in kernel 4.6
From: Mark Wielaard <mark@klomp.org>
To: Florian Weimer <fw@deneb.enyo.de>, linux-api@vger.kernel.org,
        netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Tom Herbert <tom@herbertland.com>,
        valgrind-developers@lists.sourceforge.net
Date: Sun, 22 Apr 2018 18:10:53 +0200
In-Reply-To: <874lk8jq04.fsf@mid.deneb.enyo.de>
References: <874lk8jq04.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.22.6 (3.22.6-14.el7) 
Mime-Version: 1.0
X-Remote-Spam-Flag: NO
X-Remote-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on gnu.wildebeest.org
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Adding valgrind-developers to CC.

On Wed, 2018-04-18 at 21:03 +0200, Florian Weimer wrote:
> Since this commit:
> 
> commit 28a94d8fb35b3a75b802f368ae6f4a9f6b0d435a
> Author: Tom Herbert <tom@herbertland.com>
> Date:   Mon Mar 7 14:11:02 2016 -0800
> 
>     net: Allow MSG_EOR in each msghdr of sendmmsg
> 
>     This patch allows setting MSG_EOR in each individual msghdr passed
>     in sendmmsg. This allows a sendmmsg to send multiple messages when
>     using SOCK_SEQPACKET.
> 
>     Signed-off-by: Tom Herbert <tom@herbertland.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> the msg_flags argument in individual msghdr arguments is longer
> completely ignored for SOCK_SEQPACKET sockets.  msg_flags was and is
> still documented as ignored for sendmsg(2), so by analogy for
> sendmmsg(2) as well.
> 
> It seems that valgrind does not know about this yet, and due to
> limited use of SCTP, this userspace ABI change has not been noticed so
> far.

That is correct. If you look at coregrind/m_syswrap/syswrap-generic.c
(msghdr_foreachfield), it explicitly says:

   /* msg_flags is completely ignored for send_mesg, recv_mesg doesn't read
      the field, but does write to it. */

So the various valgrind syscall wrappers will not be called to inspect
the msg_flags field. This means you don't get warned if the msg_flags
field contains undefined bits for any syscall send_msg variant.

> What are the plans in this area?  Will other kinds of sockets start
> using the msghdr flags for sending?
> 
> A fully backwards-compatibility way to achieve this would be to
> specify that you have to pass a new flag to sendmmsg (MSG_PERHDR?), in
> its flags argument, to activate the per-msghdr flags.
> 
> The glibc DNS stub resolver relies on the previously documented
> behavior, and I wonder how widely we should backport the change:
> 
>   https://sourceware.org/bugzilla/show_bug.cgi?id=23037
> 
> If the MSG_PERHDR route will be taken, we can skip this work, and
> valgrind can flag uninitialized bits in msg_flags only if MSG_PERHDR
> is passed.  (I believe it would be difficult for valgrind to look at
> the socket type to determine whether undefined bits need reporting.)

We have abstracted the checking a bit so it can be reused for the
different ways a msg can be send, through socketcall, sendmsg and
sendmmsg. I am not sure we can easily determine the underlying socket
type. It seems to mean we would have to track the creation of all
socketfds. So having a flag bit for sendmsg and sendmmsg would be much
nicer.

Thanks,

Mark
