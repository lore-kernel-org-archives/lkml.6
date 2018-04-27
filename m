Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756405AbeD0AuK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 20:50:10 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44685 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeD0AuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 20:50:07 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, tycho@docker.com,
        serge@hallyn.com, sunyuqiong1988@gmail.com, david.safford@ge.com,
        mkayaalp@cs.binghamton.edu, James.Bottomley@HansenPartnership.com,
        Yuqiong Sun <suny@us.ibm.com>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
References: <1522159038-14175-1-git-send-email-stefanb@linux.vnet.ibm.com>
        <1522159038-14175-2-git-send-email-stefanb@linux.vnet.ibm.com>
        <87sh8lcecn.fsf@xmission.com>
        <1523636702.3272.63.camel@linux.vnet.ibm.com>
        <d8c30d7d-c679-9323-7a25-d3148e9b96c6@canonical.com>
        <1524081472.3272.319.camel@linux.vnet.ibm.com>
        <87wox4s282.fsf@xmission.com>
        <8895cb9c-7b9e-2f82-e3d8-a15f5fc26e25@canonical.com>
        <2103bbb9-3f2a-78f8-f7ad-28859659973f@linux.vnet.ibm.com>
        <f84ae8af-fa5b-9f31-fbef-5a49f90dd45a@canonical.com>
        <0d2b2635-d7fb-d240-7dd0-2a81014c58ba@linux.vnet.ibm.com>
Date: Thu, 26 Apr 2018 19:49:59 -0500
In-Reply-To: <0d2b2635-d7fb-d240-7dd0-2a81014c58ba@linux.vnet.ibm.com> (Stefan
        Berger's message of "Thu, 26 Apr 2018 17:18:43 -0400")
Message-ID: <87fu3hbhhk.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fBraN-0008E6-GN;;;mid=<87fu3hbhhk.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Hl3/VdaKPl/oCUBG/Nl1dUzFSNIOn+sY=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4954]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 453 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 7 (1.5%), b_tie_ro: 5 (1.2%), parse: 1.85 (0.4%),
        extract_message_metadata: 6 (1.2%), get_uri_detail_list: 1.96 (0.4%),
        tests_pri_-1000: 8 (1.7%), tests_pri_-950: 2.4 (0.5%), tests_pri_-900: 1.83
        (0.4%), tests_pri_-400: 30 (6.7%), check_bayes: 28 (6.3%), b_tokenize: 11
        (2.4%), b_tok_get_all: 7 (1.6%), b_comp_prob: 3.9 (0.9%), b_tok_touch_all:
        3.1 (0.7%), b_finish: 0.91 (0.2%), tests_pri_0: 364 (80.3%),
        check_dkim_signature: 0.97 (0.2%), check_dkim_adsp: 5 (1.1%), tests_pri_500:
        10 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH v3 1/3] ima: extend clone() with IMA namespace support
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Berger <stefanb@linux.vnet.ibm.com> writes:

> On 04/19/2018 11:35 AM, John Johansen wrote:

>> It sounds like its already decided, with ima and selinux going with an unshare file within their own fs.
>>
>> AppArmor went a different route already, splitting namespace creation (mkdir in the apparmorfs policy/namespace dir) and the task entering the namespace with a write apparmor's equiv of setexeccon.
>>
> I am supporting procfs entries for the IMA namespace spawned by writing a
> boolean '1' into IMA's securityfs 'unshare' file. It would allow to use
> setns(fd, 0), obviously with the 0 parameter. I think this is an important
> function to support considering entering a set of namespace. I am just wondering
> about the 0 parameter. We don't have a CLONE flag for it, so there's not other
> way to support it then. Does it matter ?

That should be fine.  We can pick a flag for setns at some point for
IMA.  The setns function uses the flag field as an enumeration so any of
the low 8 bits or a combination with overlapping bit is valid to setns.

Eric
