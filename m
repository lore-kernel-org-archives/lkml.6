Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227/CqheVLhC8+9rWlZiDC6FI/HzwKY1YhZ2b8scYt7MDlX0khgnv6ujltSHBoWhacpMH3ye
ARC-Seal: i=1; a=rsa-sha256; t=1519218413; cv=none;
        d=google.com; s=arc-20160816;
        b=kn4yRdaT64I3FZn1Dqqu+MSugwuS3dr1cv5JsCTwwBl8F+5Vmjn3yl9POzORHmipk5
         FlNXZWBrXQA0FPUEXn/8sOXfWuGKYPjwl+e/Nrrkt6Okh3U630Tv+ETCUxJBBNSRbTO8
         AxQCFtS/qOWjOB+Fa5zuAAAUHGhmfgNnXlKSHiUqf3ZNbxMGxzmo9aS4/xAjHfrvizY/
         ez8wr/leZvKKw2b1xxG62b/+uPXJXy5RZ3Ze2GTJiPAOGbBrKM9WDBQyTaiTXm9q3CsI
         1fYqwPyc49JYkXjjnrrpHjD2cIGR5pE6JnN8NfBXKP71PWP26jxZ2r8Y5Ht7hK2DdkoO
         JExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HoKsQ6e8n0m98lwCSZCaHJSenvhX2k3bPnFB/qinP20=;
        b=KhkQT9pFvYX52bk84mPkKyvbSgyS3/rxUPITx4QBLq9N4y+FbgIMggBSTulLpidtAg
         S+62/6if5hKHKpqD66Y7e8pujyj6JQv+QDzB0f4e6KP9P3SGl28Eu2/DazhqKmYAd8d2
         JsJzbINrd6szjMwBxs4ZgAlG+LrZsYpA9gVzb9gOfsA/5oxZy2tGXY8kscroX6+U1B24
         UcP6g57qTl1rcvxXHqnbjywRGJ9L9vzWDUyQ8pwTxIAIQ9bWUR3rQtOISRltGmm4MLEs
         1MopBV2VzPxWMR9AYRj1T4ukgwSjDkSCam78xfN6MqzXwvPpbJzRRpyd2GaznT3t889q
         LZXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 4.15 031/163] arm: dts: mt7623: fix card detection issue on bananapi-r2
Date: Wed, 21 Feb 2018 13:47:40 +0100
Message-Id: <20180221124531.958096337@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015469218852122?=
X-GMAIL-MSGID: =?utf-8?q?1593015967195463658?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Wang <sean.wang@mediatek.com>

commit b96a696fb2a8dd1ee4e6cfee48dcac270fc53287 upstream.

Fix that bananapi-r2 booting from SD-card would fail since incorrect
polarity is applied to the previous setup with GPIO_ACTIVE_HIGH.

Cc: stable@vger.kernel.org
Fixes: 0eed8d097612 ("arm: dts: mt7623: Add SD-card and EMMC to bananapi-r2")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -204,7 +204,7 @@
 	bus-width = <4>;
 	max-frequency = <50000000>;
 	cap-sd-highspeed;
-	cd-gpios = <&pio 261 0>;
+	cd-gpios = <&pio 261 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&mt6323_vmch_reg>;
 	vqmmc-supply = <&mt6323_vio18_reg>;
 };
