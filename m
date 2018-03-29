Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486815-1522349630-2-9428340915386288645
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522349630; b=NfCKC6n+2oQnicGykhR5+OP8huto6yxN9oZgEJNof6f96AQDiT
    AT2Ne9i35r0QswfFZ8GAJqGOkxHshwPy1SwQqE3B+sbY4AXvGDDgS5sBdwDRvm2M
    Am0Xbfc5ZpuGGw0qEOXrQzJeFBtCyEpklGLrNDFG8SMpznzCKmX3UxX82bBS1t5u
    jf+cBWCpW4cJuPF2vopP3uTRfUWBNfF70UBkxrPCy4eqfEUGkHDHv58+vJ3+W/Hj
    45SXNBYyNxh0twYv1cQd4K5tEunOcnkpj3+qkcc5s44BzZq/bY7S+o7uWVrCZn9w
    XBuEfpBxAu24y/qg4MwB72b75hgYmhrIzdKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1522349630; bh=aUja8SMkHeRcGMnAoPupWJFT1trBm+8xRF95d4kI+A
    4=; b=PzuDytbwWQ/yQ0yARkAff6hNGJI5IpmIjddeBDOpKLNUM1nIQBiJMcouqe
    8GrA2lMfcRgEmfNOBXJm91+5Y6bL+2uHtPCS4+EyDzX7rF71Z6eQxHMtSHnVtoL1
    11wxaeYN23OuBsRYVGWjT0wdS3ZbniuErtU5kEjt+NEgDTbsY+hyWfOYdpRZaTH8
    njg3Z0GfP1RHxOSZv+vhLFIE1kCd+SxVUjq6Hyykv2gvSbxzG+X8/KC9zEDuwZcY
    6XNOrAGbpuJrt79kcaNZDQA9TZo1dya8cYpHeY+lUicOybXzD+1Zk9yi3D0u+gJe
    YKQcePm9atI1BPUKraYSmVO8zLbg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHbLTEwEHCZIUz3mL8UyFP2eOcZ9WPLq2mTP+lGGLlxtyOEQutSpn3KXSWrcFNZd0zXm0DxPt1IT37wDoj6/1nOA5wlDW4vsuD2FizgqT9VuvdVynFxu
    w4P3mOFkKMjYTOeNURXh/AOyb9gJQr1e8f5OVBNbDIXQJPbord6TBDtfb98UNZzy3BQZ5M6WMYEbQJcUVNuHIoMqIfFglAfnp80jMdDoQyeactf2RWi5dj4J
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=MqK6kde1AAAA:8
    a=VwQbUJbxAAAA:8 a=P8VWwBNfptmOyr09_WsA:9 a=2hrgJWteX5doMNov:21
    a=Yu6BGZb2FEVabcau:21 a=x8gzFH9gYPwA:10 a=9aqP8kKXEzZd0rnup5AB:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeC2Sxd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:53:33 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42501 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeC2Sxa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 14:53:30 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stanislav Kinsbursky <skinsbursky@parallels.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-api@vger.kernel.org
References: <87woyfyh57.fsf@xmission.com>
        <5d4a858a-3136-5ef4-76fe-a61e7f2aed56@redhat.com>
        <87o9jru3bf.fsf@xmission.com>
        <935a7c50-50cc-2dc0-33bb-92c000d039bc@redhat.com>
        <87woyego2u.fsf_-_@xmission.com>
        <047c6ed6-6581-b543-ba3d-cadc543d3d25@redhat.com>
        <87h8ph6u67.fsf@xmission.com>
        <7d3a1f93-f8e5-5325-f9a7-0079f7777b6f@redhat.com>
        <20180329021409.gcjjrmviw2lckbfk@linux-n805>
        <3e201de2-bed2-6f7d-0783-700d095142e0@colorfullife.com>
        <20180329105601.GA597@bombadil.infradead.org>
        <05772f83-d680-aea1-b222-cef2430dcc83@colorfullife.com>
Date: Thu, 29 Mar 2018 13:52:25 -0500
In-Reply-To: <05772f83-d680-aea1-b222-cef2430dcc83@colorfullife.com> (Manfred
        Spraul's message of "Thu, 29 Mar 2018 20:07:44 +0200")
Message-ID: <87lgea7lzq.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f1cfw-0007S9-7G;;;mid=<87lgea7lzq.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/nhjXEhtPM8/7tS7f5/3jXtV3Kr7+5Pok=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa06.xmission.com
X-Remote-Spam-Level: *
X-Remote-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG,
        T_XMDrugObfuBody_14 autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 T_XMDrugObfuBody_14 obfuscated drug references
X-Remote-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: *;Manfred Spraul <manfred@colorfullife.com>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 1226 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.7 (0.2%), b_tie_ro: 1.78 (0.1%), parse: 0.78 (0.1%),
        extract_message_metadata: 10 (0.8%), get_uri_detail_list: 1.25 (0.1%),
        tests_pri_-1000: 5 (0.4%), tests_pri_-950: 1.17 (0.1%), tests_pri_-900: 0.99
        (0.1%), tests_pri_-400: 22 (1.8%), check_bayes: 21 (1.7%), b_tokenize: 7
        (0.6%), b_tok_get_all: 8 (0.6%), b_comp_prob: 2.2 (0.2%), b_tok_touch_all:
        2.6 (0.2%), b_finish: 0.55 (0.0%), tests_pri_0: 1176 (96.0%),
        check_dkim_signature: 0.49 (0.0%), check_dkim_adsp: 2.8 (0.2%),
        tests_pri_500: 4.2 (0.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] ipc: Remove IPCMNI
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Manfred Spraul <manfred@colorfullife.com> writes:

> Hello Mathew,
>
> On 03/29/2018 12:56 PM, Matthew Wilcox wrote:
>> On Thu, Mar 29, 2018 at 10:47:45AM +0200, Manfred Spraul wrote:
>>>>>>>> This can be implemented trivially with the current code
>>>>>>>> using idr_alloc_cyclic.
>>> Is there a performance impact?
>>> Right now, the idr tree is only large if there are lots of objects.
>>> What happens if we have only 1 object, with id=INT_MAX-1?
>> The radix tree uses a branching factor of 64 entries (6 bits) per level.
>> The maximum ID is 31 bits (positive signed 32-bit integer).  So the
>> worst case for a single object is 6 pointer dereferences to find the
>> object anywhere in the range (INT_MAX/2 - INT_MAX].  That will read 12
>> cachelines.  If we were to constrain ourselves to a maximum of INT_MAX/2
>> (30 bits), we'd reduce that to 5 pointer dereferences and 10 cachelines.
> I'm concerned about the up to 6 branches.
> But this is just guessing, we need a test with a realistic workload.

Yes.

My primary purpose with the patch was to show that the issues with the
current limits could be resolved in a straght forward manner.  I really
don't know if idrs are the appropriate data structure.  It is possible
rbtrees are a better fit.


I think my algorithm I proposed for generating identifiers is as likely
as any to be a good one.  It does need testing on a wide variety of
applications to see what applications actually care about and for that I
think my proposed patch is more than sufficient.

By not keeping a generation counters in the slots themselves linux
already differs substantially from traditional implementations.

Doing something to free us from using a fixed number of bits for the
counter and a fixed number of bits to encode the slot we can support
much larger use of this API.

Eric

