Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3039319-1523472094-2-11856755494752867151
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523472092; b=edfbLEwEDY21S/tY7jjmYQPN2Y3f0NQwogIUBBCBOc3rVnxPnM
    l8UB5z34OZ3yb60FEXvhaGnJqK+bjAMvjqK33f43pxkJCuHF/1JMn6SC1RN92yqt
    QU5XcvVLHehwBu1qYQLINNtcWBL/00lCWPymjLrMSuBj65HO10zKybemBPx77OCn
    nvlvGkNG3KXj3HuncvVCqE6NfCN6NQbesoPrtbf2h5ao3/47EZsjMC6aNM90WhCW
    17JoqnOFEBpqTtfT+IMUKuQtSo0tHsAeXaf9jOAl+UKKI46TLy4iXiAKwurc9uV9
    VMq/g+67y6kWWq+p/31pa1A5DvyygBwWsh0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523472092; bh=0usna3RnWtastGlFizsbIKrVAAkx8V
    F3GEBWECedixA=; b=ksEh6ZkkFKO95yofQTcVWHNNh6CDzKGhffn8NxL/xqXP8m
    tb2+MgGr9J8b9tFl+1R9I5j/eDozkF9AobIKJ3Yxq8bq621LMlD3adsGfyEkXtZN
    qRk/BLXI1TK4iMMDxj/6tfUWS0F41qW6w9wKS5+WuieuJ+OVydGCAGC9EfiHIEhw
    avZDnjQYfzCrx6BK93EJVr3LuhL0zJm31AoVg4Ft2GSzwEId/1SnVJwp3vS0SiHP
    LoDLIe8KxTsV7wIk/VnUVn7LctP7lnFOM4ePd3dEKb2W1qkpsQPfi3vIoqvypaAp
    UoLS8Eg1mokDrI0LASDsdjlNfw3xhh2S5+ovEftA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfPNW5PWICCZBoR/y3wF2a6Lt74U47yQuJznQ0FuN4EiugJVuOhUsl+efo9h9ys2sehgcX9aVNi5v2Un8uwxPQQqefpEMpI1FJ1Ea2Vp2Dl/9G91r7KMH
    CV8yRwQcP2/OaZOma9dq0Cjg5qbo7Dn486plFDqWSbM9ExWx+uWL2cPpAlgBMzfSZSqevP4BmxnaOg0DhenMVPUikcv+4+jujGzty2uk9CoReNTzbwFuVFtz
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=i0EeH86SAAAA:8
    a=57SyGIRnAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=TZeuQikzWl3-NoflrHoA:9 a=oi8sJIV_VhWeT3Eg:21 a=qPc6-ZfKddN8SxDY:21
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=YzT4AsKTxtEdF6UtD8mD:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754827AbeDKSl1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:41:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56820 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754810AbeDKSl0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:41:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Wang Nan <wangnan0@huawei.com>, kernel-team@lge.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 080/121] perf tests: Decompress kernel module before objdump
Date: Wed, 11 Apr 2018 20:36:23 +0200
Message-Id: <20180411183501.074294029@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
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

From: Namhyung Kim <namhyung@kernel.org>


[ Upstream commit 94df1040b1e6aacd8dec0ba3c61d7e77cd695f26 ]

If a kernel modules is compressed, it should be decompressed before
running objdump to parse binary data correctly.  This fixes a failure of
object code reading test for me.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20170608073109.30699-8-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/tests/code-reading.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -141,6 +141,8 @@ static int read_object_code(u64 addr, si
 	unsigned char buf2[BUFSZ];
 	size_t ret_len;
 	u64 objdump_addr;
+	const char *objdump_name;
+	char decomp_name[KMOD_DECOMP_LEN];
 	int ret;
 
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
@@ -202,9 +204,25 @@ static int read_object_code(u64 addr, si
 		state->done[state->done_cnt++] = al.map->start;
 	}
 
+	objdump_name = al.map->dso->long_name;
+	if (dso__needs_decompress(al.map->dso)) {
+		if (dso__decompress_kmodule_path(al.map->dso, objdump_name,
+						 decomp_name,
+						 sizeof(decomp_name)) < 0) {
+			pr_debug("decompression failed\n");
+			return -1;
+		}
+
+		objdump_name = decomp_name;
+	}
+
 	/* Read the object code using objdump */
 	objdump_addr = map__rip_2objdump(al.map, al.addr);
-	ret = read_via_objdump(al.map->dso->long_name, objdump_addr, buf2, len);
+	ret = read_via_objdump(objdump_name, objdump_addr, buf2, len);
+
+	if (dso__needs_decompress(al.map->dso))
+		unlink(objdump_name);
+
 	if (ret > 0) {
 		/*
 		 * The kernel maps are inaccurate - assume objdump is right in
