Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbeE3Tll (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:41:41 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:45483 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753627AbeE3Tlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:41:39 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Dave Chinner <david@fromorbit.com>, Eric Sandeen <sandeen@sandeen.net>,
        Eric Biggers <ebiggers3@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Brian Foster <bfoster@redhat.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000457b2d056cbb0044@google.com>
        <20180522123107.GC3751@bfoster.bfoster>
        <20180522222620.GW23861@dastard>
        <20180522225208.GB658@sol.localdomain>
        <20180523074425.GM14384@magnolia>
        <20180523162015.GA3684@sol.localdomain>
        <a52266f9-0096-b28c-c01c-046ababcfe3a@sandeen.net>
        <20180523234114.GA3434@thunk.org> <20180524004931.GB23861@dastard>
        <20180524005906.GC3434@thunk.org>
Date: Wed, 30 May 2018 14:41:32 -0500
In-Reply-To: <20180524005906.GC3434@thunk.org> (Theodore Y. Ts'o's message of
        "Wed, 23 May 2018 20:59:06 -0400")
Message-ID: <87k1rlgccz.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fO6yW-0007tk-UN;;;mid=<87k1rlgccz.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18au9+f3h+9YrY7FpaT1BNyOj/uzMbiHVs=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3116]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Theodore Y. Ts'o" <tytso@mit.edu>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1220 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.8 (0.2%), b_tie_ro: 1.87 (0.2%), parse: 0.99 (0.1%),
        extract_message_metadata: 4.1 (0.3%), get_uri_detail_list: 1.50 (0.1%),
        tests_pri_-1000: 4.7 (0.4%), tests_pri_-950: 1.45 (0.1%), tests_pri_-900:
        1.23 (0.1%), tests_pri_-400: 20 (1.6%), check_bayes: 19 (1.5%), b_tokenize: 6
        (0.5%), b_tok_get_all: 6 (0.5%), b_comp_prob: 2.3 (0.2%), b_tok_touch_all:
        2.3 (0.2%), b_finish: 0.60 (0.0%), tests_pri_0: 1169 (95.8%),
        check_dkim_signature: 0.63 (0.1%), check_dkim_adsp: 2.8 (0.2%),
        tests_pri_500: 6 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Bugs involving maliciously crafted file system
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Y. Ts'o" <tytso@mit.edu> writes:

> On Thu, May 24, 2018 at 10:49:31AM +1000, Dave Chinner wrote:
>> User automounting of removable storage should be done via a
>> privilege separation mechanism and hence avoid this whole class of
>> security problems. We can get this separation by using FUSE in these
>> situations, right?
>
> FUSE is a pretty terrible security boundary.  And not all file systems
> have FUSE support.  As I had suggested earlier, probably better to use
> 9P, and mount the file system in a VM.

I just have to ask.  Why do you find FUSE to be a pretty terrible
security boundary?

My experience with kernel's 9P implemenation is that it is scarier to
deal with, and that 9P is starting to suffer the maladies of an
unmaintained filesystem (which it is).

FUSE was always written with the assumption that it would be attacked by
malicious users and generally appears robust against that kind of thing.

The whole internet accessibleness of 9P while making it usable in VM's
generally looks like down-side as it adds a the whole issue of
malicious packets from a 3rd party that is neither client nor server to
deal with.

Eric
