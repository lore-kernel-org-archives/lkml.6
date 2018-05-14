Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-958837-1526311407-2-5692097543726354762
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526311407; b=U0B8BToaLK4JcH88gzXT/kTkl4AISFQz+xnM9nKEyBvE2lP8Dy
    u2KRlvRkpA0xj4+vSshPW+7FXgUjyXx0ikg2uGamhe4I9LPt15kIupMXi01BR61f
    Gsg5ykd3apYBHn3/kOIz2Dg6wvVKmvhFzx5o/YlnBKyIACfgQwsFk2AMsqQzn9uS
    e6CKc6TZzBPtJ50V6nRWpoGiAp9SLF9Zwh6e3/M1lU29yHiBF5KSujliNO86jyUQ
    XzpYRM4OyviCP41qjnPBpucdXYi8Zt0hqT6lf6B1lmNo69naXUIAXVScfyxdnluq
    ZuNWuNE8sG1GyXv8SIxTor2LVBL58KopMyzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526311407;
    bh=miI9vXWLtp2DeaKX7ES7cp4+R0kxdl3tjqoqQp6yC+U=; b=glI2+yfPxAEM
    R87sukQzlB+8cK12cl5qI2ENvopqTzqDePkpUFtMrKT98bQcx9xQeQuladRudFvG
    j6bgQmXsQjGChNF5nzNYIU6qDce8jKEI0Rvd+mNSJlbj5SZxGbRbSWbFfRgKVaCg
    EYFdYCC3PIWihTYUJKacwfwI7xiMG3/wG6MP625ImdOilU2woNNpRLDvma4cTKBy
    2DP/jIurdXZnEnlvQhKxalX1NlN4sU8zY5DP24pwR68Upo07XB8ihBEipTOlj6D+
    73uRTkg735bBB3rioJzQnNlNEgd4PD/b3FbgtTzaYzG7avXbADwTDnSbDdhYCATm
    wnV+2sLo3w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.nsa.gov;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=tycho.nsa.gov header.result=pass
    header_org.domain=nsa.gov header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-110 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.nsa.gov;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=tycho.nsa.gov header.result=pass
      header_org.domain=nsa.gov header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-110 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMIBWBkMEoVF4CsgLFY3LXmg3D8OtA5elvfQej1KnvNZMwYY26lDGg/0vxpnyvrSm4kPkq/raFHYrdCvZrVAhSl74sEBYVo7AagPyc5rbPJm8rqAutCI
    u9PQmtDq05rflZp2RUMJja9HvF9fNZyr2MhvPGqO9FBwwW61wblqOIZahDOuWGs8aQ9znzz4g2wTGjFJFX8+xwgXmfZ5zD74nno30aPp/LiW9Me3N7yP5oF6
    qwxVlks4SGCazAp4y7LxKw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=vpqfxihKAAAA:8 a=VwQbUJbxAAAA:8 a=ijX7H-lU7-LzLEi_RsAA:9
    a=0722UH2Serge4KXO:21 a=6DCh2--YQ379MXYi:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AULIiLoY-XQsE5F6gcqX:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932453AbeENPXX (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 11:23:23 -0400
Received: from uphb19pa09.eemsg.mail.mil ([214.24.26.83]:1510 "EHLO
        USFB19PA12.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932486AbeENPXU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 May 2018 11:23:20 -0400
X-IronPort-AV: E=Sophos;i="5.49,400,1520899200";
   d="scan'208";a="11754731"
IronPort-PHdr: =?us-ascii?q?9a23=3A4e8cjhchiQEwIvxvHGex/rBhlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc29ZR2N2/xhgRfzUJnB7Loc0qyK6/umATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfb1/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4rx1QxH0ligIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNwUX2?=
 =?us-ascii?q?pBWttaWTJHDI2ycoADC/MNMfhEo4X4oVYFsBmwChS2BO731zFGmHH206053e?=
 =?us-ascii?q?ovHw7J0w4vEM4BvnnPsNX4Nr0fXfypwKTGzzjOae5d1zfn6IjPdxAsueyCXa?=
 =?us-ascii?q?5ufsrJyUkgCQXFhUiNp4zgJTyV0uANvHab7uF9Uu+vkHMoqxpqrzizxsYjlo?=
 =?us-ascii?q?nJhoUPxlDC7iV22pw5JdK/SE5leNOpFoZbuSKCN4ZuX88vTG5ltDw6x7Ebo5?=
 =?us-ascii?q?K3YicHxIo9yxLCbfGMbpKG7Qj5VOmLJDd1nHdleLWiiBms6UWg0ej8VtWs0F?=
 =?us-ascii?q?ZNsypFjsHAtnAT2BzX7ciKUud98V272TaOygDT8ftIIVw0lKXHK54hxaQ8lp?=
 =?us-ascii?q?wPvkTYAiD6gkD2jK6Sdkk8++io7froYqn+q5OBOIJ5hRvyP6QzlsClH+g1PR?=
 =?us-ascii?q?YCU3KG9eik0b3s50z5QLFEjv0slanZtYjXJd8Gqa6iGAJVzoYi5Aq/Dzehyt?=
 =?us-ascii?q?gYm2IHI0hfdBKIiIjpJUnCIOrkAvenn1SsjDBryujaMbL7GZXCMHjCnaz6fb?=
 =?us-ascii?q?lh605T0hczzd5b551KELENOe78VVXruNPECR85NhS+w/z7B9VlyoMeRWWPD7?=
 =?us-ascii?q?edMKPTt1+I++0uL/CXZIALpDn9NuIl5//yjX45gFMdeK6p0oYKaHC8APtrOF?=
 =?us-ascii?q?uZYXXyjdcbC2sKvRQxTPbsiFKcVT5ffXGyX7gz5jsjEoKpEZ/DRpyxgLyGxC?=
 =?us-ascii?q?q7GpxWZmZbClGDCHvodJuLW+0KaC2MJs9siSIEVbe/RI87zx2utxH1y6BhLu?=
 =?us-ascii?q?XK/i0Ur5Xj1MJ65+fLjxE96SR0D9iB02GKV2x0hnkHRyIy3K1kuUxy0EqD0a?=
 =?us-ascii?q?xhj/xdEtxT4OlJXRkgOZHAyOx6Dsj4WhjdcdeRVFamXtKmDCksQNw239IDfU?=
 =?us-ascii?q?NzF8y/gRDCxCqlH6IVl6eQBJEv9qLc3mPxJ9pmy3rcyKUtkkMqQsxVNW2pnq?=
 =?us-ascii?q?R/7RTcB5bVk0WFkKanbaYc3CnN9GeF12aOvkZYUA5qXqXDRnAQeE3WoM/l6U?=
 =?us-ascii?q?zYSb+uDrInMgpdxsGYLqtGcMHmjVJDRP37ItTRf3qxm3usBRaP3r6Mb5TldH?=
 =?us-ascii?q?sG3CrBD0gElAMT8G2aOgg+HCehpGfeDD1zFVLqeU/s9vN+qHyjRE8u0w6Kd1?=
 =?us-ascii?q?Fh16ay+hMNnfyTVfUT3r0ZuCcgrTV4BVW90MzMC9qGuQVheL5RYdIk7FdD0m?=
 =?us-ascii?q?LZqRJyMoa7L694hV4ebh53sFn02xVxFIpMi8oqrGsyxgpoNa2YyE9Bdy+f3Z?=
 =?us-ascii?q?3oOL3XL27y/Aq1a67XwVHTy9CW9b0K6PsmqlXvpgapFlAt8yYv794A+HKH64?=
 =?us-ascii?q?SCNwESWI//Vkstv0xxrqrXcwEm7IPdyHNoPLPxuTaE0NUsUq9t7i2FN4NbMa?=
 =?us-ascii?q?WZBErpHsYHHcmyOakvnFS0ah8sIu9f7ug3Mtmgev/A37SkaqIouBGCqCwT5I?=
 =?us-ascii?q?F7z1LJ9CdmTOPM94gKzuve3QadUTr4ylC7vZaz0bhNeDVaO2240yWsUJZYe6?=
 =?us-ascii?q?laZY8WDSKrJMqty5N1gJu7HzZj2RaHBlUbyIf9YheWblrgzSVMxE8Xpjqhgi?=
 =?us-ascii?q?L+wDtqxXVh5JG69QfthujjbxEaIXVjQGh5kUyqedHyiMoVFgD8VC0Avzjg6U?=
 =?us-ascii?q?fhzLVAv4x7LnLPWgEQJm7xNW40FuOSsbqEK+xI6JouqihRGLC+ZlCcDLz6ox?=
 =?us-ascii?q?IcyC7lN2BXwjc9djqjvtPymBkszCq+IXto5FHefsI4kRTS6cfXQvlS9jEGXi?=
 =?us-ascii?q?59iCTSQF+mMI/ttemZi4zetaieXmStX9UHaSTtwp6Bsm646HdsDBmXnrW3nc?=
 =?us-ascii?q?PqVxMz0jLh3p9sWGPKtEC4Kqvi0qmhecdgZFNpHxeo6c99AJt/iaM2jZQd2D?=
 =?us-ascii?q?4dnJrDrlQdlmKmCslWwaLzajI2QDcPx9PEqFz+1FZLMmOCx4W/UG6UhMRmeY?=
 =?us-ascii?q?/pMSstxish4pUSW++v57tekH4w+wDgoA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2C6BQDLpfla/wHyM5BcGwEBAQEDAQEBCQEBAYMYK4FcK?=
 =?us-ascii?q?INylHJFAQEBAQEBBn8IIXUalSo2AYRAAoMRITgUAQIBAQEBAQECAWsogjUkA?=
 =?us-ascii?q?YJOAQEBAQMjBGILEQMBAgECAiYCAk8IBgEMBgIBAYJfQIF0DaplgWkzg3gBA?=
 =?us-ascii?q?V6DZYIngQmHHIEMgQeBDyMMgic1h3OCVAKHOIRgjB4JjksGjG+SCDMhgVIrC?=
 =?us-ascii?q?AIYCCEPgn6QGAFRIzB6AQGPbQEB?=
Subject: Re: [PATCH 20/23] LSM: Move common usercopy into
To: Casey Schaufler <casey@schaufler-ca.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
 <cb3455a2-b957-8a9a-f056-35f97fe51e71@schaufler-ca.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a9e6b33b-3d17-2535-5798-bc092e8559c3@tycho.nsa.gov>
Date: Mon, 14 May 2018 11:12:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <cb3455a2-b957-8a9a-f056-35f97fe51e71@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/10/2018 08:55 PM, Casey Schaufler wrote:
> From: Casey Schaufler <casey@schaufler-ca.com>
> Date: Thu, 10 May 2018 15:54:25 -0700
> Subject: [PATCH 20/23] LSM: Move common usercopy into
>  security_getpeersec_stream
> 
> The modules implementing hook for getpeersec_stream
> don't need to be duplicating the copy-to-user checks.
> Moving the user copy part into the infrastructure makes
> the security module code simpler and reduces the places
> where user copy code may go awry.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h  | 10 ++++------
>  include/linux/security.h   |  6 ++++--
>  security/apparmor/lsm.c    | 28 ++++++++++------------------
>  security/security.c        | 17 +++++++++++++++--
>  security/selinux/hooks.c   | 22 +++++++---------------
>  security/smack/smack_lsm.c | 19 ++++++++-----------
>  6 files changed, 48 insertions(+), 54 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 81504623afb4..84bc9ec01931 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -841,9 +841,8 @@
>   *	SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
>   *	socket is associated with an ipsec SA.
>   *	@sock is the local socket.
> - *	@optval userspace memory where the security state is to be copied.
> - *	@optlen userspace int where the module should copy the actual length
> - *	of the security state.
> + *	@optval the security state.
> + *	@optlen the actual length of the security state.
>   *	@len as input is the maximum length to copy to userspace provided
>   *	by the caller.
>   *	Return 0 if all is well, otherwise, typical getsockopt return
> @@ -1674,9 +1673,8 @@ union security_list_options {
>  	int (*socket_setsockopt)(struct socket *sock, int level, int optname);
>  	int (*socket_shutdown)(struct socket *sock, int how);
>  	int (*socket_sock_rcv_skb)(struct sock *sk, struct sk_buff *skb);
> -	int (*socket_getpeersec_stream)(struct socket *sock,
> -					char __user *optval,
> -					int __user *optlen, unsigned int len);
> +	int (*socket_getpeersec_stream)(struct socket *sock, char **optval,
> +					int *optlen, unsigned int len);
>  	int (*socket_getpeersec_dgram)(struct socket *sock,
>  					struct sk_buff *skb,
>  					struct secids *secid);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index ab70064c283f..712d138e0148 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1369,8 +1369,10 @@ static inline int security_sock_rcv_skb(struct sock *sk,
>  	return 0;
>  }
>  
> -static inline int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
> -						    int __user *optlen, unsigned len)
> +static inline int security_socket_getpeersec_stream(struct socket *sock,
> +						    char __user *optval,
> +						    int __user *optlen,
> +						    unsigned int len)
>  {
>  	return -ENOPROTOOPT;
>  }
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 90453dbb4fac..7444cfa689b3 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1017,10 +1017,8 @@ static struct aa_label *sk_peer_label(struct sock *sk)
>   *
>   * Note: for tcp only valid if using ipsec or cipso on lan
>   */
> -static int apparmor_socket_getpeersec_stream(struct socket *sock,
> -					     char __user *optval,
> -					     int __user *optlen,
> -					     unsigned int len)
> +static int apparmor_socket_getpeersec_stream(struct socket *sock, char **optval,
> +					     int *optlen, unsigned int len)
>  {
>  	char *name;
>  	int slen, error = 0;
> @@ -1037,22 +1035,16 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
>  				 FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
>  				 FLAG_HIDDEN_UNCONFINED, GFP_KERNEL);
>  	/* don't include terminating \0 in slen, it breaks some apps */
> -	if (slen < 0) {
> +	if (slen < 0)
>  		error = -ENOMEM;
> -	} else {
> -		if (slen > len) {
> -			error = -ERANGE;
> -		} else if (copy_to_user(optval, name, slen)) {
> -			error = -EFAULT;
> -			goto out;
> -		}
> -		if (put_user(slen, optlen))
> -			error = -EFAULT;
> -out:
> -		kfree(name);
> -
> +	else if (slen > len)
> +		error = -ERANGE;
> +	else {
> +		*optlen = slen;
> +		*optval = name;
>  	}
> -
> +	if (error)
> +		kfree(name);
>  done:
>  	end_current_label_crit_section(label);
>  
> diff --git a/security/security.c b/security/security.c
> index cbe1a497ec5a..6144ff52d862 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1924,8 +1924,21 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>  int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>  				      int __user *optlen, unsigned len)
>  {
> -	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
> -				optval, optlen, len);
> +	char *tval = NULL;
> +	u32 tlen;
> +	int rc;
> +
> +	rc = call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
> +			   &tval, &tlen, len);
> +	if (rc == 0) {
> +		tlen = strlen(tval) + 1;

Why are you recomputing tlen here from what the module provided, and further presuming it must be nul-terminated?

> +		if (put_user(tlen, optlen))
> +			rc = -EFAULT;
> +		else if (copy_to_user(optval, tval, tlen))
> +			rc = -EFAULT;
> +		kfree(tval);
> +	}
> +	return rc;
>  }
>  
>  int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 81f104d9e85e..9520341daa78 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4955,10 +4955,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  	return err;
>  }
>  
> -static int selinux_socket_getpeersec_stream(struct socket *sock,
> -					    __user char *optval,
> -					    __user int *optlen,
> -					    unsigned int len)
> +static int selinux_socket_getpeersec_stream(struct socket *sock, char **optval,
> +					    int *optlen, unsigned int len)
>  {
>  	int err = 0;
>  	char *scontext;
> @@ -4979,18 +4977,12 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
>  		return err;
>  
>  	if (scontext_len > len) {
> -		err = -ERANGE;
> -		goto out_len;
> +		kfree(scontext);
> +		return -ERANGE;
>  	}
> -
> -	if (copy_to_user(optval, scontext, scontext_len))
> -		err = -EFAULT;
> -
> -out_len:
> -	if (put_user(scontext_len, optlen))
> -		err = -EFAULT;
> -	kfree(scontext);
> -	return err;
> +	*optval = scontext;
> +	*optlen = scontext_len;
> +	return 0;
>  }
>  
>  static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, struct secids *secid)
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 660a55ee8a57..12b00aac0c94 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3878,14 +3878,12 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>   *
>   * returns zero on success, an error code otherwise
>   */
> -static int smack_socket_getpeersec_stream(struct socket *sock,
> -					  char __user *optval,
> -					  int __user *optlen, unsigned len)
> +static int smack_socket_getpeersec_stream(struct socket *sock, char **optval,
> +					  int *optlen, unsigned int len)
>  {
>  	struct socket_smack *ssp;
>  	char *rcp = "";
>  	int slen = 1;
> -	int rc = 0;
>  
>  	ssp = smack_sock(sock->sk);
>  	if (ssp->smk_packet != NULL) {
> @@ -3894,14 +3892,13 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
>  	}
>  
>  	if (slen > len)
> -		rc = -ERANGE;
> -	else if (copy_to_user(optval, rcp, slen) != 0)
> -		rc = -EFAULT;
> -
> -	if (put_user(slen, optlen) != 0)
> -		rc = -EFAULT;
> +		return -ERANGE;
>  
> -	return rc;
> +	*optval = kstrdup(rcp, GFP_ATOMIC);
> +	if (*optval == NULL)
> +		return -ENOMEM;
> +	*optlen = slen;
> +	return 0;
>  }
>  
>  
> 

