Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-558212-1524653633-2-1963478073508800919
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653633; b=S0sVDV8cCE8PYqnA9TO1zd8QlnaHU6dlG4RJNLR/w3Wdk4EUON
    iWonW5XK+i/x1GOWiVrnYrM0w5DqJRN08nvOAtlrktXy+vCPVt4UnDhF729ZZXh2
    UwQhK2CKL9gjEVLeguzcw92P3oRBfvqIMHVj3ohSApHMUYMNxiA2u3BayRe8t9XB
    F5EI1CXlW5XbtElK2HiVQESjzHrvblnSTpNQI4stkQg+dfC/Fs4e+obTwgDP4GBd
    06X32qGlyyR0QmjxFcuGoHDMtatxmCy7e+rEekbjwCK7Y/M+E8s7neZNBjGnTx9s
    VL8+M/M6BMC1DF8g2sXEnw0LEPRluJ9odbTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653633; bh=d2TmqYvAPuGaqp7SIJLzfa3fPmRyst
    VfbypmJ6pPoic=; b=iJkdU5zTSzM3t4kd2UXtARPTewcT5gHUbYiQz9B0rC9Afs
    FOYuuVDENPXm851rd6GJlymo10r8pvIKqgpq7TP2fb3RtXo5AGNvRZ1Oit1osATT
    qXkaLRzyI29pBUWgwSDD+NLNsLP7hwoEXHsvmXgSy7Eq21m3cfp4a3RhJ7eDn+uz
    YPjJyJjj08S/rl1XE+nKrrhJ3gcx0NzZVM0lwni/jgvgUMmSqG0cjid6mf3cfSqQ
    Jm3/aU0xhI6ynxArgG2MWqedAzAGugZF/NI/6lrZwbDV6H+OsIGflHz7VM4MsN7J
    EUTrdpM5n45nPTcqGnvc6DUeVtpGmN2GQg0c3pWw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfOfwxu+ZROs+AuB96kjGGaX7dXW27KgEyDTy3+Ck5i/Dla753E/sJvwXqaEuQDVibl60h2VhvN8RvTTdU5kzL1bNeUdFh8sD3xTwqxyAvOMoJcLdsNsy
    csC44vj6CPwuVbijhtqC8L134tLPloylIywgJSz3WOryuTgYhM61H3XCtea0l3VP7tCLBrsn8IckDNhTGzJjOWkEHayo6Sr29gM9ZJtD4Q5wwHCBpZnHD6Jk
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=hWMQpYRtAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=hT20bRyzTuZkxee3I38A:9 a=QEXdDO2ut3YA:10 a=KCsI-UfzjElwHeZNREa_:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754243AbeDYKnp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:43:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53096 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753921AbeDYKnl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:43:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 156/183] tools/libbpf: handle issues with bpf ELF objects containing .eh_frames
Date: Wed, 25 Apr 2018 12:36:16 +0200
Message-Id: <20180425103248.808956475@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesper Dangaard Brouer <brouer@redhat.com>


[ Upstream commit e3d91b0ca523d53158f435a3e13df7f0cb360ea2 ]

V3: More generic skipping of relo-section (suggested by Daniel)

If clang >= 4.0.1 is missing the option '-target bpf', it will cause
llc/llvm to create two ELF sections for "Exception Frames", with
section names '.eh_frame' and '.rel.eh_frame'.

The BPF ELF loader library libbpf fails when loading files with these
sections.  The other in-kernel BPF ELF loader in samples/bpf/bpf_load.c,
handle this gracefully. And iproute2 loader also seems to work with these
"eh" sections.

The issue in libbpf is caused by bpf_object__elf_collect() skipping
some sections, and later when performing relocation it will be
pointing to a skipped section, as these sections cannot be found by
bpf_object__find_prog_by_idx() in bpf_object__collect_reloc().

This is a general issue that also occurs for other sections, like
debug sections which are also skipped and can have relo section.

As suggested by Daniel.  To avoid keeping state about all skipped
sections, instead perform a direct qlookup in the ELF object.  Lookup
the section that the relo-section points to and check if it contains
executable machine instructions (denoted by the sh_flags
SHF_EXECINSTR).  Use this check to also skip irrelevant relo-sections.

Note, for samples/bpf/ the '-target bpf' parameter to clang cannot be used
due to incompatibility with asm embedded headers, that some of the samples
include. This is explained in more details by Yonghong Song in bpf_devel_QA.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/lib/bpf/libbpf.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -661,6 +661,24 @@ bpf_object__init_maps(struct bpf_object
 	return bpf_object__validate_maps(obj);
 }
 
+static bool section_have_execinstr(struct bpf_object *obj, int idx)
+{
+	Elf_Scn *scn;
+	GElf_Shdr sh;
+
+	scn = elf_getscn(obj->efile.elf, idx);
+	if (!scn)
+		return false;
+
+	if (gelf_getshdr(scn, &sh) != &sh)
+		return false;
+
+	if (sh.sh_flags & SHF_EXECINSTR)
+		return true;
+
+	return false;
+}
+
 static int bpf_object__elf_collect(struct bpf_object *obj)
 {
 	Elf *elf = obj->efile.elf;
@@ -742,6 +760,14 @@ static int bpf_object__elf_collect(struc
 		} else if (sh.sh_type == SHT_REL) {
 			void *reloc = obj->efile.reloc;
 			int nr_reloc = obj->efile.nr_reloc + 1;
+			int sec = sh.sh_info; /* points to other section */
+
+			/* Only do relo for section with exec instructions */
+			if (!section_have_execinstr(obj, sec)) {
+				pr_debug("skip relo %s(%d) for section(%d)\n",
+					 name, idx, sec);
+				continue;
+			}
 
 			reloc = realloc(reloc,
 					sizeof(*obj->efile.reloc) * nr_reloc);
