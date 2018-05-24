Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156021-2-647381272462972951
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
    1527156020; b=cXb0ZWZyBGNY9LxT7HniTP0k84uFADH5IiapyCmqSTcysfjsZ2
    SnnhOHa9aI+DsfImnFKp7JA9Sb3hrgfaRexGBT0WOjREl6x0Na4BbBnUxWVkTWIF
    CjjEgp9ljSG3BxBX/Gvu4apLnaxelS4SYEx/9ySncksA0OefmgcmPT4tymZkAwti
    u6SNZoqvAR5EzwcBuhK0fczmQTTqep6LuHInbcgfM5Bi9NBuvvynQGeiEydirDaY
    HP4tDfTUAVwpKL/pXzajbse2Q/ZfwE99NK9yZWJFu/1aiO/PMJtfaKFcA4I9tF1n
    bqDAeZ4JSHdwyU9PqB2eXT3h+NrM1Itribzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type; s=fm2; t=
    1527156020; bh=c9/fVUo0OUcFuVicwys2UtrdzmDCgxojYrUatrNj/Yg=; b=n
    KcATb+aFENsZnQsWIL4HU7DfXKYhSehs35hPPIs8SXD9VRU2I8DkcoSObuVj/UZk
    9Z9uSJFL35W33B0hjPCxTMuE0UmxlDUJy50nlGRZEaDSL1C/Yeumwc5dDgeuPZ/3
    2xalJ2+SLu6HLfys9YDf3a13TJtiRSiI1WB4E2sPtsM1xWUrc5Om2TSL1ZRcxq0V
    HSLb/rfbgwTiQvG24zxzauX+SZAqE0RMevhKilCTmUKpbutOjH1jPHcKSPz+o0Z+
    Sjod7/j1shESntV5JS8LdZ2ODFPytiihMQG13NwQI035zngrLo0mndT5OPbQWMxK
    PaQfcyLOIotnJmPGENJyQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=g3BoI1TQ x-bits=1024 x-keytype=rsa
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
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=g3BoI1TQ x-bits=1024 x-keytype=rsa
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
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAdvtAiTTMQHoAtrQP/tcblWUU/mlNgJIkfCM7VsDfMRr2obiaxVAkYkN4y7nyJpRE2ev34s479A6KIqA7tq+mCgb1Gz0YsxOYJSU2m9FV7O0Bv03Qa7
    ccfo0LmNuWtcmc4lfgp/sN0lzvhPGAEBgGpkb8YYBjSR16n/RzLnt5ipurahwQP/fTtG3BOfgIMC2yu16pTCjppZIOjhb7v2wgCLPK/nwDWAeuol0XGhKqGN
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=t85fTSt3vdMCwxv8IC8A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	greg@kroah.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Subject: [PATCH 4.16 035/161] powerpc/rfi-flush: Always enable fallback flush on pseries
Date: Thu, 24 May 2018 11:37:40 +0200
Message-Id: <20180524093022.562595919@linuxfoundation.org>
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

commit 84749a58b6e382f109abf1e734bc4dd43c2c25bb upstream.

This ensures the fallback flush area is always allocated on pseries,
so in case a LPAR is migrated from a patched to an unpatched system,
it is possible to enable the fallback flush in the target system.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/setup.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -468,26 +468,18 @@ static void pseries_setup_rfi_flush(void
 
 	/* Enable by default */
 	enable = true;
+	types = L1D_FLUSH_FALLBACK;
 
 	rc = plpar_get_cpu_characteristics(&result);
 	if (rc == H_SUCCESS) {
-		types = L1D_FLUSH_NONE;
-
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
 			types |= L1D_FLUSH_MTTRIG;
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_ORI30)
 			types |= L1D_FLUSH_ORI;
 
-		/* Use fallback if nothing set in hcall */
-		if (types == L1D_FLUSH_NONE)
-			types = L1D_FLUSH_FALLBACK;
-
 		if ((!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR)) ||
 		    (!(result.behaviour & H_CPU_BEHAV_FAVOUR_SECURITY)))
 			enable = false;
-	} else {
-		/* Default to fallback if case hcall is not available */
-		types = L1D_FLUSH_FALLBACK;
 	}
 
 	setup_rfi_flush(types, enable);
