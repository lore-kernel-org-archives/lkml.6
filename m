Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967330AbeE2VTu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:19:50 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:44848 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966952AbeE2VTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:19:41 -0400
X-Google-Smtp-Source: ADUXVKIfx3l7S8Jp/dkwCKszV4FlXxrXJPb1VDE8E3VaHReFXj3TEPTDG3KWm8cs+3qjri9dx6iwJTd2mxKSEbPBekQ=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180524201105.3179904-6-stefanb@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com> <20180524201105.3179904-6-stefanb@linux.vnet.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 May 2018 17:19:39 -0400
Message-ID: <CAHC9VhQTFPwz5tpL133DQuXDbZR4P7zy4m3hb4nwm9OSf4RNgQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] integrity: Add exe= and tty= before res= to integrity audits
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
> Use the new public audit functions to add the exe= and tty=
> parts to the integrity audit records. We place them before
> res=.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> ---
>  security/integrity/integrity_audit.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
> index db30763d5525..8d25d3c4dcca 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -56,6 +56,8 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
>                 audit_log_untrustedstring(ab, inode->i_sb->s_id);
>                 audit_log_format(ab, " ino=%lu", inode->i_ino);
>         }
> +       audit_log_d_path_exe(ab, current->mm);
> +       audit_log_tty(ab, current);

NACK

Please add the new fields to the end of the audit record, thank you.

>         audit_log_format(ab, " res=%d", !result);
>         audit_log_end(ab);
>  }

-- 
paul moore
www.paul-moore.com
