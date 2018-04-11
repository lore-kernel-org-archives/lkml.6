Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx492TENvjUKnkpLztgnGvn0U8lW2WrUEKJ7RPG/XJFEJV1zDdvuqkF72TvlwSSWa4eKYFmsq
ARC-Seal: i=1; a=rsa-sha256; t=1523473428; cv=none;
        d=google.com; s=arc-20160816;
        b=x6BlE/5300tLe26ysiEQDcrHTsB7SuTF4EqSGfMXoi2OuWlqQHorbdYOsc8XVeIbpC
         nxCq9e2bUiD5IzcOiIEPTalvoxxUeXR5NHy9MmqjHBL9vAj3ktPsHX7/NTeeeCMLgkdc
         vwNbsQab0svWDCe+/fIeHdqKoIGjAOr8hoDn6xPQkz85kUbsqicYU1yQw5AW9OMMM9PT
         VPMMDvMWDwpStAA+hIz9ez65SijhJCIYe7Zh3z6aUfiOCwC/tMaIximL4TLtlrmKotf+
         ux2JmBJour59YSpERb0rzu2v6MW9IAhz2yLNi9dvTJgRqPUDA+mkV8tAs+RIqH+Ufgxr
         S+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SLkGbyxM9uQ7K4nZeouZvSRBH4BgeVPIzxbq4e7B74M=;
        b=o1Hkc5aDboN5/Q44oJ8kwCGxQZS/qZHXchtfLTnmbGF/xex0wtM8zan/s3Pcg8ZiJg
         y+Z4ugLIrXerHPc0f5eTkZmIJonPrO4LmknexZjggtIVLNXSJmu2Bp7fRSflSS9ZMm4Q
         fBU/5j7vy+9myP3XRH9hITTvTFJ9brX866W+2hTlRVVlcyH9W4ZkUxTFwc1jGsEl3zzI
         nJuxOdXLtW3+c4Pq+qYB/8WlbFTLW0rAftz9XJdwmsUtrTG8EyF4pRJ8MozZCxFyzZdS
         /MRS1m3LibNGNSmMQukrDWdSrmV92eFVecQ3TEJEPivlPav/VOT2URayMuJlgIORlUIr
         COZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Netanel Belgazal <netanel@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 243/310] net: ena: add missing return when ena_com_get_io_handlers() fails
Date: Wed, 11 Apr 2018 20:36:22 +0200
Message-Id: <20180411183632.928093211@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477673424025462?=
X-GMAIL-MSGID: =?utf-8?q?1597477673424025462?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Netanel Belgazal <netanel@amazon.com>


[ Upstream commit 2d2c600a917127f16f179d5a88fc44ba3ed263ed ]

Fixes: 1738cd3ed342 ("Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1542,6 +1542,7 @@ static int ena_create_io_tx_queue(struct
 			  "Failed to get TX queue handlers. TX queue num %d rc: %d\n",
 			  qid, rc);
 		ena_com_destroy_io_queue(ena_dev, ena_qid);
+		return rc;
 	}
 
 	ena_com_update_numa_node(tx_ring->ena_com_io_cq, ctx.numa_node);
@@ -1606,6 +1607,7 @@ static int ena_create_io_rx_queue(struct
 			  "Failed to get RX queue handlers. RX queue num %d rc: %d\n",
 			  qid, rc);
 		ena_com_destroy_io_queue(ena_dev, ena_qid);
+		return rc;
 	}
 
 	ena_com_update_numa_node(rx_ring->ena_com_io_cq, ctx.numa_node);
