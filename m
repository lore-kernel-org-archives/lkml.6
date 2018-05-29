Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967513AbeE2VSs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:18:48 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34464 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967319AbeE2VSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:18:03 -0400
X-Google-Smtp-Source: ADUXVKLtY26g2NFGPXaYAEoGpL51Nr4bAFeLeXqeyVWZMYL2puHXXMWx+TYr6wUuy0UzcsuTtCntuhY1rxLG3h/e/us=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180524201105.3179904-5-stefanb@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com> <20180524201105.3179904-5-stefanb@linux.vnet.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 May 2018 17:18:01 -0400
Message-ID: <CAHC9VhQk8wEsrGdzUBeT7FPkSrs8SRmCDwpS5Ae8oXyV_m3NYQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] audit: Allow others to call audit_log_d_path_exe()
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: zohar@linux.vnet.ibm.com, sgrubb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 4:11 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Add the prototype for audit_log_d_path_exe() so that it can be
> called by IMA later in this series.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  include/linux/audit.h | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 2deb76c74d10..65eca0795308 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -144,6 +144,8 @@ extern void             audit_log_untrustedstring(struct audit_buffer *ab,
>  extern void                audit_log_d_path(struct audit_buffer *ab,
>                                              const char *prefix,
>                                              const struct path *path);
> +extern void                audit_log_d_path_exe(struct audit_buffer *ab,
> +                                                struct mm_struct *mm);
>  extern void                audit_log_key(struct audit_buffer *ab,
>                                           char *key);
>  extern void                audit_log_link_denied(const char *operation);
> @@ -192,6 +194,9 @@ static inline void audit_log_d_path(struct audit_buffer *ab,
>                                     const char *prefix,
>                                     const struct path *path)
>  { }
> +static inline void audit_log_d_path_exe(struct audit_buffer *ab,
> +                                       struct mm_struct *mm)
> +{}
>  static inline void audit_log_key(struct audit_buffer *ab, char *key)
>  { }
>  static inline void audit_log_link_denied(const char *string)
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
