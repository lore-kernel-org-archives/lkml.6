Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156027-2-16735747679952319109
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
    1527156026; b=iqsdYi8c1vxvGGilOdOfGMKlzhXs5HQE6+hJueGk/mPMP3zC4s
    VVpsz3P2ggN/FxTEd3L7Qhue8HeT4q5/8O8a5XBGRmPP2ux169WnU6fLPBEAyYBI
    L/+hDfUtQ3pv2biczZUsL+U9sDRsXA0JslhJ+rLYNfPL4SVcG3rOJ7Aqcg4IDwWY
    O7VRM/cap9XZMmOJuGwtZpAlnlbJhtzX0j9LMpsC8w2qBp7EIFJ0w1PZeGGeOIx4
    oR+bKblvJTbSvUQKoYBtz9SU+lZg6bzPy3eQv//YhY+cG43s9I4tprCDc6pOaD7S
    xGU+Iw7ZF91fxGWcgE2BlXaC8O+aqnMTiqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type; s=fm2; t=
    1527156026; bh=HmGvQFbIMYIbcWkEys+ZfQ/hQMx/ihJZlfZqzTs+Tbs=; b=O
    RI9WAS033wSlRYZBzxRcsLLp+hyL3mG9gIrRnTs+nCvHZ+WWRJVQNekj9fcRDUOS
    rgZsnlf0h0F9Ns1L7LYAu25mqqnuFC7ktL8X6noxxfe7YD87U0+GKzNJcP9ijDuK
    /uIgLdWsAKtNPSfS7UW3mW+I85/LZB9P2F/pLN1pcgxNCQIZsiQiEignK2lZlqma
    ZPsQihdjSarwSi0BZ/RZ9kzoL6mhbW85N9XSJgQgcEogjI1IfBDBpEqEOULE6aN7
    zVuDOyoIsMZxrtjwnep9L0cqHSuvXfqLTgJhNjGcCKZtR4UYbvSeIf3wfZhS2mg5
    gCu0uZU3myEu+bxAdptxw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=KN0sxxzN x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=KN0sxxzN x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfN9k1a0+2H15z+4r6zoedyQwb+ktnEKhHsncxTIve+qblZ1xdjvG2FuS7EVmlnA/jhUChPvPlExPKbjUjzW3qujqD/TBSGWLj4LPcoQ+ZlroOv88RvD2
    eq1KK1iyj84eqYsiPVc+0rtr18Jf4Zl2QWEY2OZUAWTa4rxBwbn0RaVjtP6A6MuQARFI93OVJlAb6eUvTeZ7tvmz6VB4V6fhNhM0YH21TruBoF0uz9lSmxtn
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=vvlizlK6F9ouvwjLhVcA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	greg@kroah.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.16 037/161] powerpc/pseries: Add new H_GET_CPU_CHARACTERISTICS flags
Date: Thu, 24 May 2018 11:37:42 +0200
Message-Id: <20180524093022.815286667@linuxfoundation.org>
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

commit c4bc36628d7f8b664657d8bd6ad1c44c177880b7 upstream.

Add some additional values which have been defined for the
H_GET_CPU_CHARACTERISTICS hypercall.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/hvcall.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -337,6 +337,9 @@
 #define H_CPU_CHAR_L1D_FLUSH_ORI30	(1ull << 61) // IBM bit 2
 #define H_CPU_CHAR_L1D_FLUSH_TRIG2	(1ull << 60) // IBM bit 3
 #define H_CPU_CHAR_L1D_THREAD_PRIV	(1ull << 59) // IBM bit 4
+#define H_CPU_CHAR_BRANCH_HINTS_HONORED	(1ull << 58) // IBM bit 5
+#define H_CPU_CHAR_THREAD_RECONFIG_CTRL	(1ull << 57) // IBM bit 6
+#define H_CPU_CHAR_COUNT_CACHE_DISABLED	(1ull << 56) // IBM bit 7
 
 #define H_CPU_BEHAV_FAVOUR_SECURITY	(1ull << 63) // IBM bit 0
 #define H_CPU_BEHAV_L1D_FLUSH_PR	(1ull << 62) // IBM bit 1
