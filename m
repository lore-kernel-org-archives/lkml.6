Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Qxz5wPf7eEYTDF1Aebe65/8LeOi1HX2Nb5TwY+XUnErlqsnJc20DeBSZZZuCoJ9ACGeKf
ARC-Seal: i=1; a=rsa-sha256; t=1523473513; cv=none;
        d=google.com; s=arc-20160816;
        b=C69DbaIuzpsFuCv+kpOrEnzrLGHZXafvk6FcDi3JHCQBgHLgcGiIO/RHBamrHnzUi3
         6SAP0X8eM5twgqkWbfkn+05UWOtftrC7qc4WSxfyMSoF/tlCXE4j7o78Cxfx4vm/93BZ
         nDzzmOhoXvs3usVVLW7vgRh2qGQaTuuxZMeSDnVB+VRPIwGbrPtWML6qsYkze0e27ODT
         zfue1njY+JdbQzmZV5EW/bY84JpekZkQ0xAUsyrIwhS1oJFZvK8CWKUG+DJHecV5SQc1
         kZajaAJHy7yE6CTm4Ts4yi3LqfBxyvqN8l3Jn5+M2ywbwg/WrSKpP3KcuzgdUvuQJh1z
         wXFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Rs9TmTweCNNF1pPw3YazVbz6dMFokh3YDayzcgkWU7k=;
        b=DHffaq7GBY8HdH6eYGgqCyhncVLsvrywzRRrzJZZOW3VhbEyssiQNdShLbpwC4opkG
         KLF5EP4OIKW7D8PMVo4wfltAPnoE2FiHB0nWthvOD1w8ZxJJOG12IK7O67S3GQyPJdp7
         /mAhwuO/b3lrQB8XuQ5pbdVw5g62+JW72qmTH0gkVnx1WrZX6LozWiZltwLmMZoBNBb+
         A8SKYyOpFAqZXuCvItznvbCYytEWMZbcynRVAR4U1mgA9052oD4CKaKL5rmAvDmJVEZU
         aAayVZ8ydVrEY7igz/zIiFOHNKmgZ49n2/p2igCheBW5fpjyz/fhoUhQjconQA55fOmm
         pKIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 275/310] clk: at91: fix clk-generated compilation
Date: Wed, 11 Apr 2018 20:36:54 +0200
Message-Id: <20180411183634.449769750@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477763331817315?=
X-GMAIL-MSGID: =?utf-8?q?1597477763331817315?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>

commit 4a5f06a01cfd1f7a9141bdb760bf5b68cca7f224 upstream.

Fix missing }

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/at91/clk-generated.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -266,6 +266,7 @@ at91_clk_register_generated(struct regma
 	if (ret) {
 		kfree(gck);
 		hw = ERR_PTR(ret);
+	}
 
 	return hw;
 }
