Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1404550-1523021323-2-2863320716964226776
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021322; b=Q3blu+3KfR7Psp2Bpat8qW88f5wEump3Sz5A86+Si2exroU+to
    PfOTNkBDXxYaQBhY5wcpnWtC90KM1ypx9m0vdeMbba5DXFVXI2MgYCX9vK5gey80
    vSEJ3fbrd0UXauYdRwUvb0nXEMr60ebQo3P4inQMgkl7VBHOvcUMy7RoVB0lXJTa
    kOvM6LEELDtW67VR9KpT3d9rFGf2RRCcCINuGCP4BBcpVMp5oEC5oDZoWshZFgUr
    7AaHvbuEBawYulTXpRxm6c8Lq0cjXddo8jfALPA3Qbaool/ockXggRS2vs9KwtkG
    GGnRyZHPWUsXQsJQeQnHER6mhDJvDbCstdnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021322; bh=6QsDDenkWFmcXZsm1BaU6NiHYNMYyR
    M9wN7ALl04KeY=; b=aW2+z+6zrj0ZVgpae72XZq/gk4fc4cQxwD8hye7vZWpGUQ
    CkxqRQur+lahPnLBEHLGkFDFDqz+pT96ZlgXybpoFeoCUk88PY2Q9YU4Feg2XVf2
    hb+JBw+Yv60y6eQLxPKsQmCG3AJaR4p65tiYsVuIKlkFMVd6HHRsDuVK0w8h49l2
    i3w+O6Ab8KdyQVtv3JYK5IgK/1sVW3XeQSgxpWseSuBUusKQSDWsoKXklSmWT/vJ
    Rg+gjeH3FvuQxCLjL6eT66wNfx4TE70AXYbzSwosvGqS0lDzJzAnNRdVFt2I4xgM
    erve5AzFfWE9bYaheNalG4PmEWrmBuPdyvNOc+Bw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKUpfh9pIMUOhTvG0H1hlgPVynaVam6SDePDI9LZx5ovXtEObvg0Si1ac+aVZJc1Aaimzg5WFeGxJh1NC7P/ivXeBV7HyJd8ErtASyvRy2YZeiQDlp9U
    4kiQbQcPNqg6xhgB3PbHCsPzj7f5Knryi8zBRonUIZJ6gMUiBi0uqKM6wjV1RgTOqQki+b/BeAV/C0bRDiFB4Vm4C8sVNtr/dw0rby7dz//q3XzBU4CLJYKj
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8 a=3HDBlxybAAAA:8 a=ag1SF4gXAAAA:8
    a=n48M2zEUs-cqSXvTnrEA:9 a=byKTLy9JJB1jI3FB:21 a=J8Cl51E-iIvRTv23:21
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=laEoCiVfU_Unz3mSdgXN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754440AbeDFN2k (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:28:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55428 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752755AbeDFN2h (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:28:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot+0502b00edac2a0680b61@syzkaller.appspotmail.com,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 3.18 54/93] netfilter: x_tables: add and use xt_check_proc_name
Date: Fri,  6 Apr 2018 15:23:23 +0200
Message-Id: <20180406084227.270123514@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit b1d0a5d0cba4597c0394997b2d5fced3e3841b4e upstream.

recent and hashlimit both create /proc files, but only check that
name is 0 terminated.

This can trigger WARN() from procfs when name is "" or "/".
Add helper for this and then use it for both.

Cc: Eric Dumazet <eric.dumazet@gmail.com>
Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Reported-by: <syzbot+0502b00edac2a0680b61@syzkaller.appspotmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/netfilter/x_tables.h |    2 ++
 net/netfilter/x_tables.c           |   30 ++++++++++++++++++++++++++++++
 net/netfilter/xt_hashlimit.c       |    5 +++--
 net/netfilter/xt_recent.c          |    6 +++---
 4 files changed, 38 insertions(+), 5 deletions(-)

--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -247,6 +247,8 @@ unsigned int *xt_alloc_entry_offsets(uns
 bool xt_find_jump_offset(const unsigned int *offsets,
 			 unsigned int target, unsigned int size);
 
+int xt_check_proc_name(const char *name, unsigned int size);
+
 int xt_check_match(struct xt_mtchk_param *, unsigned int size, u_int8_t proto,
 		   bool inv_proto);
 int xt_check_target(struct xt_tgchk_param *, unsigned int size, u_int8_t proto,
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -367,6 +367,36 @@ textify_hooks(char *buf, size_t size, un
 	return buf;
 }
 
+/**
+ * xt_check_proc_name - check that name is suitable for /proc file creation
+ *
+ * @name: file name candidate
+ * @size: length of buffer
+ *
+ * some x_tables modules wish to create a file in /proc.
+ * This function makes sure that the name is suitable for this
+ * purpose, it checks that name is NUL terminated and isn't a 'special'
+ * name, like "..".
+ *
+ * returns negative number on error or 0 if name is useable.
+ */
+int xt_check_proc_name(const char *name, unsigned int size)
+{
+	if (name[0] == '\0')
+		return -EINVAL;
+
+	if (strnlen(name, size) == size)
+		return -ENAMETOOLONG;
+
+	if (strcmp(name, ".") == 0 ||
+	    strcmp(name, "..") == 0 ||
+	    strchr(name, '/'))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(xt_check_proc_name);
+
 int xt_check_match(struct xt_mtchk_param *par,
 		   unsigned int size, u_int8_t proto, bool inv_proto)
 {
--- a/net/netfilter/xt_hashlimit.c
+++ b/net/netfilter/xt_hashlimit.c
@@ -668,8 +668,9 @@ static int hashlimit_mt_check(const stru
 
 	if (info->cfg.gc_interval == 0 || info->cfg.expire == 0)
 		return -EINVAL;
-	if (info->name[sizeof(info->name)-1] != '\0')
-		return -EINVAL;
+	ret = xt_check_proc_name(info->name, sizeof(info->name));
+	if (ret)
+		return ret;
 	if (par->family == NFPROTO_IPV4) {
 		if (info->cfg.srcmask > 32 || info->cfg.dstmask > 32)
 			return -EINVAL;
--- a/net/netfilter/xt_recent.c
+++ b/net/netfilter/xt_recent.c
@@ -355,9 +355,9 @@ static int recent_mt_check(const struct
 			info->hit_count, ip_pkt_list_tot);
 		return -EINVAL;
 	}
-	if (info->name[0] == '\0' ||
-	    strnlen(info->name, XT_RECENT_NAME_LEN) == XT_RECENT_NAME_LEN)
-		return -EINVAL;
+	ret = xt_check_proc_name(info->name, sizeof(info->name));
+	if (ret)
+		return ret;
 
 	mutex_lock(&recent_mutex);
 	t = recent_table_lookup(recent_net, info->name);
