Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405291-2-14085934823637323061
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
    1524405291; b=YJoRAPU/RoIqEMIIHhfy1d1HxFW0FUsl/qXTYU7qdzO6Nu5uC7
    DVlCVJzYwWSbgZSvjT5MsSdZkAUGjTNWAzmxPqf3GJ82sOMEkCp9nxr62LGJpG0e
    R8vCl+UvJOCjossiVJ+Z3hpoXWHVVJNXyvPGeNikMNVKgWGGkFlBx9dZLk5JVtKS
    /pkNKWZWNuLMEebD2f4n1j5bRoHol84+Nfg8vwP132UdcLEHGZSByJzGdgwTzE0T
    V/1SlxSDL2wxBb0PpgdsY4LWOE/4n3jvk8N5c3lgg9eSm7joAm/2ftuTs2zgVMX0
    l3YGY+c+2K4xsK6r/KcZ04sYW+09xZV53O7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405291; bh=UsSG4kqiRQETNn+w3f/UQMkCwiPn/5
    hs7TIEQ5PsvyU=; b=t6QlQM3111ZA4Ih579ufsp0zMpvF9mVjh01K/xXnNFJ3HL
    esH49MicHxU8glyLMuiJNrFtc1VOeNQMFlSmzTi+q+gNplUdj0ujG8qiED8V1Rn/
    WPtl/WJu3DJ1XOJ9kwSCjn7Z//ggPPalnPJlUoyMdoZaTHKCbAVlOJh3hzbA6Xf1
    XIHfKQhMoejyhVxrIG0hJF8c+oErD14rikUNebwAwCPFQ3nmd1NktnnUii48QCMX
    R7ubG1kBHCOTB3zukwfn/taKQg20fXbpm7JcbyDYsOvb/09vlgoc/gCF6K46bu6Z
    uZol506HBphkkjwhCpxCAPv6ZnzG0xRUs+XBFsoQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfNG6j/6HJXxhkPqUJ12kZn8ef348THM8PxCglMcBSuzWu55OcNqxQ99Jv9KRdCTqrEbmN5IT4WgJOeaMc1aCJRuF1/n6a1j9Uw6dDrd2l+y6c3OKH50m
    0av1Ev6a4TpHTh28OVlZCYMLvy+BoLcjf+WNGmSUEm52pmHQSzqRurkBhjZqjF+FBYFemJKbcINnjWXuciuh2Z/EFcF8ZfxfI6PaKo6v1MlQItcEtuhUb/Ai
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=zAyngx5bAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8
    a=Swvf4cUhDNO75JoQKjkA:9 a=BsB3AOBp7HpAhrC6:21 a=6cz1nU60tvq-poK0:21
    a=QEXdDO2ut3YA:10 a=4LA4qAFo6bo561LpWNDU:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752473AbeDVNyq (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 09:54:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44260 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbeDVNym (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 09:54:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, George Cherian <george.cherian@cavium.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.16 002/196] cpufreq: CPPC: Use transition_delay_us depending transition_latency
Date: Sun, 22 Apr 2018 15:50:22 +0200
Message-Id: <20180422135104.373154221@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: George Cherian <george.cherian@cavium.com>

commit 3d41386d556db9f720e00de3e11e45f39cb5071c upstream.

With commit e948bc8fbee0 (cpufreq: Cap the default transition delay
value to 10 ms)  the cpufreq was not honouring the delay passed via
ACPI (PCCT). Due to which on ARM based platforms using CPPC the
cpufreq governor tries to change the frequency of CPUs faster than
expected.

This leads to continuous error messages like the following.
" ACPI CPPC: PCC check channel failed. Status=0 "

Earlier (without above commit) the default transition delay was
taken form the value passed from PCCT. Use the same value provided
by PCCT to set the transition_delay_us.

Fixes: e948bc8fbee0 (cpufreq: Cap the default transition delay value to 10 ms)
Signed-off-by: George Cherian <george.cherian@cavium.com>
Cc: 4.14+ <stable@vger.kernel.org> # 4.14+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/cppc_cpufreq.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -20,6 +20,7 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/dmi.h>
+#include <linux/time.h>
 #include <linux/vmalloc.h>
 
 #include <asm/unaligned.h>
@@ -162,6 +163,8 @@ static int cppc_cpufreq_cpu_init(struct
 	policy->cpuinfo.max_freq = cppc_dmi_max_khz;
 
 	policy->cpuinfo.transition_latency = cppc_get_transition_latency(cpu_num);
+	policy->transition_delay_us = cppc_get_transition_latency(cpu_num) /
+		NSEC_PER_USEC;
 	policy->shared_type = cpu->shared_type;
 
 	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
