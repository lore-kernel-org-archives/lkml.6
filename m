Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527156050-2-12584688974717975102
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
    1527156049; b=ass3es6M3HOxge8YD1iKXZ1IT0UKF98nULginfPNuLqUh5hgx6
    ArYCxYfmF6+2n6dtSILK1lWdEijju9fNggwGkTUylGd0cI7UArzKVPSW1vt8u2WO
    9V5nQ22ueuzHgH74wjkRSgkBPTWTotpAPXQ5FtRri/3RA6ghRvoVpw6xgYthTAHI
    Of7j9mjzcYNj63xIBpZTg5RjIn5UzHis/BzRde+x0rvzCyZqcMlDb4g3SvIZaD9b
    CPDzpbvuG+QDu4CXQuFkyeMNkJUgT742GXbUW6Qvyn0rftirpmbgEt2nGKc+m3V9
    zadroZ9WAf1+OVLgGczZPz35FL2O71GnI6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type; s=fm2; t=
    1527156049; bh=KoVKndfSTZ5BljIyIq3co4a8lbiFBBaumbuKKpRMTO8=; b=O
    TnYFZD8TpSx9EzB+qvMaZfD9FujGcQT1f3T4aWwnqeClTpGd5yEXfcYcIHdt920g
    j49NJHVqnfAsLObeMwox/35wQjJ2ekcTdUeB+11Mqp9fLXxmK09vJ+LI3dOJEJBB
    woamrHsG46POqWX27qSJSUTZ9NNVW7Xb0HBmwm0JZ8+DVTBDFRk5l3VjKHPiuNYM
    8gPNrGLOl1Wu56uWdu0v2RXwA3zG9rLPQztpqeUM5U9CKrS0qFzOIgXAW8ZcSb4U
    tGPJKXmxHLge1LX1gZMEMKRK3qBtypoDlFeQGG/zQ3FYVgo2ONYFWswkdof4dRPL
    H3CY0ncdRbSkskmxaWNfg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=0s6w8+UK x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=0s6w8+UK x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfHWYrt6wEq0ja+8IqUxsAdVz7GfoNvAABoQBvWNM0unVN4YjgAhvh4f1/s8jFecMxqgr87qzryRIwLcgzqk27dKknNIIDWyMBwlDYSY9PiqxEvey6Puf
    npQltKyWKWhAIrgTQYKB8fmKKPzRW+fGHW9RPLfswvbXhH3LASRUdNeNb9YRE8XV4GwHhE6cjjaBXzg6LpfqZ+T/llRuDkKhhoA6DvxuLj0zR6EfSiBkpNeb
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=d0IehV0JNGKWzH5UNt0A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	greg@kroah.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.16 044/161] powerpc/64s: Wire up cpu_show_spectre_v1()
Date: Thu, 24 May 2018 11:37:49 +0200
Message-Id: <20180524093023.640028407@linuxfoundation.org>
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

commit 56986016cb8cd9050e601831fe89f332b4e3c46e upstream.

Add a definition for cpu_show_spectre_v1() to override the generic
version. Currently this just prints "Not affected" or "Vulnerable"
based on the firmware flag.

Although the kernel does have array_index_nospec() in a few places, we
haven't yet audited all the powerpc code to see where it's necessary,
so for now we don't list that as a mitigation.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/security.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -50,3 +50,11 @@ ssize_t cpu_show_meltdown(struct device
 
 	return sprintf(buf, "Vulnerable\n");
 }
+
+ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	if (!security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR))
+		return sprintf(buf, "Not affected\n");
+
+	return sprintf(buf, "Vulnerable\n");
+}
