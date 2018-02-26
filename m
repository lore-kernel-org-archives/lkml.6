Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbeBZWMu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:12:50 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:42676 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeBZWMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:12:46 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Arnd Bergmann <arnd@arndb.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        "open list\:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, Guenter Roeck <linux@roeck-us.net>,
        Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>,
        "open list\:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org,
        David Howells <dhowells@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
        <2d12dc77-16b9-417d-72e3-2b1ffa38803d@gmail.com>
        <CAK8P3a2GP8uQWe+DCD=p-JLHxXBUTBpx9nnpNzF_Hz49XA9a8A@mail.gmail.com>
Date: Mon, 26 Feb 2018 16:11:54 -0600
In-Reply-To: <CAK8P3a2GP8uQWe+DCD=p-JLHxXBUTBpx9nnpNzF_Hz49XA9a8A@mail.gmail.com>
        (Arnd Bergmann's message of "Mon, 26 Feb 2018 09:26:57 +0100")
Message-ID: <877eqz1jv9.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eqR0V-0005HF-00;;;mid=<877eqz1jv9.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ldKvu5W0bi/2HjmDirfnMhIhzyB1Sojc=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Arnd Bergmann <arnd@arndb.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15028 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.8 (0.0%), b_tie_ro: 1.89 (0.0%), parse: 0.96 (0.0%),
        extract_message_metadata: 15 (0.1%), get_uri_detail_list: 2.0 (0.0%),
        tests_pri_-1000: 3.9 (0.0%), tests_pri_-950: 1.14 (0.0%), tests_pri_-900:
        1.02 (0.0%), tests_pri_-400: 25 (0.2%), check_bayes: 24 (0.2%), b_tokenize: 8
        (0.1%), b_tok_get_all: 8 (0.1%), b_comp_prob: 2.5 (0.0%), b_tok_touch_all:
        3.2 (0.0%), b_finish: 0.68 (0.0%), tests_pri_0: 205 (1.4%),
        check_dkim_signature: 0.45 (0.0%), check_dkim_adsp: 4.1 (0.0%),
        tests_pri_500: 14771 (98.3%), poll_dns_idle: 14761 (98.2%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: Removing architectures without upstream gcc support
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Sat, Feb 24, 2018 at 1:15 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 02/22/2018 07:45 AM, Arnd Bergmann wrote:
>>
>> Add blackfin to that list, there have been no responses from the
>> maintainers last time I posted patches to remove DSA header files, so we
>> had to go these through the networking tree. Have not see a Blackfin
>> pull request since forever, Aaron himself seems to agree this should be
>> removed:
>>
>> http://lkml.iu.edu/hypermail/linux/kernel/1801.1/04345.html
>
> Peter Zijlstra also mentioned that one on IRC, I didn't have it on my radar
> before. Like Tile, it has only recently been marked as Orphaned in MAINTAINERS,
> so I'd be inclined to wait a little while to give possible users a
> chance to step
> up as new maintainers.
>
> My plan for v4.17 is now:
>
> - remove score, unicore and metag due to lack of toolchain
>   or interest from the maintainers.
> - keep hexagon, and try to build an llvm/clang toolchain
> - remove frv and m32r due to being abandoned for several years
> - mark tile and blackfin for pending removal later this year unless
>   a new maintainer steps up
> - mark mn10300 for pending removal unless it gets updated to
>   support chips that were made in the past 12 years and to build
>   properly.

My frustration says please please please remove blackfin with sugar on
top.   If you look at the new unified siginfo.h you will notice that
blackfin has the majority of conflicting si_code definitions.

Given that I have already dealt with the frustrating situations I can
wait a release or two.  But even though I found a cross compiler for
blackfin there is a real cost to keeping it in the tree.

Eric
