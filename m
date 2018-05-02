Return-Path: <jsimmons@infradead.org>
X-Google-Smtp-Source: AB8JxZpkCTQ9t0+jDXMAbxO7mqiMdbL+yzrhWEZDyuYG43NRjNwES/abxpUCLErz9YiH4t3sYj5A
ARC-Seal: i=1; a=rsa-sha256; t=1525284701; cv=none;
        d=google.com; s=arc-20160816;
        b=GUXx7Njb/rnGil7oALPIceb/AmfYXRRwxIxJu4QkacpCZ+KaDBvKJl4nnBV3nF/DzY
         b1bgZLs4P3hNPct5VXN3VJdNPwa8U7TdGc+z3a1FlQcyme5lAb8tb8GxmRs9DmaNG+A2
         b0zpzjnYFUfUssA32SXng3Gd6VJsfIwDABLQGhieRsbbibs/dnY7d8SXFgwhLLM7GivD
         oEhK0RJj5edqgEYczRzu+nuioaoWPzTNWvEAHN2lJQ4d4uIDKw6j3Uz6HTqtRJvpI+Up
         k7pYF+LNX2Ik6TiPoVxkM6WQ+jHJp4vavIz+MYWKzzsOU2mtWp51nQrRDKhoH8FU5p1H
         6zzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=p/91GZnWzQMxM9aJRq9cLwrUEzaKE0jLdoQeNEp4h6I=;
        b=nIMFdvz1UGB2AK1l5rxhpu+hmBNYTLuSB8Y+SGr+uhYyTFhCRJDgFlhagEl8wXFzxi
         +U1jb7RBpr1QgB+j6qvYOFgeje8xKnDz9EpmqTZuqgPhjDzNuns8dWEnHdoteowlXABn
         4iPFxR0IRw8NU0Le9hPk0/JfI3mNuOcA1B5f31PSn2HPjxMGPkoXNVuCP2+pVdBWgdS7
         NyNlSXewW3qi2J5S8gHxpovZ7OfK6ycmOtuW7wRzr2PyS+aFMGW7LRDndvwAt4RUpeOt
         YUQPkUjdHKBCQcDL3oWzp7awSoBJLPytb+SDB/6GxVxJ/KPm3e6S+dTUxdAVjHngDmEH
         1G1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=K+Oj/Xoz;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=K+Oj/Xoz;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Date: Wed, 2 May 2018 19:11:33 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
cc: Oleg Drokin <oleg.drokin@intel.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Andreas Dilger <andreas.dilger@intel.com>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 01/10] staging: lustre: ldlm: store name directly in
 namespace.
In-Reply-To: <152514675876.17843.12443354625160742215.stgit@noble>
Message-ID: <alpine.LFD.2.21.1805021910440.24633@casper.infradead.org>
References: <152514658325.17843.11455067361317157487.stgit@noble> <152514675876.17843.12443354625160742215.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180502_191133_377378_C006895D 
X-CRM114-Status: GOOD (  20.83  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: SpamAssassin version 3.4.1 on casper.infradead.org summary:
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232316691358736?=
X-GMAIL-MSGID: =?utf-8?q?1599376930887322099?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> Rather than storing the name of a namespace in the
> hash table, store it directly in the namespace.
> This will allow the hashtable to be changed to use
> rhashtable.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: James Simmons <jsimmons@infradead.org>

> ---
>  drivers/staging/lustre/lustre/include/lustre_dlm.h |    5 ++++-
>  drivers/staging/lustre/lustre/ldlm/ldlm_resource.c |    5 +++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/lustre/lustre/include/lustre_dlm.h b/drivers/staging/lustre/lustre/include/lustre_dlm.h
> index d668d86423a4..b3532adac31c 100644
> --- a/drivers/staging/lustre/lustre/include/lustre_dlm.h
> +++ b/drivers/staging/lustre/lustre/include/lustre_dlm.h
> @@ -362,6 +362,9 @@ struct ldlm_namespace {
>  	/** Flag indicating if namespace is on client instead of server */
>  	enum ldlm_side		ns_client;
>  
> +	/** name of this namespace */
> +	char			*ns_name;
> +
>  	/** Resource hash table for namespace. */
>  	struct cfs_hash		*ns_rs_hash;
>  
> @@ -878,7 +881,7 @@ static inline bool ldlm_has_layout(struct ldlm_lock *lock)
>  static inline char *
>  ldlm_ns_name(struct ldlm_namespace *ns)
>  {
> -	return ns->ns_rs_hash->hs_name;
> +	return ns->ns_name;
>  }
>  
>  static inline struct ldlm_namespace *
> diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c b/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
> index 6c615b6e9bdc..43bbc5fd94cc 100644
> --- a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
> +++ b/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
> @@ -688,6 +688,9 @@ struct ldlm_namespace *ldlm_namespace_new(struct obd_device *obd, char *name,
>  	ns->ns_obd      = obd;
>  	ns->ns_appetite = apt;
>  	ns->ns_client   = client;
> +	ns->ns_name     = kstrdup(name, GFP_KERNEL);
> +	if (!ns->ns_name)
> +		goto out_hash;
>  
>  	INIT_LIST_HEAD(&ns->ns_list_chain);
>  	INIT_LIST_HEAD(&ns->ns_unused_list);
> @@ -730,6 +733,7 @@ struct ldlm_namespace *ldlm_namespace_new(struct obd_device *obd, char *name,
>  	ldlm_namespace_sysfs_unregister(ns);
>  	ldlm_namespace_cleanup(ns, 0);
>  out_hash:
> +	kfree(ns->ns_name);
>  	cfs_hash_putref(ns->ns_rs_hash);
>  out_ns:
>  	kfree(ns);
> @@ -993,6 +997,7 @@ void ldlm_namespace_free_post(struct ldlm_namespace *ns)
>  	ldlm_namespace_debugfs_unregister(ns);
>  	ldlm_namespace_sysfs_unregister(ns);
>  	cfs_hash_putref(ns->ns_rs_hash);
> +	kfree(ns->ns_name);
>  	/* Namespace \a ns should be not on list at this time, otherwise
>  	 * this will cause issues related to using freed \a ns in poold
>  	 * thread.
> 
> 
> 
