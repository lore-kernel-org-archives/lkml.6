Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48yGnFVzY3L2vbwc0f1emYRpXDaMB6vwUn39/Li40NDITvxqAL3nP3kQ1Z19V0flGWbrElH
ARC-Seal: i=1; a=rsa-sha256; t=1523472945; cv=none;
        d=google.com; s=arc-20160816;
        b=piVN4Tp/DmNz6pwHNxKYCdDYnQTJvpvMRclJnJGA4mZhJjG57NCyhb9DUdA94IeLHj
         /n3V2/cm89HLb9tEtw6Mg61jAHhWlKSfaaFBTg3ytVfNs59Nc6PN3cXfU79FpCB/Evgf
         lHPmc0Bn08SDL3SVD+gltE+UnHWK966y2x2zhkdcbNdwt/lNs0QDsbI/Xw/sV0spNMVD
         hUBrAgAPaoEt290glrDi/wZTduBt5g5eKIQoyWOj2lCwuDzpvWMVR7BCHmqOlaXEZxET
         Nv57Eu8u12T6AoDmsTTf1j9v2eJwpyouRFuTkPYbrNiCo+xTBBS3pNdnqu2PkGjIobRq
         /gQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HFNFx+EzUZJEzF2J7jrNxZPscSrLkkugr3igNoI1nfE=;
        b=IFKN8alR3BTA8RZ83rJMxCiCjYs0BbtgS+iOQ5X9J4zkdMVybSQqF7jbJymch9/YpZ
         E7ojecgpqHxmIxIz/cIs1JKpQ4cyVf1mFH5xQSAQURxB67NdrfiPcSz/FZQC+NAcCB2C
         h1FWsfBwKjGkUX111L38M4xmKrzXqWvkUXZFJuexgK/YIqtodbuSE69ftTD7B+6FjwBf
         PzFyxq1Crs7Jh+CqWEPLm78MOuHsCsaegUElTBaDozO4raPWZ+HEGFZN647xxwm3iXbE
         aSb797gdnfrYJbH7lSO42iwTuINap5wv+hjHVwEzQcW7b8l2+w0Wk9E8cmSKfPKH9DPc
         jJRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Holger Brunck <holger.brunck@keymile.com>,
	Zhao Qiang <qiang.zhao@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 074/310] fsl/qe: add bit description for SYNL register for GUMR
Date: Wed, 11 Apr 2018 20:33:33 +0200
Message-Id: <20180411183625.503352823@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477167551930414?=
X-GMAIL-MSGID: =?utf-8?q?1597477167551930414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Holger Brunck <holger.brunck@keymile.com>


[ Upstream commit c7f235a7c2d09b1b83671ba2d93ebee981554467 ]

Add the bitmask for the two bit SYNL register according to the QUICK
Engine Reference Manual.

Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
Cc: Zhao Qiang <qiang.zhao@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/soc/fsl/qe/qe.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -668,6 +668,10 @@ struct ucc_slow_pram {
 #define UCC_FAST_GUMR_CTSS	0x00800000
 #define UCC_FAST_GUMR_TXSY	0x00020000
 #define UCC_FAST_GUMR_RSYN	0x00010000
+#define UCC_FAST_GUMR_SYNL_MASK	0x0000C000
+#define UCC_FAST_GUMR_SYNL_16	0x0000C000
+#define UCC_FAST_GUMR_SYNL_8	0x00008000
+#define UCC_FAST_GUMR_SYNL_AUTO	0x00004000
 #define UCC_FAST_GUMR_RTSM	0x00002000
 #define UCC_FAST_GUMR_REVD	0x00000400
 #define UCC_FAST_GUMR_ENR	0x00000020
