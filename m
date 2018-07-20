Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B34ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD85F2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="R/ibazhm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD85F2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbeGTXFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 19:05:46 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44655 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbeGTXFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 19:05:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id q127-v6so12261814ljq.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 15:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N8lqMQbZJ3/vhu3U4PpNyadT2ckSWfoWhlQ+MrtDeJg=;
        b=R/ibazhmRyr4ateEWccxNhjpoSrNsxFbxJokRwHy0/hwlOQ+3LGkppSQCkwvbzsxIe
         9UtqBF40ABf434gWlwpaAAJA2sgtPX94DBPjV06k8WuqdBO0VGoFbp5EE7S4SjPCBBXx
         a2P6oST++4AFc7jomGS6FBgexUSHeayl4MCftddBPHqk4e25EH2bi6JIumt1wd17Ft3Z
         f8/Ml+LLwUAauwW0ND4EBLI1ssmjpapa9dIHVT2b2dOcN9YUypVpPyWlUTSAxUcl2sxI
         W52XcwRnD0SHnTBAaANSiTSzSgf2qjRgicN6CQnvz3CeXLI0Ouz1ac1GVoaJd0482T4W
         Bl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N8lqMQbZJ3/vhu3U4PpNyadT2ckSWfoWhlQ+MrtDeJg=;
        b=HQjFlBZhGsJkPVdO6tMf9oZP02ONE3fzm/W6tDBPyIAQGzPLew9ycRDIpDo6xV7LdM
         2TmT6NVIGw4VMAAar0qvoDo9UMJTr6XzNyb+EgNoZQh1qMpJdUabSMXgjWaOXvloKv44
         EUZvmcQSLMRiuf4QQCTl6hP75OKczhc0GqmbAw/r7rbMgGHe2XrftrpfcfKGdR+PqWAQ
         FSfWOveJpoXH/XPItBkxgYS7YsqHne+GVpvOoU8/feYq3AEE0wDHDBBjKJMeI1PkWS94
         uCSDClRK2X1WFPVPRnYi38hNBE4nh/91DUhBO0KjceuoZ5EcqTkbp/++q9JRm9irPnJP
         xnZA==
X-Gm-Message-State: AOUpUlFO53k32BmJ+vzRZZK8A37CdE2nVmkU8KZrKD13C1C0WRumwqvY
        yOm7AbLIYnV8j6N6h9pazZdjUs7l9WTWkE0IePwk
X-Google-Smtp-Source: AAOMgpcbWZ6C/9E8qj8fbg7r767jtNdjPllNgk06gCQmVyVA7PfnnGeT4aoAlOwtPehrRTi1u17FaKXFRsjT3/gqmQk=
X-Received: by 2002:a2e:5f5b:: with SMTP id t88-v6mr2853881ljb.140.1532124929627;
 Fri, 20 Jul 2018 15:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1528304203.git.rgb@redhat.com> <b1eff0b849cc472f10dee8bd4f2eeb3567f0a459.1528304204.git.rgb@redhat.com>
In-Reply-To: <b1eff0b849cc472f10dee8bd4f2eeb3567f0a459.1528304204.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 20 Jul 2018 18:15:18 -0400
Message-ID: <CAHC9VhRhHJV87g+4b2BMxnrpgPvNYMBa1RUQzK3xrK1yugBYzQ@mail.gmail.com>
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 09/10] debug audit: read
 container ID of a process
To:     rgb@redhat.com
Cc:     cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 1:02 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Add support for reading the audit container identifier from the proc
> filesystem.
>
> This is a read from the proc entry of the form
> /proc/PID/audit_containerid where PID is the process ID of the task
> whose audit container identifier is sought.
>
> The read expects up to a u64 value (unset: 18446744073709551615).
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/proc/base.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 318dff4..ca8bfe2 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1303,6 +1303,21 @@ static ssize_t proc_sessionid_read(struct file * file, char __user * buf,
>         .llseek         = generic_file_llseek,
>  };
>
> +static ssize_t proc_contid_read(struct file *file, char __user *buf,
> +                                 size_t count, loff_t *ppos)
> +{
> +       struct inode *inode = file_inode(file);
> +       struct task_struct *task = get_proc_task(inode);
> +       ssize_t length;
> +       char tmpbuf[TMPBUFLEN*2];
> +
> +       if (!task)
> +               return -ESRCH;
> +       length = scnprintf(tmpbuf, TMPBUFLEN*2, "%llu", audit_get_contid(task));
> +       put_task_struct(task);
> +       return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
> +}

While I still remain very nervous about opening the audit container ID
up for abuse by making it accessible, I understand that this would
make things a lot easier us (e.g. testing) and perhaps the container
engines as well.  In order to limit the potential for abuse, what do
you think about restricting read access to those processes which have
CAP_AUDIT_CONTROL, similar to what we do for setting the audit
container ID?

>  static ssize_t proc_contid_write(struct file *file, const char __user *buf,
>                                    size_t count, loff_t *ppos)
>  {
> @@ -1333,6 +1348,7 @@ static ssize_t proc_contid_write(struct file *file, const char __user *buf,
>  }
>
>  static const struct file_operations proc_contid_operations = {
> +       .read           = proc_contid_read,
>         .write          = proc_contid_write,
>         .llseek         = generic_file_llseek,
>  };
> @@ -3030,7 +3046,7 @@ static int proc_pid_patch_state(struct seq_file *m, struct pid_namespace *ns,
>  #ifdef CONFIG_AUDITSYSCALL
>         REG("loginuid",   S_IWUSR|S_IRUGO, proc_loginuid_operations),
>         REG("sessionid",  S_IRUGO, proc_sessionid_operations),
> -       REG("audit_containerid", S_IWUSR, proc_contid_operations),
> +       REG("audit_containerid", S_IWUSR|S_IRUSR, proc_contid_operations),
>  #endif
>  #ifdef CONFIG_FAULT_INJECTION
>         REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),
> @@ -3422,7 +3438,7 @@ static int proc_tid_comm_permission(struct inode *inode, int mask)
>  #ifdef CONFIG_AUDITSYSCALL
>         REG("loginuid",  S_IWUSR|S_IRUGO, proc_loginuid_operations),
>         REG("sessionid",  S_IRUGO, proc_sessionid_operations),
> -       REG("audit_containerid", S_IWUSR, proc_contid_operations),
> +       REG("audit_containerid", S_IWUSR|S_IRUSR, proc_contid_operations),
>  #endif
>  #ifdef CONFIG_FAULT_INJECTION
>         REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),

--
paul moore
www.paul-moore.com
