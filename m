Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414329-2-11551807466509943490
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414329; b=vhsvuiE6osAHcDX7zenffmiGcYsp8N9JuYeF7WyInmLDYl2
    AQ0xRGzEPksjrojq7IoVO2WSbyUdnOr+WP7p0WaapycLnrd3Dl7GXVNc4xDpx//B
    NJn7ILh5SAyhsRLhm8XivmSqXn17yZyL+/f0q+SytiCdt5B2OtspIJVsQVuZp2wa
    Eko3y0aMY/2iH1KJGTtgcfhV4Nv9WtpqV2r1kWcrGoIYzxNgLWNMB3OtV1otp2Ap
    smNvEg7F35gCSij553M9bFL2IklFoyBPODhw/ffkQ6vdDr3RWZgT7uSirkAPovip
    wCvasrYMxzFSoDp1Ynai7sjwSsEsV1ElSnh0rWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414329; bh=JcBERBTxtQn6jmZe4Nwb9oRx7N
    LyVsLTHsKc8PBjSlU=; b=X/1k4ZC/7a2KQj9Exl4NFTLcozhXIrknp0857k5KyE
    zdufLo0pOXVoaZxLWH8pR/vw5V2JY0cwP3YfZMi5dbyE16tlGEJHCDrkYTKB8htl
    JeQvbbfZH9AiqtaugaOsjwNXEk7DdFUEFxN/nUmv/iaBq/sT8RBFFdpksTwljd0E
    8VrpzIqtS9gpVExBZQimb8Qxim9xqcjZacwmySnbLncqnsX/ZXJETJHJOs+dublw
    gXtp3Aph274KLlPhocklRjL3Crs6v6H/fQCfTDSGfkI3xhISMFKbUcg/r+72iNJS
    6YtucUCULXR+qB2luVkBoERLhSMN87avI8XzmwUQWLYg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934457AbeBWSv0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:51:26 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46010 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934552AbeBWSvY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:51:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Todd Kjos <tkjos@android.com>,
        syzbot <syzkaller@googlegroups.com>
Subject: [PATCH 4.14 050/159] ANDROID: binder: remove WARN() for redundant txn error
Date: Fri, 23 Feb 2018 19:25:58 +0100
Message-Id: <20180223170749.576977751@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Todd Kjos <tkjos@android.com>

commit e46a3b3ba7509cb7fda0e07bc7c63a2cd90f579b upstream.

binder_send_failed_reply() is called when a synchronous
transaction fails. It reports an error to the thread that
is waiting for the completion. Given that the transaction
is synchronous, there should never be more than 1 error
response to that thread -- this was being asserted with
a WARN().

However, when exercising the driver with syzbot tests, cases
were observed where multiple "synchronous" requests were
sent without waiting for responses, so it is possible that
multiple errors would be reported to the thread. This testing
was conducted with panic_on_warn set which forced the crash.

This is easily reproduced by sending back-to-back
"synchronous" transactions without checking for any
response (eg, set read_size to 0):

    bwr.write_buffer = (uintptr_t)&bc1;
    bwr.write_size = sizeof(bc1);
    bwr.read_buffer = (uintptr_t)&br;
    bwr.read_size = 0;
    ioctl(fd, BINDER_WRITE_READ, &bwr);
    sleep(1);
    bwr2.write_buffer = (uintptr_t)&bc2;
    bwr2.write_size = sizeof(bc2);
    bwr2.read_buffer = (uintptr_t)&br;
    bwr2.read_size = 0;
    ioctl(fd, BINDER_WRITE_READ, &bwr2);
    sleep(1);

The first transaction is sent to the servicemanager and the reply
fails because no VMA is set up by this client. After
binder_send_failed_reply() is called, the BINDER_WORK_RETURN_ERROR
is sitting on the thread's todo list since the read_size was 0 and
the client is not waiting for a response.

The 2nd transaction is sent and the BINDER_WORK_RETURN_ERROR has not
been consumed, so the thread's reply_error.cmd is still set (normally
cleared when the BINDER_WORK_RETURN_ERROR is handled). Therefore
when the servicemanager attempts to reply to the 2nd failed
transaction, the error is already set and it triggers this warning.

This is a user error since it is not waiting for the synchronous
transaction to complete. If it ever does check, it will see an
error.

Changed the WARN() to a pr_warn().

Signed-off-by: Todd Kjos <tkjos@android.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1933,8 +1933,14 @@ static void binder_send_failed_reply(str
 					&target_thread->todo);
 				wake_up_interruptible(&target_thread->wait);
 			} else {
-				WARN(1, "Unexpected reply error: %u\n",
-						target_thread->reply_error.cmd);
+				/*
+				 * Cannot get here for normal operation, but
+				 * we can if multiple synchronous transactions
+				 * are sent without blocking for responses.
+				 * Just ignore the 2nd error in this case.
+				 */
+				pr_warn("Unexpected reply error: %u\n",
+					target_thread->reply_error.cmd);
 			}
 			binder_inner_proc_unlock(target_thread->proc);
 			binder_thread_dec_tmpref(target_thread);
