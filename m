Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161125AbeEXQ4D (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:56:03 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51781 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033992AbeEXQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:55:56 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>, linux-kernel@vger.kernel.org
References: <87o9h6554f.fsf@xmission.com>
        <20180523232538.4880-2-ebiederm@xmission.com>
        <20180524135517.GQ3401@ubuntu-xps13>
Date: Thu, 24 May 2018 11:55:45 -0500
In-Reply-To: <20180524135517.GQ3401@ubuntu-xps13> (Seth Forshee's message of
        "Thu, 24 May 2018 08:55:17 -0500")
Message-ID: <87y3g92dta.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fLtWs-0000lv-1Y;;;mid=<87y3g92dta.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+iqItHExj9W5lbrmwUHmXACpD/0iD1yM0=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Seth Forshee <seth.forshee@canonical.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 469 ms - load_scoreonly_sql: 3.6 (0.8%),
        signal_user_changed: 6 (1.3%), b_tie_ro: 3.4 (0.7%), parse: 2.1 (0.4%),
        extract_message_metadata: 34 (7.3%), get_uri_detail_list: 2.2 (0.5%),
        tests_pri_-1000: 17 (3.6%), tests_pri_-950: 2.8 (0.6%), tests_pri_-900: 1.96
        (0.4%), tests_pri_-400: 29 (6.2%), check_bayes: 27 (5.7%), b_tokenize: 10
        (2.0%), b_tok_get_all: 7 (1.6%), b_comp_prob: 4.1 (0.9%), b_tok_touch_all:
        2.3 (0.5%), b_finish: 0.88 (0.2%), tests_pri_0: 342 (72.9%),
        check_dkim_signature: 1.13 (0.2%), check_dkim_adsp: 6 (1.3%), tests_pri_500:
        21 (4.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [REVIEW][PATCH 2/6] vfs: Allow userns root to call mknod on owned filesystems.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seth Forshee <seth.forshee@canonical.com> writes:

> On Wed, May 23, 2018 at 06:25:34PM -0500, Eric W. Biederman wrote:
>> These filesystems already always set SB_I_NODEV so mknod will not be
>> useful for gaining control of any devices no matter their permissions.
>> This will allow overlayfs and applications to fakeroot to use device
>> nodes to represent things on disk.
>> 
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> For a normal filesystem this does seem safe enough.
>
> However, I'd also like to see us allow unprivileged mounting for
> overlayfs, and there we need to worry about whether this would allow a
> mknod in an underlying filesystem which should not be allowed. That
> mknod will be subject to this same check in the underlying filesystem
> using the credentials of the user that mounted the overaly fs, which
> should be sufficient to ensure that the mknod is permitted.

Sufficient to ensure the mknod is not permitted on the underlying
filesystem.  I believe you mean.

> Thus this looks okay to me.
>
> Acked-by: Seth Forshee <seth.forshee@canonical.com>

Eric
