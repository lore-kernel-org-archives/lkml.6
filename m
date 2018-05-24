Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156047-2-6437945932617672346
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527156046; b=d7Atvlpi/v0AzzJxi235TY+lv2dOUYYhLzbnR4qMkqUfv0sSaS
    gVpizpQGKsoxH6ihY/x8V02/XwGeNwMVncZUGsQ1SH196PMSEsa/rUOlr5mgwqiZ
    1YFvdH7MrZX9oWVQGVUdN5ZQwNfiR0HNC4k/YDH4810zOSOtb4yDVFqOV91P/4QC
    gWeLDN983y9fzGKch54ev4V+t/BHMby2XaRe7b8LSf+snrPZHojZ7o7uU1Fu3NmG
    MNnQuzfRSXvfiGExxtli3cX3LeLbLIKPLLENklNwEklrBBBKz/SlNOlHrygiuj+b
    ejhSmjWAV0idiMO75DPxUu/LAYnBes2lsSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type; s=fm2; t=
    1527156046; bh=MeEaFOk0MGNSQPypQCHfNEMqtZ0DZyXw7LeuV9+vKO0=; b=I
    YTM6aR3kKIs1a7dZaLYOhOm6yLVtxGWWC3aqJ8zLQ1JMWqLK3HSfH/sgDs0uJ9Ah
    a2HXfX1qH7nTJKq4HixOhi6eFJwxEGeUBYCJ9nwi4KgrBPjulhfsUw1vtlPygooS
    thwa9V/maqYHBuU+PeVYVBWch/xF0wQm+AtfU/6vxG0NCTaInZWNQJpD4Mdg6MzE
    YfWRxpvDAq4xhLmz8DWdOPcxREIWgNQhdc4KN29udy/hqTol/KzaItQFevZsOQzd
    wQC50AluRxRmBlkDWwGQq8pWZVTMC3LMndfbHcDVtgot9ZDvBwkfpbY1+y4y5KVv
    huU3O/qsQOzkC4wWb5mQw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=cB8HFQkl x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=pass
    smtp.mailfrom="SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org"
    smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=cB8HFQkl x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=pass
      smtp.mailfrom="SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org"
      smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC4YgMNu6N2EWImrRRyngCHQUhWX51R01v/Dkz8mKpfTFv4v/kuWGYgpATAoUAXQOh2SWuv/FM4EKTMFCeT+kMBK5cSVdqnpwENcj4qUufMS5on0HPwz
    /1fsokN2PwlblUy+snfTR6m+W2EchrvGI6cQngkBRKQeO6wSMZGcu/fwwZG6/aPRITy8aD2KKQzjLRGTexu1otcZxRNhl6RZ+/3Pr9GdLJ+Jq9qPpp1EXqyp
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=8vRx38_tVF0tVzjOe2IA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	greg@kroah.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.16 043/161] powerpc/pseries: Use the security flags in pseries_setup_rfi_flush()
Date: Thu, 24 May 2018 11:37:48 +0200
Message-Id: <20180524093023.538534106@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit 2e4a16161fcd324b1f9bf6cb6856529f7eaf0689 upstream.

Now that we have the security flags we can simplify the code in
pseries_setup_rfi_flush() because the security flags have pessimistic
defaults.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/setup.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -501,30 +501,27 @@ static void pseries_setup_rfi_flush(void
 	bool enable;
 	long rc;
 
-	/* Enable by default */
-	enable = true;
-	types = L1D_FLUSH_FALLBACK;
-
 	rc = plpar_get_cpu_characteristics(&result);
-	if (rc == H_SUCCESS) {
+	if (rc == H_SUCCESS)
 		init_cpu_char_feature_flags(&result);
 
-		if (result.character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
-			types |= L1D_FLUSH_MTTRIG;
-		if (result.character & H_CPU_CHAR_L1D_FLUSH_ORI30)
-			types |= L1D_FLUSH_ORI;
-
-		if ((!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR)) ||
-		    (!(result.behaviour & H_CPU_BEHAV_FAVOUR_SECURITY)))
-			enable = false;
-	}
-
 	/*
 	 * We're the guest so this doesn't apply to us, clear it to simplify
 	 * handling of it elsewhere.
 	 */
 	security_ftr_clear(SEC_FTR_L1D_FLUSH_HV);
 
+	types = L1D_FLUSH_FALLBACK;
+
+	if (security_ftr_enabled(SEC_FTR_L1D_FLUSH_TRIG2))
+		types |= L1D_FLUSH_MTTRIG;
+
+	if (security_ftr_enabled(SEC_FTR_L1D_FLUSH_ORI30))
+		types |= L1D_FLUSH_ORI;
+
+	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) && \
+		 security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR);
+
 	setup_rfi_flush(types, enable);
 }
 
