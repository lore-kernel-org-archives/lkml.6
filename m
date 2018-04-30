Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116542-2-3958885547639767471
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
    1525116541; b=G8KAzxuIMKw0/VIz3dRSuvC48jan/9D0S1nvGxMmHeLSJGz6JL
    czqAZBVGjrdLf3i9sWxQ3RjCqbEauDgixgjVohwXtKViGVG0FTByb/Cxlw107Tb1
    zLpjgYK0mPZipErdNU9sZ5VCFoJlvIht4gmxbBFTR0+QEmFYQAu/6f2G0w1kmQEW
    yZSttNSWEBJBrIpb17MNcKGnmxtKP3yRqfIpxARiAImQNG2URrzUBZJvNY99Updr
    wbQWNBzT0rcSWebuowHSOgnn97y+pOnKeFKB2BKr1HDQb6X91+PAQORgjpZRbKFt
    +DzxC20dFEUNVE+ftEcp+t8yKzcEdWAMVJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116541; bh=8J5+ALNfF4SnvjZuxJQj5R/mZsXZRy
    Ab9MX5/POP59M=; b=L/sUKrz1coBnR5c6Gzw9eXN0OhHIwJy4D7fjeaN5NG4VNg
    GH8AddbW0MUqinHQVaOEKCS74LK+/vLksR/qWgNc43DMYIceJwun42kZOlrwBOIC
    ZLLZwuUzPHTzJ4kIqt6ZAopOyChuogijAUt1TI6nMC/RSbqeEvEHMFtSKWVXsCyg
    iyS1th39ZOfksKD+x4wFcVZYrEO5R+2+eXMt4aK6GVM7ORisb3v1UqZFkAoxPkLs
    Mdr1NWmopEejtkGn2HHjniEj3CGrAW1BEgli1PJOG6/4Drc4k9kGwTRWdhWS7axX
    u8YoUpr4CvFa3kkckEkApiMPPOGlguL7CyS8ZqBQ==
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
X-CM-Envelope: MS4wfHFKv2h0iD+dr4IsTWAWz8Tz6ayD1oJtU1HuTL5jYiF1kTi43JhaL9YWWQZ5ji+Y+SggZLUHtxULbJ7tTAcu/mCVvXykMA6DSIVdRz8Wc+OC0zk6uvzv
    1Aw4S+zFVRlOQlegwgcVcLzxVCYUMIQi1WXMcogsUWwJUsK8QQ4gwd4300+DwXnad2eC7XaKqAdQn/9rFT/xgEsfXYI8WniX10//ASugONV3AGvNx9lH3dSD
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=GAEBHUnfkgZ9E9rjFQMA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756455AbeD3T25 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755258AbeD3T24 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:28:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8293323448
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitezslav Samel <vitezslav@samel.cz>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 4.16 109/113] x86/microcode/intel: Save microcode patch unconditionally
Date: Mon, 30 Apr 2018 12:25:20 -0700
Message-Id: <20180430184019.802044613@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
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

From: Borislav Petkov <bp@suse.de>

commit 84749d83758af6576552046b215b9b7f37f9556b upstream.

save_mc_for_early() was a no-op on !CONFIG_HOTPLUG_CPU but the
generic_load_microcode() path saves the microcode patches it has found into
the cache of patches which is used for late loading too. Regardless of
whether CPU hotplug is used or not.

Make the saving unconditional so that late loading can find the proper
patch.

Reported-by: Vitezslav Samel <vitezslav@samel.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vitezslav Samel <vitezslav@samel.cz>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180418081140.GA2439@pc11.op.pod.cz
Link: https://lkml.kernel.org/r/20180421081930.15741-1-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/microcode/intel.c |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -485,7 +485,6 @@ static void show_saved_mc(void)
  */
 static void save_mc_for_early(u8 *mc, unsigned int size)
 {
-#ifdef CONFIG_HOTPLUG_CPU
 	/* Synchronization during CPU hotplug. */
 	static DEFINE_MUTEX(x86_cpu_microcode_mutex);
 
@@ -495,7 +494,6 @@ static void save_mc_for_early(u8 *mc, un
 	show_saved_mc();
 
 	mutex_unlock(&x86_cpu_microcode_mutex);
-#endif
 }
 
 static bool load_builtin_intel_microcode(struct cpio_data *cp)
