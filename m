Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1E5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 23:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA20F2187A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 23:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6V5+wwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA20F2187A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeHRC6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 22:58:24 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37025 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbeHRC6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 22:58:23 -0400
Received: by mail-oi0-f67.google.com with SMTP id j205-v6so16840862oib.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 16:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vgqbi5vy3vrcTrukIlCO9JzHe8eRIEvgOuDE8qIboSA=;
        b=j6V5+wwb76MrDcX9LXytAdgDBqHl4yawKwuVPQIo6YbnxrZaNmBR5n4nk1oKvwRgvi
         NZXIzuMtrjAC0r7aDYxIO7N2xSJoufNFjaF4mtadlrUrxXVGN9/dfukeCEH7wIYVwCUl
         91kffffscUaA6Orly0BheBw4dHhP+ohGMof6zkSSz78G94M/OymGnfNncIpfs0l2KRxb
         Lty0PKcwkvG/J2ZJiNfqaYdiku4FUOfdPKzfDcJ4GjmupYqXqpUSsNFSYkN4ou8n6fO3
         GcnMnvvw91gAtK33NXEySHshKdVmO52FqejtpesZk+dbQWQBdb30CvG5NydsVi9uFEio
         AymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vgqbi5vy3vrcTrukIlCO9JzHe8eRIEvgOuDE8qIboSA=;
        b=GjyG31uj65UZ6IrwT55rfknjMiJydFUTzBWO0fJFDFPLgYc0XhMcu1lEVwDdcAolrY
         FXKXlTHHH4mGigQ0rFysRUw6jMR/z9EBD/zl01iwSZCHg9kUcK8Et+dnEgwVFRn75nV4
         Ch5tW7iU14A+qal4ll0ZUxZDBqj76ECt2F0bSeMDyJEe64iANLPMZ7IGbXKEm3T+e9hp
         txzRK4rQEFiIJe5gum8u/pc7autVTzzV7ppo5FLt4x0HsWly3wBTMNH36qRPEtYavzYl
         BUY6FQAruvqYThVQOPBFaDMWKRUGasj/wGc/FSZBjPndlBX33hpaPXSPiLH+030ZZBvR
         uJwg==
X-Gm-Message-State: APzg51BM8kW8fOLBTFSrrHqcZg3Vk9vy1B6SKqs24KTBpr5jhqzERxki
        yYJdh8BNPW6hbxhlpI2uCtQUVvQWG9c2TufIAe/e7EEWESYYtA==
X-Google-Smtp-Source: AA+uWPwyRwT/rE2MCuOlabUA/e9vqSqoffeJyRl3uClSffnFBBsM5fi4Qb45RJJqn8cNGx6K01Xovw6Wxpjbc9RfEx4=
X-Received: by 2002:aca:e504:: with SMTP id c4-v6mr4404435oih.246.1534549976789;
 Fri, 17 Aug 2018 16:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180817221624.10232-1-casey.schaufler@intel.com> <20180817221624.10232-4-casey.schaufler@intel.com>
In-Reply-To: <20180817221624.10232-4-casey.schaufler@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 18 Aug 2018 01:52:30 +0200
Message-ID: <CAG48ez3aB5X9=hqepovG6L4vQYZjzHZ6fWqdd4Vtzh92u2J5fQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/5] LSM: Security module checking for side-channel dangers
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

On Sat, Aug 18, 2018 at 12:17 AM Casey Schaufler
<casey.schaufler@intel.com> wrote:
>
> From: Casey Schaufler <cschaufler@localhost.localdomain>
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
[...]
> +#ifdef CONFIG_SECURITY_SIDECHANNEL_UIDS
> +static int safe_by_uid(struct task_struct *p)
> +{
> +       const struct cred *ccred = current_real_cred();
> +       const struct cred *pcred = get_task_cred(p);
> +
> +       /*
> +        * Credential checks. Considered safe if:
> +        *      UIDs are the same
> +        */
> +       if (ccred != pcred && ccred->euid.val != pcred->euid.val)
> +               return -EACCES;
> +       return 0;
> +}

This function looks bogus. get_task_cred() bumps the refcount on the
returned cred struct pointer, but you don't drop it. You probably want
to use something that doesn't fiddle with the refcount at all here to
avoid cacheline bouncing - possibly a raw rcu_dereference_protected()
if there are no better helpers.

Same thing for the other get_task_cred() calls further down in the patch.
