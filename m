Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966702AbeE2UaC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 16:30:02 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33730 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966480AbeE2U37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 16:29:59 -0400
X-Google-Smtp-Source: ADUXVKJg8CQ0W8HvON7hzJBWJilX5pR9U4+cHrYpe1WkUwPjMWshFeRLjWGMosNe2XVw14+yUK9WtXTiP/iVYjbwtmA=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180524201105.3179904-2-stefanb@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com> <20180524201105.3179904-2-stefanb@linux.vnet.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 May 2018 16:29:56 -0400
Message-ID: <CAHC9VhTpfjKd2bTx9Q9TVo9hqPFRB-VNHYhzZb+DjXJUE1txcg@mail.gmail.com>
Subject: Re: [PATCH 1/8] ima: Call audit_log_string() rather than logging it untrusted
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: zohar@linux.vnet.ibm.com, sgrubb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 4:10 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> The parameters passed to this logging function are all provided by
> a privileged user and therefore we can call audit_log_string()
> rather than audit_log_untrustedstring().
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> ---
>  security/integrity/ima/ima_policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index d89bebf85421..a823f11a3e6b 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -615,7 +615,7 @@ static void ima_log_string_op(struct audit_buffer *ab, char *key, char *value,
>                 audit_log_format(ab, "%s<", key);
>         else
>                 audit_log_format(ab, "%s=", key);
> -       audit_log_untrustedstring(ab, value);
> +       audit_log_string(ab, value);
>         audit_log_format(ab, " ");
>  }
>  static void ima_log_string(struct audit_buffer *ab, char *key, char *value)
> --
> 2.13.6
>
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit

-- 
paul moore
www.paul-moore.com
