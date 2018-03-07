Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4025272-1520451931-2-162858570949646816
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520451930; b=vy5iyzOkNQ1OCE/CEtD7eDWhwcDuYuwGWXWFNhcaEb23hre
    9GvugeQnYwHNBcjJrlZp8ayenSUfIE35M3EzVdwms3JS+Syp/T1lMConRFvrIc9C
    z//c1xuFOPttUGejOLv9HU2w4qn+3RN/yKa8tjwIv2yI80R2nD9fnN+4MgqKpiwz
    8xF0HcsZPY777aWr4euLUS47f3Twi6XidwiYcbIIz4ku9fVZXSdhgtC5rUz/9Fd0
    TO0rtDO5XHMrFcPb442uxfiOmNo73z6qx6SfqofPhSevLaZ8/DcdU/wNkGIZmlXe
    IQyxEV/7CgIUEfwche4wtQVxs7okT2s1hXpXBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520451930; bh=hBsf6bRo5SR8Gbp6s/Rg9wDC/8
    arM/lQ4MeGSjejrLU=; b=YXU4LhjgW/7H3E/R9C2NmEfLTXenOd8DQNNWY50X3i
    f4303dp61gHMY5iTuXLDan9V6PHOu45LimoDiOiDLjGLYjfCFgjTlw7QRntkYyKp
    sH53lPaE/8p08LC+zrV2c71UEAiQm2F70sTXJgUrFOnevmI5iMD1kDGGD7jRZqKl
    /LPT+MkxRukPh8HoH3DhsHkGAylmZunnkUBj84CnjPQQQK91ZfN/lZFJnXswUzbR
    VMMttHH6z6titEEyZKBc/UAyWjXE1COY3olva5JLhIJPHGELVYRrWcLLssv86FxN
    Y95qmuzIgpitV4eCuJcCcEt/Sasroq3zLSx45Fae1g0w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965313AbeCGTp0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:45:26 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44170 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965311AbeCGTpY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:45:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Panceac <sebastian@resin.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 4.14 032/110] x86/platform/intel-mid: Handle Intel Edison reboot correctly
Date: Wed,  7 Mar 2018 11:38:15 -0800
Message-Id: <20180307191043.871641268@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
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

From: Sebastian Panceac <sebastian@resin.io>

commit 028091f82eefd5e84f81cef81a7673016ecbe78b upstream.

When the Intel Edison module is powered with 3.3V, the reboot command makes
the module stuck.  If the module is powered at a greater voltage, like 4.4V
(as the Edison Mini Breakout board does), reboot works OK.

The official Intel Edison BSP sends the IPCMSG_COLD_RESET message to the
SCU by default. The IPCMSG_COLD_BOOT which is used by the upstream kernel
is only sent when explicitely selected on the kernel command line.

Use IPCMSG_COLD_RESET unconditionally which makes reboot work independent
of the power supply voltage.

[ tglx: Massaged changelog ]

Fixes: bda7b072de99 ("x86/platform/intel-mid: Implement power off sequence")
Signed-off-by: Sebastian Panceac <sebastian@resin.io>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1519810849-15131-1-git-send-email-sebastian@resin.io
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/platform/intel-mid/intel-mid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -79,7 +79,7 @@ static void intel_mid_power_off(void)
 
 static void intel_mid_reboot(void)
 {
-	intel_scu_ipc_simple_command(IPCMSG_COLD_BOOT, 0);
+	intel_scu_ipc_simple_command(IPCMSG_COLD_RESET, 0);
 }
 
 static unsigned long __init intel_mid_calibrate_tsc(void)
