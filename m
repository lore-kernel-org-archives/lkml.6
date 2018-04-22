Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49xJ8glq3OYRi5bwsL97r6CMzV9wCYEtazAYBkVNEn2+rHhsI/Z+SEStBn1iBZKoN2/MLM9
ARC-Seal: i=1; a=rsa-sha256; t=1524405805; cv=none;
        d=google.com; s=arc-20160816;
        b=u54Me/jIFjJyMUWQcDcemnE9VCr4kBhWBf1+Jt3ZzmBFkRtl6zeRLLoPhSs6wBeFZ3
         nBpft85PZr3NAm9LviVeUbtpJzX7bTBMwg3RhLNs20VeeD9JrqixYcdej1UpdBmrmehs
         FvD7eJLaDat0IDuvuqYSP2GA2VNCu8lbVT+8fZ9uJDui6di6I1F2KC5WQxp6GBWBTXTv
         ELSnfAC7QIEzpOeqEgbFK0WJOqQzoGSGnugNchsJn7mk0pzhtz/sM859cPL9QyKRFf/X
         aWnzostQiGjMO9mfMoHn2e1d1QYrdeFrJwtOHwheINxS1NpftG1yfsHMP+SOvALrYvlq
         dAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0JiKYUjxlNsnhCcnQ/0irNXjQaIuuTR9VhQImumD2qw=;
        b=qlvNkDX3v8MmpUEta/VrTsjhUJ9n7B3IlgBKpbaAb9UbxWgO8uvBSZWFX2cnwK/G1a
         Tj6m1y+qc7dCZuDvwyfnSYF1ehk+ErLNZYIt2gLrU4oNQcxVG/wXdO5mvopIYX0N4LZd
         zWy7dUACKjSz3vdfdSfidnOUL+SiHUEN8h585UFhjfmOxgKHiL/zT2wd+Njxk4R0HS+l
         5QndeBOGdxvNS2Fidq1UI2rmcQSTanPxQdUkB0wkbqAiWGEoS9ZkFOvRffL0anuFQ7zy
         zATvyEfx+918q/LlvfEf2cc1AmrZ+xf+no76qRg4O0r3wykMr5XzVYeaNS/0hergQeyB
         F7mA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nico Sneck <nicosneck@hotmail.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.16 156/196] drm/radeon: add PX quirk for Asus K73TK
Date: Sun, 22 Apr 2018 15:52:56 +0200
Message-Id: <20180422135112.286424249@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455342370234754?=
X-GMAIL-MSGID: =?utf-8?q?1598455342370234754?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nico Sneck <nicosneck@hotmail.com>

commit b1550359d1eb392ee54f7cf47cffcfe0a602f6a7 upstream.

With this the dGPU turns on correctly.

Signed-off-by: Nico Sneck <nicosneck@hotmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/radeon_device.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -139,6 +139,10 @@ static struct radeon_px_quirk radeon_px_
 	 * https://bugs.freedesktop.org/show_bug.cgi?id=101491
 	 */
 	{ PCI_VENDOR_ID_ATI, 0x6741, 0x1043, 0x2122, RADEON_PX_QUIRK_DISABLE_PX },
+	/* Asus K73TK laptop with AMD A6-3420M APU and Radeon 7670m GPU
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=51381#c52
+	 */
+	{ PCI_VENDOR_ID_ATI, 0x6840, 0x1043, 0x2123, RADEON_PX_QUIRK_DISABLE_PX },
 	{ 0, 0, 0, 0, 0 },
 };
 
