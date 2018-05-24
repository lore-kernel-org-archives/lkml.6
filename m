Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163687-5-10435807191183507072
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163686; b=Vjq3zG0igYQ2+50k5cK/AWB3n0Hh5Ws4rVrZSTCVujFQeURRaT
    E3mGErmk4UeMAOiVCENfFjDwd/pHWUr7SnM1kO2xxlHrYmRJvyWS57BxyfP5XSmE
    Z6v+sUn6Z3yqNY7wErQx7qR51s1X11Ld1yto8ofUx7FB3sC1DcZHNQD2wbScPsuE
    QGqnI/B6MokFWS54huNr1xP5zynss8DjXFn7FRKMLWIfauouYn1ZSfrF9dlcPKNA
    zq1b2XpoSeEpNPo6caFdWnqWMYuSNwHQrvGJhBkWFxlcs6yIbJCruBhlpiAsiotX
    ExUX7Ivs/MSOKM8P7oclJm9MXByR7cgMMCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163686; bh=aBEgqUgZdyHvhJ0JYNE881PSSEMs62
    BUZcB10QVL9ek=; b=gy+T+xF1YhWeWW8mzCeZtky5bUgTzBcjI5nqTtsZ13l2d7
    K/sD4fFLYK5vps7/EmBeY7Zt38L41J5TW7ssbHpuAAt9eVw/bWW5+AIxFW5AASSn
    oWzbCSl6iu97s32p5kiXObI3IGmzC/kqluhLGNMXz4Ua6gPGHvQ5iPzmuc/mqRCC
    kNSiZLgxzuI0RfNv9duuyJ0qD1t/sttVu3ASxLDOIDt/XNvOSxpHxMF4ov0VGyCh
    FDyqoOFIpSATU46BZ/WcWz08URn9nq9TnN+snCS6fF6MoJuAwn5Wy0a5nYcTpDGT
    IHh9yHkjIV/6LaCfAi2dFvmxa3e4nHB8chG6j/gQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=MQDYny+u x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=MQDYny+u x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMRBLRciCyxDaOoO/LoE/aehXlkLZzlpKU4OvifZCAORwN2KJaGYi7cHJftOoB/qCQPudllOQSdDCFbBEdcUp/72hKmOAqJ94Unl02RA7HOEP50Gx9Gd
    rzdcokaFuG0PjzCQgqxQ1ReBaJdbEpe2WexPgdI5eVp8AZ4DIc5TNMGFGYGT3s4FPRB84A/sKrYU5YwjPACHI64Vt/ZZT7BhnGTYmg91Kb3v5DxIvm9bD67Y
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=MYakio4dAAAA:8
    a=FOH2dFAWAAAA:8 a=drOt6m5kAAAA:8 a=Z4Rwk6OoAAAA:8 a=ag1SF4gXAAAA:8
    a=KIgr-69tmq1Z4tTJjfIA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=cei-m1nUyINrUup_78-m:22 a=i3VuKzQdj-NEYjvDI-p3:22 a=RMMjzBEyIzXRtoq5n5K6:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966632AbeEXMHU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966544AbeEXJnx (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:43:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Willy Tarreau <w@1wt.eu>, socketpair@gmail.com,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jens Axboe <axboe@fb.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: [PATCH 4.4 30/92] pipe: cap initial pipe capacity according to pipe-max-size limit
Date: Thu, 24 May 2018 11:38:07 +0200
Message-Id: <20180524093201.812425243@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>

commit 086e774a57fba4695f14383c0818994c0b31da7c upstream.

This is a patch that provides behavior that is more consistent, and
probably less surprising to users. I consider the change optional, and
welcome opinions about whether it should be applied.

By default, pipes are created with a capacity of 64 kiB.  However,
/proc/sys/fs/pipe-max-size may be set smaller than this value.  In this
scenario, an unprivileged user could thus create a pipe whose initial
capacity exceeds the limit. Therefore, it seems logical to cap the
initial pipe capacity according to the value of pipe-max-size.

The test program shown earlier in this patch series can be used to
demonstrate the effect of the change brought about with this patch:

    # cat /proc/sys/fs/pipe-max-size
    1048576
    # sudo -u mtk ./test_F_SETPIPE_SZ 1
    Initial pipe capacity: 65536
    # echo 10000 > /proc/sys/fs/pipe-max-size
    # cat /proc/sys/fs/pipe-max-size
    16384
    # sudo -u mtk ./test_F_SETPIPE_SZ 1
    Initial pipe capacity: 16384
    # ./test_F_SETPIPE_SZ 1
    Initial pipe capacity: 65536

The last two executions of 'test_F_SETPIPE_SZ' show that pipe-max-size
caps the initial allocation for a new pipe for unprivileged users, but
not for privileged users.

Link: http://lkml.kernel.org/r/31dc7064-2a17-9c5b-1df1-4e3012ee992c@gmail.com
Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
Reviewed-by: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: <socketpair@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Jens Axboe <axboe@fb.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/pipe.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -616,6 +616,9 @@ struct pipe_inode_info *alloc_pipe_info(
 		unsigned long pipe_bufs = PIPE_DEF_BUFFERS;
 		struct user_struct *user = get_current_user();
 
+		if (pipe_bufs * PAGE_SIZE > pipe_max_size && !capable(CAP_SYS_RESOURCE))
+			pipe_bufs = pipe_max_size >> PAGE_SHIFT;
+
 		if (!too_many_pipe_buffers_hard(user)) {
 			if (too_many_pipe_buffers_soft(user))
 				pipe_bufs = 1;
