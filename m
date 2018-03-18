Return-Path: <xypron.glpk@gmx.de>
X-Google-Smtp-Source: AG47ELv/kgkpBG5QzRLmo+o+rLguCjviZMY6dc2X5OX8N3TIgCpMtnGpLKjgzfSha+51nvm8wdCE
ARC-Seal: i=1; a=rsa-sha256; t=1521384466; cv=none;
        d=google.com; s=arc-20160816;
        b=Gn6zfZlkT1nrMTLSL5Oxdhbu7lfQtfz9Xvf1c+Lh4RpoVGvHojqCfJe3AAml0yhqC2
         0rpMGYo02ejtaaYujizNooSMJCT3y798y02Ji6h+Ca+0/uLkaAvvynr9OSq31q7nB3L9
         z/I00apEj9dsXHEKD7Qg+mbzV2lfk9cBz9UGmyUFy/uZOEk23pbd0j5yliE/U2TKewbD
         +UEN2E2lgCUNks5Hc0HxYXxprXGHivaaHxMpK+cuMGhWgsEA+SM7G8pciAdeEGXwhIPE
         rrK98TzdCs0s6tC+ijotvePNiSRMoh1MDZ+caiVM78LDN7/L2IirKHCo3JtIl7J+Lqxo
         TLSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=xBFYuGJkprcZyuXNoAjbouIuBMVBVrzjJLOrZbbhmEQ=;
        b=pj2anvUU2cL01cEdINe7wfsGRP43ikHjEuRTPbEg+8MJ3lr+EyOh53zxXY4Pn3IES2
         I1lMOIaqcTWm/ZdZkNpChHjnsf7ipeLXEpHvvVJwG0xB4mK9jKNNmFgG+sBDbLvdVS9E
         MEyI6uLMob7o8YCoERkTfoXJT0WH2MxQQ1C+i7CTVnpiQBoOyoJt3g3uFgEYapr0T4ZG
         6v6X+MKaAE+PCMeyj3ogGwGr9ggCAVU/DBYgjtgJIwK4XFwvegid3CsCYkXI3X3r8QG+
         o/kACkihqr5REaaWguG4iSeEPGhdCO90IfuMzXywMKr9mhKh9cxwFm613lFWij0xuN8l
         6t4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of xypron.glpk@gmx.de designates 212.227.17.20 as permitted sender) smtp.mailfrom=xypron.glpk@gmx.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of xypron.glpk@gmx.de designates 212.227.17.20 as permitted sender) smtp.mailfrom=xypron.glpk@gmx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] usb: dwc3: ep0: remove redundant assignment
Date: Sun, 18 Mar 2018 15:47:40 +0100
Message-Id: <20180318144740.29610-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:BBHitDYD/VI8pEhnH3pw7JJoK0AtZc8z+1BvHvUg7/9gg2necQh
 9H15ZMqKlWSBuLsPTFKBP2P4lS0pRCT5QR0RnJdjcIgELm1WwYQw/h5NUmrmNoEOs8oxs1B
 +5Dy7/92JdFSW4wSWHd4aYGgOD0Tom/jWXyqV50tJHYANvTuAH5zRRBZcVu8eyZl/V1/FM0
 I4bVq31g6HyvqjntKc3eQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FeoL4/PlEHs=:81zPp8XsWmIrdzKLJnAmIZ
 hXEZMYTmFiUTmmOC0bJPySJhwOPauE3w7B/TgsqQpqShRdHkWCnYzRYSaMi3/tK30grcZ0gNx
 7pASr5BFSgCMs4RgrmrZF47lTDv2hirziAo0ZW0Taq01UqqpWxi6HWhq8Hc+mLq7Qsg0vvSfq
 84FQvUENWxtIlcCxNdXLzpvg10gi6X0SlgYDfD1K2MY4Cy6NHPHxAhg5KRf2cxuSor73rdh3f
 6BFM6jGqx950yPQSi5j3eb0zypdVnzjzqQig3ukVd4mai8vZps83CAsM0GOQQRsRMFKOGnMbh
 P+23loHWr2lwCt0payPmyLW0Umz/CjxvS7FRXzfrn3PWCoe6MPPfBg5uVn2U6H9eiIw9GK6mO
 2vItRqwY4oq0tBzQ80TuCRtIwkq3qNa2z1PFTymuZ47Wdvag4NhFDCl0gl1rnt/7AUipASniO
 oXaxm1wm9UvOshMMCFUxqQmSAk3LOK7ZYCegWDitI7uB9tihlvANXD3xQONkriPZ/P/sN3yPm
 Mog9rbKt3QvmwR8TazwhdbdVwvJFm4sr97D8t504T3KV4GAJ/39oDSLl9TczPH3RKuzdTGVm3
 aUAR+VUxgxyPua/WreEt76Pd+36kiEO075emrMzt6xteGGQxMl5NwaLF6vmI7SEyVYfSXBmIo
 zEAVC/5Cm0RUrHV+Mu36wmzdxhI8a+M346370bIq/yuH/jtQq4XngW1O9ryuurBAzSLvyptvg
 q/bnyd8NxrC2aznc6yaOHe7ezp9aFbo8AWzdb9wGCBR+NUwHtkBWEAwMolLW7UJudea1E7RGP
 LqJnVcO1I0C7LgAj/6SK4ncKJxHrg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595287238008174836?=
X-GMAIL-MSGID: =?utf-8?q?1595287238008174836?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In

	dwc3_request	*r = NULL;
	r = A;

the first assignment has no effect. Remove it.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 drivers/usb/dwc3/ep0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 18be31d5743a..5a991bca8ed7 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -814,7 +814,7 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
 static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event)
 {
-	struct dwc3_request	*r = NULL;
+	struct dwc3_request	*r;
 	struct usb_request	*ur;
 	struct dwc3_trb		*trb;
 	struct dwc3_ep		*ep0;
-- 
2.16.2
