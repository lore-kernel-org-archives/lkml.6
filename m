Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA54C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374B020831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="MM6CrpAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374B020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbeKTC4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:56:32 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35581 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730726AbeKTC4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:56:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so26699466ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 08:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yss6bnnFff1d6Og4tmLLqMWYSirKfn2CsZruH2AJybI=;
        b=MM6CrpAbAahRllLDs4S38JNwK94tOyyHLsWQdJt39tWImQZBdEzaIGQ3Ok/PavLsP0
         KasUxwoPnbTN8+ywe+L/Q1UksLbgQVbJzMgLY0BFhuwutNRlDngXp93kHCKB6ZKDSqmX
         lUBU3xKG2FjVoN8yunKbx7R15pi8nHuLDPf04df5xd79yJPwn7E3Klesz3XUmLfGUisS
         kAFXJTBoQrUziDCpVht7yVO8CQRqu9MRq5cDuN11oJu23tILNr1Kbkv3vMzv2UFBQNcW
         W/PakLoVQrTNs+hHz3lBnGjHtrUSfXHhDreLQU88ulwyLw9owL4U0WZs6UxH/sIJ2FAW
         2o2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yss6bnnFff1d6Og4tmLLqMWYSirKfn2CsZruH2AJybI=;
        b=tJLxW69WBkkl71lSfgw35cW00sJ+NSmjiw/wOI0Q78vsGatSvvIawAJRVRQ4mhKkSY
         EwPQwOPcpF1BRFZlu0U/hobnQtbkVSsqGdz/EOki4JhVGknbjZdlsa3c78+2xydBBlyc
         T24syUsWO7jM99h6VxD7CfpRkygu1zuMRzA1gQdMcPbsvsPOBnHLEQGadRPVgl16QRHc
         8HJuqDzL0lW1RZ93ZBceyU+KSlC2mDAGMmNCPMPJTKy15C8qqSOi9absdTAYV4WCBeVd
         Tk5CBJCCrhPJExKJHFn+Id0aSMV8Rrfeve0UEKl01AhbeZ8YwORa3GkTrTgF932nvLuE
         gclQ==
X-Gm-Message-State: AGRZ1gKcSkKkO+vu9LpmO4/FbFeRfYAz/0+j7oext1hQxx6o7mq/zy5U
        qLngm9Xm1ZKpWnKBPe6X2/n8TNlKhpw0ySw9pMQe
X-Google-Smtp-Source: AJdET5fM0chhETgJuPt0HEcryM5X4Wpp7cXdxJBeM3SwqfCtUuvyonYiY5yS+iJqyRGaKi/nvP6x951HEL0DsqR1Urk=
X-Received: by 2002:a2e:8ec8:: with SMTP id e8-v6mr11865823ljl.162.1542645142341;
 Mon, 19 Nov 2018 08:32:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1532709911.git.rgb@redhat.com> <6e361523183574f2637a80932f6fd47e5dc8defa.1532709911.git.rgb@redhat.com>
In-Reply-To: <6e361523183574f2637a80932f6fd47e5dc8defa.1532709911.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Nov 2018 11:32:10 -0500
Message-ID: <CAHC9VhRkEvkQ5kwBFF05R8+WS+oihNFjrUrivFRRqxCBv+u=sA@mail.gmail.com>
Subject: Re: [PATCH ghak59 V2 1/6] audit: give a clue what CONFIG_CHANGE op
 was involved
To:     rgb@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, sgrubb@redhat.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 3:51 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> The failure to add an audit rule due to audit locked gives no clue
> what CONFIG_CHANGE operation failed.
> Similarly the set operation is the only other operation that doesn't
> give the "op=" field to indicate the action.
> All other CONFIG_CHANGE records include an op= field to give a clue as
> to what sort of configuration change is being executed.
>
> Since these are the only CONFIG_CHANGE records that that do not have an
> op= field, add them to bring them in line with the rest.
>
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
> index 2a80587..1ed8723 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -400,7 +400,7 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
>         ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
>         if (unlikely(!ab))
>                 return rc;
> -       audit_log_format(ab, "%s=%u old=%u", function_name, new, old);
> +       audit_log_format(ab, "op=set %s=%u old=%u", function_name, new, old);
>         audit_log_session_info(ab);
>         rc = audit_log_task_context(ab);
>         if (rc)
> @@ -1362,7 +1362,9 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                         return -EINVAL;
>                 if (audit_enabled == AUDIT_LOCKED) {
>                         audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
> -                       audit_log_format(ab, " audit_enabled=%d res=0", audit_enabled);
> +                       audit_log_format(ab, " op=%s_rule audit_enabled=%d res=0",
> +                                        msg_type == AUDIT_ADD_RULE ? "add" : "remove",

Let's not be clever here, this just makes it harder to grep for
"op=add_rule"; make the ternary statement return "add_rule" or
"remove_rule".

> +                                        audit_enabled);
>                         audit_log_end(ab);
>                         return -EPERM;
>                 }

--
paul moore
www.paul-moore.com
