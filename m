Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757172AbeDKTdY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:33:24 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:49496 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756957AbeDKTdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:33:21 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>, y2038@lists.linaro.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180411150829.3881900-1-arnd@arndb.de>
Date: Wed, 11 Apr 2018 14:32:04 -0500
In-Reply-To: <20180411150829.3881900-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Wed, 11 Apr 2018 17:07:58 +0200")
Message-ID: <87fu41ilor.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f6LUc-0007Jj-NI;;;mid=<87fu41ilor.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.140.30;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18HeMQ2kxbndGHvzUPy9BMq2eLBRZ4XzLI=
X-SA-Exim-Connect-IP: 97.119.140.30
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -3.0 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0014]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Arnd Bergmann <arnd@arndb.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 707 ms - load_scoreonly_sql: 0.31 (0.0%),
        signal_user_changed: 25 (3.6%), b_tie_ro: 17 (2.4%), parse: 1.80 (0.3%),
        extract_message_metadata: 52 (7.4%), get_uri_detail_list: 1.21 (0.2%),
        tests_pri_-1000: 25 (3.5%), tests_pri_-950: 15 (2.1%), tests_pri_-900: 2.0
        (0.3%), tests_pri_-400: 43 (6.1%), check_bayes: 41 (5.8%), b_tokenize: 8
        (1.1%), b_tok_get_all: 10 (1.4%), b_comp_prob: 2.8 (0.4%), b_tok_touch_all: 6
        (0.8%), b_finish: 0.91 (0.1%), tests_pri_0: 511 (72.2%),
        check_dkim_signature: 1.18 (0.2%), check_dkim_adsp: 26 (3.7%), tests_pri_500:
        24 (3.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] sparc: compat: allow including asm/compat.h for 32-bit
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> We have several files on sparc that include linux/compat.h and expect
> asm/compat.h not to be included, otherwise we get a build failure.

Should this say: "We have several files on sparc that include
linux/compat.h and expect asm/compat.h not be included when
!CONFIG_COMPAT." ?

I don't have your tree and I see asm/compat.h included from
linux/compat.h already so the description above seems wrong.

Eric
