Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116732-2-3860359598858617984
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
    1525116731; b=BD6yuF48ZiY4YZcCeIg0TpNbrzgZ27oD77ASmkOnG/vGtFA7a3
    t1GY7DlYv6WESGQMVqIL+BiOanFNmGWpAfwf+BvfXksKfetxaFzk42W6euMwHtX2
    iKwhMKF+9aks1ZSmZ5ONxLOq6Svc1HGJ55PuAKE4ryF0oZ0hamRlENOZcUOHS+Sp
    6AKG5sqPrnSlm1RLyGEnSQqDrffUxjCXLE+ZaCMsetRg9hWS1FHzBnV4gCXrUnDz
    b+2UweYO1GEIFeHJHqQpLJNf9isLqfqGFJQWJaEISSShYRkSQd5bkqOzLfYQ//Yu
    I1tznPVEe0BxAYKaqS0KiFrMZsubhG0v29pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116731; bh=picRc/ofA9i4Ig6fJOzSQD860iVzkW
    lBhjPP7mxUyV4=; b=Ne39n/vW6rY1EgS1/tjA7vGMjnOTGBvJ/ZqNXi2Vz69+IE
    /iBYEDYmjDBR1KL0lf+h6rltYZsFqnmeZ/zUeKbV7dF/mu2cJlOmuIFeQyyiMZP6
    LznZtMhlsn1MJG2v0U+fjq4/lPbU7xjfuIDvr5uG+fNiAXX+Oo35Pi/3QhmIUj+5
    aJsfpSqRBKZOeeHRSnfV0P0a81t22Q0WFR45aGk4KHyj7wzSWecGdyUXlE6e7s0x
    oGhWzMWZ6S07IoIsQpUWA1Fwkq/fXGepou7jxO4C34uxmY6EOBNv0apn3OY+jdTz
    glQl2WxlLvNRblT2qJmYl9p4vi6kVrGBElY+HLcg==
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
X-CM-Envelope: MS4wfHyNqLKbzB8yFnaNPBjqUnbX4KNcQJqgqZmGax0bCpduI8jpFnIRB7r/TuD6wRbjkt9tLtKJmqCzvQ/UeIkzaeRGKfkICwukzBXK+0gS18KOVo/QewIo
    TFkyZ4H9wNF4xqNkMVfD+Ep5t0nmmV0pE6UkPlA5eHmbye/ac+EZnVKeM/8XXbpW3CetL5IhNiII70Rm44fFktBaNjyOWq2NI+yNA0UrCnIEymRZLXYNcMnN
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=UwP2SR5P6s2dbk43-pEA:9
    a=m3qw9H-hkk5F1kt-:21 a=aqC3XoRQiQxCncLf:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756458AbeD3Tbz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932429AbeD3T3A (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:29:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C146B2344C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alistair Popple <alistair@popple.id.au>,
        Balbir Singh <bsingharora@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.16 082/113] powerpc/powernv/npu: Do a PID GPU TLB flush when invalidating a large address range
Date: Mon, 30 Apr 2018 12:24:53 -0700
Message-Id: <20180430184018.652944439@linuxfoundation.org>
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

From: Alistair Popple <alistair@popple.id.au>

commit d0cf9b561ca97d5245bb9e0c4774b7fadd897d67 upstream.

The NPU has a limited number of address translation shootdown (ATSD)
registers and the GPU has limited bandwidth to process ATSDs. This can
result in contention of ATSD registers leading to soft lockups on some
threads, particularly when invalidating a large address range in
pnv_npu2_mn_invalidate_range().

At some threshold it becomes more efficient to flush the entire GPU
TLB for the given MM context (PID) than individually flushing each
address in the range. This patch will result in ranges greater than
2MB being converted from 32+ ATSDs into a single ATSD which will flush
the TLB for the given PID on each GPU.

Fixes: 1ab66d1fbada ("powerpc/powernv: Introduce address translation services for Nvlink2")
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Alistair Popple <alistair@popple.id.au>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Tested-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/npu-dma.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -34,6 +34,13 @@
 #define npu_to_phb(x) container_of(x, struct pnv_phb, npu)
 
 /*
+ * When an address shootdown range exceeds this threshold we invalidate the
+ * entire TLB on the GPU for the given PID rather than each specific address in
+ * the range.
+ */
+#define ATSD_THRESHOLD (2*1024*1024)
+
+/*
  * Other types of TCE cache invalidation are not functional in the
  * hardware.
  */
@@ -627,11 +634,19 @@ static void pnv_npu2_mn_invalidate_range
 	struct npu_context *npu_context = mn_to_npu_context(mn);
 	unsigned long address;
 
-	for (address = start; address < end; address += PAGE_SIZE)
-		mmio_invalidate(npu_context, 1, address, false);
+	if (end - start > ATSD_THRESHOLD) {
+		/*
+		 * Just invalidate the entire PID if the address range is too
+		 * large.
+		 */
+		mmio_invalidate(npu_context, 0, 0, true);
+	} else {
+		for (address = start; address < end; address += PAGE_SIZE)
+			mmio_invalidate(npu_context, 1, address, false);
 
-	/* Do the flush only on the final addess == end */
-	mmio_invalidate(npu_context, 1, address, true);
+		/* Do the flush only on the final addess == end */
+		mmio_invalidate(npu_context, 1, address, true);
+	}
 }
 
 static const struct mmu_notifier_ops nv_nmmu_notifier_ops = {
