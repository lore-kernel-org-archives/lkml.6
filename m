Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-51321-1522440804-5-11788885499678144474
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
    1522440802; b=XxQ088BOIjdeIolTTfB7vTEJeEBtXViiKH3DZOQpXoSdf/mmFX
    tlSIOgUtJH64ZZhu2U7mYPKc2eqQ8mvW9UwgpbaHqndJsRKvh9ts9r6U7yT+qbk0
    GQbINsqhQPmGXXaeASIn4ScS1gW318im4AvYRfZEmUg/X4g0MjtbFO3Ch2/iGMGk
    ipmt8CxRGEpnX18GOJo9dKtM+hbU2YqAJj1ZaVd1p6LpOUvfkip+E/ot4nJuIKeH
    6IL5iGvSaTS43AmZFvxMit6+U8587F7qNbzeuXA6rPldTcSmjWUFlDSF3HNtjots
    GuQUmX1wjVecu75LYMMYwxV+hnSSuDRV36CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1522440802; bh=rx58Qa/eSzqFm9HBKhnytNH6qGngyK6x0PS1oWclEd
    I=; b=LAJJ86hN+a2oIG7P63R6lUzk/V/nmnaz/42pCCffslnPCSfFybFQV4FuBn
    rW7Qxk8PvMdYyLDoo/Cc6lqRrsAXQh189GgaxRMJLUOABXMcZYMuJIl2GDGCv76R
    1z7E7wYpVmhpppeYeoLfFhQxDiKgNXOHT5kiNe+ubphWPIIamogCQc4SrXgoY/9Q
    B32RpeJRVn4w+ikE3hS6iqj6B6IEs5roGSlEz4t8K84KLhwFf09qdPif05UMaMfs
    S1gwi82pekTAEdk0IabXwKx4q5uRVNlzejtnDcWekwt4J7TjGJgjlxrDt3isnCjf
    QmOlXarrwDrZ3bLrMPo6ukCFAPhQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfOY58fQ3GTzCr/idIlSNCwy90qEmzq8QHBj7IFSaHzz/xaPKQgnlRhKfDGt2OdSPimPLHyl+uYNwQTWR27wYqjk/56gkkf9/byOfVOV+xEB91ZbB9nJP
    Tfz0x2MWupVf1NEGKLqP7sbZhBcjQeZW3dtfeqjlJ5DHwjVrNtR1xiWJMnPAwU9l2zlvuGzkeA3+cbYKKKdnhOz3nlYkSfKbRYL1xJlKaYCqKjV07BgaC5B2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=R4ayLD03AAAA:8
    a=VwQbUJbxAAAA:8 a=6W9OKRh2ladY7Hu-fEsA:9 a=x8gzFH9gYPwA:10
    a=qJlm0-shE6CLU_iKUWNr:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbeC3UNT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 16:13:19 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43826 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbeC3UNR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 30 Mar 2018 16:13:17 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: manfred@colorfullife.com,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com,
        linux-security-module@vger.kernel.org,
        Pavel Emelyanov <xemul@openvz.org>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
References: <87vadmobdw.fsf_-_@xmission.com>
        <20180323191614.32489-11-ebiederm@xmission.com>
        <20180329005209.fnzr3hzvyr4oy3wi@linux-n805>
        <20180330190951.nfcdwuzp42bl2lfy@linux-n805>
Date: Fri, 30 Mar 2018 15:12:10 -0500
In-Reply-To: <20180330190951.nfcdwuzp42bl2lfy@linux-n805> (Davidlohr Bueso's
        message of "Fri, 30 Mar 2018 12:09:51 -0700")
Message-ID: <87y3i91fxh.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f20Of-0000mV-L0;;;mid=<87y3i91fxh.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+/L7Yw0Izr6/iPI20ne4k34Tfk6UAUC2g=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa04.xmission.com
X-Remote-Spam-Level: ***
X-Remote-Spam-Status: No, score=3.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4966]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;Davidlohr Bueso <dave@stgolabs.net>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 281 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.5 (1.2%), b_tie_ro: 2.4 (0.9%), parse: 1.40 (0.5%),
        extract_message_metadata: 17 (6.2%), get_uri_detail_list: 2.5 (0.9%),
        tests_pri_-1000: 8 (2.7%), tests_pri_-950: 1.62 (0.6%), tests_pri_-900: 1.40
        (0.5%), tests_pri_-400: 26 (9.4%), check_bayes: 25 (8.9%), b_tokenize: 10
        (3.6%), b_tok_get_all: 8 (2.7%), b_comp_prob: 2.6 (0.9%), b_tok_touch_all:
        2.6 (0.9%), b_finish: 0.69 (0.2%), tests_pri_0: 210 (74.8%),
        check_dkim_signature: 0.57 (0.2%), check_dkim_adsp: 3.2 (1.1%),
        tests_pri_500: 7 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [REVIEW][PATCH 11/11] ipc/sem: Fix semctl(..., GETPID, ...) between pid namespaces
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Davidlohr Bueso <dave@stgolabs.net> writes:

> I ran this on a 40-core (no ht) Westmere with two benchmarks. The first
> is Manfred's sysvsem lockunlock[1] program which uses _processes_ to,
> well, lock and unlock the semaphore. The options are a little
> unconventional, to keep the "critical region small" and the lock+unlock
> frequency high I added busy_in=busy_out=10. Similarly, to get the
> worst case scenario and have everyone update the same semaphore, a single
> one is used. Here are the results (pretty low stddev from run to run)
> for doing 100,000 lock+unlock.
>
> - 1 proc:
>   * vanilla
> 	total execution time: 0.110638 seconds for 100000 loops
>   * dirty
> 	total execution time: 0.120144 seconds for 100000 loops
>
> - 2 proc:
>   * vanilla
> 	total execution time: 0.379756 seconds for 100000 loops
>   * dirty
> 	total execution time: 0.477778 seconds for 100000 loops
>
> - 4 proc:
>   * vanilla
> 	total execution time: 6.749710 seconds for 100000 loops
>   * dirty
> 	total execution time: 4.651872 seconds for 100000 loops
>
> - 8 proc:
>   * vanilla
>        total execution time: 5.558404 seconds for 100000 loops
>   * dirty
> 	total execution time: 7.143329 seconds for 100000 loops
>
> - 16 proc:
>   * vanilla
> 	total execution time: 9.016398 seconds for 100000 loops
>   * dirty
> 	total execution time: 9.412055 seconds for 100000 loops
>
> - 32 proc:
>   * vanilla
> 	total execution time: 9.694451 seconds for 100000 loops
>   * dirty
> 	total execution time: 9.990451 seconds for 100000 loops
>
> - 64 proc:
>   * vanilla
> 	total execution time: 9.844984 seconds for 100032 loops
>   * dirty
> 	total execution time: 10.016464 seconds for 100032 loops
>
> Lower task counts show pretty massive performance hits of ~9%, ~25%
> and ~30% for single, two and four/eight processes. As more are added
> I guess the overhead tends to disappear as for one you have a lot
> more locking contention going on.

Can you check your notes on the 4 process case?  As I read the 4 process
case above it is ~30% improvement.  Either that is a typo or there is the
potential for quite a bit of noise in the test case.


Eric
