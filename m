Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36465C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0170F205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="rbrR/Mkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0170F205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbeKTC4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:56:41 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46138 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbeKTC4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:56:40 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so26663140ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 08:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uZgJXILEkad45jJW2a4R+CFXKJI3l6Oa9VbATauk8jM=;
        b=rbrR/MkpTr5OVfV7yz8lPn8xFWj6Ez2RqvUN4gd2cszHbm5+8QHwmt0VD2koan1gl1
         WxOmZ4gZds9mZf5ZKhEIDhXNWviQXWZHDFNU93KbwPDiw/gBOSsXZrz0EicBoo4aZyoK
         ISbOAwhF0Vo41Asl0aqNiBbwHk7F6KjPr5RZtWAYNhEuNxIRjzB3h2VZNqb348P4mRy8
         AMX7HHlrCkPWUH7kj2N7VGqhl+EFr02KtScXKDdbBxCuka44Wzdsj2nxDlKctYgS8GyN
         mSlempPQav5Z3v4sU4Dq52H3SIY6hHOr1NHZjkoyRA4xeQKbuWFkUceGhApD5CNb8Oqi
         AX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZgJXILEkad45jJW2a4R+CFXKJI3l6Oa9VbATauk8jM=;
        b=EMANrqwzpdPCJ7AK88BqSuN4YMoQjZX+96DryrG3rH5Hdkxt0IigHwHMHjPMQFZhHO
         n9BHioMBIxq+ppigUda+rIQlQXzn3Zmv/dVJhcHgHX02IVw3G/IfZVOgmiVLZF4cP9ru
         wmJ/gda/Qop/g1Dh+mmhsom3P8VPwSbozt2zqpNNKi85Z+8q+mcXn8mpZQ3ODwWsD9F7
         FcTfPCRX9J4eMeIan1VlU/yj7lZmtVdVZl0wgELPDaguUi8L/Kaq9uEpsUg7JwaK2LJM
         23gj6bRdvUJIEluQKXQCMnCTAMXU8+1+KG1b3E8J1qBwd611V08Flk13qa/Yb32hpTVT
         f20g==
X-Gm-Message-State: AGRZ1gLMCP3zAIY2WYx7tEYe+pzrt8KAizj85/q9AW7CeqsexU4DnN7E
        +rO1/hyyeppKWBtuZGVG94kabMCv8fBAFfhoZjLz
X-Google-Smtp-Source: AJdET5fTkXJD+sgMDIQq6bBmSJB895Lmfuuix1GHAc+H6SKXhg3jXY1abC//OzJelpWBXVhfmJRuSXUx3mzqv22le7o=
X-Received: by 2002:a2e:97d7:: with SMTP id m23-v6mr13046738ljj.18.1542645151216;
 Mon, 19 Nov 2018 08:32:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1532709911.git.rgb@redhat.com> <5e97337b412d117309e3f02ef45c7fe00d613520.1532709911.git.rgb@redhat.com>
In-Reply-To: <5e97337b412d117309e3f02ef45c7fe00d613520.1532709911.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Nov 2018 11:32:19 -0500
Message-ID: <CAHC9VhQF0ZjW698ZTgHfMhByOoVC1FADHRpOYBnoC5cXE1QrFQ@mail.gmail.com>
Subject: Re: [PATCH ghak59 V2 3/6] audit: exclude user records from syscall context
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
> Since the function audit_log_common_recv_msg() is shared by a number of
> AUDIT_CONFIG_CHANGE and the entire range of AUDIT_USER_* record types,
> and since the AUDIT_CONFIG_CHANGE message type has been converted to a
> syscall accompanied record type, special-case the AUDIT_USER_* range of
> messages so they remain standalone records.
>
> See: https://github.com/linux-audit/audit-kernel/issues/59
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

While I'm a big fan of associating records into a single event when
they are related, in the case of these user messages the syscall
information isn't related to the logged user event, it is related with
the process' *logging* of the user event.  I agree with the idea
behind this patch, but I have some comments about the patch itself:

* I understand you separated this out because you weren't sure if it
was desirable, but now that you know it is desirable it really should
be squashed into patch 2/6 so that it is a single change.
* I'm not a fan of creating __audit_log_common_recv_msg() in this
case; let's just create a audit_log_user_recv_msg() (or similar)
instead and leave audit_log_common_recv_msg() as it is after patch
2/6.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 6cfe3c9..62ada1b 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1054,7 +1054,8 @@ static int audit_netlink_ok(struct sk_buff *skb, u16 msg_type)
>         return err;
>  }
>
> -static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
> +static void __audit_log_common_recv_msg(struct audit_context *context,
> +                                       struct audit_buffer **ab, u16 msg_type)
>  {
>         uid_t uid = from_kuid(&init_user_ns, current_uid());
>         pid_t pid = task_tgid_nr(current);
> @@ -1064,7 +1065,7 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
>                 return;
>         }
>
> -       *ab = audit_log_start(audit_context(), GFP_KERNEL, msg_type);
> +       *ab = audit_log_start(context, GFP_KERNEL, msg_type);
>         if (unlikely(!*ab))
>                 return;
>         audit_log_format(*ab, "pid=%d uid=%u", pid, uid);
> @@ -1072,6 +1073,11 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
>         audit_log_task_context(*ab);
>  }
>
> +static inline void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
> +{
> +       __audit_log_common_recv_msg(audit_context(), ab, msg_type);
> +}
> +
>  int is_audit_feature_set(int i)
>  {
>         return af.features & AUDIT_FEATURE_TO_MASK(i);
> @@ -1338,7 +1344,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                                 if (err)
>                                         break;
>                         }
> -                       audit_log_common_recv_msg(&ab, msg_type);
> +                       __audit_log_common_recv_msg(NULL, &ab, msg_type);
>                         if (msg_type != AUDIT_USER_TTY)
>                                 audit_log_format(ab, " msg='%.*s'",
>                                                  AUDIT_MESSAGE_TEXT_MAX,
> --
> 1.8.3.1
>


--
paul moore
www.paul-moore.com
