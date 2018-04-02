Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754605AbeDBXCK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 19:02:10 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:45971 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754557AbeDBXCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 19:02:08 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: syzbot <syzbot+7a1cff37dbbef9e7ba4c@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, dhowells@redhat.com, gs051095@gmail.com,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        pasha.tatashin@oracle.com, riel@redhat.com, rppt@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com, wangkefeng.wang@huawei.com
References: <94eb2c06406c59cccc0568c527c2@google.com>
Date: Mon, 02 Apr 2018 18:00:57 -0500
In-Reply-To: <94eb2c06406c59cccc0568c527c2@google.com> (syzbot's message of
        "Sun, 01 Apr 2018 01:21:01 -0700")
Message-ID: <878ta5z00m.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f38Sk-0000o8-22;;;mid=<878ta5z00m.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+R6eNXgEtyUOoj4c47k9cvyBVNqAJUEnk=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  2.5 SORTED_RECIPS Recipient list is sorted by address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4956]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_04 obfuscated drug references
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;syzbot
        <syzbot+7a1cff37dbbef9e7ba4c@syzkaller.appspotmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 204 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.8 (1.4%), b_tie_ro: 1.97 (1.0%), parse: 0.72 (0.4%),
        extract_message_metadata: 14 (7.1%), get_uri_detail_list: 1.06 (0.5%),
        tests_pri_-1000: 7 (3.2%), tests_pri_-950: 1.11 (0.5%), tests_pri_-900: 0.94
        (0.5%), tests_pri_-400: 17 (8.3%), check_bayes: 16 (7.8%), b_tokenize: 4.6
        (2.3%), b_tok_get_all: 5 (2.5%), b_comp_prob: 1.59 (0.8%), b_tok_touch_all:
        2.9 (1.4%), b_finish: 0.57 (0.3%), tests_pri_0: 154 (75.7%),
        check_dkim_signature: 0.43 (0.2%), check_dkim_adsp: 2.4 (1.2%),
        tests_pri_500: 3.7 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: KASAN: use-after-free Read in alloc_pid
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+7a1cff37dbbef9e7ba4c@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot hit the following crash on upstream commit
> 9dd2326890d89a5179967c947dab2bab34d7ddee (Fri Mar 30 17:29:47 2018 +0000)
> Merge tag 'ceph-for-4.16-rc8' of git://github.com/ceph/ceph-client
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=7a1cff37dbbef9e7ba4c
>
> So far this crash happened 4 times on upstream.
>
> Unfortunately, I don't have any reproducer for this crash yet.

Do you have any of the other traces?  This looks like a something is
calling put_pid_ns more than it is calling get_pid_ns causing a
reference count mismatch.

If this is not: 9ee332d99e4d5a97548943b81c54668450ce641b

I could use a few more hints to help narrow down what is going wrong.

It would be nice to know what the other 3 crashes looked like and
exactly which upstream they were on.

Eric
