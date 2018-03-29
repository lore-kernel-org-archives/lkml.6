Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+VIeoji8tQ5D7lFFa88QcDhyh4X0muOP3JOqrs4xQK6JTLaXrfEXo85D59vDBMha8EkgL0
ARC-Seal: i=1; a=rsa-sha256; t=1522346733; cv=none;
        d=google.com; s=arc-20160816;
        b=Y5Z19Tcr/DS0TZkaTsrj/TDNwmqrciwnU1xlLx29XCsC4YjihUYaZXicb71cBjGH0r
         xM0RVhHca/5c5egs5kaZpDDeSqFQhPvhj66ym8XrunTVDTZbFulSd5qh1h49sVP/oP/P
         rTrTgSxDRjrmJ0SLoiyFHB1lGnO9zJI622Bn+y8yC5PQ/ky8+Dm4Trv9DpRcth30zx+g
         osAjgXTnbpvhmH7fjZVEKLNoZVHZbcgGBR6IV429Ie71TAnBs0oT7ExLjEWP+DVFj9i3
         XeojCXrI3181Q4z18Hg8R1FWEayUCNxzDQ+kFfm4fVsqeS9SCVCLmLUe3CPsoVCyu7g/
         6rEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yxIxImd/T+W3CXs5jhHtuykv6NDYkqRiEpNWkG5hjm4=;
        b=CGTX0nFNwa0ndvzirqzV9bkeyHljl/HUTFwzCdqkvNlrCueiVpv2hV61kS22XHq5rh
         SkH1JfWmeyjh/5WmRwDwrihlENtOa7b7azoyb2O31WBa8g6bKC/MukBp87OyvzTADniN
         C+Bhn5WDGlXzMDU4t8bHPWUFB8yHV77/pEolvVU6zmHxDvqFmGRkAgAPP91iHXnVX7jf
         cFtvG4YDLN56ArSbr5pcDlAW1WCjk1+jypbfbv4tjoWGMdgc+2cW5DMtcIra2YdVXNgn
         vPJaDtqL2iF/ftFypQ2rE2xy/rsKgsu4GLRadgPLZWouIS9Mw6xXKJfQ7/Lkw3PcBCd/
         JweA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Camelia Groza <camelia.groza@nxp.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 39/43] dpaa_eth: remove duplicate increment of the tx_errors counter
Date: Thu, 29 Mar 2018 20:00:34 +0200
Message-Id: <20180329175734.411351952@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296086478689845?=
X-GMAIL-MSGID: =?utf-8?q?1596296248030825220?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Camelia Groza <camelia.groza@nxp.com>


[ Upstream commit 82d141cd19d088ee41feafde4a6f86eeb40d93c5 ]

The tx_errors counter is incremented by the dpaa_xmit caller.

Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2022,7 +2022,6 @@ static inline int dpaa_xmit(struct dpaa_
 	}
 
 	if (unlikely(err < 0)) {
-		percpu_stats->tx_errors++;
 		percpu_stats->tx_fifo_errors++;
 		return err;
 	}
