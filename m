Return-Path: <kernel-hardening-return-12485-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELstPe0Z2OQBJYd+pCXv58MTkgYikaLFJRUhf+Mrb0DvJu0aA19wEMZZHXP9x1jurp+Zr78a
ARC-Seal: i=1; a=rsa-sha256; t=1520900518; cv=none;
        d=google.com; s=arc-20160816;
        b=Li6J1hfuGaeUJFLRaNGjmY1OtySIAH64HldwBKqdufdShCdSNioBrfLkvImGWjwtm4
         1I8KXVPE/Kl2foOG1W22xtEYDFl5ZVnzFS7hJ55lcNV8wJpmLxf7ayg64XbtyE22aflk
         HcYbD9bbGsd2xqfw7SNyEACi88BsWnYNzhFjaKT6I2A1DozBkzy8oE9DDrlV0C5iczWN
         6JFV2ZvsQwhT6BT0PJ+waunvhiEhDuGe4pVFfrglpqe0FKF/lM11nh9cDOPN9OsMSDIu
         sri7zs/nZ+ln6ckHwRiHPiBhm2Gvwmu5leRwUAHX7k7IHfi2xeEZVp/WavM5X1XTnMG9
         6vEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=MC17LRbC+luVboVXLPjGy2S4YfEjJzugPYdIj09wPvw=;
        b=EpCp9H/joYYKkFkwwL5WNk1DNAg/AZR3qm3ADwuC6Q8WA2WUz/fdWVtPs+2sMim2Ft
         UjT1e4qduR1APhF8hTU+bCsyThYZFOuEr/YrbLEJ/NmkdzSWmz/KlVFPSjbWoGIxW5qf
         nXH+vYc/cef49qqNWrfgdyzqcqE8SZMVX1UD+dxnHCIf6Jp2yrMsmckIWfUcG89fJKFH
         ESeZAkblPW6+Xy9Om9Sj469uC3/xjQy2PCL9FOQP1I7m6BbAdvKea8eJY84LQBjCkYUR
         VRII3dpXIi5LArZg7PY4P2swjUlH3kUHz1L8iCZM+luEbHFvnT0rl4PTSbwoAqY7bj5t
         s8Mw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12485-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12485-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12485-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12485-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 12 Mar 2018 19:21:38 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] netfilter: nfnetlink_cthelper: Remove VLA usage
Message-ID: <20180313002138.GA27280@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.openwall.com
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1evXhD-000Ykc-8U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:46642
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594779782164059647?=
X-GMAIL-MSGID: =?utf-8?q?1594779782164059647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation to enabling -Wvla, remove VLA and replace it
with dynamic memory allocation.

>From a security viewpoint, the use of Variable Length Arrays can be
a vector for stack overflow attacks. Also, in general, as the code
evolves it is easy to lose track of how big a VLA can get. Thus, we
can end up having segfaults that are hard to debug.

Also, fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/netfilter/nfnetlink_cthelper.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/netfilter/nfnetlink_cthelper.c b/net/netfilter/nfnetlink_cthelper.c
index d33ce6d..4a4b293 100644
--- a/net/netfilter/nfnetlink_cthelper.c
+++ b/net/netfilter/nfnetlink_cthelper.c
@@ -314,23 +314,30 @@ nfnl_cthelper_update_policy_one(const struct nf_conntrack_expect_policy *policy,
 static int nfnl_cthelper_update_policy_all(struct nlattr *tb[],
 					   struct nf_conntrack_helper *helper)
 {
-	struct nf_conntrack_expect_policy new_policy[helper->expect_class_max + 1];
+	struct nf_conntrack_expect_policy *new_policy;
 	struct nf_conntrack_expect_policy *policy;
-	int i, err;
+	int i, ret = 0;
+
+	new_policy = kmalloc_array(helper->expect_class_max + 1,
+				   sizeof(*new_policy), GFP_KERNEL);
+	if (!new_policy)
+		return -ENOMEM;
 
 	/* Check first that all policy attributes are well-formed, so we don't
 	 * leave things in inconsistent state on errors.
 	 */
 	for (i = 0; i < helper->expect_class_max + 1; i++) {
 
-		if (!tb[NFCTH_POLICY_SET + i])
-			return -EINVAL;
+		if (!tb[NFCTH_POLICY_SET + i]) {
+			ret = -EINVAL;
+			goto err;
+		}
 
-		err = nfnl_cthelper_update_policy_one(&helper->expect_policy[i],
+		ret = nfnl_cthelper_update_policy_one(&helper->expect_policy[i],
 						      &new_policy[i],
 						      tb[NFCTH_POLICY_SET + i]);
-		if (err < 0)
-			return err;
+		if (ret < 0)
+			goto err;
 	}
 	/* Now we can safely update them. */
 	for (i = 0; i < helper->expect_class_max + 1; i++) {
@@ -340,7 +347,9 @@ static int nfnl_cthelper_update_policy_all(struct nlattr *tb[],
 		policy->timeout	= new_policy->timeout;
 	}
 
-	return 0;
+err:
+	kfree(new_policy);
+	return ret;
 }
 
 static int nfnl_cthelper_update_policy(struct nf_conntrack_helper *helper,
-- 
2.7.4
