Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750930AbeBPVx6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 16:53:58 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:52818 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeBPVx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 16:53:56 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Dongsu Park <dongsu@kinvolk.io>, lkml <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org, Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>
References: <cover.1512741134.git.dongsu@kinvolk.io>
        <CAOssrKey+oxahrXHO5d6Lu1ZD=r1t-b0i4iZM_Ke9ToqTckjkQ@mail.gmail.com>
Date: Fri, 16 Feb 2018 15:53:19 -0600
In-Reply-To: <CAOssrKey+oxahrXHO5d6Lu1ZD=r1t-b0i4iZM_Ke9ToqTckjkQ@mail.gmail.com>
        (Miklos Szeredi's message of "Tue, 13 Feb 2018 12:32:09 +0100")
Message-ID: <87y3jssisw.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1emnwq-0005W3-VU;;;mid=<87y3jssisw.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18uKjADgJE8OVmViE5VnNZqrFUh7ZQvFqU=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15021 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.6 (0.0%), b_tie_ro: 1.83 (0.0%), parse: 0.79 (0.0%),
        extract_message_metadata: 10 (0.1%), get_uri_detail_list: 0.94 (0.0%),
        tests_pri_-1000: 3.2 (0.0%), compile_eval: 0.22 (0.0%), tests_pri_-950: 1.22
        (0.0%), tests_pri_-900: 1.16 (0.0%), tests_pri_-400: 17 (0.1%), check_bayes:
        16 (0.1%), b_tokenize: 5 (0.0%), b_tok_get_all: 6 (0.0%), b_comp_prob: 1.79
        (0.0%), b_tok_touch_all: 2.2 (0.0%), b_finish: 0.56 (0.0%), tests_pri_0: 116
        (0.8%), check_dkim_signature: 0.49 (0.0%), check_dkim_adsp: 3.5 (0.0%),
        tests_pri_500: 14866 (99.0%), poll_dns_idle: 14857 (98.9%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH v5 00/11] FUSE mounts from non-init user namespaces
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> writes:

> On Fri, Dec 22, 2017 at 3:32 PM, Dongsu Park <dongsu@kinvolk.io> wrote:
>
>> Patches 1-2 deal with an additional flag of lookup_bdev() to check for
>> additional inode permission.
>
> fuse_blk is less suitable for unprivileged mounting than plain fuse.
> fusermount doesn't allow mounting fuse_blk unprivileged, so there's
> little data about that usecase (IIRC ntfs3g guys did that, or at least
> tried to do it, but I don't remember the details).
>
> As such, I think we should leave it out of the initial version.  Which
> means you can drop patches 1-2 from this series.  Unless there's a
> strong use case for this.  In which case we should look hard at the
> differences between fuse_blk and fuse and how that affects
> unprivileged operation.   There are a few assumptions about fuse_blk
> filesystem being more "well behaved", I think.

Especially to start with I am fine with that.

It makes a lot of sense to get the obvious cases first.

Eric
