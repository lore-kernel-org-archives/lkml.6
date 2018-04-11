Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124918-1523473302-2-14819829420105948083
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
    1523473300; b=jrQuMFsN+2UBO6agzuBlZicsyG19nl4ZoFi31GQp1re83ak5wi
    ufOoiXv6Kuh4eGDbgg7ywhfgDZwEcDlxdIZWNZPIKs83D1s6mzTyJWhepaheMH2S
    Zz+0P9RqPVwaFU9WWD4SDnUOKOpbBK4kqmR4QFwf/FhtV2JEykXX/r47m/G6voDH
    75HbzE8ygfkSwqZ5Qbppw2p0POab3Jd0GwmPWpEl7/7P5JRL+e50+d1mzJHKO8oG
    Nl1VSxHACtfcy5I9y9WPWzbVNod2Sh2y15Zzz6cSfPQT6u+QJeLQxRT1h+u5dWil
    1GUGqN+TG5YNnCXxtjI7Wsbwl2WQBRMkTfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473300; bh=klTRBfEA40dkUtRLpFcOHBaDlHuY/H
    VWeSY5FGIu6dc=; b=ITSSSdxXPPq8XicwaTlhdJ+sRdfg0kNTvdX36ZvK8LZfMA
    PKBbu7z9VxQofdW6aIPCZcwkyLZ3tsPTIUKblipnggoNgYYTrQg1+yq2HpdXx1iQ
    rx+UyMNL/HeGglBXMeaf9AWg7cd4mA/6WbHEJ4xJ+CLjsSJ04wYt2PPoXFpIHrkK
    fcHWYuTYh2PmmYDoOej90rULiOyHzyukpnRZK7Uunp4sWluy7aI7P5rg3nGlDbsy
    E3dpnnSMB/Hje6oqaLm6EDa7u6dsBm5UYiVujtwdBe3ggk4WW96/3DBn3p7Yd2Wi
    5UPT601WuUAFHk6nwhAK/SrN1c+ZFhHqYBlLEBdA==
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
X-CM-Envelope: MS4wfCZuhwzDxb7tmq3hbrrl1EClydkOjPQn+DgZWTfPB6QCZsxMISNo488te9L0zhfAz2svAEiZa5zEKCvZzUty6dm8ENV5aXYfoSfHxJBJLOBuqP9sSgN+
    PN36QPh3YfjQLNaWPCaJxu99aPgHuXdCxm4pjVcQkHYshBLqNGXw0Lzq2XGKOn9kiwmb1SP4iT3QqfVlT1b0XxoWkLAlHG0hFI9M2Q1NXTq5vu5GvphouRkG
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=WfulkdPnAAAA:8 a=pGLkceISAAAA:8 a=57SyGIRnAAAA:8
    a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=HcSiQ_138I7OFoV5844A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=56QPVbyS4OZCpcuOg7Z9:22
    a=YzT4AsKTxtEdF6UtD8mD:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756856AbeDKTBh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:01:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756849AbeDKTBe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:01:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>,
        David Ahern <dsahern@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 195/310] perf header: Set proper module name when build-id event found
Date: Wed, 11 Apr 2018 20:35:34 +0200
Message-Id: <20180411183630.979890454@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namhyung Kim <namhyung@kernel.org>


[ Upstream commit 1deec1bd96ccd8beb04d2112a6d12fe20505c3a6 ]

When perf processes build-id event, it creates DSOs with the build-id.
But it didn't set the module short name (like '[module-name]') so when
processing a kernel mmap event of the module, it cannot found the DSO as
it only checks the short names.

That leads for perf to create a same DSO without the build-id info and
it'll lookup the system path even if the DSO is already in the build-id
cache.  After kernel was updated, perf cannot find the DSO  and cannot
show symbols in it anymore.

You can see this if you have an old data file (w/ old kernel version):

  $ perf report -i perf.data.old -v |& grep scsi_mod
  build id event received for /lib/modules/3.19.2-1-ARCH/kernel/drivers/scsi/scsi_mod.ko.gz : cafe1ce6ca13a98a5d9ed3425cde249e57a27fc1
  Failed to open /lib/modules/3.19.2-1-ARCH/kernel/drivers/scsi/scsi_mod.ko.gz, continuing without symbols
  ...

The second message didn't show the build-id.  With this patch:

  $ perf report -i perf.data.old -v |& grep scsi_mod
  build id event received for /lib/modules/3.19.2-1-ARCH/kernel/drivers/scsi/scsi_mod.ko.gz: cafe1ce6ca13a98a5d9ed3425cde249e57a27fc1
  /lib/modules/3.19.2-1-ARCH/kernel/drivers/scsi/scsi_mod.ko.gz with build id cafe1ce6ca13a98a5d9ed3425cde249e57a27fc1 not found, continuing without symbols
  ...

Now it shows the build-id but still cannot load the symbol table.  This
is a different problem which will be fixed in the next patch.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20170531120105.21731-1-namhyung@kernel.org
[ Fix the build on older compilers (debian <= 8, fedora <= 21, etc) wrt kmod_path var init ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/header.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1454,8 +1454,16 @@ static int __event_process_build_id(stru
 
 		dso__set_build_id(dso, &bev->build_id);
 
-		if (!is_kernel_module(filename, cpumode))
-			dso->kernel = dso_type;
+		if (dso_type != DSO_TYPE_USER) {
+			struct kmod_path m = { .name = NULL, };
+
+			if (!kmod_path__parse_name(&m, filename) && m.kmod)
+				dso__set_short_name(dso, strdup(m.name), true);
+			else
+				dso->kernel = dso_type;
+
+			free(m.name);
+		}
 
 		build_id__sprintf(dso->build_id, sizeof(dso->build_id),
 				  sbuild_id);
