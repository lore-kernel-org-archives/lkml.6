Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486815-1522349004-2-2219016599470700860
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
    1522349004; b=M1zCpD9MtNS905wRfx4rq91+PZGJzKctxW5TnjnQXLV3Uf7r6Y
    TioLuJoBFfHmEIsRSpdC3gBgNFtmw95DJbs3Fb6jR4kEPyaSeZu2ISsRR4jlheV5
    Ym28L8uU8oS4vvTv1qRkHx2O7BmvVilRy8F0to/ULWt3iuacCTAnCF58UJmi1Zps
    /Pd4clZ1pyB3Tx5qBPH/FHtPJEKyd+nYzD+W6BTnaYefD+9JzN0Y0pWs0H25KIba
    DREP5U36XeK+OLXGHvLZbRoaTG7OWIt+zBkIFfkVKbX+HucyyK8vJ2S/RK38uxQX
    scZ3PTsQ83gnRrl8HF7QcQxnzIk0RdigpUHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1522349004; bh=JVJAwYyqh3KG9uviCY+1NmOSahs8mQ0p62jqP1T5Vb
    0=; b=ffHP+9oEPc4q8Wui3yNIIInkIasmGXcJZwXyKGkXd7K5ERYcXWWWXqviOV
    jgPZL0eznHDcI+cDbhBEPa4ofYrVe8+t5M5h6Pue9iHV3TDhi3UElAqQ55eTeuYq
    vNfWcLro4nBhE6mkzgFzrs3dpha542VSduBt6X37oqV3NeUq8hPPueUUJUAIZZP7
    ME3bOTlmePfcXd7+hBtzgAUs1s/hVx2HoFflrifAOQ+CeJgcsEN81efzGQ0sFOjl
    o96vbwW09GcKBvTatq14SDm+exZES1Tizbzg8CE1RJmZ0dz/SgMkYT713hlTBcDV
    q1nwX9TPOO7mrZYIEGEo+HYOqlLQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfOIKuCbp/fFW6ixmnDoev7yKR08khnIZhkWHIHdgrJsXY721x1EN3R6F/akNTekx+FDXmok5T5pP5je4nvUXWmbLcvoqfd3pQ40MR/Jlu/9IAhbcqtX0
    734zGYDAgq166bM4cnRQX2aEDCELW9KGIfhyCE+9AMjPZoUC8EvZa2QDp3BeONGKtAWxhGqFIgz6AePBC40RtWPy5CJzJYx2HY+xb324EfzcPL2CsW4MmX1r
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=R4ayLD03AAAA:8
    a=VwQbUJbxAAAA:8 a=cUn0avWGb1kEmwN4CokA:9 a=x8gzFH9gYPwA:10
    a=qJlm0-shE6CLU_iKUWNr:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbeC2SnX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:43:23 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:41298 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbeC2SnV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 14:43:21 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com,
        linux-security-module@vger.kernel.org,
        Pavel Emelyanov <xemul@openvz.org>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
        <87vadzqqq6.fsf@xmission.com>
        <990e88fa-ab50-9645-b031-14e1afbf7ccc@oracle.com>
        <877eqejowd.fsf@xmission.com>
        <3a46a03d-e4dd-59b6-e25f-0020be1b1dc9@oracle.com>
        <87a7v2z2qa.fsf@xmission.com> <87vadmobdw.fsf_-_@xmission.com>
        <20180329011241.v5kgiwbbayz425hk@linux-n805>
Date: Thu, 29 Mar 2018 13:42:00 -0500
In-Reply-To: <20180329011241.v5kgiwbbayz425hk@linux-n805> (Davidlohr Bueso's
        message of "Wed, 28 Mar 2018 18:12:41 -0700")
Message-ID: <874lky911j.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f1cVr-0004Vs-7m;;;mid=<874lky911j.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+J/gEpgA+xzEzZOOpmdQVFV4WC277Vu9U=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa07.xmission.com
X-Remote-Spam-Level: ***
X-Remote-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG,
        XMNoVowels,XMSubLong autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Remote-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;Davidlohr Bueso <dave@stgolabs.net>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 15026 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.2 (0.0%), b_tie_ro: 2.2 (0.0%), parse: 1.18 (0.0%),
        extract_message_metadata: 13 (0.1%), get_uri_detail_list: 1.73 (0.0%),
        tests_pri_-1000: 3.3 (0.0%), tests_pri_-950: 1.27 (0.0%), tests_pri_-900:
        1.04 (0.0%), tests_pri_-400: 21 (0.1%), check_bayes: 20 (0.1%), b_tokenize: 6
        (0.0%), b_tok_get_all: 7 (0.0%), b_comp_prob: 2.3 (0.0%), b_tok_touch_all:
        2.7 (0.0%), b_finish: 0.65 (0.0%), tests_pri_0: 175 (1.2%),
        check_dkim_signature: 0.54 (0.0%), check_dkim_adsp: 3.3 (0.0%),
        tests_pri_500: 14804 (98.5%), poll_dns_idle: 14794 (98.5%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [REVIEW][PATCH 00/11] ipc: Fixing the pid namespace support
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Davidlohr Bueso <dave@stgolabs.net> writes:

> On Fri, 23 Mar 2018, Eric W. Biederman wrote:
>
>>Still I would like to see this fixed and I plan on merging this code.

The code is merged into my for-next tree now.

> Yes, it needs fixed, but 1) there are pending issues (such as the
> extra atomics)

Concerns not issues.  I documented them but I don't see any serious
reason to be concerned.  The data structures are sufficiently different
from AF_UNIX as well as the usage patterns that I have no reasonable
expectation that there will be problems.

There is no reasonable alternate implementation for correcting this bug.
Because of my concerns I looked at several other possibilities and they
all showed incorrect behavior, in different circumstances.

The implementations are simple enough there are no deep subtle issues.

I have tested the code.

If a regression happens the code is carefully split up so things can be
bisected easily and reverted if necessary.

> and 2) its late in the -rc cycle. Plus this issue has existed for 11 years without
> the world ending, so I'm sure we can hold on until at least one more
> release.

People really are starting to seriously look at accessing a single ipc
namespace from multiple pid namespaces.  The work arounds I saw posted
for the current brokenness were too nasty to live.

Better to fix things before there is code that actually starts depending
on the current brokenness.

I am the namespace maintianer and this is my area of responsibility.

The code is ready and I see no reason or benefit in delay.

Eric
