Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2569030-1520284305-2-15617076581241436278
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520284304; b=V6LKpISQUC2mC8z6kHGSWcmZ5v7UAEv7y3fNgiSGgxrmklE
    Wm34KTb5+pUHq/Oa1Cg6fz97QVcbmBOs+ymwhuVWGlrkXO5s4aWM7z2+ljKgGIz3
    I0URNJ4s0gF0SD1RMmQrvQv+3EpOW3j511MFbHiaVmotUN4X5LPL0/eQffLwJCLN
    o0b59qVdYYaOd9a06hPRAunCuEWlUVaYs4tVs8AXWSuzBsf8ZUOZhUUzdZhA3Z4x
    q2e7mat9mlhCLyh+DhGMAj6bQqLL6pGyItE0OtQyOrfKIXz4w2wIeWvs2hgY+LGL
    6f1pXkmSX4BBX20/BxpejI1JZ7eiaB691sgWRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520284304; bh=EQW6AgJkqWqp0EpF8st+9sljBuui6+F7509+15jz1OY=; b=e
    94h1g86be4hrFq7yYbxGqF+7J3BDeotujxZ2DU+n1LLp/mxoMf7/eRFRF8futJiZ
    REJmHWNhNhxItfvgZ71WSK54zpSX/DL1t/5z1DKmMHTCFcBlavLeGVXjhtOJCOB3
    qGNbrMxSpwgBsxtJ1GdR2SrAkifMRTiKGnFpexOTyxEbnVMKZg2ZUmeOgcICw1i6
    yPcR+G6gHPSwG9JDDZtQzkNPsorucZgMW074lg2qruKhgBdWh5kywFkGdJxabAud
    vhaF7attNboJ8zi6jakYUyzkHTrqE2K2QRa3Xq1i9PV6ngD2/pduReWKLKQxaLhH
    ENQjlhjSvxom7+4YTBCHA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753106AbeCEVLn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 16:11:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753047AbeCEVLn (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 5 Mar 2018 16:11:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F89206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 5 Mar 2018 16:11:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net,
        torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/5] bpf, tracing: introduce bpf raw
 tracepoints
Message-ID: <20180305161139.1322f87d@gandalf.local.home>
In-Reply-To: <9bb38939-c357-4db5-6cf4-7b42187f6c7c@iogearbox.net>
References: <20180301041957.399230-1-ast@kernel.org>
        <9bb38939-c357-4db5-6cf4-7b42187f6c7c@iogearbox.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 5 Mar 2018 14:36:07 +0100
Daniel Borkmann <daniel@iogearbox.net> wrote:

> Ping, Peter/Steven. If you have a chance, please review the series.

You're not off my radar, but I'm doing a lot of traveling for the next
two weeks (started last week). I'll see if I can find some time to look
at them. I scanned them over once, and they look interesting ;-)

-- Steve
