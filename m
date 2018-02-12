Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518412647; cv=none;
        d=google.com; s=arc-20160816;
        b=QQEZ6jNYw4u1rCgqMETnTsMCIeWyRm+DE1VcBKauVeHc4qggq9VQKlOlCMcSPUIvyU
         RMvVUdco0DPWuUZQYW8lNfOYYqPEmcRTe+ajy3G+0wLpPsahpfnnktsYCRcvZzg6NKoT
         A/U1SPtQhr66QdCzQ2qL/y/eye25RwuaXZux7p5Bb3JxD0KsfxwgZBGjqqz3SqOjw6zi
         /ZOPPZJAkSWtcWImlsWewJGXi+i+1v/AAOwCQcirNnenF7RYzikAunHHidnrZulrHn2M
         sHblG7i1LbtSH+k602b4kpLvNicxj+g0u0lOCsmWZkqLrm5QUvfdMTI/45iibA3sAEsP
         GSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=R2fi9dEw2GrkHAYwMSiZ7445jXCPYwkaXsj7fqtAgbI=;
        b=askpiqnjI+XmYHRsA/XzpoNaZ2XotVCNVpxeP5aIhM347DcK6+isp3yYr2tz3J1vPc
         HkNTew0rMiCY5QmaR1aEykkQgxNjK3P933kc0M1U6vKU9jKNMB29ieSxFgtgYaoPsmp2
         TZSFi2LLvgMcCn3EfTF5aRe19Wp5NCWca9jnh99DWshCP60obRZ0Ik7qxFkWuE5DL7O1
         4QGuTnT2Sg8NlP6cSihveCsD4Z+m5XIUKESqNDMhdApKeu4ZNioGiLEz2NH5NaGb+FFX
         Z+qyGFMSgBWmTpw+8m59Vcnwr7bdQOkjCnLB7BGODBCn1ZBGxNhItPemfXRMZglyN5qA
         7VlA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OjspTIcS;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OjspTIcS;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AH8x225JBYlCh3YSSbyNlVro6IZGGKSUCvcLBRpMLa5noWljc/AbSDizQlVusCXxWthhmjU0YJ6w5A==
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Christopher Bostic <cbostic@linux.vnet.ibm.com>,
	Jeremy Kerr <jk@ozlabs.org>,
	Brad Bishop <bradleyb@fuzziesquirrel.com>,
	Edward James <eajames@us.ibm.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 09/10] dt-bindings: fsi: Add optional property no-scan-on-init
Date: Mon, 12 Feb 2018 15:45:48 +1030
Message-Id: <20180212051549.8575-10-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212051549.8575-1-joel@jms.id.au>
References: <20180212051549.8575-1-joel@jms.id.au>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592171060192825925?=
X-GMAIL-MSGID: =?utf-8?q?1592171060192825925?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christopher Bostic <cbostic@linux.vnet.ibm.com>

Add an optional FSI master property 'no-scan-on-init.  This
can be specified to indicate that a master should not be
automatically scanned at init time.  This is required in cases
where a scan could interfere with another FSI master on the same
bus.

Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Acked-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/devicetree/bindings/fsi/fsi.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/fsi/fsi.txt b/Documentation/devicetree/bindings/fsi/fsi.txt
index 4eaf488d4015..ab516c673a4b 100644
--- a/Documentation/devicetree/bindings/fsi/fsi.txt
+++ b/Documentation/devicetree/bindings/fsi/fsi.txt
@@ -56,6 +56,13 @@ addresses (link index and slave ID), and no size:
     #address-cells = <2>;
     #size-cells = <0>;
 
+An optional boolean property can be added to indicate that a particular master
+should not scan for connected devices at initialization time.  This is
+necessary in cases where a scan could cause arbitration issues with other
+masters that may be present on the bus.
+
+    no-scan-on-init;
+
 FSI slaves
 ----------
 
-- 
2.15.1
