Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeCUODT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:03:19 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:45690 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbeCUODR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:03:17 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180321172658.45b892a3@canb.auug.org.au>
Date: Wed, 21 Mar 2018 09:02:06 -0500
In-Reply-To: <20180321172658.45b892a3@canb.auug.org.au> (Stephen Rothwell's
        message of "Wed, 21 Mar 2018 17:26:58 +1100")
Message-ID: <87zi31y1b5.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eyeKS-0000bU-KH;;;mid=<87zi31y1b5.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/WZKLs4n+CdokHYJkdfkcIzZbZ1M1HxW4=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Stephen Rothwell <sfr@canb.auug.org.au>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15024 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.1 (0.0%), b_tie_ro: 2.1 (0.0%), parse: 1.11 (0.0%),
        extract_message_metadata: 12 (0.1%), get_uri_detail_list: 1.62 (0.0%),
        tests_pri_-1000: 2.9 (0.0%), tests_pri_-950: 1.18 (0.0%), tests_pri_-900:
        0.96 (0.0%), tests_pri_-400: 27 (0.2%), check_bayes: 26 (0.2%), b_tokenize: 8
        (0.1%), b_tok_get_all: 6 (0.0%), b_comp_prob: 2.6 (0.0%), b_tok_touch_all: 6
        (0.0%), b_finish: 0.69 (0.0%), tests_pri_0: 150 (1.0%), check_dkim_signature:
        0.84 (0.0%), check_dkim_adsp: 3.7 (0.0%), tests_pri_500: 14823 (98.7%),
        poll_dns_idle: 14814 (98.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: linux-next: manual merge of the userns tree with the fuse tree
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Today's linux-next merge of the userns tree got a conflict in:
>
>   fs/fuse/dev.c
>
> between commits:
>
>   dbf107b2a7f3 ("fuse: Remove the buggy retranslation of pids in fuse_dev_do_read")
>   c9582eb0ff7d ("fuse: Fail all requests with invalid uids or gids")
>   8cb08329b080 ("fuse: Support fuse filesystems outside of init_user_ns")
>
> from the fuse tree and commits:
>
>   dbf107b2a7f3 ("fuse: Remove the buggy retranslation of pids in fuse_dev_do_read")
>   c9582eb0ff7d ("fuse: Fail all requests with invalid uids or gids")
>   8cb08329b080 ("fuse: Support fuse filesystems outside of init_user_ns")
>
> from the userns tree.
>
> These commits seem to have been rebased in the fuse tree on top of
>
>   3b7008b226f3 ("fuse: return -ECONNABORTED on /dev/fuse read after abort")
>
> and modified a bit.
>
> I fixed it up (I used the fuse tree version, but please come to
> some arrangement about which is correct) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

As Miklos has merged these I plan to drop these changes from my tree.

Eric
