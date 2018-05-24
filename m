Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZphQi7tMXTwmYC2gL+lvHsyRYKZUsVvckizHO42zqzT8lEds2T3yko11RLGkdNRey//wlmh
ARC-Seal: i=1; a=rsa-sha256; t=1527156138; cv=none;
        d=google.com; s=arc-20160816;
        b=yGV2RAIWSNSTsyJvq1zIMM4g4TVv/0I8Db1RK6KlWic8QP28Mitm2QzpNPAfuk2+1l
         AUwRp0Mhbio8EXNMJgprio42iDVim1V8IQPyKwmur1e7c7QLrw180J0ZX3ef72vrVVKO
         WEHu/QikLgOHsnOyc2FmK6O6YGs83VXMNVX9MU26JHm3n8nLl2Sn7tXWpYfzaRgJx6lv
         1o/prlEVr0gfsOMPSVJWsAYLDz+pxwyCFPN94PlMuc8+iIUlzbEtn5I6BsKppCu+LPTS
         IHttGm3TKQ/8wa6GZiMjkBgJVjaazGE2OoTj9sTIRzzp1miDpnxqhqn1/3SfOKHsqORj
         hEMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Cjr0tJe4E8mAA81uXFsFXmlbU9EgGImzcchp1Kp4Ltk=;
        b=cVj4o1W1ljtfeoAZbSNlr3KAzkCV1CaBgWaO0+tO8ZA5gpFOMUxhtu3LHqyoGJ0yf/
         J170cAbHxu2H1zZuojA5q6Y131ReyIwQAVudq3zFSrnZK8w7bxO5QtqgdML36LG199ff
         hzc6OgIBdWS3O95DVOu3CmVhBxrmQbCPsKuPERYCutS9fIVS1yeLUfIU+RFNXJD+FRBp
         SW+yx/YsRQbpwFqRgk9iIcZPLWIxVCBbSKIVU8VfT3SlghatyHSOFycRsZsG8RXxVYVl
         R0DRo2gAqu/9UnjmArFMCpQlQA7DdKyxoqYpfF+oek5r5iDmeExW4FE/Hp+hL8t2+WUW
         R0uQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=WfFBxhFJ;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=WfFBxhFJ;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 078/161] usb: gadget: udc: change comparison to bitshift when dealing with a mask
Date: Thu, 24 May 2018 11:38:23 +0200
Message-Id: <20180524093027.891883897@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338418747574168?=
X-GMAIL-MSGID: =?utf-8?q?1601339275485261282?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit ac87e560f7c0f91b62012e9a159c0681a373b922 ]

Due to a typo, the mask was destroyed by a comparison instead of a bit
shift.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/goku_udc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/udc/goku_udc.h
+++ b/drivers/usb/gadget/udc/goku_udc.h
@@ -25,7 +25,7 @@ struct goku_udc_regs {
 #	define INT_EP1DATASET		0x00040
 #	define INT_EP2DATASET		0x00080
 #	define INT_EP3DATASET		0x00100
-#define INT_EPnNAK(n)		(0x00100 < (n))		/* 0 < n < 4 */
+#define INT_EPnNAK(n)		(0x00100 << (n))	/* 0 < n < 4 */
 #	define INT_EP1NAK		0x00200
 #	define INT_EP2NAK		0x00400
 #	define INT_EP3NAK		0x00800
