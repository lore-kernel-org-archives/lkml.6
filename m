Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3667791-1525410089-2-1408841461981882596
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525410089; b=RFyusIPkHtNyhKcQXfwRgzeXfKOansz4zYrgpEIEvznLgSTxim
    0NrO10IvP+HW4yFo66GECixwq3hCgnA9TW+czBtbyNenRIf+uLy5ju3FHbK6gOg9
    p0rzUCxDMFd9Iyls7f+1c8fQF2eXpzIHay5CXm/9RY7B/Axjiim2Qy5r9bdZ5Uoo
    Krf/94AY38lyCllai+ia/FHdl0FfmM5ivd42J486Hy/cD+LeMctm2vpmMzAtf1E2
    UftQynMT2T66ocWs+DJMXOSobF1ZmpcC9xuEB72GAs2CMS9lEtmac0UIgQePcU4n
    /6njoW7YD39f2Jx85s1FU1UgFk5BfP6hN3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525410089; bh=IA14e
    O0a+h2+87mthKigmdcgMCcP4uPUm6WqRlvgNic=; b=DzXxYLNyO/+XsYJWDIyK5
    L7u32nNd7pIaOcWslWa9BzS/J9TyG+FPKz/WpTuyimbhBR7S6NG1AdSV45XTfDq1
    B3vMbuZyF5YodwoNrwqxmQCtLeRtmGUk4gUWKNevdOlvkYdB88+e08tQyZ4dJ3jb
    ocBJPMQPb4IVrRjyroMN2eMU4X7fayvugRGay2gOYLeIp5WpO8pCdxg5KQPDkLhU
    wOgWBmmyC0/aM6GfE+beXbALj5F16lHPJVD0N4JxtB8aMmawExfBuL8s0TQ4BdW6
    /y0H2g6kRA73uWPvRnlCmT5m/JDG4BMZIqeOCwOVwTrxbJcB2uEyToobbqYsWLS0
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfPuGiitWhz+2Fj+Xw2/e5MRq1sIt4oRmnifE4KeSIw5HCutlS+AzDHhbByGa995ux9Tk2vPPVs2NIemKK5Pg8zuTU0zE1UgGjGgN8jxBNu/uT5V4hz/i
    BaGBwn8nxI8QfHaIgEe5rB4MaPjyixsn/pEOsJTIKqxgbJtYj8O+c/j6EdAefy8Rd+MczKx8yJchznTJ+LG6+UJShxplCJ0X5DDR7crMZC6f0zC3IcZV37Y3
    Fftf6MoL2/HNQtW0H6ki+A==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10
    a=VUJBJC2UJ8kA:10 a=qEKT6kP3PEYA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ZZnuYtJkoWoA:10 a=DDOyTI_5AAAA:8 a=flgAyN5zoFFWhOLXUhkA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 04 May 2018 14:58:36 +1000
Subject: [PATCH 6/8] staging: mt7621-pci: remove unnecessary resource details.
Message-ID: <152540991626.12190.2556491761847659514.stgit@noble>
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

These resources are extracted from devicetree, so they aren't
needed here.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/staging/mt7621-pci/pci-mt7621.c |   19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 616960e01052..5094e90eaf69 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -302,27 +302,12 @@ struct pci_ops mt7621_pci_ops= {
 	.write		= pci_config_write,
 };
 
-static struct resource mt7621_res_pci_mem1 = {
-	.name		= "PCI MEM1",
-	.start		= RALINK_PCI_MM_MAP_BASE,
-	.end		= (u32)((RALINK_PCI_MM_MAP_BASE + (unsigned char *)0x0fffffff)),
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct resource mt7621_res_pci_io1 = {
-	.name		= "PCI I/O1",
-	.start		= RALINK_PCI_IO_MAP_BASE,
-	.end		= (u32)((RALINK_PCI_IO_MAP_BASE + (unsigned char *)0x0ffff)),
-	.flags		= IORESOURCE_IO,
-};
-
+static struct resource mt7621_res_pci_mem1;
+static struct resource mt7621_res_pci_io1;
 static struct pci_controller mt7621_controller = {
 	.pci_ops	= &mt7621_pci_ops,
 	.mem_resource	= &mt7621_res_pci_mem1,
 	.io_resource	= &mt7621_res_pci_io1,
-	.mem_offset	= 0x00000000UL,
-	.io_offset	= 0x00000000UL,
-	.io_map_base	= 0xa0000000,
 };
 
 static void


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
