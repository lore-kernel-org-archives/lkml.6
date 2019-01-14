Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D4FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AF6205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Y4I58b8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfANWKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:10:36 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43391 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfANWKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:10:36 -0500
Received: by mail-lf1-f67.google.com with SMTP id u18so450425lff.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PTmKsD9und+9B0fAFJEif8c3wsDZpBoxD1GIB9BLc+s=;
        b=Y4I58b8HD+p+4LEBlZCbDov1FhXvYDdTA2Eq4HXxwZg++sxCm/vO1Mn1sollHocWV1
         IMXSnY5xFJuw/g5mIJE7JYsu464CeyiTR6o4cE43WaBD1IvJhNu/i3hsXT3oszKr36YY
         vJ3WNo2J+dEIC53Cl3urc7d7cMVTJ6Dmm/dUUi3IgFSyrQTSZJGO+e2/DRshsq1ZzhvZ
         N2btHu3AJttAf5sdS8M9Z595m8ciQxypEL5KUoj/N9559D6p0oZcAel7CvTsQpyQ3afz
         dSm3VjWxpFLUAGQ/cD9s7RC0OwW0rpIHgqSl3SQrsFYH/MJlotpkfTWG0EYh1YV55xPI
         t72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PTmKsD9und+9B0fAFJEif8c3wsDZpBoxD1GIB9BLc+s=;
        b=iRns4Iz9vMkbITx/5+LER71TC8FlXlsuQgvcf+sVCytp9fBQRL5PMsezqxkQXT2LCY
         JcL718Ra7BqY1X5ZO5oLzubpdDAJ7aPO98vEuhECTGtXLteau5flPRVOtHBTKSgNaOmI
         LvtRb2CjDV/Bw0XOnKP4cNOjdqlWCFevnZqcLyF5MQy64Ft53HJ3S9OnoZonBOHURwbE
         9pOBGeRAQH5S7zOQqxKm4LKdOoggBrs56KR4uNW+uXIx9ROm96iVaFTf45XAtAqPUF14
         DoPNJJBDnrGmNzQi0+sNZJXomVVkXQ5Ei3n2Fb/M28UKSX/yrz7QRdix2aIYQGackZS2
         NclA==
X-Gm-Message-State: AJcUukdTcPAyTtts3nnnL7gasSoxzRo31tk7tvw3b0Fr7zxr7LTRN+0Y
        +rPoymcPJDJKYmWrRp/ocZBQmQbsAPNGDGIGJRUF
X-Google-Smtp-Source: ALg8bN6C08rtrJdiVOeaKbiqc2Wg9wCps5yMNsZ2qK3P534fobLmR3ABDg13J9wkZFO6o7J6l3fXLd1TIZmx5BJ79mw=
X-Received: by 2002:a19:40cc:: with SMTP id n195mr466318lfa.40.1547503834174;
 Mon, 14 Jan 2019 14:10:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544477629.git.rgb@redhat.com> <d4c6aae31213ad17fd82f546ab5e1ee0efc985d0.1544477629.git.rgb@redhat.com>
In-Reply-To: <d4c6aae31213ad17fd82f546ab5e1ee0efc985d0.1544477629.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 14 Jan 2019 17:10:23 -0500
Message-ID: <CAHC9VhRCgWc=Zim3Q5vkr+CiB4QFs=YL5UP3nYswjs1k53upiQ@mail.gmail.com>
Subject: Re: [PATCH ghak59 V3 1/4] audit: give a clue what CONFIG_CHANGE op
 was involved
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
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

Merged, but I had to fixup a line length issue as reported by
checkpatch.pl.  While I don't think we need to always follow
checkpatch.pl 100%, please make every effort to ensure that it likes
you line lengths.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 779671883349..0e8026423fbd 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -400,7 +400,7 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
>         ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
>         if (unlikely(!ab))
>                 return rc;
> -       audit_log_format(ab, "%s=%u old=%u ", function_name, new, old);
> +       audit_log_format(ab, "op=set %s=%u old=%u ", function_name, new, old);
>         audit_log_session_info(ab);
>         rc = audit_log_task_context(ab);
>         if (rc)
> @@ -1363,7 +1363,9 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                         return -EINVAL;
>                 if (audit_enabled == AUDIT_LOCKED) {
>                         audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
> -                       audit_log_format(ab, " audit_enabled=%d res=0", audit_enabled);
> +                       audit_log_format(ab, " op=%s audit_enabled=%d res=0",
> +                                        msg_type == AUDIT_ADD_RULE ? "add_rule" : "remove_rule",
> +                                        audit_enabled);
>                         audit_log_end(ab);
>                         return -EPERM;
>                 }
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
