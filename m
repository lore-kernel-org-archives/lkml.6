Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELur070OXGYoxPCnvmCrQ1e8BrXURW9CunFVyNDMDqZ2MGrJ6dHA5twHIXAEqBlWQm5KlXKu
ARC-Seal: i=1; a=rsa-sha256; t=1521800181; cv=none;
        d=google.com; s=arc-20160816;
        b=o0D2hIN8w8faeQ5l1CLjy3dxAopRAXNRwA7/SC4HKq3l74U7tX2yMhWL/b4E2fSrmc
         O0IFXiY5HNbCAk2gh4q7AIcO6VKL3Ql9TJECa6EGYXrAJUaE+yrRkgTkAK4pGd8t5zEF
         cX1e+wbYrWWjbow4YnOHSpBRNkKl5pCaY1Oiem3MnEd5zAhIl93JTuf6Lu33dw3SD+We
         7LJDzdbVTz5KpFMz8mjjGAwCvtRCIUje10vr9FE4pFWknexQLMckDSkayEIsaHTzodsT
         eNcIY7m5waXuUq1coa/rQRkJAv5/Ytto3fWaTt2lSBDqdGR+6sslHkYTutg94MULsfsp
         r5zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1CSIgyf/a3YNG3LNPckgiLrXEfW4vSUN31xbub35ZRg=;
        b=pzy1SIqHk84/TAeC5jBIgbmYiOAR7YSqMzzSwBM+LqJ2ddI0TPEXAR5Eqx0ZT1rpoY
         MbClIFYgh1lKK3m+h58b7BeptTljaOQSgwPvD9SwXXpLLkAdQ0yqQtboYgGGyUJ0hOCa
         MWr2rI4BKBGGQXvfsP8VZ7LZXTmWMxLlZlH/FiWBfRSoGgnZ5shwCDd/8w1lJjwOMcNq
         SNFHHi64ZWTrjvOAonbeATbQE9FmUhehTs2f4pyS3UdDDmIVScJvsXrfEMjLSKVqKNiI
         osmshUAXMeMFAjcPangvX8eZSWLTQaZYVNoq/sAneUmBOHohzBxP+uG1Yzr1DfAsvMSb
         9ZQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tsang-Shian Lin <thlin@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Yan-Hsuan Chuang <yhchuang@realtek.com>,
	Birming Chiu <birming@realtek.com>,
	Shaofu <shaofu@realtek.com>,
	Steven Ting <steventing@realtek.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 77/97] rtlwifi: rtl_pci: Fix the bug when inactiveps is enabled.
Date: Fri, 23 Mar 2018 10:55:04 +0100
Message-Id: <20180323094201.888502382@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595721915428712046?=
X-GMAIL-MSGID: =?utf-8?q?1595723146606684911?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tsang-Shian Lin <thlin@realtek.com>


[ Upstream commit b7573a0a27bfa8270dea9b145448f6884b7cacc1 ]

Reset the driver current tx read/write index to zero when inactiveps
nic out of sync with HW state. Wrong driver tx read/write index will
cause Tx fail.

Signed-off-by: Tsang-Shian Lin <thlin@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Yan-Hsuan Chuang <yhchuang@realtek.com>
Cc: Birming Chiu <birming@realtek.com>
Cc: Shaofu <shaofu@realtek.com>
Cc: Steven Ting <steventing@realtek.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -1572,7 +1572,14 @@ int rtl_pci_reset_trx_ring(struct ieee80
 				dev_kfree_skb_irq(skb);
 				ring->idx = (ring->idx + 1) % ring->entries;
 			}
+
+			if (rtlpriv->use_new_trx_flow) {
+				rtlpci->tx_ring[i].cur_tx_rp = 0;
+				rtlpci->tx_ring[i].cur_tx_wp = 0;
+			}
+
 			ring->idx = 0;
+			ring->entries = rtlpci->txringcount[i];
 		}
 	}
 	spin_unlock_irqrestore(&rtlpriv->locks.irq_th_lock, flags);
