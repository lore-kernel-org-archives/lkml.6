Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2204151-1521840871-2-12481405069006800727
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521840869; b=rUqXCe54hZA8Ps7goORxDP7PfrQovvLZ6lcu8V+en+z2U0V
    l03FMyKKu3ZjxmxOux32rG0pxVKRDVXaDzXMTKkhX85kW8QRx5f9WTzb9TSqawmV
    reloZ3WvqNrg+n2qH+40B8kVt3fOb7M2gdzIAGvf0L9KiSU1fk4iuvgGMAMF/JNb
    bDULKKt311Q2lYeEgyek4urPL/XhN1nK7SZ1kVgA3VRr3boxKjSpISwFUPWgpVVO
    0c1NdXYzDJrtQG9nn3Et4MQiar2B9sdDABKYY1LHq8CGxcxcTjkdkIQlNvucrwMj
    4tfS2jyyk68/tLzhdrtzHYM4PEinJxI8XrN3zxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    arctest; t=1521840869; bh=B7Fogr4fcVRR3IN9/C/+v45K21LEROKYbEa8YR
    gvoPo=; b=Zxv7zVmI26j2+it0c471HsKfmIegr6V3/IaQl/afN3vEFGfe2nqVNw
    lstcvYU/JkXlutvFwat0QB/FdnflSQMgeO2wlP7CsUxTxHcRXFwXsF/GNzUp0Cn8
    Bd65JIWe+ZTqHczCN8+7gffUj1gStFHE+Ts85r3G/MpaBeMQwi12zlsJtPoemeef
    4gsPvWtZVm8qL+U1aKLc50/SseL42o52JqTKTdCZVlym0Ui1k5KtG6IbHBpdAodl
    qmbuo+JIUvNFVwXZWIRndEI+9RoWCyxDZhSI3GheoYbORCqIIPmWYP4JVCabpDYk
    mkFrsUvNSemBngeW9ZaT2Lj0pyAoQTMw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbeCWVeU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 17:34:20 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58732 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752066AbeCWVeT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Mar 2018 17:34:19 -0400
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
Date: Fri, 23 Mar 2018 16:33:20 -0500
In-Reply-To: <7df62190-2407-bfd4-d144-7304a8ea8ae3@oracle.com> (NAGARATHNAM
        MUTHUSAMY's message of "Fri, 23 Mar 2018 14:17:35 -0700")
Message-ID: <87lgeio4tb.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ezUKH-0000XQ-8k;;;mid=<87lgeio4tb.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18YylTtffMEqTDdDg82zrdx59gDl6grtyQ=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa06.xmission.com
X-Remote-Spam-Level: ***
X-Remote-Spam-Status: No, score=3.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,
        T_TooManySym_05,XMNoVowels,XMSubLong autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4930]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_05 8+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;NAGARATHNAM MUTHUSAMY <nagarathnam.muthusamy@oracle.com>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 154 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.5 (1.6%), b_tie_ro: 1.83 (1.2%), parse: 0.69 (0.5%),
        extract_message_metadata: 9 (5.9%), get_uri_detail_list: 0.52 (0.3%),
        tests_pri_-1000: 4.9 (3.2%), tests_pri_-950: 1.14 (0.7%), tests_pri_-900:
        0.99 (0.6%), tests_pri_-400: 16 (10.6%), check_bayes: 15 (10.0%), b_tokenize:
        4.4 (2.9%), b_tok_get_all: 6 (3.8%), b_comp_prob: 1.39 (0.9%),
        b_tok_touch_all: 2.3 (1.5%), b_finish: 0.59 (0.4%), tests_pri_0: 110 (71.8%),
        check_dkim_signature: 0.44 (0.3%), check_dkim_adsp: 2.6 (1.7%),
        tests_pri_500: 4.9 (3.2%), rewrite_mail: 0.00 (0.0%)
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

> Thanks!
>
> Reviewed-by: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>

Does this look like it will address the issue you have been fighting
with pids?

Eric
