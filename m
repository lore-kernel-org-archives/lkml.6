Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELve/dlsjt2O+sFyeJbrFdVgt9z3p+P6f6nWxFxBvMKlnxXGgowBmkGk1gWP9zaa8i2B2kBZ
ARC-Seal: i=1; a=rsa-sha256; t=1521484123; cv=none;
        d=google.com; s=arc-20160816;
        b=xE6/jajHVCoMcD9dL5QyOYdfK5O5/4C6l839t7OLU/nEhiwhy5e+hTyJEeI1cIqlcz
         e/tQDVWQJfOp/4Si/imUHlBUJQrO/rj8WMpduJOw1CZzA83si6jt6k6mBQyuBM6sSgYe
         tV7TYfKryAvNGBaUWNMwwpzyXqUNVdp4kNQyx99iho8NPKC5evea+YmJ5WOh9YkCedgZ
         xqZ+pxBO83HROteuDcw+S48TwUTzfLDQG+bT8M/pLoCmR4yAspPCa8Q2Wl2a3nXKVi7o
         nArbhduVjHJL+MG3NKDuNaU20qwNGYoyo8EyseiK+dKUvDNG4PXKAq+wEhDIeCazkZf8
         g69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=anYGwOQNaT6EQ5Ea4uSTWj8sZlCLZmxCOIUpzK2iJmc=;
        b=SWuTciHtpiYNgJvj/pwIqHBo8KFnRITAiOU1KnONaskdMna9nN04H0ujcVN4PLBJIL
         3HeArf+FeqB2Lm6J/ddwxrf0mFlfOSLTnK8N6wcDNJozRRxRlP1az+fxysuhCtp2Z55Q
         epmcddIzaBeD8+Urth5eBH79GaAGr2dftSylWPAIDFxzzAn3Cu8Z/Ts6JxKW1Jy9nWih
         asQ6YQn0/0o2isjH/2My6jWFECEjxpjIrpDU4fahoOOu2Ycg5OwlWHegC0AXHMWzEsEr
         F9djhgJQFPdNSgdWDUvuU1Sy9cN8jc2cqtXTtD6yC0YCM/tuGbg4w1YFSuA7zEe6pmj4
         BDEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thinh Nguyen <thinhn@synopsys.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.9 240/241] usb: dwc3: Fix GDBGFIFOSPACE_TYPE values
Date: Mon, 19 Mar 2018 19:08:25 +0100
Message-Id: <20180319180801.105762772@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391736203563121?=
X-GMAIL-MSGID: =?utf-8?q?1595391736203563121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit b16ea8b9492e99e03b1269fe93ebdbf8e4eabf8a upstream.

The FIFO/Queue type values are incorrect. Correct them according to
DWC_usb3 programming guide section 1.2.27 (or DWC_usb31 section 1.2.25).

Additionally, this patch includes ProtocolStatusQ and AuxEventQ types.

Fixes: cf6d867d3b57 ("usb: dwc3: core: add fifo space helper")
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/core.h |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -159,13 +159,15 @@
 #define DWC3_GDBGFIFOSPACE_TYPE(n)	(((n) << 5) & 0x1e0)
 #define DWC3_GDBGFIFOSPACE_SPACE_AVAILABLE(n) (((n) >> 16) & 0xffff)
 
-#define DWC3_TXFIFOQ		1
-#define DWC3_RXFIFOQ		3
-#define DWC3_TXREQQ		5
-#define DWC3_RXREQQ		7
-#define DWC3_RXINFOQ		9
-#define DWC3_DESCFETCHQ		13
-#define DWC3_EVENTQ		15
+#define DWC3_TXFIFOQ		0
+#define DWC3_RXFIFOQ		1
+#define DWC3_TXREQQ		2
+#define DWC3_RXREQQ		3
+#define DWC3_RXINFOQ		4
+#define DWC3_PSTATQ		5
+#define DWC3_DESCFETCHQ		6
+#define DWC3_EVENTQ		7
+#define DWC3_AUXEVENTQ		8
 
 /* Global RX Threshold Configuration Register */
 #define DWC3_GRXTHRCFG_MAXRXBURSTSIZE(n) (((n) & 0x1f) << 19)
