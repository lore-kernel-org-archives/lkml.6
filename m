Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3056699-1521870010-2-3759743257266294339
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
    t=1521870010; b=phTfjgV1yLCnlbJlXZgmz7nkEXTkA5IG/KYlS3xyhKNnWRE
    VDktG+yevglLDe2kzo4Jt+atAX/YzRn4zAYiI9kmRL17M86Rqj7kEzXDYRoXPuWx
    XMCDYkhk2F+i0u8mMaxlxw7DzljRVm2Lq6W/esx6zpS4Um5UsIrqeJXWmhnRfXYA
    km7c6T430h5cyxxLuKT/XMRvqlEKZIsKhm4vo/uRVQkHPH0UWENnA4u1B/mBHodN
    13bf/PzQdvL0Ffv5CbbLgzMkXO+aX2O+Y4KGQKjAINP1WMBaVy+5xXQ8PMUAas6p
    fIZOsKXQ29YwyLrPKVFAw0gm4CP0IkeM34oC5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    arctest; t=1521870010; bh=GT3yWdAYG7yI6DzoX29aPJCcSlnvhI2eon3506
    8pwaY=; b=kDhvbZdXLhvUZAZx2Kbx6ssGKfTVYSx4GNXJ5xscalI2kLv+1qqqA0
    VVd+bMDvvIZX+52q6pyenYBWyyRj/hWzQQq5ojnuu8YPkdL281s9hVMKjz+wH3Cc
    eU/AIu9XUb2BKcDRird7NI4IruVa3KHggfRJ0/asmrxtOtUL2dGx4qjP/mXfn6S/
    mFzSQrruPk7xU6cE/BS78pIQ4141i0tSB7AGb7xP+wz5U4k8TZ13rXOdTbAp56ff
    o7wJayv2AHCCSALkTfY+DHbJf4aTMuUraNwKxSfMvnKgQIjKPg92yR4aYSda/+0h
    XwiTDbK/XxsByCC1r4iX6UPpDm1KcIMg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbeCXFjz (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Mar 2018 01:39:55 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:56309 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeCXFjy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 24 Mar 2018 01:39:54 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com,
        linux-security-module@vger.kernel.org,
        Pavel Emelyanov <xemul@openvz.org>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
References: <87vadmobdw.fsf_-_@xmission.com>
        <20180323191614.32489-3-ebiederm@xmission.com>
        <bb73b0ea-bcda-a996-8f14-48d9dd1b0940@schaufler-ca.com>
Date: Sat, 24 Mar 2018 00:37:19 -0500
In-Reply-To: <bb73b0ea-bcda-a996-8f14-48d9dd1b0940@schaufler-ca.com> (Casey
        Schaufler's message of "Fri, 23 Mar 2018 14:55:09 -0700")
Message-ID: <87efkam3u8.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ezbsf-00013b-2M;;;mid=<87efkam3u8.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/p6XmQW0IBxmG3YOOQAvhFrM2DCG1iNaQ=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa07.xmission.com
X-Remote-Spam-Level: ****
X-Remote-Spam-Status: No, score=4.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_XMDrugObfuBody_04,XMNoVowels,XMSubLong autolearn=disabled
        version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_04 obfuscated drug references
X-Remote-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ****;Casey Schaufler <casey@schaufler-ca.com>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 15025 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.8 (0.0%), b_tie_ro: 1.93 (0.0%), parse: 0.82 (0.0%),
        extract_message_metadata: 13 (0.1%), get_uri_detail_list: 1.19 (0.0%),
        tests_pri_-1000: 3.3 (0.0%), tests_pri_-950: 1.16 (0.0%), tests_pri_-900:
        1.03 (0.0%), tests_pri_-400: 19 (0.1%), check_bayes: 18 (0.1%), b_tokenize: 6
        (0.0%), b_tok_get_all: 6 (0.0%), b_comp_prob: 1.86 (0.0%), b_tok_touch_all:
        2.4 (0.0%), b_finish: 0.53 (0.0%), tests_pri_0: 174 (1.2%),
        check_dkim_signature: 0.56 (0.0%), check_dkim_adsp: 3.5 (0.0%),
        tests_pri_500: 14808 (98.6%), poll_dns_idle: 14798 (98.5%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [REVIEW][PATCH 03/11] msg/security: Pass kern_ipc_perm not msg_queue into the msg_queue security hooks
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Casey Schaufler <casey@schaufler-ca.com> writes:

> On 3/23/2018 12:16 PM, Eric W. Biederman wrote:
>> All of the implementations of security hooks that take msg_queue only
>> access q_perm the struct kern_ipc_perm member.  This means the
>> dependencies of the msg_queue security hooks can be simplified by
>> passing the kern_ipc_perm member of msg_queue.
>>
>> Making this change will allow struct msg_queue to become private to
>> ipc/msg.c.
>>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  include/linux/lsm_hooks.h  | 12 ++++++------
>>  include/linux/security.h   | 25 ++++++++++++-------------
>>  ipc/msg.c                  | 18 ++++++++----------
>>  security/security.c        | 12 ++++++------
>>  security/selinux/hooks.c   | 36 ++++++++++++++++++------------------
>>  security/smack/smack_lsm.c | 24 ++++++++++++------------
>
> Can I reference the comments I made in PATCH 01 of this set
> regarding the Smack changes? The problem in all of your changes
> is the same. You aren't preserving the naming conventions, and
> you've left in some code that is just silly.

Being silly like that is actually important to make a sweeping patch
like that boring and trivial to show that it is correct.  Anything
that is not a rule based transformation is much more likely to hide
a bug.  So for the push down of the type change I think it was the right
way to go.

That said I am happy to add a clean up patch that makes the obvious
cleanups and simplifications to smack_lsm.c.

Eric




