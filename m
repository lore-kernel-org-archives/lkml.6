Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9783AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E0A21840
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZQxaJgJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E0A21840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeHUUp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:45:28 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37107 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeHUUp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:45:28 -0400
Received: by mail-oi0-f68.google.com with SMTP id j205-v6so33408552oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWGilGlT6U1QaTL6FhIRIwBE8gvGjbdmOEDu9+bJbt0=;
        b=ZQxaJgJ9ZJYsBSjmKjlBvKZBuPMxDE72XJKm2T7rhuFRZwQqhXuEq2gJy7mrIspxHp
         HmNF6Y8OK0LcbAidVlm1ahYj1S83FNFUwWLk5fnH2fGx33EgI1lMhguBa2aSLXtg287d
         hIe/fl0d1HJUFXVq4Y6iUYSs4nTomUkutlZbvyxXwma0Cw3fLG/FjKlURZBlSHCQKHHx
         HJr93yVxL/Of/fl8o4wvoWLjtS969rWpneC3QkEPsp5CT17jJ4E9vsXCYfZORm6BmcmF
         yJpN/AasAWtRyWQ37t6Kh4GbT5fbY6rpuZelW4MZDQS9oCgYC+qYuKZS4z02+bBwTHi6
         THFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWGilGlT6U1QaTL6FhIRIwBE8gvGjbdmOEDu9+bJbt0=;
        b=a2r2YjXHsRFnFd2a/cJ9DLuJiKXMPIxDJZsJ2pkCj1gShQxYy0d4hc4965zG7Nki0u
         EL069RFjYP9yotO+6oeVk4E/WHYt5bRg3H0CO8AkAmlWFEOJqWhYO7fCWj7I7mP+azT/
         EzbOLed2RyFOMs+bpqg8+ozfKaoI3S0bYRMI6lrO0Iw1CQUlQPgBqgdNgh2PpQ1Hu5KL
         R/Hp9eESZCC+D4AFw/yr9t0klFGXsCQkSoojTVaxHYVRREZO0Ickqq3n79oGws4C9g7H
         l9xkCITO0Hs+bzLj8pofCguA8XcVmErnk8yxmftrI7PtLtyqhmmzTjiz9yylXv2rnmKn
         wwPA==
X-Gm-Message-State: APzg51DcJ/hMjA5sb4eeDPX1C8yX+w5oBZqTXCaFTjEZmyE1f6XFXfQr
        9Z3Ocr8ETO/uzhXygmVXyuf/qRyvbPstQxHW84U9iQ==
X-Google-Smtp-Source: ANB0VdbVIAFSxoUDa/W2LWOA3lRW5d/9TudcFvhbaNIeEEE/BnxvxQaCfRRuNpZ/tdttrNuoKmK7OaNPUOXYTpy1McQ=
X-Received: by 2002:aca:dc55:: with SMTP id t82-v6mr214854oig.159.1534872264879;
 Tue, 21 Aug 2018 10:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180821000444.7004-1-casey.schaufler@intel.com> <20180821000444.7004-4-casey.schaufler@intel.com>
In-Reply-To: <20180821000444.7004-4-casey.schaufler@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 21 Aug 2018 19:23:58 +0200
Message-ID: <CAG48ez1D-DPBP8ACA1W5=XZLNKUeVj7ZOGUG8uJ2nL1xOSR_9Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] LSM: Security module checking for side-channel dangers
To:     Casey Schaufler <casey.schaufler@intel.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Dave Hansen <dave.hansen@intel.com>,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 2:05 AM Casey Schaufler
<casey.schaufler@intel.com> wrote:
>
> The sidechannel LSM checks for cases where a side-channel
> attack may be dangerous based on security attributes of tasks.
> This includes:
>         Effective UID of the tasks is different
>         Capablity sets are different
>         Tasks are in different namespaces
> An option is also provided to assert that task are never
> to be considered safe. This is high paranoia, and expensive
> as well.
>
> Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
> ---
[...]
> diff --git a/security/sidechannel/Kconfig b/security/sidechannel/Kconfig
> new file mode 100644
> index 000000000000..af9396534128
> --- /dev/null
> +++ b/security/sidechannel/Kconfig
[...]
> +config SECURITY_SIDECHANNEL_CAPABILITIES
> +       bool "Sidechannel check on capability sets"
> +       depends on SECURITY_SIDECHANNEL
> +       default n
> +       help
> +         Assume that tasks with different sets of privilege may be
> +         subject to side-channel attacks. Potential interactions
> +         where the attacker lacks capabilities the attacked has
> +         are blocked.
> +
> +          If you are unsure how to answer this question, answer N.
> +
> +config SECURITY_SIDECHANNEL_NAMESPACES
> +       bool "Sidechannel check on namespaces"
> +       depends on SECURITY_SIDECHANNEL
> +       depends on NAMESPACES
> +       default n
> +       help
> +         Assume that tasks in different namespaces may be
> +         subject to side-channel attacks. User, PID and cgroup
> +         namespaces are checked.
> +
> +          If you are unsure how to answer this question, answer N.
[...]
> diff --git a/security/sidechannel/sidechannel.c b/security/sidechannel/sidechannel.c
> new file mode 100644
> index 000000000000..4da7d6dafdc5
> --- /dev/null
> +++ b/security/sidechannel/sidechannel.c
[...]
> +/*
> + * safe_by_capability - Are task and current sidechannel safe?
> + * @p: task to check on
> + *
> + * Returns 0 if the tasks are sidechannel safe, -EACCES otherwise.
> + */
> +#ifdef CONFIG_SECURITY_SIDECHANNEL_CAPABILITIES
> +static int safe_by_capability(struct task_struct *p)
> +{
> +       const struct cred *ccred = current_real_cred();
> +       const struct cred *pcred = rcu_dereference_protected(p->real_cred, 1);
> +
> +       /*
> +        * Capabilities checks. Considered safe if:
> +        *      current has all the capabilities p does
> +        */
> +       if (ccred != pcred &&
> +           !cap_issubset(pcred->cap_effective, ccred->cap_effective))
> +               return -EACCES;
> +       return 0;
> +}

On its own (without safe_by_namespace()), this check makes no sense, I
think. You're performing a test on the namespaced capability sets
without looking at which user namespaces they are relative to. Maybe
either introduce a configuration dependency or add an extra namespace
check here?

> +static int safe_by_namespace(struct task_struct *p)
> +{
> +       struct cgroup_namespace *ccgn = NULL;
> +       struct cgroup_namespace *pcgn = NULL;
> +       const struct cred *ccred;
> +       const struct cred *pcred;
> +
> +       /*
> +        * Namespace checks. Considered safe if:
> +        *      cgroup namespace is the same
> +        *      User namespace is the same
> +        *      PID namespace is the same
> +        */
> +       if (current->nsproxy)
> +               ccgn = current->nsproxy->cgroup_ns;
> +       if (p->nsproxy)
> +               pcgn = p->nsproxy->cgroup_ns;
> +       if (ccgn != pcgn)
> +               return -EACCES;
> +
> +       ccred = current_real_cred();
> +       pcred = rcu_dereference_protected(p->real_cred, 1);
> +
> +       if (ccred->user_ns != pcred->user_ns)
> +               return -EACCES;
> +       if (task_active_pid_ns(current) != task_active_pid_ns(p))
> +               return -EACCES;
> +       return 0;
> +}
