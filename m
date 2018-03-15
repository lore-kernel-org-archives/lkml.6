Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeCOKHV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:07:21 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:43830 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeCOKHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:07:19 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
        <20180314144614.1632190-1-arnd@arndb.de>
        <20180314144614.1632190-2-arnd@arndb.de>
Date: Thu, 15 Mar 2018 05:06:29 -0500
In-Reply-To: <20180314144614.1632190-2-arnd@arndb.de> (Arnd Bergmann's message
        of "Wed, 14 Mar 2018 15:43:47 +0100")
Message-ID: <87po45hcuy.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ewPn4-0007jw-2B;;;mid=<87po45hcuy.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Gp8JBdaqo+phXc4Xa6OPNRQzNVis/7SQ=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4993]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Arnd Bergmann <arnd@arndb.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 177 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.5 (1.4%), b_tie_ro: 1.64 (0.9%), parse: 1.26 (0.7%),
        extract_message_metadata: 15 (8.6%), get_uri_detail_list: 1.08 (0.6%),
        tests_pri_-1000: 9 (4.9%), tests_pri_-950: 1.78 (1.0%), tests_pri_-900: 1.50
        (0.9%), tests_pri_-400: 19 (10.5%), check_bayes: 17 (9.8%), b_tokenize: 7
        (4.2%), b_tok_get_all: 4.3 (2.4%), b_comp_prob: 1.78 (1.0%), b_tok_touch_all:
        2.1 (1.2%), b_finish: 0.60 (0.3%), tests_pri_0: 120 (67.6%),
        check_dkim_signature: 0.51 (0.3%), check_dkim_adsp: 2.7 (1.5%),
        tests_pri_500: 3.8 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 12/16] asm-generic: siginfo: remove obsolete #ifdefs
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The frv, tile and blackfin architectures are being removed, so
> we can clean up this header by removing all the special cases
> except those for ia64.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/uapi/asm-generic/siginfo.h | 36 ++----------------------------------
>  1 file changed, 2 insertions(+), 34 deletions(-)
>

If I am reading siginfo.h correctly after this cleanup patch
we can perform another cleanup and unconditionally define
all of the ia64 si_codes except for __SEGV_PSTKOVF which
aliases SEGV_PKUERR.

Which has the advantage that no one is tempted to define any further
aliased si_codes.

Eric
