Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524840420-2-3972302058964311535
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
    1524840419; b=Y9OWEH/nvQQTAsHbNcFsbD2DU27WGoT3INRplmWW1xWOD9W1DG
    JYPvQFWE/cQCXyh10q+qunjWFTIOCjFczrFxYWOlvREx9CNbDg/ad3EcFG/7FyI7
    bZQkJQMDTzy8mwATeIgUMSPWIFi0Rp7yQCWivoHrHjrKxxVqxWSirhsSlRuQEyOu
    l3phKnLS/5fSCQktwgFsCynjvshR9YiMJIi0LZoN0GZHnO3b8rdQZZUEaz3M7Nok
    pXpZ4awE02RfNMgtAQZn309IzE3m1tIx2RCrPVLrvGFo/mhqhqxYNlUUDqvLrpfC
    Ma6Ed027RWsK/yfoP1LTUjyoAFKtwjrhS8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524840419; bh=rlSwnbx7IGGQ8tVHZWYE9TwXNSOt5i
    BbDNYyKQbgQOA=; b=faw3TFH+dZnNFMU92zo6rTnkznI0HieJK2C9OUXkFWfhro
    IHd7NKIg68TwVjKf6GnYmNplhN1XWpuuj+ApY7pnf4nyPZn+DXpWLuJzpJ9J4Hos
    iVqiEyXJr1zWBYgSigVTKEfwld8xo7uxtwDdGGs0CCdBGLDP7ZOjiIl5kdJHpein
    TCOspVglGL0+eS31IjJSRy8OWDvLjv94K5I48FYX6sRbMBbm7xeNvRT/ONQ5RJGB
    UAZhtBKVj7VDoqDNp0OFT/vddBxMn+/h6JW1JN8XNYnsDYAwiGNAenJ/uCfO/Vhv
    v7cJWrmtaMHCv4gd2ww8A+s1jNEpvd9RtBKW7lVw==
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
X-CM-Envelope: MS4wfDoY+OUhkv7wOt+ll0rwQdnCkmwVOhWcPlA+JPBvRKHISMDulHWA+D2FII56MdhYesCZjoPaX4wCQGSYKNv4a4YSh1DRULnXPafTQfIz5ESGAxWHdHKR
    HgXhM5fbSrFBhaHgwRRGannz7VsbWLAVhr9z/1B3ezeioLpQy/1ji79+7WXYvtDCF+5+/GL/sFkSJ/50b4sxzUR9VRa6KVIPT7FBA6x5niNi6xC9iOePuPvu
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=Y4F1kmRjT2bv8szmQG4A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934025AbeD0Oqm (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934393AbeD0OH6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:07:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910F121892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 53/80] s390: do not bypass BPENTER for interrupt system calls
Date: Fri, 27 Apr 2018 15:58:46 +0200
Message-Id: <20180427135735.630826274@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
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

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit d5feec04fe578c8dbd9e2e1439afc2f0af761ed4 ]

The system call path can be interrupted before the switch back to the
standard branch prediction with BPENTER has been done. The critical
section cleanup code skips forward to .Lsysc_do_svc and bypasses the
BPENTER. In this case the kernel and all subsequent code will run with
the limited branch prediction.

Fixes: eacf67eb9b32 ("s390: run user space and KVM guests with modified branch prediction")
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/entry.S |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -1375,6 +1375,7 @@ cleanup_critical:
 	stg	%r15,__LC_SYSTEM_TIMER
 0:	# update accounting time stamp
 	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
+	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
 	# set up saved register r11
 	lg	%r15,__LC_KERNEL_STACK
 	la	%r9,STACK_FRAME_OVERHEAD(%r15)
