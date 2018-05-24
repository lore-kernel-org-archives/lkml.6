Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162724-2-17560600228982696690
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
    1527162723; b=cSRkfcI2NcW3O1c6XEEC4XCSqJFCX/VIOEYSACORdPPXEtSwfI
    uy2u4Ywq1RzHjMSAxPlujiVXoUVdWS4iEBzGP1e6vjLkDHkvBnsrg+nmXLAx3diu
    dDNGxYloE/p/Jtti3HghIRLaT82pQb73IRUap5PQVbH0cb8s2Ppj8engJ6VpYBMy
    7rvgonLYIaoolwemQH0ZapzRA/s9tHTk0BluSznkpcwSJonyw4btehF55EfLDcmO
    g8OoPuyPEM+IZtIBvLGCAb+AycdYXY64X5V5/aTyjWn41aSPId3vWsW7jDlg/0Nw
    sEkLkuqDP9dlroWipp4jezNTBvkxh7j7JIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162723; bh=hjooRdtEZ74zPu1m0MeoVJhe8LAIK/
    IwisLLazU3EVo=; b=VKWB7l9HgQ/rZGm7+/65oBaxpbPDSr0uX+jEUpkzr7QI24
    n5cgASKnKGKapAblxMz3sFPw/d8nFVzvHmldIe2BZNaG7zcwRay8vA3YGG18iUmW
    IFREP92+gSx6WeL4aWXdkH53+Zxht3PzJLUkwzUWKqnwa4VSK58mTVPu5iqHRQDq
    xxIkv9c6/973TwWTmDJZciOhi0nXaTi5Ebdi8HVQVgtB1yIxJQ3oepVL7hTW9/by
    WvOXscYA5XOZB/ZrsO5zMBDsLk8FisbsW0ZehE0IGPuboWftMMgw7cfBJgRN4+VR
    JfbMwDw6b4oZcWigqWtZE8zE3dclGVRYZc9jZZ9Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=GJFwE99n x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=100;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=GJFwE99n x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=100;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLUgzoDE9Ns++l/6uf5syO9ftjwO3+aWTfAfc0p566GzGqeauNW96570z/Oc+y4oUvcUAw4KR+duhYsQteTaprjUui0QGNhwTx3Zu3P9wSRnTRUaFUfe
    TbG035qzZKujPvdCruGOPFA1/3BcB7B/fBDRP9AcMrYPk1M2BRjfcnp1Yd3cLzW3Cm/OZI35wbc70e0BsqqbK5bpuGYRPm2aocHwcuvfuwu7+duKOVvVs5mQ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 p=wCmvBT1CAAAA:8
    a=UK1r566ZdBxH71SXbqIOeA==:117 a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=hSkVLCK3AAAA:8
    a=drOt6m5kAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=Z4Rwk6OoAAAA:8
    a=ag1SF4gXAAAA:8 a=1IQeFdjzDtnnfWY1XQAA:9 a=QEXdDO2ut3YA:10
    a=DcSpbTIhAlouE1Uv7lRv:22 a=AjGcO6oz07-iQ99wixmX:22 a=cQPPKAXgyycSBL8etih5:22
    a=RMMjzBEyIzXRtoq5n5K6:22 a=6z96SAwNL0f8klobD5od:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 100
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966244AbeEXJqk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:46:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966941AbeEXJqh (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:46:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+4f2e5f086147d543ab03@syzkaller.appspotmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        "Ernesto A. Fernandez" <ernesto.mnd.fernandez@gmail.com>,
        Vyacheslav Dubeyko <slava@dubeyko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 91/92] hfsplus: stop workqueue when fill_super() failed
Date: Thu, 24 May 2018 11:39:08 +0200
Message-Id: <20180524093207.886343038@linuxfoundation.org>
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

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 66072c29328717072fd84aaff3e070e3f008ba77 upstream.

syzbot is reporting ODEBUG messages at hfsplus_fill_super() [1].  This
is because hfsplus_fill_super() forgot to call cancel_delayed_work_sync().

As far as I can see, it is hfsplus_mark_mdb_dirty() from
hfsplus_new_inode() in hfsplus_fill_super() that calls
queue_delayed_work().  Therefore, I assume that hfsplus_new_inode() does
not fail if queue_delayed_work() was called, and the out_put_hidden_dir
label is the appropriate location to call cancel_delayed_work_sync().

[1] https://syzkaller.appspot.com/bug?id=a66f45e96fdbeb76b796bf46eb25ea878c42a6c9

Link: http://lkml.kernel.org/r/964a8b27-cd69-357c-fe78-76b066056201@I-love.SAKURA.ne.jp
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+4f2e5f086147d543ab03@syzkaller.appspotmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>
Cc: Ernesto A. Fernandez <ernesto.mnd.fernandez@gmail.com>
Cc: Vyacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/hfsplus/super.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -585,6 +585,7 @@ static int hfsplus_fill_super(struct sup
 	return 0;
 
 out_put_hidden_dir:
+	cancel_delayed_work_sync(&sbi->sync_work);
 	iput(sbi->hidden_dir);
 out_put_root:
 	dput(sb->s_root);
