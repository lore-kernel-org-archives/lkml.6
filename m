Return-Path: <jsimmons@infradead.org>
X-Google-Smtp-Source: AIpwx49fcYvctxPf4RStancFi0WydEXik8+SXFRQJVsXiG9fL38Z8DgI3SoBJAhaVQhdEtIWf8EE
ARC-Seal: i=1; a=rsa-sha256; t=1522436607; cv=none;
        d=google.com; s=arc-20160816;
        b=fpuEnjb4T6f84qkTKS0MznWqgRxd+WrDs4FRS8ouaszWb9XY7IpW7P6DJA++zWksJQ
         PhepKIHGnEgqTv3Y72Jycoh1gX3DUEdqJ3qI0IOg91eqogtVNuHkdh7IKYUiuIysRXBT
         1PJvCN4AIlaIcXsEg4+7waulHmploF5Ru5gXLwZYVho2CyqL+bQ0+iwGrpsFeIohzjWv
         4FdcSXgsRrwjq8j3EJC4WL+q5MEjP5kSMQlMWV9JYZDM0KpGRAdjDnZWv/6G9CNPEj5O
         lby/UVxpLukPqS+o0Lg9vdPUt5MrL0ZmSX2b8IrX3cBwYwe3cVGTHvQtjpG7FvIO/vQe
         loJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=7YaHpksuPi9AJc3gbdRYrFP1Mn7IklLKSP4zsr/VV0M=;
        b=cD5QIBErTPNvOkCX1EOf5Wza5hXW9MnZyh35QebQqOdHt22HhZCc3mmWgb4iTlTviU
         1E+NkrX0vE2MjXMkbVyxLbDnT+8tDHOaMIiTPNgAcT+MHaZpZE26AA6icGXPmdmRMJQA
         Z+ZnIzYAI3xx1BdaNGgWHi/c3BHj+37zA/JTe4lAoAtNJNFsjcD0d8NP5k2RV13E4goi
         nibWHhM4F6IC6rIAahU5Wch4N1wO+wnPLvI4fkhpMIVnzxzSo1WJWWH7C/N3C42PPi/w
         O9BMQNh2xqFaE0XTAu3jA1EaGwzQr+o9xxi2VfgcIERC5To9kBqnzwrFpjT8HENa+7NC
         r1sw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=opvHmR6b;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=opvHmR6b;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Date: Fri, 30 Mar 2018 20:03:23 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
cc: Oleg Drokin <oleg.drokin@intel.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Andreas Dilger <andreas.dilger@intel.com>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 15/17] staging: lustre: discard cfs_time_before_64()
In-Reply-To: <152229760881.27689.10658125792259115083.stgit@noble>
Message-ID: <alpine.LFD.2.21.1803302003160.9681@casper.infradead.org>
References: <152229732768.27689.4800156943561963977.stgit@noble> <152229760881.27689.10658125792259115083.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180330_200323_708031_7DDC02E1 
X-CRM114-Status: GOOD (  16.43  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: SpamAssassin version 3.4.1 on casper.infradead.org summary:
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244872321523554?=
X-GMAIL-MSGID: =?utf-8?q?1596390488200800322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> cfs_time_before_64 is the same as time_before64()
> similarly cfs_time_beforeq_64() matsches time_before_eq64()
> So just use the standard interfaces.

Reviewed-by: James Simmons <jsimmons@infradead.org>
 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  .../lustre/include/linux/libcfs/linux/linux-time.h |   14 --------------
>  drivers/staging/lustre/lustre/include/obd_class.h  |    4 ++--
>  drivers/staging/lustre/lustre/ptlrpc/import.c      |    4 ++--
>  3 files changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h b/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
> index 9a353c6cb85a..ecdebccf2b44 100644
> --- a/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
> +++ b/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
> @@ -56,20 +56,6 @@
>  
>  #include <linux/jiffies.h>
>  
> -/*
> - * Generic kernel stuff
> - */
> -
> -static inline int cfs_time_before_64(u64 t1, u64 t2)
> -{
> -	return (__s64)t2 - (__s64)t1 > 0;
> -}
> -
> -static inline int cfs_time_beforeq_64(u64 t1, u64 t2)
> -{
> -	return (__s64)t2 - (__s64)t1 >= 0;
> -}
> -
>  /*
>   * One jiffy
>   */
> diff --git a/drivers/staging/lustre/lustre/include/obd_class.h b/drivers/staging/lustre/lustre/include/obd_class.h
> index 7cfc3c8d100c..176b63e2c9a7 100644
> --- a/drivers/staging/lustre/lustre/include/obd_class.h
> +++ b/drivers/staging/lustre/lustre/include/obd_class.h
> @@ -932,7 +932,7 @@ static inline int obd_statfs_async(struct obd_export *exp,
>  
>  	CDEBUG(D_SUPER, "%s: osfs %p age %llu, max_age %llu\n",
>  	       obd->obd_name, &obd->obd_osfs, obd->obd_osfs_age, max_age);
> -	if (cfs_time_before_64(obd->obd_osfs_age, max_age)) {
> +	if (time_before64(obd->obd_osfs_age, max_age)) {
>  		rc = OBP(obd, statfs_async)(exp, oinfo, max_age, rqset);
>  	} else {
>  		CDEBUG(D_SUPER,
> @@ -992,7 +992,7 @@ static inline int obd_statfs(const struct lu_env *env, struct obd_export *exp,
>  
>  	CDEBUG(D_SUPER, "osfs %llu, max_age %llu\n",
>  	       obd->obd_osfs_age, max_age);
> -	if (cfs_time_before_64(obd->obd_osfs_age, max_age)) {
> +	if (time_before64(obd->obd_osfs_age, max_age)) {
>  		rc = OBP(obd, statfs)(env, exp, osfs, max_age, flags);
>  		if (rc == 0) {
>  			spin_lock(&obd->obd_osfs_lock);
> diff --git a/drivers/staging/lustre/lustre/ptlrpc/import.c b/drivers/staging/lustre/lustre/ptlrpc/import.c
> index dd4fd54128dd..537a9e2ed467 100644
> --- a/drivers/staging/lustre/lustre/ptlrpc/import.c
> +++ b/drivers/staging/lustre/lustre/ptlrpc/import.c
> @@ -463,7 +463,7 @@ static int import_select_connection(struct obd_import *imp)
>  		 * the last successful attempt, go with this one
>  		 */
>  		if ((conn->oic_last_attempt == 0) ||
> -		    cfs_time_beforeq_64(conn->oic_last_attempt,
> +		    time_before_eq64(conn->oic_last_attempt,
>  					imp->imp_last_success_conn)) {
>  			imp_conn = conn;
>  			tried_all = 0;
> @@ -476,7 +476,7 @@ static int import_select_connection(struct obd_import *imp)
>  		 */
>  		if (!imp_conn)
>  			imp_conn = conn;
> -		else if (cfs_time_before_64(conn->oic_last_attempt,
> +		else if (time_before64(conn->oic_last_attempt,
>  					    imp_conn->oic_last_attempt))
>  			imp_conn = conn;
>  	}
> 
> 
> 
