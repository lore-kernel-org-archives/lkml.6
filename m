Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqQwJ9T+qzKdKPAHRLr2Vp9fthY5a3rcDhbUlirKrZ4kdLo1sc/w8Dizc3zYuE3BOeR9FUL
ARC-Seal: i=1; a=rsa-sha256; t=1524837908; cv=none;
        d=google.com; s=arc-20160816;
        b=if+BIBxe+gc0cg8/Jo7rEBElTOKCa1XYV+34ogx1K9KIp3q0B832NKcu+mdgFrVyCO
         K3tVFdgJ1kWLM+oyY6Il1ZVnLiEmFnkDRY2ULD7fhm8lTXOBcQf3NK/ONUqCloIfM8Pi
         cB/12wL5IRLSFxRWHkJHNGU9OJH0sBt45uwyVw2tbAMNeulkyR3+vn0S5XuMEO/+NpSo
         K7AUF5OxH/6oHsyEqJqVzRAqa2LupjsGcs78rPek7psXS8y6Faz6iIOgg/VbL5O5HRib
         0YVx3XvRr1vwHAE7ldW59bc3Wti6xWxvelmvq9+TM2JdI1JvaPZHZhN3zTCy/JiP7mjT
         84AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=y9dwPV+Jizj5KnNnlcIhr89HMFEhS2b5ta6Bkb/Z2Zw=;
        b=nuRehda4JtPwCAzB1WNXtoALh+2uVKn9zTyikvUWjSYRm4FRpycem9PKFJtZiV0kkX
         gb9JDcSGwe7MHrtkuwB6jFF2KBJux6OEbn23g/v4T8TEIZVHvMr8sMnIIEiAOf9jYR8U
         vNwPywT19itj3vaMrbnSmiL1V72/NQhU3s5+6hjEeN+FzBhCJucxdQ7eD304N4Npc7/j
         QFtlCkZZcH4SZiD4v688ElN1+vLByfjjvSPnUIWd+92/hbhJ5rFSAoCrMJTSr/4VBdi2
         Tce6bxqNI34JYJOIQKUtUKUAqL3/CX7MBzDl+kDTDqj2Nr9OaucQmkP7rCcu5vdeLRPj
         YgaA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B821421890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 63/74] net: ethernet: ti: cpsw: fix tx vlan priority mapping
Date: Fri, 27 Apr 2018 15:58:53 +0200
Message-Id: <20180427135712.549769252@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908434647327307?=
X-GMAIL-MSGID: =?utf-8?q?1598908434647327307?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>


[ Upstream commit 5e391dc5a8d801a2410d0032ad4a428d1d61800c ]

The CPDMA_TX_PRIORITY_MAP in real is vlan pcp field priority mapping
register and basically replaces vlan pcp field for tagged packets.
So, set it to be 1:1 mapping. Otherwise, it will cause unexpected
change of egress vlan tagged packets, like prio 2 -> prio 5.

Fixes: e05107e6b747 ("net: ethernet: ti: cpsw: add multi queue support")
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ti/cpsw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -124,7 +124,7 @@ do {								\
 
 #define RX_PRIORITY_MAPPING	0x76543210
 #define TX_PRIORITY_MAPPING	0x33221100
-#define CPDMA_TX_PRIORITY_MAP	0x01234567
+#define CPDMA_TX_PRIORITY_MAP	0x76543210
 
 #define CPSW_VLAN_AWARE		BIT(1)
 #define CPSW_ALE_VLAN_AWARE	1
