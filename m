Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4B9C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E8A20834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E8A20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeJEXLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:11:38 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:60597 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbeJEXLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:11:38 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MYNeM-1gCQyQ3his-00VLdR; Fri, 05 Oct 2018 18:12:08 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MYNeM-1gCQyQ3his-00VLdR; Fri, 05 Oct 2018 18:12:08 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: add #ifdef checks for secmark filtering
Date:   Fri,  5 Oct 2018 18:11:47 +0200
Message-Id: <20181005161206.727098-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:M0zCqPWFVcOcannDUuDOwgjJPuoxDACZDZgPCSEac5NqWsHTsnQ
 5cLvwEfc5dqqDCJn+KUuBx+2+8hR1QKx1VuPDioqGjr8bSlSLsbM/pkw4baQpJDsvQx0ObM
 nV9Bn4Efv8DDhQUjHASr5FUqSA+GiPf2Zd3RnUMeM7x0ee0j4G1/ZoeRSYbjb2Ftx70Y4Y9
 MnUX3MshiavQME6bJystA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/ulGstPc9Ak=:VvsvVRm7tiz75wDNKFPRbH
 Rad4logNWV8ZYqjG4jOCO69Aurf5F/stq6D3myd5dNsHoOLBWHxTTfhXicYzQGEUD4A3YHicI
 V1k0mQEbZm1NDUkz6phGW8nImYcQ+RISegp7d/pD/aR9n/Iv83wY9+KMYvz2992uHvr1D9soz
 1jYI36qt5qj0dbHFW2qAq75V2hwfHe6W5It9g00BWHL1d3ryj6PRGpbAIZgXOBo2YsQ/wJkVB
 FgAyffDg23wfLXSb0D60U0eD0t6f09qeIquH6OFfiTvT9OpykEpouB8zUHiGS/wbdhxdZC+Z5
 BeVpOggUNf/U2aNiD4h3EtdKOwrmsJLSmR83cyEfDtWP2ZrIT1S+fTxzx5uDti8QkY7zb4SEq
 cP43FHQ45QX4cArg/JmSzjS0rNUy9elvwT8DIDRFf2zFnjm/UoQVHy3DrBQKearOoLDv4Y/nw
 6dbYOofXle7sLWNQVStUVZdpoMmCprAjlon4tgmo59Dq/k5ev4tGfAfyq8YWSbtEAYkKyG0BL
 z2pxpmSBXfKTNkpQhNnootn6R3v2lmTKEmgdj0rHs+t16HfQGXDOr79dXTHq8wAFwLeofxjEe
 wwhCooD/tFfH6XgUM6jJvZCQzjrDui5UrMYr7aNgbBD2r3GlWAWp+1Hg6taU5FPAPL7WhjhGk
 Q6Yr0vvUMVeh5qKgM0HnLmyq3bLgjHuhGvZTHbZ+c0ZkuZqKQLCJDfgxqeZQe/N824cM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added code fails to build when either SECMARK or
NETFILTER are disabled:

security/apparmor/lsm.c: In function 'apparmor_socket_sock_rcv_skb':
security/apparmor/lsm.c:1138:12: error: 'struct sk_buff' has no member named 'secmark'; did you mean 'mark'?

security/apparmor/lsm.c:1671:21: error: 'struct nf_hook_state' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]

Add a set of #ifdef checks around it to only enable the code that
we can compile and that makes sense in that configuration.

Fixes: ab9f2115081a ("apparmor: Allow filtering based on secmark policy")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/apparmor/lsm.c | 10 ++++++++++
 security/apparmor/net.c |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 53201013c40e..b74b724d3e84 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1123,6 +1123,7 @@ static int apparmor_socket_shutdown(struct socket *sock, int how)
 	return aa_sock_perm(OP_SHUTDOWN, AA_MAY_SHUTDOWN, sock);
 }
 
+#ifdef CONFIG_NETWORK_SECMARK
 /**
  * apparmor_socket_sock_recv_skb - check perms before associating skb to sk
  *
@@ -1141,6 +1142,7 @@ static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	return apparmor_secmark_check(ctx->label, OP_RECVMSG, AA_MAY_RECEIVE,
 				      skb->secmark, sk);
 }
+#endif
 
 
 static struct aa_label *sk_peer_label(struct sock *sk)
@@ -1235,6 +1237,7 @@ static void apparmor_sock_graft(struct sock *sk, struct socket *parent)
 		ctx->label = aa_get_current_label();
 }
 
+#ifdef CONFIG_NETWORK_SECMARK
 static int apparmor_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 				      struct request_sock *req)
 {
@@ -1246,6 +1249,7 @@ static int apparmor_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	return apparmor_secmark_check(ctx->label, OP_CONNECT, AA_MAY_CONNECT,
 				      skb->secmark, sk);
 }
+#endif
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
@@ -1304,13 +1308,17 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(socket_getsockopt, apparmor_socket_getsockopt),
 	LSM_HOOK_INIT(socket_setsockopt, apparmor_socket_setsockopt),
 	LSM_HOOK_INIT(socket_shutdown, apparmor_socket_shutdown),
+#ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(socket_sock_rcv_skb, apparmor_socket_sock_rcv_skb),
+#endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
 	LSM_HOOK_INIT(socket_getpeersec_dgram,
 		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
+#ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
+#endif
 
 	LSM_HOOK_INIT(cred_alloc_blank, apparmor_cred_alloc_blank),
 	LSM_HOOK_INIT(cred_free, apparmor_cred_free),
@@ -1666,6 +1674,7 @@ static inline int apparmor_init_sysctl(void)
 }
 #endif /* CONFIG_SYSCTL */
 
+#if defined(CONFIG_NETFILTER) && defined(CONFIG_NETWORK_SECMARK)
 static unsigned int apparmor_ip_postroute(void *priv,
 					  struct sk_buff *skb,
 					  const struct nf_hook_state *state)
@@ -1754,6 +1763,7 @@ static int __init apparmor_nf_ip_init(void)
 	return 0;
 }
 __initcall(apparmor_nf_ip_init);
+#endif
 
 static int __init apparmor_init(void)
 {
diff --git a/security/apparmor/net.c b/security/apparmor/net.c
index f9a678ce994f..c07fde444792 100644
--- a/security/apparmor/net.c
+++ b/security/apparmor/net.c
@@ -190,6 +190,7 @@ int aa_sock_file_perm(struct aa_label *label, const char *op, u32 request,
 	return aa_label_sk_perm(label, op, request, sock->sk);
 }
 
+#ifdef CONFIG_NETWORK_SECMARK
 static int apparmor_secmark_init(struct aa_secmark *secmark)
 {
 	struct aa_label *label;
@@ -254,3 +255,4 @@ int apparmor_secmark_check(struct aa_label *label, char *op, u32 request,
 				    aa_secmark_perm(profile, request, secid,
 						    &sa, sk));
 }
+#endif
-- 
2.18.0

