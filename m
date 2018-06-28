Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B989BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9B7278B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="1ibThO7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9B7278B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934942AbeF1Tln (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:41:43 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41996 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934012AbeF1Tlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:41:42 -0400
Received: by mail-lf0-f68.google.com with SMTP id u202-v6so5074812lff.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 12:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5P0hZ5qeVerJPWSrkgklM7HL5mxKSLKR1TKQ5TC19I=;
        b=1ibThO7fdp5K48/2Ar4DIOZH0cPD0VBs9XA0WRQDtpYZWpcv/KSz0dvO+CGzur9MuB
         osYWtWiw/prpeE1hPxjLUs5cC8TNg0ekBAi9+zob/g53QT3PARnuwA8+lp+slqQP4TNy
         hGrxkOOyqrqoIFcacaKSZ5jQqmUuTBmm0Q9Iw72EEvUGRDCT++3+lH9MC9B9LRQi0uMy
         bSI0ZqM4HADl4sfryxybsgESySwP2mntdCY4iijPspIBP/bsY2Lz9gEvo8YidvQdJ1KZ
         EXPt/R3OH0bPML2Z27Mu9TmOKOBbHHr62TLX2n6NaTgVnc5kuKAlkJwzZIOQ3rspPPP0
         8BcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5P0hZ5qeVerJPWSrkgklM7HL5mxKSLKR1TKQ5TC19I=;
        b=BUgyUi4BQswpthnP9r1a/1CjhIJD5b+SNqUfvTBGUAhubVlQj1LucKmTaIG5tSg7Hx
         GlcW9w6g6AkamIQYDuwIv1LhWzKLERFg/1RjTz3JSxKxF+sXj7yd+TW92TLT9I78TJZk
         Bq4SvF78UpYxo7lUxTWSeCoE/d7+DwYniflbVhtGbtthtij/s1qm900ktpYVYrSCwINp
         cib0MHmxwSHOEcOnL/Zgct+CwlDcI6wuBkg+Al12UzG/j9XMgASTg13/ceR+SFAH/BFf
         wexMVqVEm3BGg4buJcRJNysiTRCOSsWfOX0FUXxP0JSXYqQ2YXoggkZLOVB/71Wez7Mv
         odcg==
X-Gm-Message-State: APt69E2FDz2EdkhpS23ISKcLHm4NaRVy0LWIPOeBOoZFYlhVYw6o346I
        m3tLM91W15E2y8A4Ez+6/1dpNKGgYdOSlenWw/Wd
X-Google-Smtp-Source: AAOMgpfwNkaklwdM+DOe95b+3hJFSUATGEnynwaO0vaKJaHr6N28PQs8GfLt4Al6JTxbqP5Nuz8tr1AyQ3XIXansp+M=
X-Received: by 2002:a19:d754:: with SMTP id o81-v6mr7569956lfg.124.1530214900195;
 Thu, 28 Jun 2018 12:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529003588.git.rgb@redhat.com> <17f22b579c28c6cd9475a57e792b5d4fb4dde1dc.1529003588.git.rgb@redhat.com>
In-Reply-To: <17f22b579c28c6cd9475a57e792b5d4fb4dde1dc.1529003588.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 28 Jun 2018 15:41:28 -0400
Message-ID: <CAHC9VhTxjcmJGEq6XQmRV0Ouk8oOyHO2C8+HVQOy1qxw9yKyXw@mail.gmail.com>
Subject: Re: [RFC PATCH ghak59 V1 1/6] audit: give a clue what CONFIG_CHANGE
 op was involved
To:     rgb@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, sgrubb@redhat.com,
        aviro@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 4:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> The failure to add an audit rule due to audit locked gives no clue
> what CONFIG_CHANGE operation failed.
> Similarly the set operation is the only other operation that doesn't
> give the "op=" field to indicate the action.
> All other CONFIG_CHANGE records include an op= field to give a clue as
> to what sort of configuration change is being executed.
>
> Since these are the only CONFIG_CHANGE records that that do not have an
> op= field, add them to bring them in line with the rest.

Normally this would be an immediate reject because this patch inserts
a field into an existing record, but the CONFIG_CHANGE record is so
variable (supposedly bad in its own right) that I don't this really
matters.

With that out of the way, I think this patch is fine, but I don't
think it is complete.  At the very least there is another
CONFIG_CHANGE record in audit_watch_log_rule_change() that doesn't
appear to include an "op" field.  If we want to make sure we have an
"op" field in every CONFIG_CHANGE record, let's actually add them all
:)

There appears to be another one in audit_mark_log_rule_change() ...
and one more in audit_receive_msg().  There may be more.

> Old records:
> type=CONFIG_CHANGE msg=audit(1519812997.781:374): pid=610 uid=0 auid=0 ses=1 subj=... audit_enabled=2 res=0
> type=CONFIG_CHANGE msg=audit(2018-06-14 14:55:04.507:47) : audit_enabled=1 old=1 auid=unset ses=unset subj=... res=yes
>
> New records:
> type=CONFIG_CHANGE msg=audit(1520958477.855:100): pid=610 uid=0 auid=0 ses=1 subj=... op=add_rule audit_enabled=2 res=0
>
> type=CONFIG_CHANGE msg=audit(2018-06-14 14:55:04.507:47) : op=set audit_enabled=1 old=1 auid=unset ses=unset subj=... res=yes
>
> See: https://github.com/linux-audit/audit-kernel/issues/59
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index e7478cb..ad54339 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -403,7 +403,7 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
>         ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
>         if (unlikely(!ab))
>                 return rc;
> -       audit_log_format(ab, "%s=%u old=%u", function_name, new, old);
> +       audit_log_format(ab, "op=set %s=%u old=%u", function_name, new, old);
>         audit_log_session_info(ab);
>         rc = audit_log_task_context(ab);
>         if (rc)
> @@ -1365,7 +1365,9 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                         return -EINVAL;
>                 if (audit_enabled == AUDIT_LOCKED) {
>                         audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
> -                       audit_log_format(ab, " audit_enabled=%d res=0", audit_enabled);
> +                       audit_log_format(ab, " op=%s_rule audit_enabled=%d res=0",
> +                                        msg_type == AUDIT_ADD_RULE ? "add" : "remove",
> +                                        audit_enabled);
>                         audit_log_end(ab);
>                         return -EPERM;
>                 }
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
