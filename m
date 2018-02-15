Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166650AbeBOUnx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:43:53 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42766 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161706AbeBOUnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:43:51 -0500
X-Google-Smtp-Source: AH8x224HXyyz0fOkDnUpWb3p28/P3KlaT+1rtjCaixk6hBVECBBVZYpZKOGjrQxhXZz0ECdhcvn35wp/u5aSSdE+SMc=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <5f742621971f0267cf5854a6a5054746ef3ab95f.1518435853.git.rgb@redhat.com>
References: <cover.1518435853.git.rgb@redhat.com> <5f742621971f0267cf5854a6a5054746ef3ab95f.1518435853.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Feb 2018 15:43:49 -0500
Message-ID: <CAHC9VhRtgzBB0HCNjE--CiYfUSfBq5C2U767BbN=ecRc_dqSZA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] fixup! audit: remove arch_f pointer from struct audit_krule
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 7:29 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditfilter.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

I realize this is an RFC patchset, but considering recent patchsets I
feel some clarification might be helpful to prevent future delays ...
when submitting patchsets for merging please do not submit "fixup!"
patches which fix problems in patches that are submitted earlier in
the patchset, simply merge/squash the "fixup!" patches before
submitting.

> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 3343d1c..48dcb59 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -221,11 +221,13 @@ static inline int audit_match_class_bits(int class, u32 *mask)
>  static int audit_match_signal(struct audit_entry *entry)
>  {
>         int i;
> +       u32 archval;
>         struct audit_field *arch;
>
>         for (i = 0; i < entry->rule.field_count; i++)
>                 if (entry->rule.fields[i].type == AUDIT_ARCH) {
>                         arch = &entry->rule.fields[i];
> +                       archval = arch->val;
>                         break;
>                 }
>
> @@ -238,7 +240,7 @@ static int audit_match_signal(struct audit_entry *entry)
>                                                entry->rule.mask));
>         }
>
> -       switch(audit_classify_arch(arch->val)) {
> +       switch(audit_classify_arch(archval)) {
>         case 0: /* native */
>                 return (audit_match_class_bits(AUDIT_CLASS_SIGNAL,
>                                                entry->rule.mask));
> --
> 1.8.3.1
>



-- 
paul moore
www.paul-moore.com
