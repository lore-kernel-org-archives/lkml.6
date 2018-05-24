Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156044-2-801607598551214002
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527156043; b=A8W7scUuaCfpI46Koz7ZuBw+iEW0E/1viBl+orVaTJZGXs5+RU
    +IsHU9dUANqPimNXgOB5tCB7lKCsbBOxx67eAyfDYgVhf+1lNxWjfbXNI+MzsRlu
    Z8rNU0zHpGPXM/ZqxFKB4H2cVhd14yrVlMhjl7Dw8I6fwmIKXKN43dsjlT+HJzhL
    CGPBubx7AfJE8bdMpWiRgK0EvAolUUxITfrTfV1bBZGkHAzVl/n7o3sg6f3css2Q
    drYFAFTCu/C1nLpIcClRj/SFDux78IzpHbZP2y7NnEfEdVNM7YiQO0yylrPpsea7
    fdsMIallb5jlsV15IaqaBx3Ax29gv/NNwPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type; s=fm2; t=
    1527156043; bh=Ilkctlkw3EuLS9edG72OzQHlnuhuRIaeD+T9qOdGHFM=; b=T
    Ci2BJ/97+7e7fqoZlTCFYLM0lZz0G6nzZgAvkkocoSqa90x0MKfyOqD0TXHABZPJ
    mr0LpJ/jM0hHlWkeyAUcXVPygnWmVlMyncmz5p8eHDWomSpfmiNSCH2Cnng00gdY
    PSrTGbX7P72II3/ddxXfg8p2MuWW7hPFxGYu0lDXmlo1kHOfXYUBUyCIQH4P60z3
    qPipU9tTligUxwFrpFQVk90cApCfBOdWEycPQp7s4+03fPLcOUnno0qlv4GSLZEG
    9Qpg7lAGhMChYm0VWSeEb9O9WeQqzOIbB/Zkad5i19iQ+IJveBG78GA+EHGoJ1n2
    hnh6StMmrAIyvc4uCfG8g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=gC9x7x59 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=gC9x7x59 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfMP8ozITHj0je9T9YR5HxtIs/90Y+Exu+M4/AVXnYMxBu5Sai51tuKRlI8Jxg7bZPh1uCV7x6MP2IN19TavLFcNcdoOuMSth0W2yqaJK09nFGfClaZB2
    MONLGIMXn5lrCVl5guFUuoNBYOyeBMHBiaaqcnPTi14nRb5i0+Nb3ETTgM4XAc4ximvHXCTPhfr/iGipKR2SCL1/Htq92wzPCpvBQbJh4lFCda2injMsv70e
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=QnBerKj8dotVBY-Hzz8A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	greg@kroah.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.16 042/161] powerpc/powernv: Use the security flags in pnv_setup_rfi_flush()
Date: Thu, 24 May 2018 11:37:47 +0200
Message-Id: <20180524093023.407204916@linuxfoundation.org>
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

commit 37c0bdd00d3ae83369ab60a6712c28e11e6458d5 upstream.

Now that we have the security flags we can significantly simplify the
code in pnv_setup_rfi_flush(), because we can use the flags instead of
checking device tree properties and because the security flags have
pessimistic defaults.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/powernv/setup.c |   41 ++++++++-------------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -66,7 +66,7 @@ static void init_fw_feat_flags(struct de
 	if (fw_feature_is("enabled", "fw-bcctrl-serialized", np))
 		security_ftr_set(SEC_FTR_BCCTRL_SERIALISED);
 
-	if (fw_feature_is("enabled", "inst-spec-barrier-ori31,31,0", np))
+	if (fw_feature_is("enabled", "inst-l1d-flush-ori30,30,0", np))
 		security_ftr_set(SEC_FTR_L1D_FLUSH_ORI30);
 
 	if (fw_feature_is("enabled", "inst-l1d-flush-trig2", np))
@@ -99,11 +99,10 @@ static void pnv_setup_rfi_flush(void)
 {
 	struct device_node *np, *fw_features;
 	enum l1d_flush_type type;
-	int enable;
+	bool enable;
 
 	/* Default to fallback in case fw-features are not available */
 	type = L1D_FLUSH_FALLBACK;
-	enable = 1;
 
 	np = of_find_node_by_name(NULL, "ibm,opal");
 	fw_features = of_get_child_by_name(np, "fw-features");
@@ -111,40 +110,20 @@ static void pnv_setup_rfi_flush(void)
 
 	if (fw_features) {
 		init_fw_feat_flags(fw_features);
+		of_node_put(fw_features);
 
-		np = of_get_child_by_name(fw_features, "inst-l1d-flush-trig2");
-		if (np && of_property_read_bool(np, "enabled"))
+		if (security_ftr_enabled(SEC_FTR_L1D_FLUSH_TRIG2))
 			type = L1D_FLUSH_MTTRIG;
 
-		of_node_put(np);
-
-		np = of_get_child_by_name(fw_features, "inst-l1d-flush-ori30,30,0");
-		if (np && of_property_read_bool(np, "enabled"))
+		if (security_ftr_enabled(SEC_FTR_L1D_FLUSH_ORI30))
 			type = L1D_FLUSH_ORI;
-
-		of_node_put(np);
-
-		/* Enable unless firmware says NOT to */
-		enable = 2;
-		np = of_get_child_by_name(fw_features, "needs-l1d-flush-msr-hv-1-to-0");
-		if (np && of_property_read_bool(np, "disabled"))
-			enable--;
-
-		of_node_put(np);
-
-		np = of_get_child_by_name(fw_features, "needs-l1d-flush-msr-pr-0-to-1");
-		if (np && of_property_read_bool(np, "disabled"))
-			enable--;
-
-		np = of_get_child_by_name(fw_features, "speculation-policy-favor-security");
-		if (np && of_property_read_bool(np, "disabled"))
-			enable = 0;
-
-		of_node_put(np);
-		of_node_put(fw_features);
 	}
 
-	setup_rfi_flush(type, enable > 0);
+	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) && \
+		 (security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR)   || \
+		  security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV));
+
+	setup_rfi_flush(type, enable);
 }
 
 static void __init pnv_setup_arch(void)
