Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797899-1518708573-2-6864449793081976153
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
    t=1518708572; b=LEzCc4wEYmX4XSviecuRMKUEJnBTCmbwqrnD1w8vOF7qlyN
    I87Ll4yBD8C00ZRFQtSq4jxiLNwogpgGsH4m/n3YR9WuPyLgLjeItdjl1n4InrTr
    uuxmA+g6kxd68rwWKl/xyouXvYXosQJdON7+Uh1qa8B0AURe+1iC8pPhYlBTRBZQ
    y6oznTiMIOJme5egfca+FKVPjS9IHCiCoobKpBl+rME52Qh19P/zDI7S1YeiXTzj
    8QTNGZHNYT6/1bMjxasmqSoZXR5L5WWfVqdwc4/p+yXelDoROzeNFxGIvg2C+0QO
    aDL3KrtYAQzfhyS9d1qACzEZg30fws/2QgHqS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708572; bh=z5Nm4bPU7sezaCNB56uNJlsidI
    NOUo76ioJWmG0w+eg=; b=koWUlcqlPOoeNqtSgd5qoig0JdlhcdCYTXsxGRrkNK
    gb8JxNQ1ntyAqgfXBMdS3nKnRZRJiovANCBaSvHbRWrm1E4kmEknBBnGzORI07S0
    8D5txEPV7O/744O9oqAFUE1uQNcyS68l4Adx+u4eHJAmH2uaZ/rEukXxMlCfB06R
    5O0P2FoFVNA2vZuQWmWBoUAuGq3ReKnE54gj4vUR7COlArG6IsTGrhJ/GX/3y63P
    IyE4IE9HuKo+12sK1+AEuVBQxdX0QQztDwyhdDvSb90F9gNVqw/76tuToVQfALOw
    TxKinLJmPmUmuinaIapaATkW3LK3y3kK0fvL3B0Qm1Dg==
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
        id S1164041AbeBOP33 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:29:29 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54414 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163607AbeBOP32 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:29:28 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.9 88/88] ftrace: Remove incorrect setting of glob search field
Date: Thu, 15 Feb 2018 16:17:55 +0100
Message-Id: <20180215151234.639070044@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 7b6586562708d2b3a04fe49f217ddbadbbbb0546 upstream.

__unregister_ftrace_function_probe() will incorrectly parse the glob filter
because it resets the search variable that was setup by filter_parse_regex().

Al Viro reported this:

    After that call of filter_parse_regex() we could have func_g.search not
    equal to glob only if glob started with '!' or '*'.  In the former case
    we would've buggered off with -EINVAL (not = 1).  In the latter we
    would've set func_g.search equal to glob + 1, calculated the length of
    that thing in func_g.len and proceeded to reset func_g.search back to
    glob.

    Suppose the glob is e.g. *foo*.  We end up with
	    func_g.type = MATCH_MIDDLE_ONLY;
	    func_g.len = 3;
	    func_g.search = "*foo";
    Feeding that to ftrace_match_record() will not do anything sane - we
    will be looking for names containing "*foo" (->len is ignored for that
    one).

Link: http://lkml.kernel.org/r/20180127031706.GE13338@ZenIV.linux.org.uk

Fixes: 3ba009297149f ("ftrace: Introduce ftrace_glob structure")
Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/ftrace.c |    1 -
 1 file changed, 1 deletion(-)

--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3911,7 +3911,6 @@ __unregister_ftrace_function_probe(char
 		func_g.type = filter_parse_regex(glob, strlen(glob),
 						 &func_g.search, &not);
 		func_g.len = strlen(func_g.search);
-		func_g.search = glob;
 
 		/* we do not support '!' for function probes */
 		if (WARN_ON(not))
