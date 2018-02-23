Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225oL5kHP8I5aGcBr2jk1x65/J0zDUNdXktLqOrcWcDUnH9/2x58p54i325a6HKrLEK2woaY
ARC-Seal: i=1; a=rsa-sha256; t=1519412337; cv=none;
        d=google.com; s=arc-20160816;
        b=hk1hz5niuOy++PhyUCIgd3RagrlsJpIRHZPD8t4rSvXke8qH2bZCZqS4Vs70T6Qtie
         zciwZ8pyjFA4pW/pM6Vfa8XiuEZIeAUKX5Iu2nPPe1YYi0WFM42eaWUgbi9OFIcI3ce5
         ZphmeZEAPg3N19n8C1BdMrQvk7AtjqO2jHUtb/1YvbUKrsMjm4IwePCkca3XQgE9Nrd5
         0L4/+k7mFdgW/H2y/42kuzMUx+RLi/oE1c5mfxH8RIh769iflcK5EDvcNqdBhzn2g8PU
         W8pctsT8zsU89lv3Swsp+wXm5wOrfZ49yhqtnUScoO9b6zONwafc+tXr78cPVfM47D7G
         m8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Co1OZRGD/TpKW+chh9UV4SReE0xU+8xsIMQUcwGgKw8=;
        b=Cc6eTixqhfQ8nVUJlSoxTWEOkjxnxeLdTSxpXEvGFEt/E1TrzZWIipHhzEP3SdLCbq
         HTxu0kmffdtCsa9DAloxZxXcnuO4h3UFAoGwXTpzke7IV8QL0GNf3c6teJQY0h7jvv/k
         IwI0gmrtpH7xQxotLWjIDCHs0TuNVnuubfDEPsQk2bYTf659uxB1oZV3tM56nRbO4WVO
         iMutUwOs/CDrd+2PznoIUOpdpirXxyZyMb/t4Uo2zEgyO3GsJB7wvfVr087G3dqslvRi
         AmXkpOLC8bY3jZ21zPRL85+z1uwqrED2y8GoZto9R7bAsUShk2s1CiZn8Lqr8LgFvj2C
         Z/Pg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 4.15 44/45] mei: me: add cannon point device ids for 4th device
Date: Fri, 23 Feb 2018 19:29:23 +0100
Message-Id: <20180223170722.402558532@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219191114651685?=
X-GMAIL-MSGID: =?utf-8?q?1593219310400243135?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Winkler <tomas.winkler@intel.com>

commit 2a4ac172c2f257d28c47b90c9e381bec31edcc44 upstream.

Add cannon point device ids for 4th (itouch) device.

Cc: <stable@vger.kernel.org> 4.14+
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/hw-me-regs.h |    2 ++
 drivers/misc/mei/pci-me.c     |    2 ++
 2 files changed, 4 insertions(+)

--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -133,7 +133,9 @@
 #define MEI_DEV_ID_KBP_2      0xA2BB  /* Kaby Point 2 */
 
 #define MEI_DEV_ID_CNP_LP     0x9DE0  /* Cannon Point LP */
+#define MEI_DEV_ID_CNP_LP_4   0x9DE4  /* Cannon Point LP 4 (iTouch) */
 #define MEI_DEV_ID_CNP_H      0xA360  /* Cannon Point H */
+#define MEI_DEV_ID_CNP_H_4    0xA364  /* Cannon Point H 4 (iTouch) */
 
 /*
  * MEI HW Section
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -99,7 +99,9 @@ static const struct pci_device_id mei_me
 	{MEI_PCI_DEVICE(MEI_DEV_ID_KBP_2, MEI_ME_PCH8_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_LP, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_LP_4, MEI_ME_PCH8_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H_4, MEI_ME_PCH8_CFG)},
 
 	/* required last entry */
 	{0, }
