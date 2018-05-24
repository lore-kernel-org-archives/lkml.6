Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527156052-2-2471810636464637820
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
    1527156052; b=gGjZ6rqrKqVqLbZDsr/uX8XLLhKilYut+808yeGSOQk9AG37L1
    mzMv9RomohHjz38EQrWbtmcl/PBaI8+PI9Lmx9+9LMTtxp3GaT6WWR9wHYex+HC+
    ywCokqzuJ5z0fXJA3JFDw/jciVIgnWZi+CqUO0wvXmE12PIXMo7oM+J2gVyX3RjM
    CvDipDfVbr0rsyHNkWGsLgN92vEMJVb3mO7vvXBN3c+pCplwjwF4C28UEcxFtVxH
    4ksMBxjDd4SRbR82lXuZEKH/Yx5oqbwun8U4qPE4I5tGPAC91byxR6mux2YpWhzL
    itUC3Jo/Ajrs+H9ydtotjhpjk1h3DtLqALtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type; s=fm2; t=
    1527156052; bh=kg4v8WQ0Dtg4Mm6WpBvv8rVRtTqncdT6FG416/YN3O0=; b=G
    csE/lhhJHb/DEVhXuRgruzU4d20E90yo6QnLDZHNVUyyRaGdEImlhKZ3Kpr+Lz4T
    Jd5ISBqRoMw0vRpj6OHzgAQu+I8R0c3N8Wh2hgVay97ENXQdOoYh4VGg+o/h8GkI
    kash9QsjmFr+CnzTgClk1FIeQtqCx8yI3awAqQ/4juZJl3+NNJetOrcg/bia3aFt
    sWx+t61WscEG6dtj86HY9H6IGzhcYtJuc5lo6CyE1+5NHgMRUJPUUmBHWAmYC4+s
    fHQFPUUK5+WiaKKEwvwzklC7hM8cLHVvqbcc2nPix8AqrKxiKi+L7rXi2akn9KCX
    Mpc+93uN+qEEDVy4Um86A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=PWa68u2D x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=PWa68u2D x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfK6bh+cpWDLML0pKubdVXfDlMAPNMEuzI8dcW4uG01lWt6XdGJAIWqQPZK3RRQoo6lhpxnB7h1Po3fzJ957AVh9ZNhHon0Bnwtlh2p6m3BNVKIif19ZK
    HQqjL4ros0ic8uMcqo7A63EbkrTTfbGsdnUpo/5H1z7vAZKVXQszeusxkQ45IY9RxsuWZsKNrwwuZ9pHCHxzTLJHpgysxVBIegEER7qqoh8sR9aDcCRLD9dy
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=Z4KKdM25U3oJDl1ujtkA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	greg@kroah.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.16 045/161] powerpc/64s: Wire up cpu_show_spectre_v2()
Date: Thu, 24 May 2018 11:37:50 +0200
Message-Id: <20180524093023.761898151@linuxfoundation.org>
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

commit d6fbe1c55c55c6937cbea3531af7da84ab7473c3 upstream.

Add a definition for cpu_show_spectre_v2() to override the generic
version. This has several permuations, though in practice some may not
occur we cater for any combination.

The most verbose is:

  Mitigation: Indirect branch serialisation (kernel only), Indirect
  branch cache disabled, ori31 speculation barrier enabled

We don't treat the ori31 speculation barrier as a mitigation on its
own, because it has to be *used* by code in order to be a mitigation
and we don't know if userspace is doing that. So if that's all we see
we say:

  Vulnerable, ori31 speculation barrier enabled

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/security.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -58,3 +58,36 @@ ssize_t cpu_show_spectre_v1(struct devic
 
 	return sprintf(buf, "Vulnerable\n");
 }
+
+ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	bool bcs, ccd, ori;
+	struct seq_buf s;
+
+	seq_buf_init(&s, buf, PAGE_SIZE - 1);
+
+	bcs = security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED);
+	ccd = security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABLED);
+	ori = security_ftr_enabled(SEC_FTR_SPEC_BAR_ORI31);
+
+	if (bcs || ccd) {
+		seq_buf_printf(&s, "Mitigation: ");
+
+		if (bcs)
+			seq_buf_printf(&s, "Indirect branch serialisation (kernel only)");
+
+		if (bcs && ccd)
+			seq_buf_printf(&s, ", ");
+
+		if (ccd)
+			seq_buf_printf(&s, "Indirect branch cache disabled");
+	} else
+		seq_buf_printf(&s, "Vulnerable");
+
+	if (ori)
+		seq_buf_printf(&s, ", ori31 speculation barrier enabled");
+
+	seq_buf_printf(&s, "\n");
+
+	return s.len;
+}
