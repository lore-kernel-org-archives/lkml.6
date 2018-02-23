Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227F6gRkvNrXjucIqWdHgYf15bTCESwETRAOh7DxYzIWUWcEglMdw7GKCkxzl79MiMF5Vns/
ARC-Seal: i=1; a=rsa-sha256; t=1519411034; cv=none;
        d=google.com; s=arc-20160816;
        b=qLWbHphR0UM37d8SFMK9vXPksAcYXHeXY6sAFJyDHYZjL5oTKwnuMRadfqgJox0iOx
         VqzkrkQgH5QmpWiOKi+QWYEguMqqT0P9uJQntcEmYI+633BGyd8+3ik5Y1kJS8HXIY0u
         RTSN6HuTGrDV6y46qdeBpWGHI/+Mu45+ZQiWthbuy4gMFFfwgYyCgktGbM7kSNmX2B1f
         bP/nAQ6EzeAXwqS1YAyb3BGwnnc4jlzfZ75FSnkyffPG9cs/FlPNCWI6aixgmVj4RyzH
         TgMhXTUSeOyT+0tkW3J9gU74g+SAKIyNrT1ChBN1c8EDvIJluvWVuP3u6+ujguhPudD4
         Drxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dWtrmDizR3ki1Ix2JZVmznhAcMdQNH6gXKT/uh5JT/g=;
        b=Y1oFsp/prk2iqTtwWsRJCjllzmfJDKv5YEjfH8jSdnzf0BBidA7NTRIn5KyGKa3aE3
         o9BPOk2Y3YbXIlZ6H1qWJY1i3aCZ+j6dZXDyUlMFf8HOb/couw06UurKQdZ4SuQ3N79o
         B67JxNXMe/rCiExjhTQJXsfoKFYgzTocQLaBAdItYpgvAyYmpIoJnIn4UR1RNstbedoA
         0LKaT9wg5JBoCI0GDLRZbkSWM4KAH1LKSr6MKROvPJnc8n3z1jC/eXn4NTe64RiVX69t
         mCmOFOxvaY8Bi1PNBicPlAaFhJkh8dZoBbsbwVLvi1P1VMK/oP2QqEDYL/yHX07If1DZ
         Vp0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.4 098/193] SCSI: initio: remove duplicate module device table
Date: Fri, 23 Feb 2018 19:25:31 +0100
Message-Id: <20180223170341.366407634@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217944727605893?=
X-GMAIL-MSGID: =?utf-8?q?1593217944727605893?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit d282e2b383e3f41a7758e8cbf3076091ef9d9447 upstream.

The initio driver has for many years had two copies of the
same module device table. One of them is also used for registering
the other driver, the other one is entirely useless after the
large scale cleanup that Alan Cox did back in 2007.

The compiler warns about this whenever the driver is built-in:

drivers/scsi/initio.c:131:29: warning: 'i91u_pci_devices' defined but not used [-Wunused-variable]

This removes the extraneous table and the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 72d39fea901 ("[SCSI] initio: Convert into a real Linux driver and update to modern style")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/initio.c |   16 ----------------
 1 file changed, 16 deletions(-)

--- a/drivers/scsi/initio.c
+++ b/drivers/scsi/initio.c
@@ -110,11 +110,6 @@
 #define i91u_MAXQUEUE		2
 #define i91u_REVID "Initio INI-9X00U/UW SCSI device driver; Revision: 1.04a"
 
-#define I950_DEVICE_ID	0x9500	/* Initio's inic-950 product ID   */
-#define I940_DEVICE_ID	0x9400	/* Initio's inic-940 product ID   */
-#define I935_DEVICE_ID	0x9401	/* Initio's inic-935 product ID   */
-#define I920_DEVICE_ID	0x0002	/* Initio's other product ID      */
-
 #ifdef DEBUG_i91u
 static unsigned int i91u_debug = DEBUG_DEFAULT;
 #endif
@@ -127,17 +122,6 @@ static int setup_debug = 0;
 
 static void i91uSCBPost(u8 * pHcb, u8 * pScb);
 
-/* PCI Devices supported by this driver */
-static struct pci_device_id i91u_pci_devices[] = {
-	{ PCI_VENDOR_ID_INIT,  I950_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_INIT,  I940_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_INIT,  I935_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_INIT,  I920_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_DOMEX, I920_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ }
-};
-MODULE_DEVICE_TABLE(pci, i91u_pci_devices);
-
 #define DEBUG_INTERRUPT 0
 #define DEBUG_QUEUE     0
 #define DEBUG_STATE     0
