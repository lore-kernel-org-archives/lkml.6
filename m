Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F8DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BED223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BED223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeKPFkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:40:14 -0500
Received: from mout.gmx.net ([212.227.17.21]:45187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725742AbeKPFkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:40:14 -0500
Received: from [192.168.20.60] ([92.116.174.227]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQ7sF-1gS4JO3rHv-005LoQ; Thu, 15
 Nov 2018 20:30:58 +0100
Subject: Re: [PATCH v7 0/5] parisc: system call table generation support
To:     Firoz Khan <firoz.khan@linaro.org>, linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
References: <1542177301-25844-1-git-send-email-firoz.khan@linaro.org>
From:   Helge Deller <deller@gmx.de>
Message-ID: <58c3c4a4-7f55-bf08-1c96-ef1aa7f97072@gmx.de>
Date:   Thu, 15 Nov 2018 20:30:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1542177301-25844-1-git-send-email-firoz.khan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:33G1HuU9zPs50P5qFHJN1mIKF9MkI7g1YnxVzHf3TGiyBGz+kSC
 NrBlAE9s3pTBJ4HPJYWRGPgHKbH+WR4UhwsOvITwewpWE2xaMsBpiIBAu79HelFLPyM82rj
 BVFz9waLYn1hPPXufMcbxuFlGZtc71tuaggVPlmAIpGMFPAvT5hIcIXUAesy1rlZeMEefMG
 hw6y3Cm5Bl6BHNc0eHBJA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A7KOrODjcYk=:7ACHZM3rpn9yt/lsjJClFj
 gmPZN52MLI+IyPpsqmWi4CKhcdqx/5LToShj8LEHaUDm18nwSjjLThMXwZigCAFL/eFrXXVVP
 2vCiUiexiOPrNqW96VZjVImxkLj07/7NpXhwhejPCIVhZMtAjAKh5FmMwuNYJcH2MxPSIcBQK
 Slada19QVodULmyWu3DSi7xrRPmfxYQFG8i7uEtgkM5UWDu35NLHhq1G2yMLLLW2OOxCtnE8H
 WZoIlveBu3B/nxBfyEbBQgQCN4BYOBFVZa3Z7pMvzV9BObN4GJ7b9fvMQgbkKFD6mgeM4gROY
 nGYQLILaQlnTTf0u8fuKzLJYd/lspEcn/OHK7Yswp5jxt5/eMmbQqKZuLzxFxpo1XiY8lrnrf
 WmUVytSdfxcI5Rm+3H19y4urGmt9X3/4oKyHLFi7FSXyDnBvcHNKreEZRRG5q5b4xiTcKl6g+
 2fLAepAHS6d42LPJBjNu1szJvCzV59eECmgg8J8lHibOGKdwf1qpLp0GORQTga4tMAaqcZgfi
 ODRNW0uTcbwQhr8nK9J0K/yn6O+5hxFLA2ToOlShEY9qMRUzSANv2rZyE67ua9nFd1KgADpeT
 dzF0ElhARwChSV51OANbNDLkK9Pbndj4TBXFhH3Hz5Vi1DIforOx0TiVH91x7VI+orsMwFAbh
 Ia7cMS0RbBS9yiVLvep9nP03HIfMvGTv20KJzBTyjhFKzSaaUmGl1ng91AhxW+pxpFgRQyHdo
 GMXueEz6h+YQAaq3jD5yX99ymk/LnSzzwWW21XPg11AMfBloqOKLCkPOCRcw+bOmc6vXnfBWb
 VEBAkTx0tAD15A4DmZU3e0tW5ZZu3OCSAxjkm5yvKsEvfRQ6vOddIz2qjn2CWJ5dxnewN2fzr
 BMzy+3cq1DF+QnMedC7VTPmosqrPlHx/5Ha2JOIPRgG1Eh01eOh3iirGXKtqYt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.11.2018 07:34, Firoz Khan wrote:
> The purpose of this patch series is, we can easily
> add/modify/delete system call table support by cha-
> nging entry in syscall.tbl file instead of manually
> changing many files. The other goal is to unify the
> system call table generation support implementation
> across all the architectures.
> 
> The system call tables are in different format in
> all architecture. It will be difficult to manually
> add, modify or delete the system calls in the resp-
> ective files manually. To make it easy by keeping a
> script and which'll generate uapi header file and
> syscall table file.
> 
> syscall.tbl contains the list of available system
> calls along with system call number and correspond-
> ing entry point. Add a new system call in this arch-
> itecture will be possible by adding new entry in the
> syscall.tbl file.
> 
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
> 
> ARM, s390 and x86 architecuture does exist the sim-
> ilar support. I leverage their implementation to
> come up with a generic solution.
> 
> I have done the same support for work for alpha, ia64,
> m68k, microblaze, mips, powerpc, sh, sparc and xtensa.
> Below mentioned git repository contains more details
> about the workflow.
> 
> https://github.com/frzkhn/system_call_table_generator/
> 
> Finally, this is the ground work to solve the Y2038
> issue. We need to add two dozen of system calls to
> solve Y2038 issue. So this patch series will help to
> add new system calls easily by adding new entry in
> the syscall.tbl.
> 
> changes since v6:
>  - changed from generic-y to generated-y in Kbuild.
> 
> changes since v5:
>  - optimized/updated the syscall table generation
>    scripts.
>  - fixed all mixed indentation issues in syscall.tbl.
>  - added "comments" in syscall_*.tbl.
> 
> changes since v4:
>  - optimized/updated the syscall table generation
>    scripts.
>  - removed __IGNORE entries which was added in v2
>    to suppress the warning.
> 
> changes since v3:
>  - optimized/updated the syscall table generation
>    scripts.
>  - added missing new line.
> 
> changes since v2:
>  - updated the syscall.tbl file by including missed
>    entries.
> 
> changes since v1:
>  - enclosed __NR_sycalls macro with __KERNEL__.
> 
> Firoz Khan (5):
>   parisc: move __IGNORE* entries to non uapi header
>   parisc: add __NR_syscalls along with __NR_Linux_syscalls
>   parisc: add system call table generation support
>   parisc: generate uapi header and system call table files
>   parisc: syscalls: ignore nfsservctl for other architectures

Firoz, you may add
Acked-by: Helge Deller <deller@gmx.de>
to the whole parisc series.

Thanks!
Helge


 
>  arch/parisc/Makefile                      |   3 +
>  arch/parisc/include/asm/Kbuild            |   3 +
>  arch/parisc/include/asm/unistd.h          |   8 +
>  arch/parisc/include/uapi/asm/Kbuild       |   2 +
>  arch/parisc/include/uapi/asm/unistd.h     | 382 +------------------------
>  arch/parisc/kernel/syscall.S              |  11 +-
>  arch/parisc/kernel/syscall_table.S        | 459 ------------------------------
>  arch/parisc/kernel/syscalls/Makefile      |  57 ++++
>  arch/parisc/kernel/syscalls/syscall.tbl   | 369 ++++++++++++++++++++++++
>  arch/parisc/kernel/syscalls/syscallhdr.sh |  36 +++
>  arch/parisc/kernel/syscalls/syscalltbl.sh |  36 +++
>  scripts/checksyscalls.sh                  |   1 +
>  12 files changed, 531 insertions(+), 836 deletions(-)
>  delete mode 100644 arch/parisc/kernel/syscall_table.S
>  create mode 100644 arch/parisc/kernel/syscalls/Makefile
>  create mode 100644 arch/parisc/kernel/syscalls/syscall.tbl
>  create mode 100644 arch/parisc/kernel/syscalls/syscallhdr.sh
>  create mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh
> 

