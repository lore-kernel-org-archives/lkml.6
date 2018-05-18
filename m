Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeERTt4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:49:56 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37653 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbeERTtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:49:55 -0400
X-Google-Smtp-Source: AB8JxZrhFioJKD1+Z9XJ1dEcdM7+cZLFWLmh+EAGKvZphQmt4+I8mDR9pvSYZEKBv95RiqSXFGUtieWOCsKLFHrz8Rw=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <9ffbbadb26bbc362c74c8c2140425ef614712e1a.1526608767.git.rgb@redhat.com>
References: <9ffbbadb26bbc362c74c8c2140425ef614712e1a.1526608767.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 18 May 2018 15:49:53 -0400
Message-ID: <CAHC9VhRtMaunng7dpR5QVWsQfHvSq9Q-Q=sTB19cKwtmLtH7bw@mail.gmail.com>
Subject: Re: [PATCH] audit: use existing session info function
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 10:01 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Use the existing audit_log_session_info() function rather than
> hardcoding its functionality.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditfilter.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Merged into audit/next, thanks.

> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index d7a807e..9e87377 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1089,8 +1089,6 @@ static void audit_list_rules(int seq, struct sk_buff_head *q)
>  static void audit_log_rule_change(char *action, struct audit_krule *rule, int res)
>  {
>         struct audit_buffer *ab;
> -       uid_t loginuid = from_kuid(&init_user_ns, audit_get_loginuid(current));
> -       unsigned int sessionid = audit_get_sessionid(current);
>
>         if (!audit_enabled)
>                 return;
> @@ -1098,7 +1096,7 @@ static void audit_log_rule_change(char *action, struct audit_krule *rule, int re
>         ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
>         if (!ab)
>                 return;
> -       audit_log_format(ab, "auid=%u ses=%u" ,loginuid, sessionid);
> +       audit_log_session_info(ab);
>         audit_log_task_context(ab);
>         audit_log_format(ab, " op=%s", action);
>         audit_log_key(ab, rule->filterkey);
> --
> 1.8.3.1
>



-- 
paul moore
www.paul-moore.com
