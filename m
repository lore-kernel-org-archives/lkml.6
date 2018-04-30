Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZokxyrESj8elmyBpa23/CisBje6DFkiUF3ZqzrUrkNKoXJEhXtxZArCNT/Iqpad3t1FqEvO
ARC-Seal: i=1; a=rsa-sha256; t=1525116410; cv=none;
        d=google.com; s=arc-20160816;
        b=WE+wYFB7uHJY9rUvYqXueOfS7GPtyiYjUz7IbPRkGpYy4BXCz0dZj6KDeHEemE8iX1
         rlHS5YrpqPoOIC2tfIORCtoQDgjCpzOGWa/E64M2+OpS3H3hPL19PVzbzgSEk0EX/1Rm
         VbGZvM4lS+zyULv9W3YqwStMlvVuWSNqVwB0OklmGzLiMAxPn+6ti4o67cVeEIy1KWfL
         umDvg2kUpdmboyLX6q93246ioCjS002hIZVyCu4IDEnAioEUzWC1Ryd3vt0Ey1R8Ymtj
         i6LN2uRCDMMdKpRzfHxVZ+k6csgZf/s0zD6IHga4HDvwBZUFAy8a+jnJ8OYL6FTbRk9a
         EWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=YTS92WL8cGpoOYoSkgefdX29oamHMbC4jphuNa8r/3k=;
        b=bAY67oK/GWIcXMeMdup3l3JCP6QHo0KJF/+Q6Hjv+c+i6CM3QyoBDZ3aR7zxHBWgiV
         thsYgjHd7F90rLfE3CydcVRj17pJjQIrzY5qqa8/CO5lOXKdRPCAMwF79Ux6Vxauf9Ki
         aFCE5rOhEKDxFYnObQhpdyZ9i9K6s6gY/TVtMphUbUA0SRkVYu66YT+D6rayzJwnEXg1
         b7p5Wl7SSrsMdRzmCb8kf5YOOjGZj94T7PXb+zg4vMNKF+y1povN3euSp9QMcaIVY7dK
         xxc5T01wRv2Ppj2r8cdXkKHys466ltQ50KIbCwcratzp5ow9na+capSs5/n+HEvgyeeI
         5slQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3D822E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Evan Wang <xswang@marvell.com>,
	Victor Gu <xigu@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4.9 43/61] PCI: aardvark: Fix PCIe Max Read Request Size setting
Date: Mon, 30 Apr 2018 12:24:46 -0700
Message-Id: <20180430183955.000933042@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200572509818955?=
X-GMAIL-MSGID: =?utf-8?q?1599200465461232225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Evan Wang <xswang@marvell.com>

commit fc31c4e347c9dad50544d01d5ee98b22c7df88bb upstream.

There is an obvious typo issue in the definition of the PCIe maximum
read request size: a bit shift is directly used as a value, while it
should be used to shift the correct value.

Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Evan Wang <xswang@marvell.com>
Reviewed-by: Victor Gu <xigu@marvell.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
[Thomas: tweak commit log.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pci-aardvark.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -32,6 +32,7 @@
 #define     PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT	5
 #define     PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE		(0 << 11)
 #define     PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT	12
+#define     PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SZ		0x2
 #define PCIE_CORE_LINK_CTRL_STAT_REG				0xd0
 #define     PCIE_CORE_LINK_L0S_ENTRY				BIT(0)
 #define     PCIE_CORE_LINK_TRAINING				BIT(5)
@@ -296,7 +297,8 @@ static void advk_pcie_setup_hw(struct ad
 	reg = PCIE_CORE_DEV_CTRL_STATS_RELAX_ORDER_DISABLE |
 		(7 << PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT) |
 		PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE |
-		PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT;
+		(PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SZ <<
+		 PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT);
 	advk_writel(pcie, reg, PCIE_CORE_DEV_CTRL_STATS_REG);
 
 	/* Program PCIe Control 2 to disable strict ordering */
