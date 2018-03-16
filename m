Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt/jVIJLnwlqQY/mUR3id0SwEp1KQdXKMxjzwLvn/ppJ+Bg2LF7cV4snthzRedwrXcZicxL
ARC-Seal: i=1; a=rsa-sha256; t=1521215107; cv=none;
        d=google.com; s=arc-20160816;
        b=Lv1vVCU4NokrFQBc0h1DX7HZi+A13VCadqJthPqfz4d2Kfdf8a2hC4MW0CPbWjuNP+
         07/VZpI9YLvMkxdZmEIzaLg8QaGR79eDKcfVt7FGUq+DTuoUq8K8GFlzg22zO2ocIN/J
         cocqDqiKeAD8zdF3xcZc/eVba1lDnb8ej57mZ/3WXHJQiKCnRz4bE7xlH8pBa1BGizNl
         gZRxapWp2fbYd/vdLf6aonYzMhj2iP/nZ9TR8ROhlB8exqddSebAkrCi5T5widWBJVsq
         W9WGG8sO5wLjr3pRE7zoE8+wnY0jM/GCHFFtytgT3bkEq8cjsmbbpOwSY2zgkt2x9ZIL
         zXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WJQe1C6vtN+fkvgqLiaA60i/plVQMzWbomF8AEQqZ+k=;
        b=FYA0aMjxB5vEk5VXGiyG6/vM8MzItY9Mspmw83h+TToEx20jRh1xBIF70z8WFVnOAw
         zn6LRt21pLvDqs6CdkWBn47rZ25rEdO4XB27/UiRiWSa0509x9L7xsECyCk6Epd3f2jz
         6OSMWqphzV3mpnJPyiEg7eR7OX/ppuMHZN+7pvxOtWSZu5fY1cDT0BhyZ6wDbkFuGHhL
         B6/qOHk9oG6UZuQqAQ0tw0YgNjuZq7PQjAe+IdojfUT+8eeoEsHnpvsOAuEzoN1vs0Sg
         9oF/OZXzpV/pnzxxzy0Lwe2CqW0GSkqRx5DwNpvPDoA+DLgogXhzDK+P7NGPV9vswFCF
         t84A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 118/128] crypto: caam/qi - use correct print specifier for size_t
Date: Fri, 16 Mar 2018 16:24:19 +0100
Message-Id: <20180316152342.344342092@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109231762934341?=
X-GMAIL-MSGID: =?utf-8?q?1595109652847411945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Horia Geantă" <horia.geanta@nxp.com>


[ Upstream commit 9db09e3bad65393dc23b0279beb7f3754d77065c ]

Fix below warnings on ARMv7 by using %zu for printing size_t values:

drivers/crypto/caam/caamalg_qi.c: In function aead_edesc_alloc:
drivers/crypto/caam/caamalg_qi.c:417:17: warning: format %lu expects argument of type long unsigned int, but argument 4 has type unsigned int [-Wformat=]
   sizeof(struct qm_sg_entry))
                 ^
drivers/crypto/caam/caamalg_qi.c:672:16: note: in expansion of macro CAAM_QI_MAX_AEAD_SG
    qm_sg_ents, CAAM_QI_MAX_AEAD_SG);
                ^
drivers/crypto/caam/caamalg_qi.c: In function ablkcipher_edesc_alloc:
drivers/crypto/caam/caamalg_qi.c:440:17: warning: format %lu expects argument of type long unsigned int, but argument 4 has type unsigned int [-Wformat=]
   sizeof(struct qm_sg_entry))
                 ^
drivers/crypto/caam/caamalg_qi.c:909:16: note: in expansion of macro CAAM_QI_MAX_ABLKCIPHER_SG
    qm_sg_ents, CAAM_QI_MAX_ABLKCIPHER_SG);
                ^
drivers/crypto/caam/caamalg_qi.c: In function ablkcipher_giv_edesc_alloc:
drivers/crypto/caam/caamalg_qi.c:440:17: warning: format %lu expects argument of type long unsigned int, but argument 4 has type unsigned int [-Wformat=]
   sizeof(struct qm_sg_entry))
                 ^
drivers/crypto/caam/caamalg_qi.c:1062:16: note: in expansion of macro CAAM_QI_MAX_ABLKCIPHER_SG
    qm_sg_ents, CAAM_QI_MAX_ABLKCIPHER_SG);
                ^

Fixes: eb9ba37dc15a ("crypto: caam/qi - handle large number of S/Gs case")
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/caam/caamalg_qi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -668,7 +668,7 @@ static struct aead_edesc *aead_edesc_all
 	qm_sg_ents = 1 + !!ivsize + mapped_src_nents +
 		     (mapped_dst_nents > 1 ? mapped_dst_nents : 0);
 	if (unlikely(qm_sg_ents > CAAM_QI_MAX_AEAD_SG)) {
-		dev_err(qidev, "Insufficient S/G entries: %d > %lu\n",
+		dev_err(qidev, "Insufficient S/G entries: %d > %zu\n",
 			qm_sg_ents, CAAM_QI_MAX_AEAD_SG);
 		caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents,
 			   iv_dma, ivsize, op_type, 0, 0);
@@ -905,7 +905,7 @@ static struct ablkcipher_edesc *ablkciph
 
 	qm_sg_ents += mapped_dst_nents > 1 ? mapped_dst_nents : 0;
 	if (unlikely(qm_sg_ents > CAAM_QI_MAX_ABLKCIPHER_SG)) {
-		dev_err(qidev, "Insufficient S/G entries: %d > %lu\n",
+		dev_err(qidev, "Insufficient S/G entries: %d > %zu\n",
 			qm_sg_ents, CAAM_QI_MAX_ABLKCIPHER_SG);
 		caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents,
 			   iv_dma, ivsize, op_type, 0, 0);
@@ -1058,7 +1058,7 @@ static struct ablkcipher_edesc *ablkciph
 	}
 
 	if (unlikely(qm_sg_ents > CAAM_QI_MAX_ABLKCIPHER_SG)) {
-		dev_err(qidev, "Insufficient S/G entries: %d > %lu\n",
+		dev_err(qidev, "Insufficient S/G entries: %d > %zu\n",
 			qm_sg_ents, CAAM_QI_MAX_ABLKCIPHER_SG);
 		caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents,
 			   iv_dma, ivsize, GIVENCRYPT, 0, 0);
