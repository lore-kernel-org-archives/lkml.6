Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsbsMm13jjWxRIxZgz9zwUk8xWHfmbdSth7UJ4C2mQ+CW+1LfhPOkwtVobET3hjnmhAVSAj
ARC-Seal: i=1; a=rsa-sha256; t=1521483645; cv=none;
        d=google.com; s=arc-20160816;
        b=pNzqDzKo7DmXV2FQoMeAQ5wBM8Axi6eXlXNU2ksXX9XWtN+CSB+FjidLPzLB2uvo72
         fbl58p1MTOgLp9XYTvun+Ina6B3g/W3uvanNv/CLcyFxCiG5rpdFxNifRetKJDA4Bwgp
         YoNItbrCAjNhmHg2qnAJB5Aebs3VXyZviZjXO40ftGE8OEqd6PFEsmn5BLrC+wlDDBh4
         D+UiNQVfTIQDUDcDDs3h6Rp+TT4HO6MwJrjDP4xDC3X5z2DPWYQA4XVe5r98jIemnMyk
         yVC8r0Hq+bkUn3Mfq0FjpctQ1turhq4I+Zo+fcSzyImodFNWa9/l/w5wd0+SugOnbDkC
         RbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yq8C8uKSjUDHsy+q677Fp65Ph6ERJHeCfNvCrxLj2dw=;
        b=RxXEAkws8k+1f4UJ+WN2ANh4kKNACsXzvszr9UzVLqSU1PLfsPZVEN4yQuSH2WevQx
         gdNv+f2OhuG347dhRDdjuA5lrR2QFioqbqCKQ3ehufBR33THrXyXY/elfjb91OtDRVGK
         Lym/slWdpW/poxJV/Mx/LhMmtC7a/QiBj7xZR70ZqlpGMaINOtqu5pGBaVV4u3o4wCNF
         8KDRxEH49kPYk5BYXQUoMtrZARuf6zUZgozy0hrGUQuICDD76J0HI9gabg012d+Tsfkb
         JA+kRatJIebbUANIYMkJ5MQiC2xQjuVV3/f8/1W/yhPo//LzMTZxRzIMXcuugWp4jCea
         sK2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Quan Nguyen <qnguyen@apm.com>,
	Iyappan Subramanian <isubramanian@apm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 029/241] drivers: net: phy: xgene: Fix mdio write
Date: Mon, 19 Mar 2018 19:04:54 +0100
Message-Id: <20180319180752.373015832@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391234856721071?=
X-GMAIL-MSGID: =?utf-8?q?1595391234856721071?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quan Nguyen <qnguyen@apm.com>


[ Upstream commit 4b72436dc3dd2457056b22d6f147777368c869fa ]

This patches fixes a typo in the argument to xgene_enet_wr_mdio_csr().

Signed-off-by: Quan Nguyen <qnguyen@apm.com>
Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/mdio-xgene.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/phy/mdio-xgene.c
+++ b/drivers/net/phy/mdio-xgene.c
@@ -232,7 +232,7 @@ static int xgene_xfi_mdio_write(struct m
 
 	val = SET_VAL(HSTPHYADX, phy_id) | SET_VAL(HSTREGADX, reg) |
 	      SET_VAL(HSTMIIMWRDAT, data);
-	xgene_enet_wr_mdio_csr(addr, MIIM_FIELD_ADDR, data);
+	xgene_enet_wr_mdio_csr(addr, MIIM_FIELD_ADDR, val);
 
 	val = HSTLDCMD | SET_VAL(HSTMIIMCMD, MIIM_CMD_LEGACY_WRITE);
 	xgene_enet_wr_mdio_csr(addr, MIIM_COMMAND_ADDR, val);
