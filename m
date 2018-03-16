Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsIjldBUVD+f8yhkqcPpyO6+G2okuGaAkFFAPjKqohHaZaoGmnbPeOGBb1bT+9npeunafCZ
ARC-Seal: i=1; a=rsa-sha256; t=1521214706; cv=none;
        d=google.com; s=arc-20160816;
        b=bhJXgzWskJkg7xragXdwFzxaBMIoqC+LbZxsG9787Gnj8YOF7TcCqaxK/SJxXf2Z6f
         X+hEyyzMJrLlD7UDduQ/q/2y/gxUECUBM9ZLe6SMivgERFpxxy+mcASJe8/Uv7Sp5cTp
         Pcpd4OJ1lRtEBSiSnxSwVrug92iUFo0BlbnJEfUSs6VRb+pDY3dPWsngoUTh+AE4cU4S
         d8PuoS3ZUTGpK5v2HV1/eDrSlF6bt/fxV2+y0xNv9QTCA2LYc0M79Zc1/4/DLcqiQ9/V
         xZXYEFOQUu3yVzvEo183dHDI3RTk3sn8OAec7HGb4UL6RTyCXZhEpPCgdIrfYCe/HZTJ
         0sRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6sxj+mcWcGH48MUNreBJBxLWQR8vBcQfdN7bVXpud8Q=;
        b=asm9oh76P+P3j8mj+D8hwsqgQI5XRnEbAKQKWx7+TUJh/JkUfGL2+XUNsGjbTD8MUr
         OXXyPnlHa7ndB9Kds/Qkg5Za4KeXcSZb3BjaB2kM4KuH5y2TWPP4e4KQMy9d1po8BI0D
         9bBh4Dyi6bqljrSRIKFR/eG75Aj9y2gv7/t0+YwbQWd8xxhg4DF5H7ZgBoinQyXPhEIS
         MfEEBJGqIblHGlq/vLNs+sU3oMVLzd0MjUwalV7gkSDwxoKnoyjx3M9qvNLUHcVaQZ/a
         lO7SypvxaHYP7clZXPCKJa+tpp+Lpg7q0TmNDbiuQG7DT73ltmGBsiP9TQvolD2Fx8jC
         /C7Q==
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
Subject: [PATCH 4.14 099/109] crypto: caam/qi - use correct print specifier for size_t
Date: Fri, 16 Mar 2018 16:24:08 +0100
Message-Id: <20180316152335.255169888@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109231762934341?=
X-GMAIL-MSGID: =?utf-8?q?1595109231762934341?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
