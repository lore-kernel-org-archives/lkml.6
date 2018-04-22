Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524405749-2-7175621622044280502
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
    1524405749; b=CvA7D3qywb4sx2IsKztOBKDns6WqkKdBcsp3JkczBbU1TzKj06
    pInJNDpV/9aXpMdlkHsjDoV+fMLyGXpnGvhFcCkAbrBnmCpi42zhQYnwhViLR2Ki
    9MZiHgH4DF6kBTTqVBWfM2x/UAt03eydLCvKXnP29VFlwgCjjqBtspnIxAOAXpcc
    guJ7TOUKvLlc+ZauMat2r074BwFIcmUwUt7DGJPV2t5N9ttH1w4tdssrb7yH5NYN
    6kq2hhlqWFoFAmEbFsFkT3N0YidBEoSaNZMroE3YFHbkYsluXhjluKYjcFDxnYQB
    8hSHt9Y4U5vBY2EN/fEbNWAQtSU2OkGQcjlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405749; bh=6LyRQHBzOJtQmhaxmQTe0fz0Wd2FJo
    E+wMFWy4plGCA=; b=X62mMnEg19JlUeu1r8NzkvGovVadKmsznhCnd4oj62WKwI
    +IPdxmp6XwB7Bg6spr3qwzsSLn1YvYTJa4FbNaPA1bVIgFUjDYKcnfwBpZQBLow1
    /ePfl84b6OsZPVlV+TpVGnm/uwswhs8DqJbeJeWTgApEXQfLpTiFu3biuoNK3LVH
    yigZy0i7OoLyEQTMnHtyXMbKMAgigQTp5Ci3036nGGzpV/j/gv16ZdsE19XsN4ix
    HWL5l1J+xDlKYpxrDkDVthRTuFGa85KO3wQ0ryDxTPG1494C4NYxGChav8lm4NJx
    7iHaGmNPBrB1H+H/OqKnMgVghQVDmY7O4GGUn1hQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG1KJEAZrxVs3I1YkQj5LP3EIHtY7RPs03qDLNC7q+tohqmk3FsvdB91MjaV2p/d1XAQRM0bn2bFxi4nS7VHXe++nXd6OooQBuIJc+LyFd90sIEbl9vJ
    Cok/sqPpsg1p0RnLn+7WmHKTmy5/mjzeueMIvBHuWKZ/qj50jUYPfzfpCZH++l5aYR8LoagT3TRq4GOhjKJJPJ1AdYY6VcZjC53wJ6huhKBGUzipHPZoQYDR
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=wMNdZWldAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=leThz_s48j75lV_PSgMA:9
    a=QEXdDO2ut3YA:10 a=FUarYpL4UH3yWsho8X8J:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754257AbeDVOCZ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:02:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48514 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753879AbeDVOCX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:02:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.16 178/196] powerpc/xive: Fix trying to "push" an already active pool VP
Date: Sun, 22 Apr 2018 15:53:18 +0200
Message-Id: <20180422135113.457346237@linuxfoundation.org>
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

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit b32e56e5a87a1f9243db92bc7a5df0ffb4627cfb upstream.

When setting up a CPU, we "push" (activate) a pool VP for it.

However it's an error to do so if it already has an active
pool VP.

This happens when doing soft CPU hotplug on powernv since we
don't tear down the CPU on unplug. The HW flags the error which
gets captured by the diagnostics.

Fix this by making sure to "pull" out any already active pool
first.

Fixes: 243e25112d06 ("powerpc/xive: Native exploitation of the XIVE interrupt controller")
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/sysdev/xive/native.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -389,6 +389,10 @@ static void xive_native_setup_cpu(unsign
 	if (xive_pool_vps == XIVE_INVALID_VP)
 		return;
 
+	/* Check if pool VP already active, if it is, pull it */
+	if (in_be32(xive_tima + TM_QW2_HV_POOL + TM_WORD2) & TM_QW2W2_VP)
+		in_be64(xive_tima + TM_SPC_PULL_POOL_CTX);
+
 	/* Enable the pool VP */
 	vp = xive_pool_vps + cpu;
 	pr_debug("CPU %d setting up pool VP 0x%x\n", cpu, vp);
