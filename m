Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq7WVmZPXprCyFlO1TB2/Qrw1swwdw1aP1xn+Kk4u9tCl151W60dvrIt4H8CvuftmF1Sde7
ARC-Seal: i=1; a=rsa-sha256; t=1527155666; cv=none;
        d=google.com; s=arc-20160816;
        b=wST2yf80hMDMgtZUvfHsl/7fDOJE3N6fJAcWQcrZdby/z/kWHNNPWNMu8UtQscL0R5
         6uwtOS10ZWMv3TYwpxNxWknsze4tPaF0MM5U1noo5mprIxFwaKpl2GUry1iQJATBtDm1
         cXyM5GiC3EJzxS5DYwaJlrWe+qhdejkr6ZWxvgzRitDqNORb255UUNpCav/amp+86t/U
         1yR7GTLaDlJNJOTGi86vSuobAjbj/u6GvS6wEr/vcQkAidevz1LOrryGQQkjYlbkjkxY
         LenWwcNl4+C7RzE6ksRSy2lo0H/cCEzIG7+ZPHGHlgdmBEyAgWWIcCF0JGhfYSOWKjy3
         CsCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=JYyePSqrPkEK1NS1pLRCtUt6jPv25IXjMZuHXg0hse0=;
        b=SoegSFeWgwrhnJSLkx3tBsJ/MY0S+MLQIB1XXXtwF7Y+iYK7dEaYhit12DEBmzzRWS
         Kq516/suf3qUxubO48hYW4AppYyBTatR+fa8FbDTMC3MY7DNfIpH2E//7LC/xHHCI+kf
         6ev9a/FGaoPXPyHh1kne+XmECe1RPD3W98u05NjK0+gbclAO3w1aA+WpxSIxRFcC4ulI
         yiYXkyengqEubsCE45Hc2ChQBWzqURFvj/wd1jY9pPTVShM/cdQuX4K7bfUrKuWsCE+/
         OtNDRTdZkl26S0+ZoYsbY8JTFW1rK/6EVxZnG8lPvjvZyvllnyPV8/HZFvLXCIizMyvH
         ayig==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OTQwRERl;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OTQwRERl;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 071/165] usb: dwc3: Makefile: fix link error on randconfig
Date: Thu, 24 May 2018 11:37:57 +0200
Message-Id: <20180524093624.890422421@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338780263103947?=
X-GMAIL-MSGID: =?utf-8?q?1601338780263103947?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felipe Balbi <felipe.balbi@linux.intel.com>

[ Upstream commit de948a74ad6f0eefddf36d765b8f2dd6df82caa0 ]

If building a kernel without FTRACE but with TRACING, dwc3.ko fails to
link due to missing trace events. Fix this by using the correct
Kconfig symbol on Makefile.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_USB_DWC3)			+= dwc3.o
 
 dwc3-y					:= core.o
 
-ifneq ($(CONFIG_FTRACE),)
+ifneq ($(CONFIG_TRACING),)
 	dwc3-y				+= trace.o
 endif
 
