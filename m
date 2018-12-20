Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B407BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7420C21904
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbeLTUSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:18:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45941 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbeLTUSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:18:06 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so2709482ljd.12;
        Thu, 20 Dec 2018 12:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XroxzhWfPD2bAvfx/V2TZG7sZyZWMjyXnGj7iTyn1kw=;
        b=iTJrF2cM+U61uFKeZQKI72864KcXJOiQnipSpmAU5dpIv7v0VUKzGWtwKfEjVKFQ+W
         vzTT3QiRewLP+DEM8ocYmq7vcOl/Y527X0UZfM6R637ZP7dmDpO5DZVZ7C0zrbbBKytE
         PvxWVcpCt3j/so+ZlfcRYMAk4NVGTCtXt0kODDVfruI66KhCjINWI3m0W604+4zpphDp
         UbBfe6ltYB/63xHetwAzJIRsv68FdJMdeCimLa65z8Y64S4cYDYIlPo1S/K5aYHMxbYF
         ytZ7n2WvPQBYl+F66anLXBHtpf1DASc//Ec7O4xauyM898AIqbCFtMRBLEJ2YOWTdPyq
         XLVg==
X-Gm-Message-State: AA+aEWbhpTssXhxxVsd6hG9/wn0McVuMKfM7BrGW2uaYjQjEnEWOYE3Z
        rvofza3I1GncTl/TxTTOaF5WGOr7
X-Google-Smtp-Source: AFSGD/VsX2RyKim/2+YJLbpSUk7aHoJQsm1tiby++CjLp4cUGTUgLgCzZNJjadj+9cOBKjNCVdk8uA==
X-Received: by 2002:a2e:7801:: with SMTP id t1-v6mr8960232ljc.84.1545337083160;
        Thu, 20 Dec 2018 12:18:03 -0800 (PST)
Received: from [192.168.1.183] (128-68-180-112.broadband.corbina.ru. [128.68.180.112])
        by smtp.gmail.com with ESMTPSA id d190sm5212311lfe.9.2018.12.20.12.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 12:18:02 -0800 (PST)
Reply-To: alex.popov@linux.com
Subject: Re: 10e9ae9fab ("gcc-plugins: Add STACKLEAK plugin for tracking .."):
 WARNING: can't dereference registers at (null) for ip
 entry_SYSCALL_64_after_hwframe
To:     kernel test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>
Cc:     LKP <lkp@01.org>, kernel-hardening@lists.openwall.com,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5c18828f.VHbQvL3kBXAW0ohl%lkp@intel.com>
From:   Alexander Popov <alex.popov@linux.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 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
 jXz/74kjFsyRgZA+d6a1pGtOwITEBxtxxg==
Message-ID: <532c3a5b-3358-6f70-b0e8-c2b4afbbbab3@linux.com>
Date:   Thu, 20 Dec 2018 23:18:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5c18828f.VHbQvL3kBXAW0ohl%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I've carefully worked with this report, let me share the results.

On 18.12.2018 8:15, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit 10e9ae9fabaf96c8e5227c1cd4827d58b3aa406d
>     gcc-plugins: Add STACKLEAK plugin for tracking the kernel stack

This bot has been running trinity at the following points:

> afaef01c00  x86/entry: Add STACKLEAK erasing the kernel stack at the end of syscalls
> 10e9ae9fab  gcc-plugins: Add STACKLEAK plugin for tracking the kernel stack

    just after stackleak was merged into 4.20-rc1

> 1a9430db28  ima: cleanup the match_token policy code

    near 4.20-rc7 (Dec 17)

> 6648e120dd  Add linux-next specific files for 20181217

    rc + next (Dec 17)

> +---------------------------------------------------------------+------------+------------+------------+---------------+
> |                                                               | afaef01c00 | 10e9ae9fab | 1a9430db28 | next-20181217 |
> +---------------------------------------------------------------+------------+------------+------------+---------------+
> | boot_successes                                                | 386        | 141        | 134        | 135           |
> | boot_failures                                                 | 68         | 9          | 16         | 8             |

The following oopses happened on 4.20-rc1 and disappeared on 4.20-rc7:

> | RIP:trace                                                     | 37         |            |            |               |
> | WARNING:stack_recursion                                       | 36         |            |            |               |
> | WARNING:at(____ptrval____)for_ip_syscall_return_via_sysret/0x | 37         |            |            |               |
> | Kernel_panic-not_syncing:Machine_halted                       | 37         |            |            |               |
> | PANIC:double_fault                                            | 27         |            |            |               |

They are caused by stackleak issues with ftrace and kprobes, that are fixed
in these commits:
    e9c7d656610e
    ef1a84093489

I've double-checked that now stackleak works properly with function tracing,
function_graph tracing and kprobes.

> | Mem-Info                                                      | 2          | 0          | 1          |               |
> | invoked_oom-killer:gfp_mask=0x                                | 1          | 0          | 1          |               |
> | RIP:__put_user_4                                              | 1          |            |            |               |

These 3 lines are not meaningful to me.

> | BUG:KASAN:stack-out-of-bounds_in_u                            | 25         | 8          | 12         | 7             |

This is interesting. How does KASAN work with stackleak? I tested it using
test_kasan.ko -- it works properly both for KASAN outline and inline
instrumentation.

However I noticed that stackleak lkdtm test sometimes reports that kernel
stack is not properly erased in case of KASAN outline instrumentation.
I think it happens because KASAN increases kernel stack usage, so
CONFIG_STACKLEAK_TRACK_MIN_SIZE should be adjusted. I will investigate
that later.

> | RIP:__x86_indirect_thunk_rdx                                  | 26         | 9          | 12         | 7             |
> | INFO:rcu_preempt_detected_stalls_on_CPUs/tasks                | 3          | 0          | 3          |               |
> | RIP:arch_local_irq_enable                                     | 1          |            |            |               |
> | RIP:mntput_no_expire                                          | 1          |            |            |               |
> | RIP:arch_local_irq_restore                                    | 1          |            |            |               |
> | RIP:compound_head                                             | 1          |            |            |               |
> | RIP:rcu_read_lock                                             | 1          |            |            |               |
> | RIP:check_kill_permission                                     | 1          |            |            |               |
> | RIP:radix_tree_load_root                                      | 1          |            |            |               |
> | WARNING:at(null)for_ip_entry_SYSCALL_64_after_hwframe/0x      | 0          | 7          | 11         | 7             |
> | WARNING:at(null)for_ip_async_page_fault/0x                    | 0          | 1          | 1          |               |
> | WARNING:at_kernel/locking/lockdep.c:#lock_downgrade           | 0          | 0          | 2          |               |
> | RIP:lock_downgrade                                            | 0          | 0          | 2          |               |
> | RIP:xa_is_node                                                | 0          | 0          | 1          |               |
> | BUG:kernel_reboot-without-warning_in_test_stage               | 0          | 0          | 0          | 1             |
> +---------------------------------------------------------------+------------+------------+------------+---------------+

Unfortunately, I can't extract anything useful from these lines.
And trinity doesn't provide reproducers...

Anyway, I've created exactly the same trinity setup and have been running
it for 2 days (900 tests) on 4.20-rc7 -- no kernel crashes were hit.

Best regards,
Alexander
