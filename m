Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeCNR0l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:26:41 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41170 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbeCNR0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:26:37 -0400
X-Google-Smtp-Source: AG47ELuMBnZjubhg8ql77ERB0vhpRf0GZOnrNUbBIWw26V4lNhhAk11Pc63mAtGpYREittYLQXVeSg==
Date: Wed, 14 Mar 2018 13:26:35 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
cc: linux-kbuild@vger.kernel.org, Jarod Wilson <jarod@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] kbuild: touch autoksyms.h when it is really
 missing
In-Reply-To: <1521045861-22418-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <nycvar.YSQ.7.76.1803141324420.28583@knanqh.ubzr>
References: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com> <1521045861-22418-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Masahiro Yamada wrote:

> From the comment, I expect this code creates autoksyms.h in case it
> is missing, but it actually touches it when it does exists.

Oops, indeed.

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> I do not know when this code is useful...
> 
> If autoksyms.h were missing, build should have already failed because
> include/{linux,asm-generic}/export.h need it.
> 
> Maybe for standalone test?
> Or, in order to make this script self-contained?

I agree it isn't very useful. Proof: it was wrong and wouldn't have 
worked as intended. So the best fix might be to simply remove that line.



> 
> 
>  scripts/adjust_autoksyms.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
> index 513da1a..a52210b 100755
> --- a/scripts/adjust_autoksyms.sh
> +++ b/scripts/adjust_autoksyms.sh
> @@ -49,7 +49,7 @@ case "${KCONFIG_CONFIG}" in
>  esac
>  
>  # In case it doesn't exist yet...
> -if [ -e "$cur_ksyms_file" ]; then touch "$cur_ksyms_file"; fi
> +if [ ! -e "$cur_ksyms_file" ]; then touch "$cur_ksyms_file"; fi
>  
>  # Generate a new ksym list file with symbols needed by the current
>  # set of modules.
> -- 
> 2.7.4
> 
> 
