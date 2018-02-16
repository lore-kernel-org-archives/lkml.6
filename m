Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3849420-1518770862-2-6870921923384359900
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518770861; b=ckPZwx3cgIDIA9bNaFzBJzR6tUpFAHD/U9ZyVa5w2UlMPUE
    N9rRfB0WLRnVQ7ci8BhMV8gKdQG38kJ5bzlhTs0ImsHXVY4oy+bYwvxCHo/v1cB7
    qUiDhfaUOeAkX5ExoZVOpzX00GCXyzH52pavuswNiS306c1uwOVNrAtiSEvBYjGt
    9x7Jpew1/BDdgdI3Ps0oOluJ5GygZeFLtkrJ5WBI771F4Lu3/8My4CAd4TrzUR6E
    HkWphTmG8bkipIr8zCpoBmyhtcyLzRHWoY63dGW9QM8G5Y9YzQxCPdUzI+NcGjZ6
    zT+l66Wy3PA4eWnMsntr0g1bLtsPBxsDw2ZnnvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518770861; bh=r
    GaQA9n0RAiCGvpo9xb1EkGLnQkXVIVOnGAOqxvNyFw=; b=BLv9OxXaocAG1jLBb
    oIttvO4FzlbvTXYykJPfdkvdYcEoAC6vFrjZcsaloz51tKstgjepJizCfOCe0Wxf
    K8IbHIuMtRqltYStnMCe14iASFJeTz9EuJf0rzCs2/G2G6zX8qCGJnrX0WJENLGI
    prjgnxP7I3NIPnWIhLMBa5dxOIxz0vU5TZ7/799gr0lfc5XDHeGPzm1owbBC+RXU
    7cvGUxF7LgdVDLWYIVg3KQ+oTGUYZ3li2fEWUy3FBsHxxIUZejdRcilZ8taxH25L
    2inJxKcaCFSNSdmLZ71qNj/b1hFE5IYeH4zg8EUW+7l0AwAsT8LczGPekvYuP7BI
    p8uww==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=buMAlJeS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kOBmHFA3;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=buMAlJeS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kOBmHFA3;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x225hBGc/ZEQ7j+zGd030QW2TJxD9fCTjRXvxJTv6iibreOPfeRzRwWZX2YMPbCdseQoigpvY+g==
From: Martijn Coenen <maco@android.com>
To: gregkh@linuxfoundation.org, john.stultz@linaro.org, tkjos@google.com,
 arve@android.com
Subject: [PATCH] ANDROID: binder: synchronize_rcu() when using POLLFREE.
Date: Fri, 16 Feb 2018 09:47:15 +0100
Message-Id: <20180216084715.14969-1-maco@android.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, ebiggers@google.com,
 linux-kernel@vger.kernel.org, maco@google.com,
 Martijn Coenen <maco@android.com>, dvyukov@google.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To prevent races with ep_remove_waitqueue() removing the
waitqueue at the same time.

Reported-by: syzbot+a2a3c4909716e271487e@syzkaller.appspotmail.com
Signed-off-by: Martijn Coenen <maco@android.com>
Cc: stable <stable@vger.kernel.org> # 4.14+
---
 drivers/android/binder.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 15e3d3c2260d..359220f87e1d 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4376,6 +4376,15 @@ static int binder_thread_release(struct binder_proc *proc,
 
 	binder_inner_proc_unlock(thread->proc);
 
+	/*
+	 * This is needed to avoid races between wake_up_poll() above and
+	 * and ep_remove_waitqueue() called for other reasons (eg the epoll file
+	 * descriptor being closed); ep_remove_waitqueue() holds an RCU read
+	 * lock, so we can be sure it's done after calling synchronize_rcu().
+	 */
+	if (thread->looper & BINDER_LOOPER_STATE_POLL)
+		synchronize_rcu();
+
 	if (send_reply)
 		binder_send_failed_reply(send_reply, BR_DEAD_REPLY);
 	binder_release_work(proc, &thread->todo);
-- 
2.16.1.291.g4437f3f132-goog

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
