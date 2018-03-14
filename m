Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbeCNQjV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:39:21 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:56419 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbeCNQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:39:17 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
        <20180314144614.1632190-1-arnd@arndb.de>
        <20180314144614.1632190-2-arnd@arndb.de>
Date: Wed, 14 Mar 2018 11:38:29 -0500
In-Reply-To: <20180314144614.1632190-2-arnd@arndb.de> (Arnd Bergmann's message
        of "Wed, 14 Mar 2018 15:43:47 +0100")
Message-ID: <87r2ompq7u.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ew9Qq-00050Y-3f;;;mid=<87r2ompq7u.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+rqR9pQqZ+uoiSJUgqrH3PIR8FyfSd5m8=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Arnd Bergmann <arnd@arndb.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 316 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.4 (1.1%), b_tie_ro: 2.3 (0.7%), parse: 1.44 (0.5%),
        extract_message_metadata: 22 (6.9%), get_uri_detail_list: 3.7 (1.2%),
        tests_pri_-1000: 10 (3.1%), tests_pri_-950: 1.69 (0.5%), tests_pri_-900: 1.34
        (0.4%), tests_pri_-400: 30 (9.5%), check_bayes: 29 (9.1%), b_tokenize: 12
        (3.8%), b_tok_get_all: 8 (2.7%), b_comp_prob: 2.8 (0.9%), b_tok_touch_all:
        3.3 (1.0%), b_finish: 0.71 (0.2%), tests_pri_0: 234 (74.1%),
        check_dkim_signature: 0.66 (0.2%), check_dkim_adsp: 4.1 (1.3%),
        tests_pri_500: 8 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 12/16] asm-generic: siginfo: remove obsolete #ifdefs
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The frv, tile and blackfin architectures are being removed, so
> we can clean up this header by removing all the special cases
> except those for ia64.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/uapi/asm-generic/siginfo.h | 36 ++----------------------------------
>  1 file changed, 2 insertions(+), 34 deletions(-)
>
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index 85dc965afd89..b2ebf16c391a 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -179,28 +179,13 @@ typedef struct siginfo {
>   * SIGILL si_codes
>   */
>  #define ILL_ILLOPC	1	/* illegal opcode */
> -#ifdef __bfin__
> -# define ILL_ILLPARAOP	2	/* illegal opcode combine */
> -#endif
>  #define ILL_ILLOPN	2	/* illegal operand */
>  #define ILL_ILLADR	3	/* illegal addressing mode */
>  #define ILL_ILLTRP	4	/* illegal trap */
> -#ifdef __bfin__
> -# define ILL_ILLEXCPT	4	/* unrecoverable exception */
> -#endif
>  #define ILL_PRVOPC	5	/* privileged opcode */
>  #define ILL_PRVREG	6	/* privileged register */
>  #define ILL_COPROC	7	/* coprocessor error */
>  #define ILL_BADSTK	8	/* internal stack error */
> -#ifdef __bfin__
> -# define ILL_CPLB_VI	9	/* D/I CPLB protect violation */
> -# define ILL_CPLB_MISS	10	/* D/I CPLB miss */
> -# define ILL_CPLB_MULHIT 11	/* D/I CPLB multiple hit */
> -#endif
> -#ifdef __tile__
> -# define ILL_DBLFLT	9	/* double fault */
> -# define ILL_HARDWALL	10	/* user networks hardwall violation */
> -#endif
>  #ifdef __ia64__
>  # define ILL_BADIADDR	9	/* unimplemented instruction address */
>  # define __ILL_BREAK	10	/* illegal break */
> @@ -219,9 +204,6 @@ typedef struct siginfo {
>  #define FPE_FLTRES	6	/* floating point inexact result */
>  #define FPE_FLTINV	7	/* floating point invalid operation */
>  #define FPE_FLTSUB	8	/* subscript out of range */
> -#ifdef __frv__
> -# define FPE_MDAOVF	9	/* media overflow */
> -#endif
>  #ifdef __ia64__
>  # define __FPE_DECOVF	9	/* decimal overflow */
>  # define __FPE_DECDIV	10	/* decimal division by zero */
> @@ -236,11 +218,7 @@ typedef struct siginfo {
>   */
>  #define SEGV_MAPERR	1	/* address not mapped to object */
>  #define SEGV_ACCERR	2	/* invalid permissions for mapped object */
> -#ifdef __bfin__
> -# define SEGV_STACKFLOW	3	/* stack overflow */
> -#else
> -# define SEGV_BNDERR	3	/* failed address bound checks */
> -#endif
> +#define SEGV_BNDERR	3	/* failed address bound checks */
>  #ifdef __ia64__
>  # define __SEGV_PSTKOVF	4	/* paragraph stack overflow */
>  #else
> @@ -254,12 +232,8 @@ typedef struct siginfo {
>  #define BUS_ADRALN	1	/* invalid address alignment */
>  #define BUS_ADRERR	2	/* non-existent physical address */
>  #define BUS_OBJERR	3	/* object specific hardware error */
> -#ifdef __bfin__
> -# define BUS_OPFETCH	4	/* error from instruction fetch */
> -#else
>  /* hardware memory error consumed on a machine check: action required */
> -# define BUS_MCEERR_AR	4
> -#endif
> +#define BUS_MCEERR_AR	4
>  /* hardware memory error detected in process but not consumed: action optional*/
>  #define BUS_MCEERR_AO	5
>  #define NSIGBUS		5
> @@ -271,12 +245,6 @@ typedef struct siginfo {
>  #define TRAP_TRACE	2	/* process trace trap */
>  #define TRAP_BRANCH     3	/* process taken branch trap */
>  #define TRAP_HWBKPT     4	/* hardware breakpoint/watchpoint */
> -#ifdef __bfin__
> -# define TRAP_STEP	1	/* single-step breakpoint */
> -# define TRAP_TRACEFLOW	2	/* trace buffer overflow */
> -# define TRAP_WATCHPT	3	/* watchpoint match */
> -# define TRAP_ILLTRAP	4	/* illegal trap */
> -#endif
>  #define NSIGTRAP	4
>  
>  /*
