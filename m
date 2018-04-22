Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2707851-1524408489-2-10238124312416787813
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524408488; b=BLFXQkosLST1mSC6l3vP84Ff5tLLi83t8R4s8i3vwCra+lCoz4
    ihWzaJKmqgvafy052hzKN6fQkYyqmuS6EecjnkW6kl7PxDzGF1iVDVb/9gywMAZm
    G/DgSwfomVqxIQaokBsKHZQmeZ+JwbSvVNgB5n+jHzQY0qiazitbWb8QmUtmQqSL
    Ex16UbktE3J70tEsmdmJl2OQAve1qsfx2hOcGiHSI6EflJDBvS7ux3AUibIqlDRt
    B4mIgetY86hlPto350wov4zoaB5vFWwKcLmI8jYQB64fhYAZ9LLm7b22qtb0c+X7
    6J2G7KUhKul2XmLKBAzy+on4yfrEzS0gBGag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524408488; bh=JfaR4hKX0sKhFA4hGulIZNVAxmFnY0
    QbVHO/4HjEGOI=; b=V5UqZlCE3x6PuQwAAqnn62FhyO4VZBcbBmUv4fMC7uqV0D
    wh/OfcfGBh5uSnzGfI+U37W8JqKjX5fsGG1fo951X2grwvR0HSad4NdkQV+aicus
    e6Lea375tx52kwavt4L2fynTBpDP1sRS8KlCF479ncc5wqmOQyyFXwTvTb+GFSa/
    ShBVbXTOve0KZFRwwe0PZsZ8WGGhvfVn0714KlJL4Z0P9jLUHNQml7ZHW0HOXV3h
    nMLfvEXE/5EFzjc0oA0QAOmRwYlAIeTnGc0BSqUI3tYvg1W+RGG0W11IiMY+u3QI
    gwPF6fpLfBOVTSEHmpLhs/RkoIubN9Elc2wOWWBA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGLA38V+apyhxvnODvTOmPcCLFBNn171dA/5Avd4IRYRb55CJxPzh5x1NL3WuvObSKt3wHBBbl10y0yixsrseGM8u1LWUf632wVbgacuRbUliFv9XW0v
    EnPovJM4VKKUKgb2+72IPycicOiMooJQ+A7eHtB92i+u4LFD3ttM11GGk8GtKTaZ+8LRwfJndGhSgbjCFQrc36j2sLRH2mKAiONlz577pIY06Qq2LUTepils
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=CdOsyjqGVEpJQDsmpXEA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932067AbeDVOQG (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:16:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57204 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932209AbeDVOQE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:16:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Alan Cox <alan@llwyncelyn.cymru>
Subject: [PATCH 4.4 21/97] tty: make n_tty_read() always abort if hangup is in progress
Date: Sun, 22 Apr 2018 15:52:59 +0200
Message-Id: <20180422135305.985008996@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
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

From: Tejun Heo <tj@kernel.org>

commit 28b0f8a6962a24ed21737578f3b1b07424635c9e upstream.

A tty is hung up by __tty_hangup() setting file->f_op to
hung_up_tty_fops, which is skipped on ttys whose write operation isn't
tty_write().  This means that, for example, /dev/console whose write
op is redirected_tty_write() is never actually marked hung up.

Because n_tty_read() uses the hung up status to decide whether to
abort the waiting readers, the lack of hung-up marking can lead to the
following scenario.

 1. A session contains two processes.  The leader and its child.  The
    child ignores SIGHUP.

 2. The leader exits and starts disassociating from the controlling
    terminal (/dev/console).

 3. __tty_hangup() skips setting f_op to hung_up_tty_fops.

 4. SIGHUP is delivered and ignored.

 5. tty_ldisc_hangup() is invoked.  It wakes up the waits which should
    clear the read lockers of tty->ldisc_sem.

 6. The reader wakes up but because tty_hung_up_p() is false, it
    doesn't abort and goes back to sleep while read-holding
    tty->ldisc_sem.

 7. The leader progresses to tty_ldisc_lock() in tty_ldisc_hangup()
    and is now stuck in D sleep indefinitely waiting for
    tty->ldisc_sem.

The following is Alan's explanation on why some ttys aren't hung up.

 http://lkml.kernel.org/r/20171101170908.6ad08580@alans-desktop

 1. It broke the serial consoles because they would hang up and close
    down the hardware. With tty_port that *should* be fixable properly
    for any cases remaining.

 2. The console layer was (and still is) completely broken and doens't
    refcount properly. So if you turn on console hangups it breaks (as
    indeed does freeing consoles and half a dozen other things).

As neither can be fixed quickly, this patch works around the problem
by introducing a new flag, TTY_HUPPING, which is used solely to tell
n_tty_read() that hang-up is in progress for the console and the
readers should be aborted regardless of the hung-up status of the
device.

The following is a sample hung task warning caused by this issue.

  INFO: task agetty:2662 blocked for more than 120 seconds.
        Not tainted 4.11.3-dbg-tty-lockup-02478-gfd6c7ee-dirty #28
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
      0  2662      1 0x00000086
  Call Trace:
   __schedule+0x267/0x890
   schedule+0x36/0x80
   schedule_timeout+0x23c/0x2e0
   ldsem_down_write+0xce/0x1f6
   tty_ldisc_lock+0x16/0x30
   tty_ldisc_hangup+0xb3/0x1b0
   __tty_hangup+0x300/0x410
   disassociate_ctty+0x6c/0x290
   do_exit+0x7ef/0xb00
   do_group_exit+0x3f/0xa0
   get_signal+0x1b3/0x5d0
   do_signal+0x28/0x660
   exit_to_usermode_loop+0x46/0x86
   do_syscall_64+0x9c/0xb0
   entry_SYSCALL64_slow_path+0x25/0x25

The following is the repro.  Run "$PROG /dev/console".  The parent
process hangs in D state.

  #include <sys/types.h>
  #include <sys/stat.h>
  #include <sys/wait.h>
  #include <sys/ioctl.h>
  #include <fcntl.h>
  #include <unistd.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <errno.h>
  #include <signal.h>
  #include <time.h>
  #include <termios.h>

  int main(int argc, char **argv)
  {
	  struct sigaction sact = { .sa_handler = SIG_IGN };
	  struct timespec ts1s = { .tv_sec = 1 };
	  pid_t pid;
	  int fd;

	  if (argc < 2) {
		  fprintf(stderr, "test-hung-tty /dev/$TTY\n");
		  return 1;
	  }

	  /* fork a child to ensure that it isn't already the session leader */
	  pid = fork();
	  if (pid < 0) {
		  perror("fork");
		  return 1;
	  }

	  if (pid > 0) {
		  /* top parent, wait for everyone */
		  while (waitpid(-1, NULL, 0) >= 0)
			  ;
		  if (errno != ECHILD)
			  perror("waitpid");
		  return 0;
	  }

	  /* new session, start a new session and set the controlling tty */
	  if (setsid() < 0) {
		  perror("setsid");
		  return 1;
	  }

	  fd = open(argv[1], O_RDWR);
	  if (fd < 0) {
		  perror("open");
		  return 1;
	  }

	  if (ioctl(fd, TIOCSCTTY, 1) < 0) {
		  perror("ioctl");
		  return 1;
	  }

	  /* fork a child, sleep a bit and exit */
	  pid = fork();
	  if (pid < 0) {
		  perror("fork");
		  return 1;
	  }

	  if (pid > 0) {
		  nanosleep(&ts1s, NULL);
		  printf("Session leader exiting\n");
		  exit(0);
	  }

	  /*
	   * The child ignores SIGHUP and keeps reading from the controlling
	   * tty.  Because SIGHUP is ignored, the child doesn't get killed on
	   * parent exit and the bug in n_tty makes the read(2) block the
	   * parent's control terminal hangup attempt.  The parent ends up in
	   * D sleep until the child is explicitly killed.
	   */
	  sigaction(SIGHUP, &sact, NULL);
	  printf("Child reading tty\n");
	  while (1) {
		  char buf[1024];

		  if (read(fd, buf, sizeof(buf)) < 0) {
			  perror("read");
			  return 1;
		  }
	  }

	  return 0;
  }

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@llwyncelyn.cymru>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/n_tty.c  |    6 ++++++
 drivers/tty/tty_io.c |    9 +++++++++
 include/linux/tty.h  |    1 +
 3 files changed, 16 insertions(+)

--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2238,6 +2238,12 @@ static ssize_t n_tty_read(struct tty_str
 				}
 				if (tty_hung_up_p(file))
 					break;
+				/*
+				 * Abort readers for ttys which never actually
+				 * get hung up.  See __tty_hangup().
+				 */
+				if (test_bit(TTY_HUPPING, &tty->flags))
+					break;
 				if (!timeout)
 					break;
 				if (file->f_flags & O_NONBLOCK) {
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -702,6 +702,14 @@ static void __tty_hangup(struct tty_stru
 		return;
 	}
 
+	/*
+	 * Some console devices aren't actually hung up for technical and
+	 * historical reasons, which can lead to indefinite interruptible
+	 * sleep in n_tty_read().  The following explicitly tells
+	 * n_tty_read() to abort readers.
+	 */
+	set_bit(TTY_HUPPING, &tty->flags);
+
 	/* inuse_filps is protected by the single tty lock,
 	   this really needs to change if we want to flush the
 	   workqueue with the lock held */
@@ -757,6 +765,7 @@ static void __tty_hangup(struct tty_stru
 	 * can't yet guarantee all that.
 	 */
 	set_bit(TTY_HUPPED, &tty->flags);
+	clear_bit(TTY_HUPPING, &tty->flags);
 	tty_unlock(tty);
 
 	if (f)
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -342,6 +342,7 @@ struct tty_file_private {
 #define TTY_PTY_LOCK 		16	/* pty private */
 #define TTY_NO_WRITE_SPLIT 	17	/* Preserve write boundaries to driver */
 #define TTY_HUPPED 		18	/* Post driver->hangup() */
+#define TTY_HUPPING		19	/* Hangup in progress */
 #define TTY_LDISC_HALTED	22	/* Line discipline is halted */
 
 #define TTY_WRITE_FLUSH(tty) tty_write_flush((tty))
