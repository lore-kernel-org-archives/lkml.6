Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3150701-1523473753-2-11533151513821407142
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
    1523473753; b=lG0UO7TSuBUdMT6Ndvki+tWt1r0Sagj6hNxVr2g/CEM06Eezvu
    yCWXX6JYfA8sqUHX8QSIzatJt+9ZeTvn0n3QhJyVwlsYVxGqrOW80AA9MuMTNlgD
    ou08C9ErQKp+iGXc3Tomgrm4Q1ytDre2dz1O3hdCMuJJBAXDc/weMmInMbnAKg72
    HRHHKzI90gglK6yXeL05R+iqVYfMExBJ6JVTdJwXf6LdyTocyK/rCSvy6cHWaLEk
    E4319RFWzal5CmQ4MIUjkEfl9nMXt81edX+FEZizl9cnt5O4mWa51o3ClsQ2nRZr
    l04yfkiY/6nDSZPpsH2aBtKsiY1RcfEiM7Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473753; bh=kR2Yp482SQ80gcUwa3hN1aHl5PYl60
    sA9TBPksd5KUE=; b=c6Ol5+D8NAwH0OD2s2b8WAdSy+nBcXmI//kr3x65IGASm7
    Wqu4mezVvtSYiKxyFoC4RpcFk5X0na+nj84If2rnS/Hy3XFtqk/Mwk4zzamHhLD3
    4tqZsdVJQiGMvC26Dzqit9M0Gb29Sx8ZXtIJTrtJNWi3lnveF37B53u9DXE47m/Q
    CHZuw48HD1PKZhULI1kT1+sl2C8KjauLG1lEodAef1Rru6DuAij2htvGMY+om7QD
    T4lN1KLI87So6U9k1WxghpMaLNKDXwbFu0k+JHsOxLYP2p3ILy67+bXEUmuNKeTx
    BAq8vLu6+UhAeabyGLPFLWU6O46vEqv5iUH8u34A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfKDUjBmMaMZtpOJKK3oN7pty5EUubuPisf3Gkym2B52evr18msY1rvBJPbAELd4Q79Jr47Bz3kWDDjCeJhoEX06qs63PXCK8KenpZCP0LvLQ+2xPUU3i
    kQ5wG9pXJm9LD1CteoyXtK9uZnk9KKsiM+ZJCCY5myqez3F5QSNaEOUtSoTLLekh1UuGgto7qf68cJAofD9gIfWYeS7V/zqjaIDFTMLbWguQzvMt1dnFQs59
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=A7XncKjpAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=iyCa5RAUoxkVIAlNHlcA:9
    a=UMcLqSxQMR5hhFJh:21 a=nvICiqDoeMpn8ptq:21 a=QEXdDO2ut3YA:10
    a=R9rPLQDAdC6-Ub70kJmZ:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934492AbeDKTGs (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:06:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40918 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935281AbeDKTGr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:06:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Craig Dillabaugh <cdillaba@mojatatu.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 309/310] net sched actions: fix dumping which requires several messages to user space
Date: Wed, 11 Apr 2018 20:37:28 +0200
Message-Id: <20180411183635.893702209@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Craig Dillabaugh <cdillaba@mojatatu.com>


[ Upstream commit 734549eb550c0c720bc89e50501f1b1e98cdd841 ]

Fixes a bug in the tcf_dump_walker function that can cause some actions
to not be reported when dumping a large number of actions. This issue
became more aggrevated when cookies feature was added. In particular
this issue is manifest when large cookie values are assigned to the
actions and when enough actions are created that the resulting table
must be dumped in multiple batches.

The number of actions returned in each batch is limited by the total
number of actions and the memory buffer size.  With small cookies
the numeric limit is reached before the buffer size limit, which avoids
the code path triggering this bug. When large cookies are used buffer
fills before the numeric limit, and the erroneous code path is hit.

For example after creating 32 csum actions with the cookie
aaaabbbbccccdddd

$ tc actions ls action csum
total acts 26

    action order 0: csum (tcp) action continue
    index 1 ref 1 bind 0
    cookie aaaabbbbccccdddd

    .....

    action order 25: csum (tcp) action continue
    index 26 ref 1 bind 0
    cookie aaaabbbbccccdddd
total acts 6

    action order 0: csum (tcp) action continue
    index 28 ref 1 bind 0
    cookie aaaabbbbccccdddd

    ......

    action order 5: csum (tcp) action continue
    index 32 ref 1 bind 0
    cookie aaaabbbbccccdddd

Note that the action with index 27 is omitted from the report.

Fixes: 4b3550ef530c ("[NET_SCHED]: Use nla_nest_start/nla_nest_end")"
Signed-off-by: Craig Dillabaugh <cdillaba@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_api.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -95,8 +95,10 @@ static int tcf_dump_walker(struct tcf_ha
 				continue;
 
 			nest = nla_nest_start(skb, n_i);
-			if (nest == NULL)
+			if (nest == NULL) {
+				index--;
 				goto nla_put_failure;
+			}
 			err = tcf_action_dump_1(skb, p, 0, 0);
 			if (err < 0) {
 				index--;
