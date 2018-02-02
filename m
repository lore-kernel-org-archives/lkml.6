Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591552-2-8594169918433437595
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
    t=1517591551; b=BYSyHy2NGCxwPrAY4c71djOTBdMRe7MHXPnillRC2xtEYz/
    ic9L6+foyIbgsaAaDvo26OAxohbvmx9geX5zWDw0dAmkd7HgOJj3hPqDM5lWeBw6
    Tz4Rs/J1MYZmPhS8mzwWUMTp+MnaF5YD8IMQEaemlqxmKWayJRkKgQFAl6XSA3Oo
    qDlueHTMpe7Qdninqfjj32ws5aKwAteSRFvAjd5RsLN20DIC/U3Cjp1MogEvkBk5
    1ZUYTQBtPdt0LJh9EPAhDJzuF0DuebJpJ6J52D9r/FLYW++soc0oYXHitSdRFkgx
    KjjniNOYE/rtwZ3ZUe/ZhR1FEHy5leq0105Q8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591551; bh=fWWMvpKlsqSxrUGFE4wQbAHZcl
    U8DHj2OLJcyo8Ny6A=; b=PwcQ+5pndmj6iWUODHnlxmUxmdFdxI5anCSQ+wGL7o
    u8l5+kNTIpVp7OnblngQ4ZR7HaPthc1p/4G/i/up9Vq1TecAx/vuxbBTJ/vLZgWU
    +2tOt9YrlahsYCMEQHM6ORFxbxeq/GBwiKT9xEzasFY0zZwbAqp7PKVIhoH3xvXe
    FX4fS0ETA2cLNRPekedzWrx7z9DJInr2jJEKw68jy6GpX08s5Vd8P+JsbsAiw3US
    MKYUSe5c0A+bJPp0J9UaO6fZ20ArMHpz1sQxCWSJ1PNRD9Bay9peWjI3FoGf5agS
    s1K1LVF6H2LrKtUaAs0GUSCfr4437Avgfffiwlli3G8g==
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
        id S1753474AbeBBRM1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:12:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38980 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753458AbeBBRMW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:12:22 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 116/156] perf/core: Fix memory leak triggered by perf --namespace
Date: Fri,  2 Feb 2018 17:58:17 +0100
Message-Id: <20180202140845.420181724@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>


[ Upstream commit 0e18dd12064e07519f7cbff4149ca7fff620cbed ]

perf with --namespace key leaks various memory objects including namespaces

  4.14.0+
  pid_namespace          1     12   2568   12    8
  user_namespace         1     39    824   39    8
  net_namespace          1      5   6272    5    8

This happen because perf_fill_ns_link_info() struct patch ns_path:
during initialization ns_path incremented counters on related mnt and dentry,
but without lost path_put nobody decremented them back.
Leaked dentry is name of related namespace,
and its leak does not allow to free unused namespace.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: commit e422267322cd ("perf: Add PERF_RECORD_NAMESPACES to include namespaces related info")
Link: http://lkml.kernel.org/r/c510711b-3904-e5e1-d296-61273d21118d@virtuozzo.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/events/core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6756,6 +6756,7 @@ static void perf_fill_ns_link_info(struc
 		ns_inode = ns_path.dentry->d_inode;
 		ns_link_info->dev = new_encode_dev(ns_inode->i_sb->s_dev);
 		ns_link_info->ino = ns_inode->i_ino;
+		path_put(&ns_path);
 	}
 }
 
