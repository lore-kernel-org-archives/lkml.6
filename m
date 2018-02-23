Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415250-2-18402315619050011477
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
    t=1519415250; b=N2GphEq+dkpc0mOJL60iFyvXLk8EkU6mBWKxjl6WR7FfFZZ
    kysvrfO/qWVZXvq0rxYqxJ7v4xeo1Dse3BmXyWpdqqmQbTRGeEng8T6GEREWq8iu
    97U95MWmGViaSqH0jygOEknDaoUrX3GpKobX3SMDxmKld1Xjn7RXnMeu0RxbRaFD
    RHpUD4AMODIrIVSNueEsP8TeLQrQ2LYYb/LewXLeet4tl/rq9J1KcOt7dDb3rWme
    GQi+6UHAvv7BUH8fa33B8UOSB+yhsk8nqOX1Nk6xK4KD63hLUji9kbv1Lw50OPcQ
    tkUJ/Roqf+VtIbjQ5FdEBTCq2eR/ED/bZcBqryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415250; bh=WHg1vJxsDpwsrfB2W8rkQLJrW6
    XKIoMGNZxPRFxDTpc=; b=OI/a1D5yDbVOuRfwRTW2LKkh5HymJH6vDBlbSbLcs6
    zEcy55q+6fdfUZhCjDtER4B9qpzoZKEwhSM4Xl3CAzNKUBbHifbeXzr4haIEZ7oT
    1x51iFrKIfraoZ0aEV6m9vrGSL9a3MiRsnBlbbvXWDJb12cebdL/2jKJjr8gG2lS
    y0OceZUj54q8FADRm1Hqp9hrnTGWHkKzjijaKdww0oibGRS70k0hSW/1RHBgkhA4
    GrbOvh6AMa1HQNwi2d/nTQQC8rk607tN0vzwGtg4WB+lhvUaI9YgAn696dI2O3UQ
    Zi5hAefJVYSumTMChqAt8OgL8eXGuXib/hXFkkcqeucg==
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
        id S1754474AbeBWTrP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:47:15 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44588 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933968AbeBWSre (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:47:34 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.9 116/145] arm64: Kconfig: select COMPAT_BINFMT_ELF only when BINFMT_ELF is set
Date: Fri, 23 Feb 2018 19:27:02 +0100
Message-Id: <20180223170739.812704513@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kefeng Wang <wangkefeng.wang@huawei.com>

commit 2e449048a25eb75d48dff12882b93f26d130a1c6 upstream.

Fix warning:
"(COMPAT) selects COMPAT_BINFMT_ELF which has unmet direct dependencies
(COMPAT && BINFMT_ELF)"

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1007,7 +1007,7 @@ source "fs/Kconfig.binfmt"
 config COMPAT
 	bool "Kernel support for 32-bit EL0"
 	depends on ARM64_4K_PAGES || EXPERT
-	select COMPAT_BINFMT_ELF
+	select COMPAT_BINFMT_ELF if BINFMT_ELF
 	select HAVE_UID16
 	select OLD_SIGSUSPEND3
 	select COMPAT_OLD_SIGACTION
