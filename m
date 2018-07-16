Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B03ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D53F208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gd+E/uBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D53F208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbeGPSx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:53:28 -0400
Received: from sonic306-26.consmr.mail.gq1.yahoo.com ([98.137.68.89]:42305
        "EHLO sonic306-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729883AbeGPSx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1531765490; bh=Dd4m7Xq0qH0NeT2lJZsd5AZOWVtJDyfeo3g6Gq2Cuc0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=gd+E/uBV1eg5eWkMtVfzlpeNpjsQCD8BuFL+uAo/TbBvsGG4j4xwFE5jY1keAvrCZ/s2Wcy0UJM2XG3R/8rK1e5n4lNlwP+/OBKsA94sJgtVDhncyGDiWWS9HPllR2p0jUWqN6MASfNU6KznZs3JEzahrVk3cfGZTemsWJGMlyDLo84z1ZC1RvWieo9cnFURTYUmMe/HaeA65r6lNYmW4gMfb4VLQWt46d2O3jktgqlQfCX26u/zd9Fj04AReAqeRq6zwFZHIzgpb9L+M5mdjINOnNgmjAaVdqkv6iAlsqJU26iRU+cEMA91KGQHIJE1MTI5LtG6K522kqjn40GGqA==
X-YMail-OSG: 3YshZicVM1mvhk2AHtAblXx56pYzM8YQqCdjIKIXyIze.3169KQYTvtykSRqLNd
 S28EKqAalTTFgy0CzZoM4EL0TQrZ8hXIWjwl5HG8x87Efw0awDAtQM_a6PwVEqD56J04JoxVP5Vl
 rGDe_CbzYeWpJzRtF2wRrOLbw6spMj3nkW314aaTD3bmSD1zGxjwIEu.nt.AoMFkhTHv12UrO5Z6
 ncTpWAW0NQK82YLJxp69WN_S2C3I.7Bvxxm.uiwyhAx5bOeTSrAsL1XAA4r.KANkkLYVqkJ7TquB
 vOKJ8oBwejTQoCE9DHRLdOHCDCOJ_BUvI0XcYNT41oETJnAcbqE_oz7.YuEIO8B6NQCb1lzbcFY6
 4Sc7ycxxnjAT95xtKvZ1SZVo3nIwFpp22YqEj_7QZ1uDVY.PGkvYM7hWmol9IadDEGN8YZxXHLpu
 0fU2EqJJv1tIjhZpAyBkcXxGwjsBGWsWNPWKaSqxPgdR72ZatXUTJQ3kgKzIV7AIRdBwU7Tcmkws
 oFj.KXpv3R._2UIBQ0V0JPAm0W6mJMn1RJMVulEBdkBHacqKUMfAbtCcFR8trmW8RE8bDLD7tZPg
 CDwklTBxfOUdkl_c2sXz78R6ob4CwkbUdM97A4NWd9wah5ZjGaFNXJrELb2uZNPTs.c6peN8Hhnw
 ccMTWhYCK0dqI8X1tSJeE1SZVQ17n7t92KvM2V0RPDbKOMZz1X95K9qWeArcoFWQ1d8GBNMRtbvy
 4Z7X5qu1OLZBJRpXiR0QyFFyxEBlpxuvtYCW5GLKvtleuq99zYln.UDGMhJNfP1Ts4_7JO5w_u7M
 Nvjb.HdEYz5U84KWYW4tErNWYByYw.fBmqECJGRmG8yjqITY.tdDEK7AvESKornXuSirvNO0Q8N4
 euZ4Qy3kV.s1SO5mYvRmmtspfIugULTefGB_UTKK8Sy.P83qMrN4LaWTpxwfqGCVBbUtxNOsKIVG
 QX2vMfSN5.xHHlw9rhof_zKnTAvUDQ2e.T9h0K2qQlsLBIe34iPQmU2mvc7dmjgqC5z3m3Bx0px1
 G_AszodxWpdV62LAejr0pWI8cn2JVJBI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Mon, 16 Jul 2018 18:24:50 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp410.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f8ec6a604de8f167c8cb3f4cf8695d7d;
          Mon, 16 Jul 2018 18:24:45 +0000 (UTC)
Subject: [PATCH v1 20/22] Move common usercopy into security_getpeersec_stream
To:     LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
Cc:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ac4a4408-5c69-4b87-b57d-537dba588b18@schaufler-ca.com>
Date:   Mon, 16 Jul 2018 11:24:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 20/22] Move common usercopy into security_getpeersec_stream

The modules implementing hook for getpeersec_stream
don't need to be duplicating the copy-to-user checks.
Moving the user copy part into the infrastructure makes
the security module code simpler and reduces the places
where user copy code may go awry.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 10 ++++------
 include/linux/security.h   |  6 ++++--
 security/apparmor/lsm.c    | 28 ++++++++++------------------
 security/security.c        | 17 +++++++++++++++--
 security/selinux/hooks.c   | 22 +++++++---------------
 security/smack/smack_lsm.c | 19 ++++++++-----------
 6 files changed, 48 insertions(+), 54 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7c321d11d994..8d247e7ce2fb 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -846,9 +846,8 @@
  *	SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
  *	socket is associated with an ipsec SA.
  *	@sock is the local socket.
- *	@optval userspace memory where the security state is to be copied.
- *	@optlen userspace int where the module should copy the actual length
- *	of the security state.
+ *	@optval the security state.
+ *	@optlen the actual length of the security state.
  *	@len as input is the maximum length to copy to userspace provided
  *	by the caller.
  *	Return 0 if all is well, otherwise, typical getsockopt return
@@ -1680,9 +1679,8 @@ union security_list_options {
 	int (*socket_setsockopt)(struct socket *sock, int level, int optname);
 	int (*socket_shutdown)(struct socket *sock, int how);
 	int (*socket_sock_rcv_skb)(struct sock *sk, struct sk_buff *skb);
-	int (*socket_getpeersec_stream)(struct socket *sock,
-					char __user *optval,
-					int __user *optlen, unsigned int len);
+	int (*socket_getpeersec_stream)(struct socket *sock, char **optval,
+					int *optlen, unsigned int len);
 	int (*socket_getpeersec_dgram)(struct socket *sock,
 					struct sk_buff *skb,
 					struct secids *secid);
diff --git a/include/linux/security.h b/include/linux/security.h
index 9095f63c65a9..7d3300d34f25 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1377,8 +1377,10 @@ static inline int security_sock_rcv_skb(struct sock *sk,
 	return 0;
 }
 
-static inline int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-						    int __user *optlen, unsigned len)
+static inline int security_socket_getpeersec_stream(struct socket *sock,
+						    char __user *optval,
+						    int __user *optlen,
+						    unsigned int len)
 {
 	return -ENOPROTOOPT;
 }
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index b0200481c811..7a2a8d0efa09 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1026,10 +1026,8 @@ static struct aa_label *sk_peer_label(struct sock *sk)
  *
  * Note: for tcp only valid if using ipsec or cipso on lan
  */
-static int apparmor_socket_getpeersec_stream(struct socket *sock,
-					     char __user *optval,
-					     int __user *optlen,
-					     unsigned int len)
+static int apparmor_socket_getpeersec_stream(struct socket *sock, char **optval,
+					     int *optlen, unsigned int len)
 {
 	char *name;
 	int slen, error = 0;
@@ -1046,22 +1044,16 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
 				 FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
 				 FLAG_HIDDEN_UNCONFINED, GFP_KERNEL);
 	/* don't include terminating \0 in slen, it breaks some apps */
-	if (slen < 0) {
+	if (slen < 0)
 		error = -ENOMEM;
-	} else {
-		if (slen > len) {
-			error = -ERANGE;
-		} else if (copy_to_user(optval, name, slen)) {
-			error = -EFAULT;
-			goto out;
-		}
-		if (put_user(slen, optlen))
-			error = -EFAULT;
-out:
-		kfree(name);
-
+	else if (slen > len)
+		error = -ERANGE;
+	else {
+		*optlen = slen;
+		*optval = name;
 	}
-
+	if (error)
+		kfree(name);
 done:
 	end_current_label_crit_section(label);
 
diff --git a/security/security.c b/security/security.c
index 90e741db0a42..521afa12293e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1930,8 +1930,21 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
-				optval, optlen, len);
+	char *tval = NULL;
+	u32 tlen;
+	int rc;
+
+	rc = call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
+			   &tval, &tlen, len);
+	if (rc == 0) {
+		tlen = strlen(tval) + 1;
+		if (put_user(tlen, optlen))
+			rc = -EFAULT;
+		else if (copy_to_user(optval, tval, tlen))
+			rc = -EFAULT;
+		kfree(tval);
+	}
+	return rc;
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c12c36f72258..6614d46feac4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4986,10 +4986,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	return err;
 }
 
-static int selinux_socket_getpeersec_stream(struct socket *sock,
-					    __user char *optval,
-					    __user int *optlen,
-					    unsigned int len)
+static int selinux_socket_getpeersec_stream(struct socket *sock, char **optval,
+					    int *optlen, unsigned int len)
 {
 	int err = 0;
 	char *scontext;
@@ -5010,18 +5008,12 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
 		return err;
 
 	if (scontext_len > len) {
-		err = -ERANGE;
-		goto out_len;
+		kfree(scontext);
+		return -ERANGE;
 	}
-
-	if (copy_to_user(optval, scontext, scontext_len))
-		err = -EFAULT;
-
-out_len:
-	if (put_user(scontext_len, optlen))
-		err = -EFAULT;
-	kfree(scontext);
-	return err;
+	*optval = scontext;
+	*optlen = scontext_len;
+	return 0;
 }
 
 static int selinux_socket_getpeersec_dgram(struct socket *sock,
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 157c6a731305..d4552b2286bc 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3895,14 +3895,12 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
  *
  * returns zero on success, an error code otherwise
  */
-static int smack_socket_getpeersec_stream(struct socket *sock,
-					  char __user *optval,
-					  int __user *optlen, unsigned len)
+static int smack_socket_getpeersec_stream(struct socket *sock, char **optval,
+					  int *optlen, unsigned int len)
 {
 	struct socket_smack *ssp;
 	char *rcp = "";
 	int slen = 1;
-	int rc = 0;
 
 	ssp = smack_sock(sock->sk);
 	if (ssp->smk_packet != NULL) {
@@ -3911,14 +3909,13 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
 	}
 
 	if (slen > len)
-		rc = -ERANGE;
-	else if (copy_to_user(optval, rcp, slen) != 0)
-		rc = -EFAULT;
-
-	if (put_user(slen, optlen) != 0)
-		rc = -EFAULT;
+		return -ERANGE;
 
-	return rc;
+	*optval = kstrdup(rcp, GFP_ATOMIC);
+	if (*optval == NULL)
+		return -ENOMEM;
+	*optlen = slen;
+	return 0;
 }
 
 
-- 
2.17.1


