Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2669103-1524408217-2-2398292745943608270
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
    1524408217; b=V3Q1gLkbR3fOyACIcWNESSWVdCnUpdMReZkmpApA8Ni04Bkktf
    1EpJADSXjpc6Ms4zL+EhklaGZe3d8ZdPLjG/frUS9mW78Y9cRCNp7XDbPV3SfR9R
    42iGM8g00qPPjlUMY0y5My5Iu/G6Gki11m4iHx/09+wnGX2amXK6pnVChsJ0EHY6
    97+XC4dpQb8Yxs/Ak8WtEjXVf9TAhquBe653Ro01ifu8tR0jH5tTdn5KBR3lkvp3
    zpxgu3vTP7WCWxT96xSKPKmuzagCgxyz59cXDhPLbSqRBriq/lKIZfXxbkhnQe1G
    zQ+hu++iI8L+X90JZInvVol/5ika4Wr52vOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524408217; bh=8yduKWd0EI0Yr42teKAQstwzXWz8/6
    AQoLJG9z27XrE=; b=Vpu/iTd7ukJKWPF5bY4nhVCVsRYjDTTGQ1Uglr3IFDSqGG
    gxcdOJRBSM9fVzApXocquPk/CKw3JpvcogdtggAgtMm2o/raLVtKcjciOFoRn9df
    RjQvbYlwivLE2bNdgvnhgXKTZ0sNp4BLRnNZzgrDjDEjHA6PrGrBgHq6ZVfp0h1/
    TPorvin1Co/BPkNooXPV4uwEglXhK8wv8FzcpLCsIGPfHNNaInqZDMK493ZEZvYa
    U+fMZtPGytw9yFWknEAVE95jtrfNArtOgBoiFIVtWH4nerXAZFLuTJLvFL0WbmUI
    kKhm9szfpY0/iidoVk7WDzMGnyZCMt5SCuey5wWg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfC087axgs8Fx8qcKgrYqLYfJd+FRIQt13gzRrh0UrWZJ8Re4JpQtzeyUzT8w9H9zGfEudd0rEHodKsGE/ooF6fKkisQi8Z80nq2pQmVNEqa13le04QW7
    B30aKzlRneZKS2rsXYM3RjdPps7xp4hG6FrzwxAy7jC20zp9vJx02q3Zt3EmKS+47DcraGb5wWwgiNadWCUopafBL1te/gIQRC1drbHrhrQx9ekuwORgSHyf
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=BTeA3XvPAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=HQYL0dNX9r2gA2wembEA:9
    a=QEXdDO2ut3YA:10 a=tafbbOV3vt1XuEhzTjGK:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932418AbeDVORP (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:17:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58046 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932380AbeDVORM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:17:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Chen Feng <puck.chen@hisilicon.com>
Subject: [PATCH 4.4 47/97] random: use a tighter cap in credit_entropy_bits_safe()
Date: Sun, 22 Apr 2018 15:53:25 +0200
Message-Id: <20180422135307.931591836@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 9f886f4d1d292442b2f22a0a33321eae821bde40 upstream.

This fixes a harmless UBSAN where root could potentially end up
causing an overflow while bumping the entropy_total field (which is
ignored once the entropy pool has been initialized, and this generally
is completed during the boot sequence).

This is marginal for the stable kernel series, but it's a really
trivial patch, and it fixes UBSAN warning that might cause security
folks to get overly excited for no reason.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: Chen Feng <puck.chen@hisilicon.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -724,7 +724,7 @@ retry:
 
 static int credit_entropy_bits_safe(struct entropy_store *r, int nbits)
 {
-	const int nbits_max = (int)(~0U >> (ENTROPY_SHIFT + 1));
+	const int nbits_max = r->poolinfo->poolwords * 32;
 
 	if (nbits < 0)
 		return -EINVAL;
