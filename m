Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477417-2-495044910116704021
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
    1523477417; b=vNbSHwHbKMEqTDKxF3kx+WeHHIkprhr9KVewV6ZiQEX9rej7P1
    gxJ7rrhvFfEQN+kRCNB1mXx/L9AduGYph6AaYlR337SrUJycFyz5ee+VkErWPWsf
    sJqvskKiEFU9x18yg3g0fMBOzynVYrDPAERVTtz+oNGjo0vE5tUO5E8LrzO3B/JI
    ZBol8KiiDVqi1/XXPAZI/tBH2ywZrvwLHtHWsm9lrS/74NLkV4R29OLUGLpoQiHe
    V3VNWusX5ogOGf/x12HmHEsfvaHiI26gwyf+ePSdS/gp+dq7ZSrxZigbg8EhjYn7
    wArpSyDcZ8MX2gsYX0j94XejvZXBlmz2QaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477417; bh=iPEUEbsMX0Gpj1Pl0Hu5NAkYMssaZy
    +xYdk9ZGC0b9U=; b=Z/tfQo3OsLPFumIiar0Kh76luSfKUg/0WUFyZp6Lhnmg7E
    0G8Ejdl2lgShYX8+zhRy7EiG/SIr01eKvdJ4llrsHZDE/fyFcG2l/+ofZbjS46VT
    O/YXJz4xRlcA1RiTsK6+66jBBVentXQc/brS0HY8cPiMkF4IbOB54QbQ3Le+cFV5
    iG+lTqw20SnQqjigLOKSSE8eWrq5tITNMYHb517zEDY8fKVRL5oWR+pdn87EBr5E
    +g2KEuGlELrTe91Tx+F2/EgEVag3vquBtmW+35qToae0j59yXnKB94/iQlprNHHr
    S6sXl0CLMa5nQjxjoufq4XBPZqYBdvlXI+PksgcQ==
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
X-CM-Envelope: MS4wfH6I/so5tneuyCdeCchVnpBbfL5nECGFcJDPWxCoNCka4W/hDNraYrHB8ysOSLpGKlbIOr4BVaZAdJYG1Cw64MCYOjcJUbnrAkABYqy7R4n9bbsRUeSU
    +4+N5/0vdLP+BTsOjs9JLV5GTWjqLlPAnCXgwesFhiHsgge6QXcGlRW/diNqCC8L9/IJPdPxqnb6AxD4f23m7iiMCf9fT5QBue7OZkiX99pwjucHjsQUhVWW
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=BGDGbZgwFsv30h0h_0oA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933533AbeDKSyj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:54:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34542 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933520AbeDKSyd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:54:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Balbir Singh <bsingharora@gmail.com>,
        Jessica Yu <jeyu@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 048/310] powerpc/modules: If mprofile-kernel is enabled add it to vermagic
Date: Wed, 11 Apr 2018 20:33:07 +0200
Message-Id: <20180411183624.315717395@linuxfoundation.org>
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

From: Michael Ellerman <mpe@ellerman.id.au>


[ Upstream commit 43e24e82f35291d4c1ca78877ce1b20d3aeb78f1 ]

On powerpc we can build the kernel with two different ABIs for mcount(), which
is used by ftrace. Kernels built with one ABI do not know how to load modules
built with the other ABI. The new style ABI is called "mprofile-kernel", for
want of a better name.

Currently if we build a module using the old style ABI, and the kernel with
mprofile-kernel, when we load the module we'll oops something like:

  # insmod autofs4-no-mprofile-kernel.ko
  ftrace-powerpc: Unexpected instruction f8810028 around bl _mcount
  ------------[ cut here ]------------
  WARNING: CPU: 6 PID: 3759 at ../kernel/trace/ftrace.c:2024 ftrace_bug+0x2b8/0x3c0
  CPU: 6 PID: 3759 Comm: insmod Not tainted 4.11.0-rc3-gcc-5.4.1-00017-g5a61ef74f269 #11
  ...
  NIP [c0000000001eaa48] ftrace_bug+0x2b8/0x3c0
  LR [c0000000001eaff8] ftrace_process_locs+0x4a8/0x590
  Call Trace:
    alloc_pages_current+0xc4/0x1d0 (unreliable)
    ftrace_process_locs+0x4a8/0x590
    load_module+0x1c8c/0x28f0
    SyS_finit_module+0x110/0x140
    system_call+0x38/0xfc
  ...
  ftrace failed to modify
  [<d000000002a31024>] 0xd000000002a31024
   actual:   35:65:00:48

We can avoid this by including in the vermagic whether the kernel/module was
built with mprofile-kernel. Which results in:

  # insmod autofs4-pg.ko
  autofs4: version magic
  '4.11.0-rc3-gcc-5.4.1-00017-g5a61ef74f269 SMP mod_unload modversions '
  should be
  '4.11.0-rc3-gcc-5.4.1-00017-g5a61ef74f269-dirty SMP mod_unload modversions mprofile-kernel'
  insmod: ERROR: could not insert module autofs4-pg.ko: Invalid module format

Fixes: 8c50b72a3b4f ("powerpc/ftrace: Add Kconfig & Make glue for mprofile-kernel")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Acked-by: Jessica Yu <jeyu@redhat.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/module.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -14,6 +14,10 @@
 #include <asm-generic/module.h>
 
 
+#ifdef CC_USING_MPROFILE_KERNEL
+#define MODULE_ARCH_VERMAGIC	"mprofile-kernel"
+#endif
+
 #ifndef __powerpc64__
 /*
  * Thanks to Paul M for explaining this.
