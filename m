Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+u6/qB8sA7WPv1tV28iXuLBByYm8bAcRQC6YLqKXDoD1V+Qk9Dt4z0r6gJllBkV2o4+rt+
ARC-Seal: i=1; a=rsa-sha256; t=1522346573; cv=none;
        d=google.com; s=arc-20160816;
        b=HRfcnsY8GUVJ1vDnI73xf2eL5iD7hvHuA0g+wfvJj7bziG66Eu5NJ2s8v4fOFnMv5M
         8L1ljmyJogE1BySJc+IYllN5pCecooUOBlhl1UjTTVwT/oYGrmxU5+i/K8iX93rDtsE0
         jMo4C0zoz2GZpumcMaAWIwJareNPNNKWKGueImyaHus1q2rSYU0072c69jKEbMOaAq25
         stCQkwlHKXWF4SBf6m/OavKUe24E+oiHXMtRfwaLr8OUW8RYEvXkmsp1SkwJiCIz11b3
         q7bxHsbV1GJ22EKAKhCKDzlDwTai1TS7hk7MZw/vZ+j7VOPiIYm2m7YltwXTF87TXC06
         XjeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CNcAfU7GOq3HVrQTI0D/rM2iMDRKGJ4sdqZtJsGFyb8=;
        b=UnAPieo3fn8GWrIlsW0FvQJsxKeOeopdrDE9/c1VIKQ765byalONUhmKsJga+KWI24
         OMSkIsqkvNYoo/S7SNJqUdHCXrk8hM0JNhbxmCBlpYXPUcPJdbkO9gWn1WGDlpwlNAgN
         otVygTznDjbM55s4xnU9eygUc74IuGsc1sn1K0G4CyQ0rEuD/6iecHbgDSU5+01YGrw3
         2r4LZIl+rp+cg3SC+GKdBJJPSJQqKTerOC5yTGotWFY6RIBnpJAJpNez+JYLiYTUHdDS
         av7BKQskBc59cSXzinqZyRn5ioyLyLEYY+J7Gr7rH+xmlTt7UkZPNcZVIpR0b9LOwZ3C
         owKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Camelia Groza <camelia.groza@nxp.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 32/47] dpaa_eth: remove duplicate initialization
Date: Thu, 29 Mar 2018 20:00:13 +0200
Message-Id: <20180329175731.837873050@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296080196572960?=
X-GMAIL-MSGID: =?utf-8?q?1596296080196572960?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Camelia Groza <camelia.groza@nxp.com>


[ Upstream commit 565186362b73226a288830abe595f05f0cec0bbc ]

The fd_format has already been initialized at this point.

Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2278,7 +2278,6 @@ static enum qman_cb_dqrr_result rx_defau
 	vaddr = phys_to_virt(addr);
 	prefetch(vaddr + qm_fd_get_offset(fd));
 
-	fd_format = qm_fd_get_format(fd);
 	/* The only FD types that we may receive are contig and S/G */
 	WARN_ON((fd_format != qm_fd_contig) && (fd_format != qm_fd_sg));
 
