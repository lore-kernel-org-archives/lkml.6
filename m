Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1763119-1524101275-2-11844983066451592050
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, TVD_PH_BODY_META 0.001, TVD_PH_BODY_META_ALL 1.799,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524101274; b=wKWu4UDgerKy02e7xzoZOjQdZXMt0/y3i8tBdM5MRYKbF1u0SB
    hun3XrHPbwPYLeM8ca6sSMeMXOVaK4nG3RA1YHxeS1QAW2VLdhiHcgi/dy2EjWtf
    sGm9I9qcneHzLD+D8l7SNcet5F5WhT12zyHu/mOP2tJkD3zcJhChPvhIADhnfs3I
    3p6+/Xe4WfSiinNdgsBZvKdHofXyuqXnm80BOr4eNXF/45b3FhbwDTmsB7Gzzlq8
    igZ3MywQFBnRIEDi+Z4n/HXF1rgk/DJeB1RA9SRqDVsmwWhUgdqXypOycB/2RveD
    l41W2nVRbrA5xxltqPuT7H/nARocvYLoeXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524101274; bh=4kvpre1byusB3CORcDnZfl201/SbPvLZFxPjGXLbBo
    U=; b=kh1PPB6FluVbpamyc+ew28v2CC3cvNZO4tO2nOF2zlnobFhcwRdBR5vzkV
    09dzfZvmUtjwRFRx3WswNAWtyTbu16mg+HY6iFVmxWRi8oI5MHKdshLj58gDdroN
    WTTZ9MKppx1rRQfBhrKa5Q/l/buV7SpgfvkiCDVzIcBe02vmUONEAwuXUxoEiEUh
    1OLzUs54dfcPl5lrjRzD6fETZr37XLx+bXlPWzNoI+TLWnZZxApVB2QAQXG7+6ks
    aDsS+ptPDc8XwVuUkQcEa4h427ByWkBtxa/joV4eJ6f7ntZXmV8oY2/zBWo+DnnV
    TQ1CUDzhT8tFIMZeeWgt+4+6swag==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=BOKgBd1z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UE23kI9Z;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=BOKgBd1z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UE23kI9Z;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLVOct3qFfi53OYE9q1+YIZZWYCcJQfC6sUgprSltE9i4B4/9HoSB6tgCWhbWcwILdN/FRbr6+xB5yVfUW6slxwYrC4qsHyvmbSfinyEoY7/ruseBZJ9
    Y4EE+pWpkfN2N7ViGvWyII7wNqD0DGeF8eWNt5tdwkQ7ZcxpL9nO42JMrLe05DHPCX//pQQj3TiJeVJEwOmxDmCdhQHZRxXXwTHR3MpyGpFI5QEMCJyBhQB3
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=pgo94LNVTTQY4zp_VX8A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeDSB1k (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 21:27:40 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43140 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752490AbeDSB1h (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Apr 2018 21:27:37 -0400
X-Google-Smtp-Source: AIpwx49f5SKI4ACOJKLql10MDngBkAbaksvg+vDqDdmTVn0hs2b7RlZKOh2P4tCi1GEAtnmOqYNOJ3mDpsf/rouAGNU=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <c34a7a95eb045a62e2443457979db9d7afbd9aee.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com> <c34a7a95eb045a62e2443457979db9d7afbd9aee.1521179281.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Apr 2018 21:27:34 -0400
Message-ID: <CAHC9VhQ-i5oA48sXXnN2fP06t5=9-NMoY0bKcGXorQw2k=CK0Q@mail.gmail.com>
Subject: Re: [RFC PATCH ghak32 V2 09/13] audit: add containerid support for
 config/feature/user records
To: Richard Guy Briggs <rgb@redhat.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Add container ID auxiliary records to configuration change, feature set change
> and user generated standalone records.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.c       | 50 ++++++++++++++++++++++++++++++++++++++++----------
>  kernel/auditfilter.c |  5 ++++-
>  2 files changed, 44 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index b238be5..08662b4 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -400,8 +400,9 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
>  {
>         struct audit_buffer *ab;
>         int rc = 0;
> +       struct audit_context *context = audit_alloc_local();

We should be able to use current->audit_context here right?  If we
can't for every caller, perhaps we pass an audit_context as an
argument and only allocate a local context when the passed
audit_context is NULL.

Also, if you're not comfortable always using current, just pass the
audit_context as you do with audit_log_common_recv_msg().

> -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
>         if (unlikely(!ab))
>                 return rc;
>         audit_log_format(ab, "%s=%u old=%u", function_name, new, old);
> @@ -411,6 +412,8 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
>                 allow_changes = 0; /* Something weird, deny request */
>         audit_log_format(ab, " res=%d", allow_changes);
>         audit_log_end(ab);
> +       audit_log_container_info(context, "config", audit_get_containerid(current));
> +       audit_free_context(context);
>         return rc;
>  }
>
> @@ -1058,7 +1061,8 @@ static int audit_netlink_ok(struct sk_buff *skb, u16 msg_type)
>         return err;
>  }
>
> -static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
> +static void audit_log_common_recv_msg(struct audit_context *context,
> +                                     struct audit_buffer **ab, u16 msg_type)
>  {
>         uid_t uid = from_kuid(&init_user_ns, current_uid());
>         pid_t pid = task_tgid_nr(current);
> @@ -1068,7 +1072,7 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
>                 return;
>         }
>
> -       *ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
> +       *ab = audit_log_start(context, GFP_KERNEL, msg_type);
>         if (unlikely(!*ab))
>                 return;
>         audit_log_format(*ab, "pid=%d uid=%u", pid, uid);
> @@ -1097,11 +1101,12 @@ static void audit_log_feature_change(int which, u32 old_feature, u32 new_feature
>                                      u32 old_lock, u32 new_lock, int res)
>  {
>         struct audit_buffer *ab;
> +       struct audit_context *context = audit_alloc_local();

So I know based on the other patch we are currently discussing that we
can use current here ...

>         if (audit_enabled == AUDIT_OFF)
>                 return;
>
> -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_FEATURE_CHANGE);
> +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_FEATURE_CHANGE);
>         if (!ab)
>                 return;
>         audit_log_task_info(ab, current);
> @@ -1109,6 +1114,8 @@ static void audit_log_feature_change(int which, u32 old_feature, u32 new_feature
>                          audit_feature_names[which], !!old_feature, !!new_feature,
>                          !!old_lock, !!new_lock, res);
>         audit_log_end(ab);
> +       audit_log_container_info(context, "feature", audit_get_containerid(current));
> +       audit_free_context(context);
>  }
>
>  static int audit_set_feature(struct sk_buff *skb)
> @@ -1337,13 +1344,15 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>
>                 err = audit_filter(msg_type, AUDIT_FILTER_USER);
>                 if (err == 1) { /* match or error */
> +                       struct audit_context *context = audit_alloc_local();

I'm pretty sure we can use current here.

>                         err = 0;
>                         if (msg_type == AUDIT_USER_TTY) {
>                                 err = tty_audit_push();
>                                 if (err)
>                                         break;
>                         }
> -                       audit_log_common_recv_msg(&ab, msg_type);
> +                       audit_log_common_recv_msg(context, &ab, msg_type);
>                         if (msg_type != AUDIT_USER_TTY)
>                                 audit_log_format(ab, " msg='%.*s'",
>                                                  AUDIT_MESSAGE_TEXT_MAX,
> @@ -1359,6 +1368,9 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                                 audit_log_n_untrustedstring(ab, data, size);
>                         }
>                         audit_log_end(ab);
> +                       audit_log_container_info(context, "user",
> +                                                audit_get_containerid(current));
> +                       audit_free_context(context);
>                 }
>                 break;
>         case AUDIT_ADD_RULE:
> @@ -1366,9 +1378,14 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                 if (nlmsg_len(nlh) < sizeof(struct audit_rule_data))
>                         return -EINVAL;
>                 if (audit_enabled == AUDIT_LOCKED) {
> -                       audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
> +                       struct audit_context *context = audit_alloc_local();

Pretty sure current can be used here too.  In fact I think everywhere
where we are processing commands from netlink we can use current as I
believe the entire netlink stack is processed in the context of the
caller.

> +                       audit_log_common_recv_msg(context, &ab, AUDIT_CONFIG_CHANGE);
>                         audit_log_format(ab, " audit_enabled=%d res=0", audit_enabled);
>                         audit_log_end(ab);
> +                       audit_log_container_info(context, "config",
> +                                                audit_get_containerid(current));
> +                       audit_free_context(context);
>                         return -EPERM;
>                 }
>                 err = audit_rule_change(msg_type, seq, data, nlmsg_len(nlh));
> @@ -1376,17 +1393,23 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>         case AUDIT_LIST_RULES:
>                 err = audit_list_rules_send(skb, seq);
>                 break;
> -       case AUDIT_TRIM:
> +       case AUDIT_TRIM: {
> +               struct audit_context *context = audit_alloc_local();

Same.

>                 audit_trim_trees();
> -               audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
> +               audit_log_common_recv_msg(context, &ab, AUDIT_CONFIG_CHANGE);
>                 audit_log_format(ab, " op=trim res=1");
>                 audit_log_end(ab);
> +               audit_log_container_info(context, "config",
> +                                        audit_get_containerid(current));
> +               audit_free_context(context);
>                 break;
> +       }
>         case AUDIT_MAKE_EQUIV: {
>                 void *bufp = data;
>                 u32 sizes[2];
>                 size_t msglen = nlmsg_len(nlh);
>                 char *old, *new;
> +               struct audit_context *context = audit_alloc_local();

Same.

>                 err = -EINVAL;
>                 if (msglen < 2 * sizeof(u32))
> @@ -1408,7 +1431,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                 /* OK, here comes... */
>                 err = audit_tag_tree(old, new);
>
> -               audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
> +               audit_log_common_recv_msg(context, &ab, AUDIT_CONFIG_CHANGE);
>
>                 audit_log_format(ab, " op=make_equiv old=");
>                 audit_log_untrustedstring(ab, old);
> @@ -1418,6 +1441,9 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                 audit_log_end(ab);
>                 kfree(old);
>                 kfree(new);
> +               audit_log_container_info(context, "config",
> +                                        audit_get_containerid(current));
> +               audit_free_context(context);
>                 break;
>         }
>         case AUDIT_SIGNAL_INFO:
> @@ -1459,6 +1485,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                 struct audit_tty_status s, old;
>                 struct audit_buffer     *ab;
>                 unsigned int t;
> +               struct audit_context *context = audit_alloc_local();

Same.

>                 memset(&s, 0, sizeof(s));
>                 /* guard against past and future API changes */
> @@ -1477,12 +1504,15 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                 old.enabled = t & AUDIT_TTY_ENABLE;
>                 old.log_passwd = !!(t & AUDIT_TTY_LOG_PASSWD);
>
> -               audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
> +               audit_log_common_recv_msg(context, &ab, AUDIT_CONFIG_CHANGE);
>                 audit_log_format(ab, " op=tty_set old-enabled=%d new-enabled=%d"
>                                  " old-log_passwd=%d new-log_passwd=%d res=%d",
>                                  old.enabled, s.enabled, old.log_passwd,
>                                  s.log_passwd, !err);
>                 audit_log_end(ab);
> +               audit_log_container_info(context, "config",
> +                                        audit_get_containerid(current));
> +               audit_free_context(context);
>                 break;
>         }
>         default:
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index c4c8746..5f7f4d6 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1109,11 +1109,12 @@ static void audit_log_rule_change(char *action, struct audit_krule *rule, int re
>         struct audit_buffer *ab;
>         uid_t loginuid = from_kuid(&init_user_ns, audit_get_loginuid(current));
>         unsigned int sessionid = audit_get_sessionid(current);
> +       struct audit_context *context = audit_alloc_local();
>
>         if (!audit_enabled)
>                 return;

Well, first I think we should be able to get rid of the local context,
but if for some reason we can't use current->audit_context then do the
allocation after the audit_enabled check.

> -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
>         if (!ab)
>                 return;
>         audit_log_format(ab, "auid=%u ses=%u" ,loginuid, sessionid);
> @@ -1122,6 +1123,8 @@ static void audit_log_rule_change(char *action, struct audit_krule *rule, int re
>         audit_log_key(ab, rule->filterkey);
>         audit_log_format(ab, " list=%d res=%d", rule->listnr, res);
>         audit_log_end(ab);
> +       audit_log_container_info(context, "config", audit_get_containerid(current));
> +       audit_free_context(context);
>  }

-- 
paul moore
www.paul-moore.com
