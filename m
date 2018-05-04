Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3672311-1525410083-2-9211295302398230812
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525410081; b=TuocvFMVGS5bcs9n3EX3tKfvu86a1XaGW+Mop6XPs/vqpV1RVH
    kZUItrTeXzpvUb3tnjRtW1CrkVSnRxQHwngcMbF1VIlvlqRn0WR/6PaploanQihF
    nYexsti8oGRSoEQuO8C+GCbFytD2wkKYJVF+yx1QxYap4Y8WfmRoEdbrPB52jOGG
    ZAcUcmoOGt6druTZvIfUYP6LwLWv+78+ux0VnHUm4/IM/+vm0xnG8BCEYOZCaSmM
    euBEN/iseeMOoqKq6W1IUrjITz/fVjiEW1Hp03NIH+BQdw30fkIqFVANnT+Cw4Hl
    U7ZLJbFmnK+qhC2GyhXGwKbZhvOwufiaKIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525410081; bh=5Q9Ac
    d+vkXEKVUCa0oBa9cKYqf0LnFgha6K9RTPvna4=; b=G/9XgP1/rUZ+w1qLRPVS4
    fOI8v8CamzSc/Ll3r8zSzSp1yTAiJ1no5NwJu/xU3KqRBS6Kem7ik0wQ/CEFWzjN
    QCUuY202tVqVDiA7XGyeJVxbeJd6Y+jRlaXjoE8SQ0ywNrJKdb4KDTHvXAhKjqOs
    1gTyFoj/KGbJjSt6kSSIq7f7nCcZTVi77/8mDHw9qnFe3y81c7yIqLTvUAkL2utA
    0+Zg1oCa9vbe16TT6U2H295QOUMJBoIB2HKMvjFc60ZoUMFIzNinQYMNSh+90H6s
    DRFcgjN3BW5/OhfZyq1hk1NRyvgtJh+Kg0OtRWQt7eakfYmHBj0RGHZp7Cz/3jEq
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=brown.name header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=brown.name header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO7HguKdbX1oCnEqEzldrfEaxJ+GtUEg0t6eYN13VLfCt9UJlllTHNuh+6pfvAXGB4NNemj3ihAnSVsWdIUyJtuw3lYJpSpIbTqWyc1TLk47nXFNOw0A
    UOEkfp9w96E7j/ybrTI/5kQ+H6PgMMlD8rVSvgmOmogN9nmVbDqi8O/zUBBf5SHo5Nj+CO6jx85pSQer2MKjkW8DK/pbFk5wwCh966j5OAXMHOlqoYzmbRnx
    sv5GM3088R4FMm2wpobv1g==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10
    a=VUJBJC2UJ8kA:10 a=qEKT6kP3PEYA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ZZnuYtJkoWoA:10 a=DDOyTI_5AAAA:8 a=rg2ZDoFKWZSSW3Ul81IA:9
    a=wSgb2rH3srQSJpsH:21 a=3RH1Nert1LifMAMK:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 04 May 2018 14:58:36 +1000
Subject: [PATCH 4/8] staging: mt7621-pci: white-space cleanups.
Message-ID: <152540991611.12190.5969998001308227102.stgit@noble>
In-Reply-To: <152540982998.12190.15220622955317261586.stgit@noble>
References: <152540982998.12190.15220622955317261586.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

- remove white space at end of line.
- no more than 2 blank line at a time
- remove spaces before tabs
- use tabs to line things up
- re-indent some #define do{}while(0)

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/staging/mt7621-pci/pci-mt7621.c |  291 +++++++++++++++----------------
 1 file changed, 143 insertions(+), 148 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index cc89d464ef7f..c8d7b47c8952 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -67,95 +67,94 @@ extern void chk_phy_pll(void);
 #define CONFIG_PCIE_PORT0
 #define CONFIG_PCIE_PORT1
 #define CONFIG_PCIE_PORT2
-#define RALINK_PCIE0_CLK_EN             (1<<24)
-#define RALINK_PCIE1_CLK_EN             (1<<25)
-#define RALINK_PCIE2_CLK_EN             (1<<26)
-
-#define RALINK_PCI_CONFIG_ADDR                         0x20
-#define RALINK_PCI_CONFIG_DATA_VIRTUAL_REG     0x24
-#define RALINK_PCI_MEMBASE              *(volatile u32 *)(RALINK_PCI_BASE + 0x0028)
-#define RALINK_PCI_IOBASE               *(volatile u32 *)(RALINK_PCI_BASE + 0x002C)
-#define RALINK_PCIE0_RST                (1<<24)
-#define RALINK_PCIE1_RST                (1<<25)
-#define RALINK_PCIE2_RST                (1<<26)
-#define RALINK_SYSCTL_BASE              0xBE000000
-
-#define RALINK_PCI_PCICFG_ADDR          *(volatile u32 *)(RALINK_PCI_BASE + 0x0000)
-#define RALINK_PCI_PCIMSK_ADDR          *(volatile u32 *)(RALINK_PCI_BASE + 0x000C)
-#define RALINK_PCI_BASE                 0xBE140000
-
-#define RALINK_PCIEPHY_P0P1_CTL_OFFSET (RALINK_PCI_BASE + 0x9000)
-#define RT6855_PCIE0_OFFSET     0x2000
-#define RT6855_PCIE1_OFFSET     0x3000
-#define RT6855_PCIE2_OFFSET     0x4000
-
-#define RALINK_PCI0_BAR0SETUP_ADDR      *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0010)
-#define RALINK_PCI0_IMBASEBAR0_ADDR     *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0018)
-#define RALINK_PCI0_ID                  *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0030)
-#define RALINK_PCI0_CLASS               *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0034)
-#define RALINK_PCI0_SUBID               *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0038)
-#define RALINK_PCI0_STATUS              *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0050)
-#define RALINK_PCI0_DERR                *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0060)
-#define RALINK_PCI0_ECRC                *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0064)
-
-#define RALINK_PCI1_BAR0SETUP_ADDR      *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0010)
-#define RALINK_PCI1_IMBASEBAR0_ADDR     *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0018)
-#define RALINK_PCI1_ID                  *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0030)
-#define RALINK_PCI1_CLASS               *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0034)
-#define RALINK_PCI1_SUBID               *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0038)
-#define RALINK_PCI1_STATUS              *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0050)
-#define RALINK_PCI1_DERR                *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0060)
-#define RALINK_PCI1_ECRC                *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0064)
-
-#define RALINK_PCI2_BAR0SETUP_ADDR      *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0010)
-#define RALINK_PCI2_IMBASEBAR0_ADDR     *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0018)
-#define RALINK_PCI2_ID                  *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0030)
-#define RALINK_PCI2_CLASS               *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0034)
-#define RALINK_PCI2_SUBID               *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0038)
-#define RALINK_PCI2_STATUS              *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0050)
-#define RALINK_PCI2_DERR                *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0060)
-#define RALINK_PCI2_ECRC                *(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0064)
-
-#define RALINK_PCIEPHY_P0P1_CTL_OFFSET  (RALINK_PCI_BASE + 0x9000)
-#define RALINK_PCIEPHY_P2_CTL_OFFSET    (RALINK_PCI_BASE + 0xA000)
-
-
-#define MV_WRITE(ofs, data)  \
-        *(volatile u32 *)(RALINK_PCI_BASE+(ofs)) = cpu_to_le32(data)
-#define MV_READ(ofs, data)   \
-	        *(data) = le32_to_cpu(*(volatile u32 *)(RALINK_PCI_BASE+(ofs)))
-#define MV_READ_DATA(ofs)    \
-		        le32_to_cpu(*(volatile u32 *)(RALINK_PCI_BASE+(ofs)))
-
-#define MV_WRITE_16(ofs, data)  \
-        *(volatile u16 *)(RALINK_PCI_BASE+(ofs)) = cpu_to_le16(data)
-#define MV_READ_16(ofs, data)   \
-	        *(data) = le16_to_cpu(*(volatile u16 *)(RALINK_PCI_BASE+(ofs)))
-
-#define MV_WRITE_8(ofs, data)  \
-        *(volatile u8 *)(RALINK_PCI_BASE+(ofs)) = data
-#define MV_READ_8(ofs, data)   \
-	        *(data) = *(volatile u8 *)(RALINK_PCI_BASE+(ofs))
-
-
-
-#define RALINK_PCI_MM_MAP_BASE	0x60000000
-#define RALINK_PCI_IO_MAP_BASE	0x1e160000
+#define RALINK_PCIE0_CLK_EN		(1<<24)
+#define RALINK_PCIE1_CLK_EN		(1<<25)
+#define RALINK_PCIE2_CLK_EN		(1<<26)
+
+#define RALINK_PCI_CONFIG_ADDR		0x20
+#define RALINK_PCI_CONFIG_DATA_VIRTUAL_REG	0x24
+#define RALINK_PCI_MEMBASE		*(volatile u32 *)(RALINK_PCI_BASE + 0x0028)
+#define RALINK_PCI_IOBASE		*(volatile u32 *)(RALINK_PCI_BASE + 0x002C)
+#define RALINK_PCIE0_RST		(1<<24)
+#define RALINK_PCIE1_RST		(1<<25)
+#define RALINK_PCIE2_RST		(1<<26)
+#define RALINK_SYSCTL_BASE		0xBE000000
+
+#define RALINK_PCI_PCICFG_ADDR		*(volatile u32 *)(RALINK_PCI_BASE + 0x0000)
+#define RALINK_PCI_PCIMSK_ADDR		*(volatile u32 *)(RALINK_PCI_BASE + 0x000C)
+#define RALINK_PCI_BASE	0xBE140000
+
+#define RALINK_PCIEPHY_P0P1_CTL_OFFSET	(RALINK_PCI_BASE + 0x9000)
+#define RT6855_PCIE0_OFFSET		0x2000
+#define RT6855_PCIE1_OFFSET		0x3000
+#define RT6855_PCIE2_OFFSET		0x4000
+
+#define RALINK_PCI0_BAR0SETUP_ADDR	*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0010)
+#define RALINK_PCI0_IMBASEBAR0_ADDR	*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0018)
+#define RALINK_PCI0_ID			*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0030)
+#define RALINK_PCI0_CLASS		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0034)
+#define RALINK_PCI0_SUBID		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0038)
+#define RALINK_PCI0_STATUS		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0050)
+#define RALINK_PCI0_DERR		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0060)
+#define RALINK_PCI0_ECRC		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0064)
+
+#define RALINK_PCI1_BAR0SETUP_ADDR	*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0010)
+#define RALINK_PCI1_IMBASEBAR0_ADDR	*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0018)
+#define RALINK_PCI1_ID			*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0030)
+#define RALINK_PCI1_CLASS		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0034)
+#define RALINK_PCI1_SUBID		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0038)
+#define RALINK_PCI1_STATUS		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0050)
+#define RALINK_PCI1_DERR		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0060)
+#define RALINK_PCI1_ECRC		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0064)
+
+#define RALINK_PCI2_BAR0SETUP_ADDR	*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0010)
+#define RALINK_PCI2_IMBASEBAR0_ADDR	*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0018)
+#define RALINK_PCI2_ID			*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0030)
+#define RALINK_PCI2_CLASS		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0034)
+#define RALINK_PCI2_SUBID		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0038)
+#define RALINK_PCI2_STATUS		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0050)
+#define RALINK_PCI2_DERR		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0060)
+#define RALINK_PCI2_ECRC		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0064)
+
+#define RALINK_PCIEPHY_P0P1_CTL_OFFSET	(RALINK_PCI_BASE + 0x9000)
+#define RALINK_PCIEPHY_P2_CTL_OFFSET	(RALINK_PCI_BASE + 0xA000)
+
+#define MV_WRITE(ofs, data)	\
+	*(volatile u32 *)(RALINK_PCI_BASE+(ofs)) = cpu_to_le32(data)
+#define MV_READ(ofs, data)	\
+	*(data) = le32_to_cpu(*(volatile u32 *)(RALINK_PCI_BASE+(ofs)))
+#define MV_READ_DATA(ofs)	\
+	le32_to_cpu(*(volatile u32 *)(RALINK_PCI_BASE+(ofs)))
+
+#define MV_WRITE_16(ofs, data)	\
+	*(volatile u16 *)(RALINK_PCI_BASE+(ofs)) = cpu_to_le16(data)
+#define MV_READ_16(ofs, data)	\
+	*(data) = le16_to_cpu(*(volatile u16 *)(RALINK_PCI_BASE+(ofs)))
+
+#define MV_WRITE_8(ofs, data)	\
+	*(volatile u8 *)(RALINK_PCI_BASE+(ofs)) = data
+#define MV_READ_8(ofs, data)	\
+	*(data) = *(volatile u8 *)(RALINK_PCI_BASE+(ofs))
+
+#define RALINK_PCI_MM_MAP_BASE		0x60000000
+#define RALINK_PCI_IO_MAP_BASE		0x1e160000
 
 #define RALINK_SYSTEM_CONTROL_BASE	0xbe000000
 #define GPIO_PERST
-#define ASSERT_SYSRST_PCIE(val)		do {	\
-						if (*(unsigned int *)(0xbe00000c) == 0x00030101)	\
-							RALINK_RSTCTRL |= val;	\
-						else	\
-							RALINK_RSTCTRL &= ~val;	\
-					} while(0)
-#define DEASSERT_SYSRST_PCIE(val) 	do {	\
-						if (*(unsigned int *)(0xbe00000c) == 0x00030101)	\
-							RALINK_RSTCTRL &= ~val;	\
-						else	\
-							RALINK_RSTCTRL |= val;	\
-					} while(0)
+#define ASSERT_SYSRST_PCIE(val)		\
+	do {								\
+		if (*(unsigned int *)(0xbe00000c) == 0x00030101)	\
+			RALINK_RSTCTRL |= val;				\
+		else							\
+			RALINK_RSTCTRL &= ~val;				\
+	} while(0)
+#define DEASSERT_SYSRST_PCIE(val)	\
+	do {								\
+		if (*(unsigned int *)(0xbe00000c) == 0x00030101)	\
+			RALINK_RSTCTRL &= ~val;				\
+		else							\
+			RALINK_RSTCTRL |= val;				\
+	} while(0)
 #define RALINK_SYSCFG1			*(unsigned int *)(RALINK_SYSTEM_CONTROL_BASE + 0x14)
 #define RALINK_CLKCFG1			*(unsigned int *)(RALINK_SYSTEM_CONTROL_BASE + 0x30)
 #define RALINK_RSTCTRL			*(unsigned int *)(RALINK_SYSTEM_CONTROL_BASE + 0x34)
@@ -275,7 +274,6 @@ write_config_dword(struct pci_bus *bus, unsigned int devfn, int where, u32 val)
 	return PCIBIOS_SUCCESSFUL;
 }
 
-
 static int
 pci_config_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 * val)
 {
@@ -303,7 +301,7 @@ pci_config_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u
 }
 
 struct pci_ops mt7621_pci_ops= {
-	.read		=  pci_config_read,
+	.read		= pci_config_read,
 	.write		= pci_config_write,
 };
 
@@ -313,6 +311,7 @@ static struct resource mt7621_res_pci_mem1 = {
 	.end		= (u32)((RALINK_PCI_MM_MAP_BASE + (unsigned char *)0x0fffffff)),
 	.flags		= IORESOURCE_MEM,
 };
+
 static struct resource mt7621_res_pci_io1 = {
 	.name		= "PCI I/O1",
 	.start		= RALINK_PCI_IO_MAP_BASE,
@@ -335,10 +334,10 @@ read_config(unsigned long bus, unsigned long dev, unsigned long func, unsigned l
 	unsigned int address_reg, data_reg, address;
 
 	address_reg = RALINK_PCI_CONFIG_ADDR;
-        data_reg = RALINK_PCI_CONFIG_DATA_VIRTUAL_REG;
+	data_reg = RALINK_PCI_CONFIG_DATA_VIRTUAL_REG;
 	address = (((reg & 0xF00)>>8)<<24) | (bus << 16) | (dev << 11) | (func << 8) | (reg & 0xfc) | 0x80000000 ;
-        MV_WRITE(address_reg, address);
-        MV_READ(data_reg, val);
+	MV_WRITE(address_reg, address);
+	MV_READ(data_reg, val);
 	return;
 }
 
@@ -355,7 +354,6 @@ write_config(unsigned long bus, unsigned long dev, unsigned long func, unsigned
 	return;
 }
 
-
 int
 pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
@@ -422,76 +420,76 @@ set_phy_for_ssc(void)
 	/* Debug Xtal Type */
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x400),  8, 1, 0x01);	// rg_pe1_frc_h_xtal_type
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x400),  9, 2, 0x00);	// rg_pe1_h_xtal_type
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x000),  4, 1, 0x01);	// rg_pe1_frc_phy_en               //Force Port 0 enable control
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x100),  4, 1, 0x01);	// rg_pe1_frc_phy_en               //Force Port 1 enable control
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x000),  5, 1, 0x00);	// rg_pe1_phy_en                   //Port 0 disable
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x100),  5, 1, 0x00);	// rg_pe1_phy_en                   //Port 1 disable
-	if(reg <= 5 && reg >= 3) { 	// 40MHz Xtal
-		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490),  6, 2, 0x01);	// RG_PE1_H_PLL_PREDIV             //Pre-divider ratio (for host mode)
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x000),  4, 1, 0x01);	// rg_pe1_frc_phy_en	//Force Port 0 enable control
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x100),  4, 1, 0x01);	// rg_pe1_frc_phy_en	//Force Port 1 enable control
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x000),  5, 1, 0x00);	// rg_pe1_phy_en	//Port 0 disable
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x100),  5, 1, 0x00);	// rg_pe1_phy_en	//Port 1 disable
+	if(reg <= 5 && reg >= 3) {	// 40MHz Xtal
+		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490),  6, 2, 0x01);	// RG_PE1_H_PLL_PREDIV	//Pre-divider ratio (for host mode)
 		printk("***** Xtal 40MHz *****\n");
 	} else {			// 25MHz | 20MHz Xtal
-		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490),  6, 2, 0x00);	// RG_PE1_H_PLL_PREDIV             //Pre-divider ratio (for host mode)
-		if (reg >= 6) { 	
+		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490),  6, 2, 0x00);	// RG_PE1_H_PLL_PREDIV	//Pre-divider ratio (for host mode)
+		if (reg >= 6) {
 			printk("***** Xtal 25MHz *****\n");
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4bc),  4, 2, 0x01);	// RG_PE1_H_PLL_FBKSEL             //Feedback clock select
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x49c),  0,31, 0x18000000);	// RG_PE1_H_LCDDS_PCW_NCPO         //DDS NCPO PCW (for host mode)
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a4),  0,16, 0x18d);	// RG_PE1_H_LCDDS_SSC_PRD          //DDS SSC dither period control
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a8),  0,12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA        //DDS SSC dither amplitude control
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a8), 16,12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA1       //DDS SSC dither amplitude control for initial
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4bc),  4, 2, 0x01);	// RG_PE1_H_PLL_FBKSEL	//Feedback clock select
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x49c),  0,31, 0x18000000);	// RG_PE1_H_LCDDS_PCW_NCPO	//DDS NCPO PCW (for host mode)
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a4),  0,16, 0x18d);	// RG_PE1_H_LCDDS_SSC_PRD	//DDS SSC dither period control
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a8),  0,12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA	//DDS SSC dither amplitude control
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a8), 16,12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA1	//DDS SSC dither amplitude control for initial
 		} else {
 			printk("***** Xtal 20MHz *****\n");
 		}
 	}
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a0),  5, 1, 0x01);	// RG_PE1_LCDDS_CLK_PH_INV         //DDS clock inversion
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490), 22, 2, 0x02);	// RG_PE1_H_PLL_BC                 
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490), 18, 4, 0x06);	// RG_PE1_H_PLL_BP                 
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490), 12, 4, 0x02);	// RG_PE1_H_PLL_IR                 
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490),  8, 4, 0x01);	// RG_PE1_H_PLL_IC                 
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4ac), 16, 3, 0x00);	// RG_PE1_H_PLL_BR                 
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490),  1, 3, 0x02);	// RG_PE1_PLL_DIVEN                
-	if(reg <= 5 && reg >= 3) { 	// 40MHz Xtal
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a0),  5, 1, 0x01);	// RG_PE1_LCDDS_CLK_PH_INV	//DDS clock inversion
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490), 22, 2, 0x02);	// RG_PE1_H_PLL_BC
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490), 18, 4, 0x06);	// RG_PE1_H_PLL_BP
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490), 12, 4, 0x02);	// RG_PE1_H_PLL_IR
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490),  8, 4, 0x01);	// RG_PE1_H_PLL_IC
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4ac), 16, 3, 0x00);	// RG_PE1_H_PLL_BR
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490),  1, 3, 0x02);	// RG_PE1_PLL_DIVEN
+	if(reg <= 5 && reg >= 3) {	// 40MHz Xtal
 		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x414),  6, 2, 0x01);	// rg_pe1_mstckdiv		//value of da_pe1_mstckdiv when force mode enable
-		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x414),  5, 1, 0x01);	// rg_pe1_frc_mstckdiv          //force mode enable of da_pe1_mstckdiv      
+		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x414),  5, 1, 0x01);	// rg_pe1_frc_mstckdiv	//force mode enable of da_pe1_mstckdiv
 	}
 	/* Enable PHY and disable force mode */
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x000),  5, 1, 0x01);	// rg_pe1_phy_en                   //Port 0 enable
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x100),  5, 1, 0x01);	// rg_pe1_phy_en                   //Port 1 enable
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x000),  4, 1, 0x00);	// rg_pe1_frc_phy_en               //Force Port 0 disable control
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x100),  4, 1, 0x00);	// rg_pe1_frc_phy_en               //Force Port 1 disable control
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x000),  5, 1, 0x01);	// rg_pe1_phy_en	//Port 0 enable
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x100),  5, 1, 0x01);	// rg_pe1_phy_en	//Port 1 enable
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x000),  4, 1, 0x00);	// rg_pe1_frc_phy_en	//Force Port 0 disable control
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x100),  4, 1, 0x00);	// rg_pe1_frc_phy_en	//Force Port 1 disable control
 #endif
 #if defined (CONFIG_PCIE_PORT2)
 	/* Set PCIe Port2 PHY to disable SSC */
 	/* Debug Xtal Type */
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x400),  8, 1, 0x01);	// rg_pe1_frc_h_xtal_type
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x400),  9, 2, 0x00);	// rg_pe1_h_xtal_type
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x000),  4, 1, 0x01);	// rg_pe1_frc_phy_en               //Force Port 0 enable control
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x000),  5, 1, 0x00);	// rg_pe1_phy_en                   //Port 0 disable
-	if(reg <= 5 && reg >= 3) { 	// 40MHz Xtal
-		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490),  6, 2, 0x01);	// RG_PE1_H_PLL_PREDIV             //Pre-divider ratio (for host mode)
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x000),  4, 1, 0x01);	// rg_pe1_frc_phy_en	//Force Port 0 enable control
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x000),  5, 1, 0x00);	// rg_pe1_phy_en	//Port 0 disable
+	if(reg <= 5 && reg >= 3) {	// 40MHz Xtal
+		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490),  6, 2, 0x01);	// RG_PE1_H_PLL_PREDIV	//Pre-divider ratio (for host mode)
 	} else {			// 25MHz | 20MHz Xtal
-		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490),  6, 2, 0x00);	// RG_PE1_H_PLL_PREDIV             //Pre-divider ratio (for host mode)
-		if (reg >= 6) { 	// 25MHz Xtal
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4bc),  4, 2, 0x01);	// RG_PE1_H_PLL_FBKSEL             //Feedback clock select
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x49c),  0,31, 0x18000000);	// RG_PE1_H_LCDDS_PCW_NCPO         //DDS NCPO PCW (for host mode)
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a4),  0,16, 0x18d);	// RG_PE1_H_LCDDS_SSC_PRD          //DDS SSC dither period control
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a8),  0,12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA        //DDS SSC dither amplitude control
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a8), 16,12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA1       //DDS SSC dither amplitude control for initial
+		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490),  6, 2, 0x00);	// RG_PE1_H_PLL_PREDIV	//Pre-divider ratio (for host mode)
+		if (reg >= 6) {		// 25MHz Xtal
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4bc),  4, 2, 0x01);	// RG_PE1_H_PLL_FBKSEL	//Feedback clock select
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x49c),  0,31, 0x18000000);	// RG_PE1_H_LCDDS_PCW_NCPO	//DDS NCPO PCW (for host mode)
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a4),  0,16, 0x18d);	// RG_PE1_H_LCDDS_SSC_PRD	//DDS SSC dither period control
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a8),  0,12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA	//DDS SSC dither amplitude control
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a8), 16,12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA1	//DDS SSC dither amplitude control for initial
 		}
 	}
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a0),  5, 1, 0x01);	// RG_PE1_LCDDS_CLK_PH_INV         //DDS clock inversion
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490), 22, 2, 0x02);	// RG_PE1_H_PLL_BC                 
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490), 18, 4, 0x06);	// RG_PE1_H_PLL_BP                 
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490), 12, 4, 0x02);	// RG_PE1_H_PLL_IR                 
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490),  8, 4, 0x01);	// RG_PE1_H_PLL_IC                 
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4ac), 16, 3, 0x00);	// RG_PE1_H_PLL_BR                 
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490),  1, 3, 0x02);	// RG_PE1_PLL_DIVEN                
-	if(reg <= 5 && reg >= 3) { 	// 40MHz Xtal
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a0),  5, 1, 0x01);	// RG_PE1_LCDDS_CLK_PH_INV	//DDS clock inversion
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490), 22, 2, 0x02);	// RG_PE1_H_PLL_BC
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490), 18, 4, 0x06);	// RG_PE1_H_PLL_BP
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490), 12, 4, 0x02);	// RG_PE1_H_PLL_IR
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490),  8, 4, 0x01);	// RG_PE1_H_PLL_IC
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4ac), 16, 3, 0x00);	// RG_PE1_H_PLL_BR
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490),  1, 3, 0x02);	// RG_PE1_PLL_DIVEN
+	if(reg <= 5 && reg >= 3) {	// 40MHz Xtal
 		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x414),  6, 2, 0x01);	// rg_pe1_mstckdiv		//value of da_pe1_mstckdiv when force mode enable
-		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x414),  5, 1, 0x01);	// rg_pe1_frc_mstckdiv          //force mode enable of da_pe1_mstckdiv      
+		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x414),  5, 1, 0x01);	// rg_pe1_frc_mstckdiv	//force mode enable of da_pe1_mstckdiv
 	}
 	/* Enable PHY and disable force mode */
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x000),  5, 1, 0x01);	// rg_pe1_phy_en                   //Port 0 enable
-	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x000),  4, 1, 0x00);	// rg_pe1_frc_phy_en               //Force Port 0 disable control
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x000),  5, 1, 0x01);	// rg_pe1_phy_en	//Port 0 enable
+	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x000),  4, 1, 0x00);	// rg_pe1_frc_phy_en	//Force Port 0 disable control
 #endif
 }
 
@@ -500,15 +498,15 @@ void setup_cm_memory_region(struct resource *mem_resource)
 	resource_size_t mask;
 	if (mips_cps_numiocu(0)) {
 		/* FIXME: hardware doesn't accept mask values with 1s after
-		   0s (e.g. 0xffef), so it would be great to warn if that's
-		   about to happen */
+		 * 0s (e.g. 0xffef), so it would be great to warn if that's
+		 * about to happen */
 		mask = ~(mem_resource->end - mem_resource->start);
 
 		write_gcr_reg1_base(mem_resource->start);
 		write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
 		printk("PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
-		       (unsigned long long)read_gcr_reg1_base(),
-		       (unsigned long long)read_gcr_reg1_mask());
+			(unsigned long long)read_gcr_reg1_base(),
+			(unsigned long long)read_gcr_reg1_mask());
 	}
 }
 
@@ -583,7 +581,6 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	RALINK_PCIE_CLK_GEN |= 0x80000000;
 	mdelay(50);
 	RALINK_RSTCTRL = (RALINK_RSTCTRL & ~RALINK_PCIE_RST);
-	
 
 #if defined GPIO_PERST /* add GPIO control instead of PERST_N */  /*chhung*/
 	*(unsigned int *)(0xbe000620) |= 0x1<<19 | 0x1<<8 | 0x1<<7;		// set DATA
@@ -593,7 +590,6 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 #endif
 	mdelay(500);
 
-
 	mdelay(500);
 #if defined (CONFIG_PCIE_PORT0)
 	if(( RALINK_PCI0_STATUS & 0x1) == 0)
@@ -674,7 +670,7 @@ pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
 
 /*
 	ioport_resource.start = mt7621_res_pci_io1.start;
-  	ioport_resource.end = mt7621_res_pci_io1.end;
+	ioport_resource.end = mt7621_res_pci_io1.end;
 */
 
 	RALINK_PCI_MEMBASE = 0xffffffff; //RALINK_PCI_MM_MAP_BASE;
@@ -708,7 +704,6 @@ pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
 	}
 #endif
 
-
 	switch(pcie_link_status) {
 	case 7:
 		read_config(0, 2, 0, 0x4, &val);


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
