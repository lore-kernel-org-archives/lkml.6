Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226lyhlLqrPf8shMqAV19fHvCcyVCYZVmvtKfXfwBB6X7w9hdNHJcpUOKu33eYkxmzq1bets
ARC-Seal: i=1; a=rsa-sha256; t=1519218301; cv=none;
        d=google.com; s=arc-20160816;
        b=yfjNTHs+D+p1PgBwRslUaZS/xaYjUvMpXgd7zeYsUKXgdvKb7pmP0054jNR/vznmY0
         Sl+eFOBEwBU7xs06wFmo36+cJ382XLYFOBlru4hwgtxZEk1hCoV96FZV3pu+kaC+OFj4
         Ai04RajImFS2e6Wv1dMqx8ynEwrDr7DTOF8/SkmmTULyY6P5ZVcGn6w1WLZT1A1t6m7h
         p7Xe85bC70vuTTe5gMgZIVMkNlVYX2t/j3ZKs7JsxgNKXDi2ENCAABepkVqA0YAStRYU
         r2Jm5PhLND8/BxhfQQXOtQLA8Pnv3QystWRnuDJTdVCJkqMZmnwttv9wt/UFUxcB6nFs
         pgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RXEeFiU3ztt+grIW2j+FpOZRa92hhtk+29BCm5IZ9DM=;
        b=TXcTnzudgntNJfAzgdJhg5FXup1jBTj0QsnfS9+1wxdgNwDjYRYn13PgbWdNm+BnVw
         4PSNi2avO4oVD0rtUIAwG1aS6umRG+xGW5/inlK3O69+Y4085lGFViHtR2h1aQJSBTEW
         Q46RKZXQuzmCZxJFKBFDEY4mkqZ61IZlCaD3842AGhMZTj82lYATMZGbnfXHNG9fQOfA
         /C8waqOJxLjIEEdXT/Ss68+DOtYQvC5j+oVe7wihSdOi2nqBLJC9LVmq0IgXsgQkrLNG
         UrWhVDQpUwUhEvAR7J2PomSnRvsl5jw/w0QbRl2jj+hFs+jloqki7ntsnv2Qjz5CXrwN
         H0yw==
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
Subject: [PATCH 4.14 159/167] arm: dts: mt7623: Update ethsys binding
Date: Wed, 21 Feb 2018 13:49:30 +0100
Message-Id: <20180221124533.533457393@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015849592345004?=
X-GMAIL-MSGID: =?utf-8?q?1593015849592345004?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Brugger <matthias.bgg@gmail.com>

commit 76a09ce214addb8ddc0f6d50dc1106a5f829e713 upstream.

The ethsys binding misses the reset-cells, this patch
adds this property.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/mt7623.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -753,6 +753,7 @@
 			     "syscon";
 		reg = <0 0x1b000000 0 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	eth: ethernet@1b100000 {
