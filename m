Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753062AbeFAQO6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:14:58 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59701 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbeFAQOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:14:54 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: NAGARATHNAM MUTHUSAMY <nagarathnam.muthusamy@oracle.com>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Serge Hallyn <serge.hallyn@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@amacapital.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <152286911105.615669.14053871624892399807.stgit@buzz>
        <ba7b704f-1fc4-a08d-e7cf-2766160bd419@oracle.com>
        <87h8oqhagl.fsf@xmission.com>
        <112c7cac-1982-3a2e-ffc0-878bc5ae4bb6@yandex-team.ru>
        <e1402871-77a5-6a0f-a75c-ccad77b93f49@oracle.com>
        <778ab3d0-b6bc-fdb5-669a-40222e5020d4@yandex-team.ru>
        <e3a1076d-cfd7-a034-dd08-2d74fbf751f3@oracle.com>
        <3e2c285a-1bf8-f71d-1b74-4d6465c29a54@yandex-team.ru>
        <3bdd6b27-0a46-5802-8671-07268cecc1c7@oracle.com>
        <87po1bd7ky.fsf@xmission.com>
        <CALYGNiPyjJQ2dZHtF+Ug5TFjEcK2O9anLDDDG0JftXtykPAoEg@mail.gmail.com>
        <2cc8a788-56ec-8e30-be04-d5d0e0791f90@oracle.com>
Date: Fri, 01 Jun 2018 11:14:34 -0500
In-Reply-To: <2cc8a788-56ec-8e30-be04-d5d0e0791f90@oracle.com> (NAGARATHNAM
        MUTHUSAMY's message of "Fri, 1 Jun 2018 08:55:43 -0700")
Message-ID: <87r2lqv5zp.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fOmhJ-0006HQ-Gi;;;mid=<87r2lqv5zp.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19g7fiJVOOU2HgFfxN7XsX62HkfpOboctY=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3933]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;NAGARATHNAM MUTHUSAMY <nagarathnam.muthusamy@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15024 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.5 (0.0%), b_tie_ro: 1.71 (0.0%), parse: 0.77 (0.0%),
        extract_message_metadata: 12 (0.1%), get_uri_detail_list: 0.86 (0.0%),
        tests_pri_-1000: 3.4 (0.0%), tests_pri_-950: 1.21 (0.0%), tests_pri_-900:
        1.03 (0.0%), tests_pri_-400: 50 (0.3%), check_bayes: 49 (0.3%), b_tokenize:
        36 (0.2%), b_tok_get_all: 5 (0.0%), b_comp_prob: 1.82 (0.0%),
        b_tok_touch_all: 3.3 (0.0%), b_finish: 0.59 (0.0%), tests_pri_0: 170 (1.1%),
        check_dkim_signature: 7 (0.0%), check_dkim_adsp: 2.7 (0.0%), tests_pri_500:
        14780 (98.4%), poll_dns_idle: 14769 (98.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH RFC v5] pidns: introduce syscall translate_pid
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NAGARATHNAM MUTHUSAMY <nagarathnam.muthusamy@oracle.com> writes:

> On 5/31/2018 11:58 PM, Konstantin Khlebnikov wrote:
>> On Thu, May 31, 2018 at 9:05 PM, Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>>> Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> writes:
>>>
>>>> Ping? Any additional comments on this patch?
>>> Konstantin's v5 no.
>>>
>>>    I am uncomfortable with unnecessary flexibility.  I don't want to
>>>    encourage the increased usage of pids to identify namespaces.  I saw
>>>    no arguments in favor of pids to identify namespaces from Konstantin.
>>>
>>> Your v4 updated to reflect Andrew Morton's concerns in the changelog
>>> yes.
>> Ok, whatever. If I the only blocker then let it be v4 design.
>
> Thanks! I will resend the V4 patch with a plain text man page for
> translate_pid.

I believe Andrew was also asking for the motivating use case in the
description of the patch.

Thank you,
Eric
