Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv+VjhcAtdyvRw6YaJA626HwbBPBURk2RHEOfaW0On3swK5gR9NL5GyM9um+HRviogRc8j7
ARC-Seal: i=1; a=rsa-sha256; t=1521484243; cv=none;
        d=google.com; s=arc-20160816;
        b=QAjCXo0pckbICxku7X7LI2tzB50Yu+2wwHIUBI8YTUa8FkXVYzhSYszkQZX7vAYXM/
         PbW6XS9THvCZI94FXo8jLRonEVZizPt7r34eLehzT8kDleC9KZCDXB11vcUAD8L5BuxN
         lYwbJEw/EuR87k3V7xnRUsweE5D6i+vLSCUmgtJcMQbeospRO4hnxfOH6giihCEXMnjA
         r/0F8DLH2u1tRpD0Q+z6bck+oAoRg1YzuIihmZq40CsL6rrlfESEdDJxWm+EpKsL2DaW
         npFoqqu2B/VlMFbL/qekc+2k4MVsN5FV63irH3w0v+dqHs7jFCIjqPee6bdmmwSOzaZZ
         TniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=15vOZM4xszL5GieflHi9IsjFDD+DjgVHYSvjKCYfoH8=;
        b=FEi9o460ypImh+cvu/LKV0dg2DPdTicKaYQSEQNjqP4I4YljabESZXV0/HPuuydvlB
         suudfYrruvxsFCLE0DpsORtiRqgOUasrqurcr2mPVNTNJ9ZvoiQEFiNTRpAkCkn2e8KC
         FopSv7GJknIagm9qxhC22bLHiP8xZivPypivuFQXzUWgwzdfc7hYdjObv7KttkfSmJov
         lPAxjvXaCsv41x9ktRf9HMoW65u2I+ZPIkoh3906Bnr/TwNBzGoZ50smEdbE71DVnH4K
         ZZC1uvIZ+9Hx/uGCxIxaukc1xFeZEn4TqGRKvrOMifVxSS3/7AGro8mI/D2Oq87UB9J4
         ydWA==
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
Subject: [PATCH 4.14 41/41] usb: dwc3: Fix GDBGFIFOSPACE_TYPE values
Date: Mon, 19 Mar 2018 19:08:41 +0100
Message-Id: <20180319180734.846430315@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391736203563121?=
X-GMAIL-MSGID: =?utf-8?q?1595391862455128996?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -166,13 +166,15 @@
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
