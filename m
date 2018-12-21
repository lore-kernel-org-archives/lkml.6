Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEA9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFDD2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388102AbeLUJo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:44:58 -0500
Received: from m97179.mail.qiye.163.com ([220.181.97.179]:20912 "EHLO
        m97179.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733247AbeLUJo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:44:57 -0500
X-Greylist: delayed 665 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Dec 2018 04:44:55 EST
Received: from localhost (unknown [124.65.100.10])
        by m97179.mail.qiye.163.com (Hmail) with ESMTPA id 1CD34E01448;
        Fri, 21 Dec 2018 17:33:48 +0800 (CST)
Date:   Fri, 21 Dec 2018 17:33:47 +0800
From:   WANG Chao <chao.wang@ucloud.cn>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Borislav Petkov <bp@suse.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        srinivas.eeda@oracle.com
Subject: Re: [PATCH] treewide: replace RETPOLINE with CONFIG_RETPOLINE
Message-ID: <20181221093347.GA88654@WANG-Chaos-MacBook-Pro.local>
References: <20181210163725.95977-1-chao.wang@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210163725.95977-1-chao.wang@ucloud.cn>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-HM-Spam-Status: e1kIGBQJHllBS1VLV1koWUFJQjdXWS1ZQUlXWQkOFx4IWUFZMjUtOjcyP0
        FLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngw6Iyo*STlOGT4NDgEsLwoY
        HEMKFAlVSlVKTk9OSENPQ0lDSUJJVTMWGhIXVRgTGhRVDBoVHDsOGBcUDh9VGBVFWVdZEgtZQVlK
        SU9VTU5VSktLVUpLWVdZCAFZQU9PTks3Bg++
X-HM-Tid: 0a67d01d1d0420bdkuqy1cd34e01448
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 at 12:37P, WANG Chao wrote:
> Since commit 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend
> on compiler support"), RETPOLINE has been replaced by CONFIG_RETPOLINE.
> 
> Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")
> Signed-off-by: WANG Chao <chao.wang@ucloud.cn>

ping ...

> ---
>  arch/x86/kernel/cpu/bugs.c   | 2 +-
>  include/linux/compiler-gcc.h | 2 +-
>  include/linux/module.h       | 2 +-
>  scripts/mod/modpost.c        | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 500278f5308e..e8abe3f6c10e 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -213,7 +213,7 @@ static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
>  static enum spectre_v2_user_mitigation spectre_v2_user __ro_after_init =
>  	SPECTRE_V2_USER_NONE;
>  
> -#ifdef RETPOLINE
> +#ifdef CONFIG_RETPOLINE
>  static bool spectre_v2_bad_module;
>  
>  bool retpoline_module_ok(bool has_retpoline)
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 2010493e1040..977ddf2774f9 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -68,7 +68,7 @@
>   */
>  #define uninitialized_var(x) x = x
>  
> -#ifdef RETPOLINE
> +#ifdef CONFIG_RETPOLINE
>  #define __noretpoline __attribute__((__indirect_branch__("keep")))
>  #endif
>  
> diff --git a/include/linux/module.h b/include/linux/module.h
> index fce6b4335e36..0c575f51fe57 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -817,7 +817,7 @@ static inline void module_bug_finalize(const Elf_Ehdr *hdr,
>  static inline void module_bug_cleanup(struct module *mod) {}
>  #endif	/* CONFIG_GENERIC_BUG */
>  
> -#ifdef RETPOLINE
> +#ifdef CONFIG_RETPOLINE
>  extern bool retpoline_module_ok(bool has_retpoline);
>  #else
>  static inline bool retpoline_module_ok(bool has_retpoline)
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 0d998c54564d..5a5b3780456f 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2157,7 +2157,7 @@ static void add_intree_flag(struct buffer *b, int is_intree)
>  /* Cannot check for assembler */
>  static void add_retpoline(struct buffer *b)
>  {
> -	buf_printf(b, "\n#ifdef RETPOLINE\n");
> +	buf_printf(b, "\n#ifdef CONFIG_RETPOLINE\n");
>  	buf_printf(b, "MODULE_INFO(retpoline, \"Y\");\n");
>  	buf_printf(b, "#endif\n");
>  }
> -- 
> 2.19.2
> 
> 
