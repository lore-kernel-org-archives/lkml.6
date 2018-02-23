Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226+0Ub6vw/trdpyt/Vir5/DF+yMdScX7gvu7PHd791FEoiZ2EQxhslqMpwsCjTn+ask1Gdw
ARC-Seal: i=1; a=rsa-sha256; t=1519412331; cv=none;
        d=google.com; s=arc-20160816;
        b=O4gyo6TDQWiQcJ6tTN8BMcq8deEDr8WrPj6lZPA0YaguoIH9OKDuUXD0Ms3ldXuK1a
         t9VKkfY7r7BnuVK8njFHI0cAQBoxyoEHsk+9mxaDFUAbqN2B24EFSoQwQzXraDmuV4cz
         eMlEP/g7Yg/wlc1iqvjHIK/WXIuWlGknvCTQzVjsT6EkXsaes65R3raST4W8LmLlSBAv
         5WSRyX/iGPaRfaQoiGvWA+i34swHlDsipxzIiPE1MN2zkpPdSYnzK3T45O6OI+6pL6y+
         jF9Y+oRRxUkBa/hLqOyutte04FCtWgEOZHmhqyJOjVFEBcPcnDo0ktZjikr6GwG73imW
         VOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eD8J0E+c4RKp8U4dQIzIjgnspsVuDnPO8DXn9rTfgcU=;
        b=aiBHT/wWjzTD4Cc7K0ApTUDDGn/Sgrt5YrCoE4tTufCLfoj92rmPnki0/R7J9shnIK
         ztepntAEogZ/IcOj1pw4uhmoF3JItkL8ItGxsmMLMvBDmUQWFr0cHh2m7cUiVb6FjluM
         nTpvTpFm99hmdaycip5dwANaDuWSRWl41cN3+QiPI+W+nuud9F6+mOjt3Fsa0cNpPuKt
         tXUL7vhbvuojlqFr37ZlGD9z7nZSN3F/w9G9dzMvAYhxfNuMi9QiUwAP2wR04N9FmPXy
         yR7Uu3kUV33Wg4OFsWJJhhL4yw6AraZi8m5RhSuPHWvG5/4B4+wYuII53phfmQ/aPIyG
         lCvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 4.15 43/45] mei: me: add cannon point device ids
Date: Fri, 23 Feb 2018 19:29:22 +0100
Message-Id: <20180223170722.253250915@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219189171382911?=
X-GMAIL-MSGID: =?utf-8?q?1593219305338915210?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Usyskin <alexander.usyskin@intel.com>

commit f8f4aa68a8ae98ed79c8fee3488c38a2f5d2de8c upstream.

Add CNP LP and CNP H device ids for cannon lake
and coffee lake platforms.

Cc: <stable@vger.kernel.org> 4.14+
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/hw-me-regs.h |    3 +++
 drivers/misc/mei/pci-me.c     |    3 +++
 2 files changed, 6 insertions(+)

--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -132,6 +132,9 @@
 #define MEI_DEV_ID_KBP        0xA2BA  /* Kaby Point */
 #define MEI_DEV_ID_KBP_2      0xA2BB  /* Kaby Point 2 */
 
+#define MEI_DEV_ID_CNP_LP     0x9DE0  /* Cannon Point LP */
+#define MEI_DEV_ID_CNP_H      0xA360  /* Cannon Point H */
+
 /*
  * MEI HW Section
  */
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -98,6 +98,9 @@ static const struct pci_device_id mei_me
 	{MEI_PCI_DEVICE(MEI_DEV_ID_KBP, MEI_ME_PCH8_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_KBP_2, MEI_ME_PCH8_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_LP, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H, MEI_ME_PCH8_CFG)},
+
 	/* required last entry */
 	{0, }
 };
