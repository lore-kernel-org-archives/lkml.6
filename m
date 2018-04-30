Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr2UMmEQIJvmNKZfnR45bgNlfEaUvXD0jfBjqKXU3ww6xd4DwJIr24Czk3GFf5j9+c667Cc
ARC-Seal: i=1; a=rsa-sha256; t=1525116503; cv=none;
        d=google.com; s=arc-20160816;
        b=bv3r02SdWS34lygtMW2hCqI/hT3YdhEkd2dim1WrzNrA8/ayWKD/OTwf/5du4wgjEv
         crsf4SP/UD1A9QEqv7l1CdeKhR+rNzsgTHn5djmmvIk4sP6IwcqVqCQHaLsXGBZ1+dyy
         /7TA1/UltqkwXJqFPtbFINw4FD1NC/1rpk0PxM6BpOTE4QXmvuELBZDN64HnJthx47gR
         BUifjJanwQbQcWHSH44v1CDRMZ/GK7I4Yz2X55yrL82mTivGTTUiA8QxeJ/w0cOy/utV
         rlk8VUDfcjjNtk5y0DhytZA8DHgQVB6/qnTQZdb95Owtn6mVWRFBJQ9u9Rh4CLlkPOYX
         j+fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Ml3UfgbBWEwLhVOkvacd6LK0bDu6MeEnD081KPLxvds=;
        b=kDtgA+P+ncJNYKNdcH8sc35Se7PoVgb9NViFVvlLMxf2yy1vGE/Q49aAhd8m35SgBX
         YuJML0eVIKeH1tOJHiC6SZOeyw2WsLDbxSljeHCEr8Znuvyl35kcprjy4Fe9dfR2W+E2
         ErfygwajHEmE3tmsYqQYZgyxJTzviw3tUnUdvZkMj9fjr+K3NIpUz8j9XXwJfYKB5JxK
         +w/3WC0UvlZrvPQl7EwghCN/8Dckq7krRr8XekdEEVppTib6HdCdvR6YKtXXiJfXcowP
         +8O3r0wTDTPemrs56kFPDDcug0D956fmlkD6fHPDbjHBw8WIw77X9j7JgKrqkgrEc+WL
         p5eA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B70022DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xidong Wang <wangxidong_97@163.com>,
	Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.16 058/113] mtd: rawnand: tango: Fix struct clk memory leak
Date: Mon, 30 Apr 2018 12:24:29 -0700
Message-Id: <20180430184017.505497122@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200500103464854?=
X-GMAIL-MSGID: =?utf-8?q?1599200563205823492?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

commit 007b4e8b705a4eff184d567c5a8b496622f9e116 upstream.

Use devm_clk_get() to let Linux manage struct clk memory.

Fixes: 6956e2385a16 ("add tango NAND flash controller support")
Cc: stable@vger.kernel.org
Reported-by: Xidong Wang <wangxidong_97@163.com>
Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/tango_nand.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/tango_nand.c
+++ b/drivers/mtd/nand/tango_nand.c
@@ -643,7 +643,7 @@ static int tango_nand_probe(struct platf
 
 	writel_relaxed(MODE_RAW, nfc->pbus_base + PBUS_PAD_MODE);
 
-	clk = clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
