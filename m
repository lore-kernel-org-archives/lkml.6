Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414059-2-16261636673384016925
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414058; b=hd5vxgO3B7Vd6/vReZPjLms8fKYEodUebWr2L6zpQRp6fit
    NRZ7nWDyFxjqWkw/MklOnOlgDKkeDeSSn6aNTV5O0RAZQHULTc6yZu9CM9lHiNGf
    bWy+tXVicRO/kkMsd/v0u9nnecYqAfeB63+7gX/Dcr9Pnq+ziRJWaAhtXQdOPp6b
    kHInbs6a8vhtKilGFh2963IYp1BgW+Gi3C7IFSscrNudIGU7cKmeFUTo2AhI7l8d
    CtCjV8OroLiGI2XZBYgiRyXhJyM5iwMpj875xlUivRb8t3WWHzTTSvYoiaVX6L11
    8z8nARb+uQwGSqDAs+wsZ1MbyLm2w6hYxsXkGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414058; bh=aksAzK3ez7JnA2McNze1Wjrmst
    1Zh3cf6VS2dlvX/gQ=; b=rxgrUsa41vHHCbM9VwIbM6GsdAfpIoR5fIZ81I1O6T
    Jyp0uRbpKj42vgSxqee2cTxl1YrgXkd2uDms8io2N5wqv9JHsXhhIt7gXRMh1tXp
    0Z6A54AFYcia61dNVwrMmxDNTpUyqWcsKXGM9bd/ALzxuhenGbNbwW7KgWwE+mOq
    8hSDaSEkcvtvbOFGcAb3kvM3CUsAU8SWrT9TBKraA+0ZO2fqE/+Fbna/qpgo4G/l
    EQaFrPatFQeyJlL/AsdI3OpfcRscRC6eWN92mTG72eg+kFSUdnA7ffQNGPBmz9/l
    T0pXX8iTvXBBqt6nHy8PDgYS76RPxzwSLVhypGcCNp+A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932119AbeBWT1W (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:27:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46894 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934871AbeBWSwY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:52:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sihyeon Jang <uneedsihyeon@gmail.com>, kernel-team@lge.com,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 069/159] perf help: Fix a bug during strstart() conversion
Date: Fri, 23 Feb 2018 19:26:17 +0100
Message-Id: <20180223170751.975883725@linuxfoundation.org>
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

From: Namhyung Kim <namhyung@kernel.org>


[ Upstream commit af98f2273fd0af31ce327cd1406b67c7be0b6734 ]

The commit 8e99b6d4533c changed prefixcmp() to strstart() but missed to
change the return value in some place.  It makes perf help print
annoying output even for sane config items like below:

  $ perf help
  '.root': unsupported man viewer sub key.
  ...

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Taeung Song <treeze.taeung@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Sihyeon Jang <uneedsihyeon@gmail.com>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20171114001542.GA16464@sejong
Fixes: 8e99b6d4533c ("tools include: Adopt strstarts() from the kernel")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/builtin-help.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -284,7 +284,7 @@ static int perf_help_config(const char *
 		add_man_viewer(value);
 		return 0;
 	}
-	if (!strstarts(var, "man."))
+	if (strstarts(var, "man."))
 		return add_man_viewer_info(var, value);
 
 	return 0;
@@ -314,7 +314,7 @@ static const char *cmd_to_page(const cha
 
 	if (!perf_cmd)
 		return "perf";
-	else if (!strstarts(perf_cmd, "perf"))
+	else if (strstarts(perf_cmd, "perf"))
 		return perf_cmd;
 
 	return asprintf(&s, "perf-%s", perf_cmd) < 0 ? NULL : s;
