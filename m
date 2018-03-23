Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521807180-2-3476119111910796367
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521807178; b=bOEREqfzBUT/0M/nf5dGJwLVo4KsQmDz16nzjaXsBipBrNP
    HrTZ+XgWY1PN5o1HnhAY76IDtEsPU/Xu+AEO86NZ0NqkCV8BA0gKoaAvolmNu85s
    wzrIDEtLfec6zxXyip+/4QZKwKLApyOsDaarIyIcrngckNXDuuxkbjWyxoVE9JeH
    snWKsHoTRMG8m8z8gOP/A2d5H2AClp2gGKFlxTSq7P0ytDAu1mBOLUSQWg0OvkcP
    bkCTigT6E8rXsmboDLNEfavc6k1wpRzFriQVeTfAAULUSYmpju9MQq+biCOE/Bs2
    iiKRoD70cvv0f0RWw14l3IErRD68fxH8WMHOCPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807178; bh=HIE6VHq7llc+V9eF5AVFsUTamW
    eeQTCFiPH4eR7Gqyc=; b=K5nob4Z9eqfjAr41uYcNGnEukx0uyu/qAMruEWdwZq
    bm2e7LVNM4HhOmAwfiJglS71kOnmSwgDlunM10TjNZPV5camzKC2He1XFEuoIE2D
    I0tohlG+zHO697HnmTGFptgpQhvckrwaEjqAnt1IXeJyxjPNsA+qDmvEFSEdzrQo
    Amgc7QXrhfRVPBrGVy+2Y3m8Iv1JCQULxx/Dg5Lxw6nlSbN2eVlJe+8hEh4Kacvl
    1D6oHo8NPp8TkgIqIrfbMtQsSqG/5MfrOSRqH939iDTgzxfDB1Ec9EGqPwbFPGV9
    hjxYZy6ybzgPOd6OCiBRfxq31hUfxPNfc17BefSliAtA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbeCWMMl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 08:12:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34868 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeCWJ51 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:57:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        David Ahern <dsahern@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 16/84] libbpf: prefer global symbols as bpf program name source
Date: Fri, 23 Mar 2018 10:53:30 +0100
Message-Id: <20180323095414.374570704@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Gushchin <guro@fb.com>


[ Upstream commit fe4d44b23f6b38194a92c6b8a50d921a071c4db4 ]

Libbpf picks the name of the first symbol in the corresponding
elf section to use as a program name. But without taking symbol's
scope into account it may end's up with some local label
as a program name. E.g.:

$ bpftool prog
1: type 15  name LBB0_10    tag 0390a5136ba23f5c
	loaded_at Dec 07/17:22  uid 0
	xlated 456B  not jited  memlock 4096B

Fix this by preferring global symbols as program name.

For instance:
$ bpftool prog
1: type 15  name bpf_prog1  tag 0390a5136ba23f5c
	loaded_at Dec 07/17:26  uid 0
	xlated 456B  not jited  memlock 4096B

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: David Ahern <dsahern@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/lib/bpf/libbpf.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -387,6 +387,8 @@ bpf_object__init_prog_names(struct bpf_o
 				continue;
 			if (sym.st_shndx != prog->idx)
 				continue;
+			if (GELF_ST_BIND(sym.st_info) != STB_GLOBAL)
+				continue;
 
 			name = elf_strptr(obj->efile.elf,
 					  obj->efile.strtabidx,
