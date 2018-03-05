Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934438AbeCENyk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:54:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933628AbeCENyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:54:36 -0500
Date: Mon, 5 Mar 2018 08:50:08 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit: add containerid support for IMA-audit
Message-ID: <20180305135008.po6lheqnmkqqo6q4@madcap2.tricolour.ca>
References: <1520257393.10396.291.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520257393.10396.291.camel@linux.vnet.ibm.com>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-05 08:43, Mimi Zohar wrote:
> Hi Richard,
> 
> This patch has been compiled, but not runtime tested.

Ok, great, thank you.  I assume you are offering this patch to be
included in this patchset?  I'll have a look to see where it fits in the
IMA record.  It might be better if it were an AUDIT_CONTAINER_INFO
auxiliary record, but I'll have a look at the circumstances of the
event.  Can you suggest a procedure to test it?

> ---
> 
> If the containerid is defined, include it in the IMA-audit record.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  security/integrity/ima/ima_api.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index 33b4458cdbef..41d29a06f28f 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -335,6 +335,9 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
>  	audit_log_untrustedstring(ab, algo_hash);
>  
>  	audit_log_task_info(ab, current);
> +	if (audit_containerid_set(current))
> +		audit_log_format(ab, " contid=%llu",
> +				 audit_get_containerid(current));
>  	audit_log_end(ab);
>  
>  	iint->flags |= IMA_AUDITED;
> -- 
> 2.7.5
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
