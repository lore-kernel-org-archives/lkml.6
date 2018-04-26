Return-Path: <SRS0=vINO=HP=oracle.com=dan.carpenter@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1849447-1524721975-2-7671433661955689050
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  UNPARSEABLE_RELAY 0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=vINO=HP=oracle.com=dan.carpenter@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524721974; b=nMi+9okcdWSYXQhg6qDGUpGt3e3bdHNoh0X7O6u2Iz3/ynX4HC
    Prgpm50mEtEboxU8xJgu+OM99k5OSWx70AGS6Q2AQG+k4XLoB5BU0iZSV/WcqTe/
    4O+vumVKamS1G0ceQpbmFyUK/2SRt3bOth6us77zqHq+I8vg7P1KgP+KoJPHDiLW
    0YcXnQFFbtAO9NK0v5pe5zxVZ2zGyfVz6Z639fCkCZD+MxahTnSf7O8vJJOS9UFA
    CkBt3u7jiwc084VW0dGc9G6MVH9TXoL214dXNVwHKRuE/fuQSV9O954Rq8Jxyt7/
    cqphDw8FvA39SPOs+yIZbmLwhm4vCLEtsG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:in-reply-to; s=fm2; t=1524721974; bh=
    wD31ENNtU7zOIeq3X9RVLxM6D5E+/5VejoxwvbZNQlQ=; b=CXkXJ6CAdzPY20d8
    iARMrp+MIrM5wVd+mlby58Ym/OQ4vX1bN+iez6cKRm2BCANarV+sljv+HEP8Jbkg
    vAqXRYV/2DaKI4PSZiJ8oRJJ/9FFwBUwJmznWrNCe5Q8k+fZOAlXu91ZIKsC2buq
    bWpr5F3j4J7by2lhZo1gO3PC9BwNoUf3/hYHo+hJmorQrmkBVz4324bbEHpyrrSb
    Y/zUZFCVIisFencZhUp3GQ72OfkVwlGgu/3SLMgaU/i/mK+tTnx10B9uf/PGMMMv
    672NJnmVRfG4Qmv8J0FUwwufEpDCjdVckQ7sW6KFiSJRVUiy4hhWdF+9CC/sutgK
    d6vRNg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=HCsonCoK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=vINO=HP=oracle.com=dan.carpenter@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=HCsonCoK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=vINO=HP=oracle.com=dan.carpenter@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFthSS7ht9EiZUpTPNw+b3fDYsL8GLUeOKr8Tie7GMvCbIkdKHdLz7mUxfIsnoqSIUpmoCq7elcNOlXEjG83RU7njnF/r0uitgwUtRdj2lgZPe7cJi9v
    1uk4vPbNRf9AlADOodOKXCovnuZSrykct4DIeoFOWmhXb5OsoxKsek+lqyjaKTirs5cUzRY3b1RDTQ/UqeKX+etGWpOWq+++JpqnrUoKjNKddZCH106tUZr1
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=AYtqSYW1AAAA:8 a=yPCof4ZbAAAA:8 a=srbVaA9xVWCJTdr_0wgA:9 a=CjuIK1q_8ugA:10
    a=WtHkaixNIbui_3fsm1s1:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC09221745
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=dan.carpenter@oracle.com
Date: Thu, 26 Apr 2018 08:52:35 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sun Peng <sun_peng@topsec.com.cn>
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        security@kernel.org, Tony Lindgren <tony@atomide.com>,
        Lars Poeschel <poeschel@lemonage.de>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/4] tty: n_gsm: add some locking around gsm_mux[]
Message-ID: <20180426055235.GA15229@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420083028.7fq3hw2mjjd7nrra@mwanda>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8874 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=857
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804260056
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We should take "gsm_mux_lock" when we access gsm_mux[].

Reported-by: Sun Peng <sun_peng@topsec.com.cn>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 3b3e1f6632d7..cc7f68814200 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2898,18 +2898,22 @@ static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
 	bool alloc = false;
 	int ret;
 
-	line = line & 0x3F;
 
 	if (mux >= MAX_MUX)
 		return -ENXIO;
-	/* FIXME: we need to lock gsm_mux for lifetimes of ttys eventually */
-	if (gsm_mux[mux] == NULL)
-		return -EUNATCH;
+
+	line = line & 0x3F;
 	if (line == 0 || line > 61)	/* 62/63 reserved */
 		return -ECHRNG;
+
+	spin_lock(&gsm_mux_lock);
 	gsm = gsm_mux[mux];
+	spin_unlock(&gsm_mux_lock);
+	if (!gsm)
+		return -EUNATCH;
 	if (gsm->dead)
 		return -EL2HLT;
+
 	/* If DLCI 0 is not yet fully open return an error.
 	This is ok from a locking
 	perspective as we don't have to worry about this
