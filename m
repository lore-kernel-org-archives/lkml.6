Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq5poKXfGwU6MSmdK8JcnurJTnfn8HQo0A1cM1qBfJo4fhpPNC2BVNmdpWs/KzKxDDPox98
ARC-Seal: i=1; a=rsa-sha256; t=1525116443; cv=none;
        d=google.com; s=arc-20160816;
        b=PCvrPHXihl6Nv2GFjU5Se0NXB2CQa0O+KecvsWEmVE9CrCUqxKpv7ocKGgUeuIo4H8
         rfK3rCYtwy5o3+9PUVcf9MN9oYgOlqs6sl6QqcwljpPT6wadfHv+4apdkmL/8reL8BYb
         OR5qzT24bOYuv4oghRiJ97s9c1rc5K7FhECmfpO7yLd9CDhhhAiso9NKEllctbf3fVXr
         OCQH5H9GEf5RfEX5q9z5YIVjK+/12tX8hiW4f/S1Ca3afD9HIsM5nXOO/+fT1xsDWa9h
         GQpt2sVpaLVEUbWuqdnNF0eZehR4Kc+EV9c+QbH6uR4MQFEOphHbTWqXHxoHA184AWjV
         x+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=FZwLAbDYqnA4T4jNzRJACe8YR/hDd6p0iTVls4OxyQY=;
        b=Uuz0SKUbeIax7Oi2L/gJfFggKTAVOANac40FaZfATPNPGVTlj/DOEgKuHbYOie7lOq
         TIK79mAwS8JwHOe7BlJKPLQ3X3dX7VR70E1RscalUKxxG49Dpp6aRys9TFVuKEAqbEgU
         TOgWx0KhV57pOROkCDN6qitFNrlmL4aI35k4ya9G0MrA0+U9Y4EkjNzdp0wHIBiGavY7
         EnjiQ3PUvodPQ3LI3i/t/D4UuYEOp9MzWu5gHtty0YWr29x4xYX9P10GTWRvCTmGKQQ/
         r+Eqhrp2iSpjHjfddLvo4fY7KJ4mKM0Dz/+UD3lYUcvajj5elBvSicrwcQX70oGVTpXj
         o8dQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F6D22E02
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
Subject: [PATCH 4.14 54/91] mtd: rawnand: tango: Fix struct clk memory leak
Date: Mon, 30 Apr 2018 12:24:36 -0700
Message-Id: <20180430184007.000971626@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200500103464854?=
X-GMAIL-MSGID: =?utf-8?q?1599200500103464854?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -654,7 +654,7 @@ static int tango_nand_probe(struct platf
 
 	writel_relaxed(MODE_RAW, nfc->pbus_base + PBUS_PAD_MODE);
 
-	clk = clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
