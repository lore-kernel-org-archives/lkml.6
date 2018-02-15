Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227W4hbW3blBOeqdpcI2dydEXiC3m4pOSjiv176Qhgpfui5WKX73kZGvCSKTYJs44ytcWOKB
ARC-Seal: i=1; a=rsa-sha256; t=1518709085; cv=none;
        d=google.com; s=arc-20160816;
        b=LLvj8kOpLP3zZbCuP/iUHaj+ykRfvFPekFZe9ubeYZ+ersJvLXifOhZloq5KUpwr6q
         7DxjzTbgoq9Z2bq9lItFOyxbWGL0Lwg26t/vgQU0jDBEpoewVbpkM3PVzYC/wUHmH65a
         jDcsCJ6PqZe6AZ+cs09m+sSjmy1fCTLoZL0LJqUFbvmve11DpdqypJnvYEdFYgMHa4jJ
         THlIqZtrmfnobN+cKKUDhT+XxmZCuR1cBPJczhWR99GxJR7d1cDU9BA9ji6xk9tNGSPZ
         S55lQgnkSzm3+mSAs0uuxpTuaf/HYDp2yzWbPx+p8RjXOpXpUrIAUMAArJW2oqu7COEE
         OYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wbb9eIzQgJdhV4wAuFA7t0EcnvaS/b4ry+oiItOAUA0=;
        b=jNFLe7r9749Y3M+fYKaIK91Ul8J8GTkzMWa8k2XaOAoNK5WY0i9JL5YtsFHHEL9FZs
         2T1pRo6JkB6SFjuf8KHGtSc9Hn7t5vlbSR5Jsj8rwRnsQLI4rcWwio2hmcPn9DFksAVN
         Wu9B85PfwG8tl1J7g4AtIKMTM3KI62nJpEdB9EVo/+dAlQZYxPuizzlnc/8thuU2co9v
         u9uh5nx7c+k0q+MOsIrh6Wxo3Pwe1a5nqzldLnzzVcqMT2YFTzRRWqrVU8eIzxHeashp
         Z9ru2Nqi+chKoSOEJjlyhj0DoVyKZuSxgoow94SW1uzXDxXSI9TXQNyE/IwWWXsIGUiK
         u7jQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wang Qize <wang_qize@venustech.com.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 186/195] ACPI: sbshc: remove raw pointer from printk() message
Date: Thu, 15 Feb 2018 16:17:57 +0100
Message-Id: <20180215151715.580010540@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480780987314959?=
X-GMAIL-MSGID: =?utf-8?q?1592481898772149505?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 43cdd1b716b26f6af16da4e145b6578f98798bf6 upstream.

There's no need to be printing a raw kernel pointer to the kernel log at
every boot.  So just remove it, and change the whole message to use the
correct dev_info() call at the same time.

Reported-by: Wang Qize <wang_qize@venustech.com.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/sbshc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -275,8 +275,8 @@ static int acpi_smbus_hc_add(struct acpi
 	device->driver_data = hc;
 
 	acpi_ec_add_query_handler(hc->ec, hc->query_bit, NULL, smbus_alarm, hc);
-	printk(KERN_INFO PREFIX "SBS HC: EC = 0x%p, offset = 0x%0x, query_bit = 0x%0x\n",
-		hc->ec, hc->offset, hc->query_bit);
+	dev_info(&device->dev, "SBS HC: offset = 0x%0x, query_bit = 0x%0x\n",
+		 hc->offset, hc->query_bit);
 
 	return 0;
 }
