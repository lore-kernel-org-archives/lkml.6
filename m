Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3460534-1522278342-2-7838233518728061180
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522278341; b=rEMUuoy7jlUAYwJG62qvX6RKCADKUklSyOV5Y7lgIvO3pBz
    S9VAnOuQie1zFU4WrS84FJ1zNfj2rBg0yMMlCUJRV9Cs2qmbj+W56F2XosRU1hXw
    ZNgWrvdqCJ1PVx0hP9fM79bE6vUZVO79yZG2xdeGB74d9ZRmKmbv6rwsnqVyDtm6
    fCBkereyxH87Rpa+QbbsEDcyzOsdhBf8reZDsD3b/jGIyub5orkXNYGY71MQORXI
    sNnMXWG9Y7t2Kh+KbcAqZYLIvS85c574byvLFp9SjTJqBnbfZ/3TobgKG5JbGFQq
    s/j8UvYvgMQvEcn0hWDGIAD0daroioS4jOO46zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    arctest; t=1522278341; bh=GpNmzo41FEHhhxbGLwK/zTaUh06rN7o/0aViF2
    6/NWY=; b=UCHnDF4WvlXNajRu3roEyHY1A70J/ir5SrqZ17h3lRm7i5ujhC+NG/
    Y2Sm+srHVpvaFoezxEXR2JJ4wyvLs/7Ew4ycvQ/LvSw2Znn+X6qxUef7fielxNwz
    Oa7uumhHgGHEZyWxIhsKIUf8g+ss02vKCkqT9e7Al1o0jKbnVLrxcb4HwCrRo88n
    AbQm0Xr4L2mqA0zUS+ILw14YFGYDZqiRUy5pNVxIE5L8nmHWnVSFH0C48ZTA99Lt
    gLCvZzpu9x2cNFq/ZZN2OHr223e4YsQyDnP32NwUBjMxel42PUtV8apdv2mBeCVT
    2Dde43xCnwATMt9MFDgfLm4dd0vZMXqA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfDbMoWtR9i/U+DjBDKj9aPOZPXlKySR3BHkfIy9K3etrnMIRUK1RFzX5tNC8p+u0q+/nClU5CqZcrom7QqRO+w5gI3nuiQkyt7as7rlAxm1YKzBKuzzi
    yAm+VIrIe3HlgEOi3C6WcnxuLV3Oy5YDW7tIDcbQjM9bkFvv2Z7AEzodi2txqlmeAr0oW4U9DNavy9sQsMGq8lGgdXsNuUkxjwuZFAnbbuu8AUtzYG/nrPLR
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=yPCof4ZbAAAA:8
    a=PtDNVHqPAAAA:8 a=VwQbUJbxAAAA:8 a=McqLMkaVhdXDGWNkingA:9 a=SsLxlLYP9IwA:10
    a=x8gzFH9gYPwA:10 a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752883AbeC1XF2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 19:05:28 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49180 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeC1XF0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 19:05:26 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: NAGARATHNAM MUTHUSAMY <nagarathnam.muthusamy@oracle.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com,
        linux-security-module@vger.kernel.org,
        Pavel Emelyanov <xemul@openvz.org>
References: <87vadmobdw.fsf_-_@xmission.com>
        <20180323191614.32489-9-ebiederm@xmission.com>
        <7df62190-2407-bfd4-d144-7304a8ea8ae3@oracle.com>
        <87lgeio4tb.fsf@xmission.com>
        <1091a91e-f8ee-b091-6d95-78b33520fb2d@oracle.com>
Date: Wed, 28 Mar 2018 18:04:22 -0500
In-Reply-To: <1091a91e-f8ee-b091-6d95-78b33520fb2d@oracle.com> (NAGARATHNAM
        MUTHUSAMY's message of "Fri, 23 Mar 2018 14:41:29 -0700")
Message-ID: <87woxvajk9.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f1K8C-0007P4-0Y;;;mid=<87woxvajk9.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19rVCVpAc2ye7sFYsKdvBtIFdbd3f4Pw48=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa06.xmission.com
X-Remote-Spam-Level: ***
X-Remote-Spam-Status: No, score=3.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,
        T_TooManySym_05,XMNoVowels,XMSubLong autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4873]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_05 8+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;NAGARATHNAM MUTHUSAMY <nagarathnam.muthusamy@oracle.com>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 201 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.0 (1.5%), b_tie_ro: 2.1 (1.1%), parse: 0.97 (0.5%),
        extract_message_metadata: 14 (7.1%), get_uri_detail_list: 1.44 (0.7%),
        tests_pri_-1000: 7 (3.3%), tests_pri_-950: 1.15 (0.6%), tests_pri_-900: 0.99
        (0.5%), tests_pri_-400: 18 (9.0%), check_bayes: 17 (8.6%), b_tokenize: 5
        (2.7%), b_tok_get_all: 6 (2.8%), b_comp_prob: 1.64 (0.8%), b_tok_touch_all:
        2.6 (1.3%), b_finish: 0.62 (0.3%), tests_pri_0: 146 (72.9%),
        check_dkim_signature: 0.44 (0.2%), check_dkim_adsp: 2.7 (1.3%),
        tests_pri_500: 7 (3.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [REVIEW][PATCH 09/11] ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces.
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

NAGARATHNAM MUTHUSAMY <nagarathnam.muthusamy@oracle.com> writes:

> On 3/23/2018 2:33 PM, ebiederm@xmission.com wrote:
>> NAGARATHNAM MUTHUSAMY <nagarathnam.muthusamy@oracle.com> writes:
>>
>>> Thanks!
>>>
>>> Reviewed-by: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
>> Does this look like it will address the issue you have been fighting
>> with pids?
>
> We do use IPC shared memory but it is a single large one, shared by multiple
> levels. We are currently looking into using a similar solution based on file
> locks.
> When a new level is created, a file representing that level could be created in
> a common path which could be locked by the init process of that level.
> Parent levels could query the locking pid of that file to get the pid
> translation
> of the init process of the required level. Then it could open a file descriptor
> and use the translate_pid API for further translations.

Do you want to resend the translate_pid API with file descriptors as it
was in the lwn article?  That I will apply.

Eric
