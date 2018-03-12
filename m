Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932399AbeCLPBU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:01:20 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35345 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932342AbeCLPBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:01:17 -0400
X-Google-Smtp-Source: AG47ELud8+W9Pn+mmYvAQSeiKViwTep1zFkO8EgkF5BdKdq9d8RVQjX86iSafyi80j2qekHF5/fZMfhw0NE2un+J+7Y=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <6b1842619a6f1ba13194328e28b853c18c466c03.1520835596.git.rgb@redhat.com>
References: <cover.1520835596.git.rgb@redhat.com> <6b1842619a6f1ba13194328e28b853c18c466c03.1520835596.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Mar 2018 11:01:13 -0400
Message-ID: <CAHC9VhTaHA0v-8=QkEDzTyXFvk1oFHnFj6EbHxGetU+pmr+iPQ@mail.gmail.com>
Subject: Re: [PATCH ghak21 V2 1/4] audit: make ANOM_LINK obey audit_enabled
 and audit_dummy_context
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 2:31 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Audit link denied events emit disjointed records when audit is disabled.
> No records should be emitted when audit is disabled.
>
> See: https://github.com/linux-audit/audit-kernel/issues/21
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.c | 3 +++
>  1 file changed, 3 insertions(+)

As stated previously, this has already been merged.  Ignoring.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 1a3e75d..7026d69 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2308,6 +2308,9 @@ void audit_log_link_denied(const char *operation, const struct path *link)
>         struct audit_buffer *ab;
>         struct audit_names *name;
>
> +       if (!audit_enabled || audit_dummy_context())
> +               return;
> +
>         name = kzalloc(sizeof(*name), GFP_NOFS);
>         if (!name)
>                 return;
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
