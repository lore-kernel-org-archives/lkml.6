Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517590962-2-8951020487072166986
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517590961; b=UA7tQV/ueV1EYsJ9jxXIln7x4TwNZkzuUN3unOc3+vFUEIR
    EUDVpNNDzgz8LcTEZC5++eTAimzhYDInfMWcxAtMrH7phcbmTVL2KdkFojy6eWsG
    z2dQ/ueuqa1c83KGhmj1KgO9y9P6sErKqbvZxwUE5+WULjs4t/AXi+AmAnHLceKF
    RUwaCnsv2G2RveZlHb+lJvFz3evhc4rMM1nwjw+0YV8+AdXwq8m6UwYQbsoIZh2D
    lsE1Re1763IJ+g7YHVFH2SHeymYVI7jPqpD/xZsMoBPCRlCfWqqTIP0/+Fxh2QU2
    aslJU7mvp9uMA9h7OIA6IMMNmUWX/0kPrmGNP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517590961; bh=DLNbXKnx+rAYUmApZaCpFzhYfy
    xVICAA3S0gjyoRaNo=; b=cg6vBMshADbIH+AKrh3zJHkwf1Kg+zEgQ6x50EUsbG
    nTWay12F09k0fIAdwMMcpaI3SURA9E76QKdB8pHI+gNHwKCQvawZTd8+4nru4mae
    3/hpI6SqZIeLGasLhbrkg7MZgC4wZvTJSlEK7/U0wo3Nap5wLCmOG9sx/HfoWtuU
    HfL9RjwxAQYA1OHl5aYDDkR4W9Jgr2QwDgr777MeKM0O04XVSlaW1EeLnOxOmqCz
    X5rgUstE8FvxAqSdgx1GBojlk+KrOSboHjt2fqU8Vq0hiSutYWorpOvBSYjHbGk7
    9vXYKrnqsK46L+BU8fhgM/IaArbK/XdA2ySzc2lQvPcA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752164AbeBBRCh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:02:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35442 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbeBBRCc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:02:32 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Badhri <badhri@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Greg KH <gregkh@linux-foundation.org>
Subject: [PATCH 4.4 63/67] usb: f_fs: Prevent gadget unbind if it is already unbound
Date: Fri,  2 Feb 2018 17:58:32 +0100
Message-Id: <20180202140822.175253730@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hemant Kumar <hemantk@codeaurora.org>

commit ce5bf9a50daf2d9078b505aca1cea22e88ecb94a upstream.

Upon usb composition switch there is possibility of ep0 file
release happening after gadget driver bind. In case of composition
switch from adb to a non-adb composition gadget will never gets
bound again resulting into failure of usb device enumeration. Fix
this issue by checking FFS_FL_BOUND flag and avoid extra
gadget driver unbind if it is already done as part of composition
switch.

This fixes adb reconnection error reported on Android running
v4.4 and above kernel versions. Verified on Hikey running vanilla
v4.15-rc7 + few out of tree Mali patches.

Reviewed-at: https://android-review.googlesource.com/#/c/582632/

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg KH <gregkh@linux-foundation.org>
Cc: Michal Nazarewicz <mina86@mina86.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Dmitry Shmidt <dimitrysh@google.com>
Cc: Badhri <badhri@google.com>
Cc: Android Kernel Team <kernel-team@android.com>
Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
[AmitP: Cherry-picked it from android-4.14 and updated the commit log]
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_fs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -3490,7 +3490,8 @@ static void ffs_closed(struct ffs_data *
 	ci = opts->func_inst.group.cg_item.ci_parent->ci_parent;
 	ffs_dev_unlock();
 
-	unregister_gadget_item(ci);
+	if (test_bit(FFS_FL_BOUND, &ffs->flags))
+		unregister_gadget_item(ci);
 	return;
 done:
 	ffs_dev_unlock();
