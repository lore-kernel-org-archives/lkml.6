Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224XEaoEx+GC7rdy59xQM3lj1L+HH5pWBA62Sv/aVk/uWBzuH+Li7fGWdJ7lKaUOVRq5DuoJ
ARC-Seal: i=1; a=rsa-sha256; t=1519217839; cv=none;
        d=google.com; s=arc-20160816;
        b=p0UeJfWdaG1KKSpp0esvd/7dD0DyolxNGHE9zOhla8hpSg93LtXsd8xPieugXlejpr
         mMrPnIRHxwOOJD/HW2aXB706MrNXLkq8R9xsDUFW5qPHEkdV9bJmrxB9Q5QcE/geRlUp
         5IMncDn/jXCumE15bQk8nQq6HqIKXb4FNZ8AXqMXEO6Rnsa4+nhbkN6R4/qjXS761Xj3
         KX2ki+L6+yRR21uiczDhAkTaEucvsMIwgOoXPuPzp7QEGX1Oc4QIykhk8cBngIFR90i5
         3M/1FiDvR1bUYBGKq6fFuwxgMd9m30mKI7RT3E64D3YqM0YWboU2xwyTjv803NYzjpp8
         RwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=guoBNIUrcE3YQpeghaXicUDkGwX94ibN4ey6v7Cq+cY=;
        b=h2dTf+uCyL8x9DUyz3JQVSs9JnoFf2JP+TZy+7KD0j7X6pldf7J1b7JtVwjgeuuHpU
         1wK+f9AOaWEdeCOVKbTwtagAuhbQDA48RuzxKrwXvGMKpZAbEcmCnkUwA2ssL9YzaBjF
         /CIzrDxTd9seaHYSNx5GmS+H7tuJjis/5HQqAQ5mfK72nmfvTjky6KbDIO9b8MT+FrcL
         BE7ttlOL5T0v23g0bQOhwianRPbsuXujYNszYToB35xo9Hxp44HJztaAi5Z2QLkV0r4D
         Akg9k/q/+NBbGYOqCicjwOt7+pKKYer9DNlFnF8z52xyrNHjsT3w/Fqv3Z650Ed/scAZ
         NPcg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 4.9 73/77] arm: dts: mt2701: Add reset-cells
Date: Wed, 21 Feb 2018 13:49:22 +0100
Message-Id: <20180221124435.261753197@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015364888704673?=
X-GMAIL-MSGID: =?utf-8?q?1593015364888704673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Brugger <matthias.bgg@gmail.com>

commit ae72e95b5e4ded145bfc6926ad9457b74e3af41a upstream.

The hifsys and ethsys needs the definition of the reset-cells
property. Fix this.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/mt2701.dtsi |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -197,12 +197,14 @@
 		compatible = "mediatek,mt2701-hifsys", "syscon";
 		reg = <0 0x1a000000 0 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	ethsys: syscon@1b000000 {
 		compatible = "mediatek,mt2701-ethsys", "syscon";
 		reg = <0 0x1b000000 0 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	bdpsys: syscon@1c000000 {
