Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs8JzzBcMGD7+AsJfGN2nrrgg7JXrKIKZgRQKmQz0ccuxgJsVgJNu6JLNoeaHZcPlkfKc/Y
ARC-Seal: i=1; a=rsa-sha256; t=1520955622; cv=none;
        d=google.com; s=arc-20160816;
        b=M9sm0UZnSNOTntN0JDEPbG2C8qRD+eKGIJKzp4VvWtUP3RnPGzTn8NoFGuREdqJaka
         kIVz9dOfde7Ik1Z4KAEXURf1Uo6RNyZSR+irDkWFdOZoSQM3ZfDWLT27dPEJUi3b8i6g
         JCkvhDcR8070FMDT3h4i+HKo3SHHxrNydjQ5w4a6Dl57vjMLM+Iois3v9sFC3C80kdG2
         0XNGJW/lW2adPsnGq/umsZ8mFm0FG0SFBlEm6YFPMsvjmxi+6ri6NcFRaL/KmNKYM1BE
         V3L4TzcujSYmooEDAKn0WHj7HlPzhbAd0AvMcELgpULoFZBKTlrixgfxhfmYYEgNMWDr
         WDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=09fpnm7q6nJfQGjZarMAFndCxUDGWWQfYSSXa+UfTPw=;
        b=uYOdPKkFkpfRCOMcasSJM0pCNysHBebjwvOu4iBY3gimrYnE1zBJesmmzQignmTnPk
         +M0HkEMgNAdRWfsALlkg631z3hN7YhFQsAkq1RXs7ge/nmrYwHUvUWbeyuMhczjT/d8W
         rDVNMSESFQnXvs5pRi6Oxslj18slg43lxF9ncdIvdU74XgKxfl8HqWS9Cmst+QHbVKcF
         um0SleaeeOyLvXEPg1g/IO65yit6jFsH6ohkHDuPbo5wBMrwK7Rh5rgC8sJvPivGPc0k
         7X0vr9uM3kT5SsZMpFm68PsabZ6NqLkfrto4Lv0x3xFKeml7OvUT3T+BBL+pbAgYOzC5
         du0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paul Burton <paul.burton@mips.com>,
	Aleksandar Markovic <aleksandar.markovic@mips.com>,
	Rob Herring <robh@kernel.org>,
	linux-mips@linux-mips.org,
	devicetree@vger.kernel.org,
	James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.14 113/140] dt-bindings: Document mti,mips-cpc binding
Date: Tue, 13 Mar 2018 16:25:16 +0100
Message-Id: <20180313152505.770942823@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836982014962493?=
X-GMAIL-MSGID: =?utf-8?q?1594837562717285474?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit aece34cd576c7625181b0488a8129c1e165355f7 upstream.

Document a binding for the MIPS Cluster Power Controller (CPC) that
allows the device tree to specify where the CPC registers are located.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/18512/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/power/mti,mips-cpc.txt |    8 ++++++++
 MAINTAINERS                                              |    1 +
 2 files changed, 9 insertions(+)

--- /dev/null
+++ b/Documentation/devicetree/bindings/power/mti,mips-cpc.txt
@@ -0,0 +1,8 @@
+Binding for MIPS Cluster Power Controller (CPC).
+
+This binding allows a system to specify where the CPC registers are
+located.
+
+Required properties:
+compatible : Should be "mti,mips-cpc".
+regs: Should describe the address & size of the CPC register region.
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9001,6 +9001,7 @@ MIPS GENERIC PLATFORM
 M:	Paul Burton <paul.burton@mips.com>
 L:	linux-mips@linux-mips.org
 S:	Supported
+F:	Documentation/devicetree/bindings/power/mti,mips-cpc.txt
 F:	arch/mips/generic/
 F:	arch/mips/tools/generic-board-config.sh
 
