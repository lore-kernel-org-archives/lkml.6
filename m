Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqrwAJESaGbH2ySpPZ2zZW6G2l1m8LzYCy4TBY52sPexbUBe7VfhRsYBqkmJ4UFoqJsly0D
ARC-Seal: i=1; a=rsa-sha256; t=1524837989; cv=none;
        d=google.com; s=arc-20160816;
        b=PonRhFWGedyAmEKUlC2cv15gfgedv5Bc7lDSWzjOPBOOcL7gm3c7drESCu0xLQD6NQ
         /B6oV610PTL/5TK98s8bLu9AuRZruweNvp2diEuTnEkSAABkol+b8AJ173u+vvEsT8X6
         wYWTmdF+6SeSNAO0riVO2yQs3d0GD8FA69UpA21be1b5L6K1ltHDCU+yzzwnug6Im5fe
         VSXN/EVFIsvm2QtxqL8f5DZwRRsofMuXiPp6JkkxuqoUu2FRTL6iVk5FAixo/JjnH2BH
         IEotTHukPRrnOwbRCpf7EvOQmBsvCYZFDUM168NogqWkG3R7YJtQULllQiYkrnOCZj70
         d+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=sgWwtVhgxX/juCjoXcUg1tFjF4CdonN4CiJNdoaDl60=;
        b=S/VMFz/G7S9ZfIvjbG8Jic4+2qKjf8Zoq8QaILIw70isP7JZr4vgx8c3CmPMSdLi/P
         XV/6b4CZEh0BHAJyVJU26H/I5BbaqR93gCXA68aRAiOOLz0wy95VlJp2StWBPdy0vjht
         qTa8v5UE7j4BHPCxxMd3b7xGrnNC8YzznfvalfgzOkCYOIJKuLwWLRcSXXPNPwq4oedA
         3zAaf+6YgVu9GcunzdiU2H7YLn5uHikYEJLzTO3L949N47PIOFdFnAxWZvIlt2PzIC+J
         4uELgjrnPtjpD0TOizJYjNlZA4cTHlMwp68svi+OCQ7PbDmjZSacJPJn4pKToMVBLkp3
         3LSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD3121890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Archit Taneja <architt@codeaurora.org>,
	Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4.14 02/80] drm: bridge: dw-hdmi: Fix overflow workaround for Amlogic Meson GX SoCs
Date: Fri, 27 Apr 2018 15:57:55 +0200
Message-Id: <20180427135733.038377575@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908520118172007?=
X-GMAIL-MSGID: =?utf-8?q?1598908520118172007?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neil Armstrong <narmstrong@baylibre.com>

commit 9c305eb442f3b371fc722ade827bbf673514123e upstream.

The Amlogic Meson GX SoCs, embedded the v2.01a controller, has been also
identified needing this workaround.
This patch adds the corresponding version to enable a single iteration for
this specific version.

Fixes: be41fc55f1aa ("drm: bridge: dw-hdmi: Handle overflow workaround based on device version")
Acked-by: Archit Taneja <architt@codeaurora.org>
[narmstrong: s/identifies/identified and rebased against Jernej's change]
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1519386277-25902-1-git-send-email-narmstrong@baylibre.com
[narmstrong: v4.14 to v4.16 backport]
Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1634,6 +1634,8 @@ static void dw_hdmi_clear_overflow(struc
 	 * (and possibly on the platform). So far only i.MX6Q (v1.30a) and
 	 * i.MX6DL (v1.31a) have been identified as needing the workaround, with
 	 * 4 and 1 iterations respectively.
+	 * The Amlogic Meson GX SoCs (v2.01a) have been identified as needing
+	 * the workaround with a single iteration.
 	 */
 
 	switch (hdmi->version) {
@@ -1641,6 +1643,7 @@ static void dw_hdmi_clear_overflow(struc
 		count = 4;
 		break;
 	case 0x131a:
+	case 0x201a:
 		count = 1;
 		break;
 	default:
