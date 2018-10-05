Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FA7C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE0B208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE0B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbeJFE4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 00:56:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47921 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeJFE4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 00:56:54 -0400
Received: from static-50-53-48-205.bvtn.or.frontiernet.net ([50.53.48.205] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1g8Y4x-0007qB-Tm; Fri, 05 Oct 2018 21:56:12 +0000
Subject: Re: [PATCH] apparmor: add #ifdef checks for secmark filtering
To:     Arnd Bergmann <arnd@arndb.de>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     David Howells <dhowells@redhat.com>, Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181005161206.727098-1-arnd@arndb.de>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 xsFNBE5mrPoBEADAk19PsgVgBKkImmR2isPQ6o7KJhTTKjJdwVbkWSnNn+o6Up5knKP1f49E
 BQlceWg1yp/NwbR8ad+eSEO/uma/K+PqWvBptKC9SWD97FG4uB4/caomLEU97sLQMtnvGWdx
 rxVRGM4anzWYMgzz5TZmIiVTZ43Ou5VpaS1Vz1ZSxP3h/xKNZr/TcW5WQai8u3PWVnbkjhSZ
 PHv1BghN69qxEPomrJBm1gmtx3ZiVmFXluwTmTgJOkpFol7nbJ0ilnYHrA7SX3CtR1upeUpM
 a/WIanVO96WdTjHHIa43fbhmQube4txS3FcQLOJVqQsx6lE9B7qAppm9hQ10qPWwdfPy/+0W
 6AWtNu5ASiGVCInWzl2HBqYd/Zll93zUq+NIoCn8sDAM9iH+wtaGDcJywIGIn+edKNtK72AM
 gChTg/j1ZoWH6ZeWPjuUfubVzZto1FMoGJ/SF4MmdQG1iQNtf4sFZbEgXuy9cGi2bomF0zvy
 BJSANpxlKNBDYKzN6Kz09HUAkjlFMNgomL/cjqgABtAx59L+dVIZfaF281pIcUZzwvh5+JoG
 eOW5uBSMbE7L38nszooykIJ5XrAchkJxNfz7k+FnQeKEkNzEd2LWc3QF4BQZYRT6PHHga3Rg
 ykW5+1wTMqJILdmtaPbXrF3FvnV0LRPcv4xKx7B3fGm7ygdoowARAQABzR1Kb2huIEpvaGFu
 c2VuIDxqb2huQGpqbXgubmV0PsLBegQTAQoAJAIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIX
 gAUCTo0YVwIZAQAKCRAFLzZwGNXD2LxJD/9TJZCpwlncTgYeraEMeDfkWv8c1IsM1j0AmE4V
 tL+fE780ZVP9gkjgkdYSxt7ecETPTKMaZSisrl1RwqU0oogXdXQSpxrGH01icu/2n0jcYSqY
 KggPxy78BGs2LZq4XPfJTZmHZGnXGq/eDr/mSnj0aavBJmMZ6jbiPz6yHtBYPZ9fdo8btczw
 P41YeWoIu26/8II6f0Xm3VC5oAa8v7Rd+RWZa8TMwlhzHExxel3jtI7IzzOsnmE9/8Dm0ARD
 5iTLCXwR1cwI/J9BF/S1Xv8PN1huT3ItCNdatgp8zqoJkgPVjmvyL64Q3fEkYbfHOWsaba9/
 kAVtBNz9RTFh7IHDfECVaToujBd7BtPqr+qIjWFadJD3I5eLCVJvVrrolrCATlFtN3YkQs6J
 n1AiIVIU3bHR8Gjevgz5Ll6SCGHgRrkyRpnSYaU/uLgn37N6AYxi/QAL+by3CyEFLjzWAEvy
 Q8bq3Iucn7JEbhS/J//dUqLoeUf8tsGi00zmrITZYeFYARhQMtsfizIrVDtz1iPf/ZMp5gRB
 niyjpXn131cm3M3gv6HrQsAGnn8AJru8GDi5XJYIco/1+x/qEiN2nClaAOpbhzN2eUvPDY5W
 0q3bA/Zp2mfG52vbRI+tQ0Br1Hd/vsntUHO903mMZep2NzN3BZ5qEvPvG4rW5Zq2DpybWc7B
 TQROZqz6ARAAoqw6kkBhWyM1fvgamAVjeZ6nKEfnRWbkC94L1EsJLup3Wb2X0ABNOHSkbSD4
 pAuC2tKF/EGBt5CP7QdVKRGcQzAd6b2c1Idy9RLw6w4gi+nn/d1Pm1kkYhkSi5zWaIg0m5RQ
 Uk+El8zkf5tcE/1N0Z5OK2JhjwFu5bX0a0l4cFGWVQEciVMDKRtxMjEtk3SxFalm6ZdQ2pp2
 822clnq4zZ9mWu1d2waxiz+b5Ia4weDYa7n41URcBEUbJAgnicJkJtCTwyIxIW2KnVyOrjvk
 QzIBvaP0FdP2vvZoPMdlCIzOlIkPLgxE0IWueTXeBJhNs01pb8bLqmTIMlu4LvBELA/veiaj
 j5s8y542H/aHsfBf4MQUhHxO/BZV7h06KSUfIaY7OgAgKuGNB3UiaIUS5+a9gnEOQLDxKRy/
 a7Q1v9S+Nvx+7j8iH3jkQJhxT6ZBhZGRx0gkH3T+F0nNDm5NaJUsaswgJrqFZkUGd2Mrm1qn
 KwXiAt8SIcENdq33R0KKKRC80Xgwj8Jn30vXLSG+NO1GH0UMcAxMwy/pvk6LU5JGjZR73J5U
 LVhH4MLbDggD3mPaiG8+fotTrJUPqqhg9hyUEPpYG7sqt74Xn79+CEZcjLHzyl6vAFE2W0kx
 lLtQtUZUHO36afFv8qGpO3ZqPvjBUuatXF6tvUQCwf3H6XMAEQEAAcLBXwQYAQoACQUCTmas
 +gIbDAAKCRAFLzZwGNXD2D/XD/0ddM/4ai1b+Tl1jznKajX3kG+MeEYeI4f40vco3rOLrnRG
 FOcbyyfVF69MKepie4OwoI1jcTU0ADecnbWnDNHpr0SczxBMro3bnrLhsmvjunTYIvssBZtB
 4aVJjuLILPUlnhFqa7fbVq0ZQjbiV/rt2jBENdm9pbJZ6GjnpYIcAbPCCa/ffL4/SQRSYHXo
 hGiiS4y5jBTmK5ltfewLOw02fkexH+IJFrrGBXDSg6n2Sgxnn++NF34fXcm9piaw3mKsICm+
 0hdNh4afGZ6IWV8PG2teooVDp4dYih++xX/XS8zBCc1O9w4nzlP2gKzlqSWbhiWpifRJBFa4
 WtAeJTdXYd37j/BI4RWWhnyw7aAPNGj33ytGHNUf6Ro2/jtj4tF1y/QFXqjJG/wGjpdtRfbt
 UjqLHIsvfPNNJq/958p74ndACidlWSHzj+Op26KpbFnmwNO0psiUsnhvHFwPO/vAbl3RsR5+
 0Ro+hvs2cEmQuv9r/bDlCfpzp2t3cK+rhxUqisOx8DZfz1BnkaoCRFbvvvk+7L/fomPntGPk
 qJciYE8TGHkZw1hOku+4OoM2GB5nEDlj+2TF/jLQ+EipX9PkPJYvxfRlC6dK8PKKfX9KdfmA
 IcgHfnV1jSn+8yH2djBPtKiqW0J69aIsyx7iV/03paPCjJh7Xq9vAzydN5U/UA==
Organization: Canonical
Message-ID: <cddbef8c-f2e0-149c-2626-a3657851672b@canonical.com>
Date:   Fri, 5 Oct 2018 14:56:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005161206.727098-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2018 09:11 AM, Arnd Bergmann wrote:
> The newly added code fails to build when either SECMARK or
> NETFILTER are disabled:
> 
> security/apparmor/lsm.c: In function 'apparmor_socket_sock_rcv_skb':
> security/apparmor/lsm.c:1138:12: error: 'struct sk_buff' has no member named 'secmark'; did you mean 'mark'?
> 
> security/apparmor/lsm.c:1671:21: error: 'struct nf_hook_state' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
> 
> Add a set of #ifdef checks around it to only enable the code that
> we can compile and that makes sense in that configuration.
> 
> Fixes: ab9f2115081a ("apparmor: Allow filtering based on secmark policy")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd, I have pulled this into apparmor-next


> ---
>  security/apparmor/lsm.c | 10 ++++++++++
>  security/apparmor/net.c |  2 ++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 53201013c40e..b74b724d3e84 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1123,6 +1123,7 @@ static int apparmor_socket_shutdown(struct socket *sock, int how)
>  	return aa_sock_perm(OP_SHUTDOWN, AA_MAY_SHUTDOWN, sock);
>  }
>  
> +#ifdef CONFIG_NETWORK_SECMARK
>  /**
>   * apparmor_socket_sock_recv_skb - check perms before associating skb to sk
>   *
> @@ -1141,6 +1142,7 @@ static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  	return apparmor_secmark_check(ctx->label, OP_RECVMSG, AA_MAY_RECEIVE,
>  				      skb->secmark, sk);
>  }
> +#endif
>  
>  
>  static struct aa_label *sk_peer_label(struct sock *sk)
> @@ -1235,6 +1237,7 @@ static void apparmor_sock_graft(struct sock *sk, struct socket *parent)
>  		ctx->label = aa_get_current_label();
>  }
>  
> +#ifdef CONFIG_NETWORK_SECMARK
>  static int apparmor_inet_conn_request(struct sock *sk, struct sk_buff *skb,
>  				      struct request_sock *req)
>  {
> @@ -1246,6 +1249,7 @@ static int apparmor_inet_conn_request(struct sock *sk, struct sk_buff *skb,
>  	return apparmor_secmark_check(ctx->label, OP_CONNECT, AA_MAY_CONNECT,
>  				      skb->secmark, sk);
>  }
> +#endif
>  
>  static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
> @@ -1304,13 +1308,17 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(socket_getsockopt, apparmor_socket_getsockopt),
>  	LSM_HOOK_INIT(socket_setsockopt, apparmor_socket_setsockopt),
>  	LSM_HOOK_INIT(socket_shutdown, apparmor_socket_shutdown),
> +#ifdef CONFIG_NETWORK_SECMARK
>  	LSM_HOOK_INIT(socket_sock_rcv_skb, apparmor_socket_sock_rcv_skb),
> +#endif
>  	LSM_HOOK_INIT(socket_getpeersec_stream,
>  		      apparmor_socket_getpeersec_stream),
>  	LSM_HOOK_INIT(socket_getpeersec_dgram,
>  		      apparmor_socket_getpeersec_dgram),
>  	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
> +#ifdef CONFIG_NETWORK_SECMARK
>  	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
> +#endif
>  
>  	LSM_HOOK_INIT(cred_alloc_blank, apparmor_cred_alloc_blank),
>  	LSM_HOOK_INIT(cred_free, apparmor_cred_free),
> @@ -1666,6 +1674,7 @@ static inline int apparmor_init_sysctl(void)
>  }
>  #endif /* CONFIG_SYSCTL */
>  
> +#if defined(CONFIG_NETFILTER) && defined(CONFIG_NETWORK_SECMARK)
>  static unsigned int apparmor_ip_postroute(void *priv,
>  					  struct sk_buff *skb,
>  					  const struct nf_hook_state *state)
> @@ -1754,6 +1763,7 @@ static int __init apparmor_nf_ip_init(void)
>  	return 0;
>  }
>  __initcall(apparmor_nf_ip_init);
> +#endif
>  
>  static int __init apparmor_init(void)
>  {
> diff --git a/security/apparmor/net.c b/security/apparmor/net.c
> index f9a678ce994f..c07fde444792 100644
> --- a/security/apparmor/net.c
> +++ b/security/apparmor/net.c
> @@ -190,6 +190,7 @@ int aa_sock_file_perm(struct aa_label *label, const char *op, u32 request,
>  	return aa_label_sk_perm(label, op, request, sock->sk);
>  }
>  
> +#ifdef CONFIG_NETWORK_SECMARK
>  static int apparmor_secmark_init(struct aa_secmark *secmark)
>  {
>  	struct aa_label *label;
> @@ -254,3 +255,4 @@ int apparmor_secmark_check(struct aa_label *label, char *op, u32 request,
>  				    aa_secmark_perm(profile, request, secid,
>  						    &sa, sk));
>  }
> +#endif
> 

