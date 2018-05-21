Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrMYNFEDvuHroU2xqqs9No0B4CVeCjMhTsDOpyu/5rRhZKAGnPHys0WTlETEpnaysfEV/uS
ARC-Seal: i=1; a=rsa-sha256; t=1526937784; cv=none;
        d=google.com; s=arc-20160816;
        b=Cd6SruEUQhRpVC6n8k7U4IELKTzv5ks157SGTs0VTBqm5qX4p5HPSIyadrSeGLdYi/
         sioQ7LetXYM8aADUX8HevkDNRFUXmq/K3rZHqxWtcN5hOZkcf571Kb+pF3QUda5zllSG
         moy7Xyr6dq+fHC6sUGtw3IKu936Ix69tnL3Nzgc1u/iASegpeJcjJO5b2XZlUJ8F81Qb
         iHKXcUAUO6Q9AQ6IflLaaGOK7fsYv3wdx8aBtdte2RY++eLSCsYOprziaShtzcTZrrJ3
         HkePNN2a86xVv6hUPGSen3WeM8kCd1AALZ1huLNU/P8T8ulRcNKS/1ybn+YfM5sJ8fWZ
         Iubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=coJBfaVCbKzDQ0BWK6T8cByStiL7hkbuBOg0T+75NoI=;
        b=lqTiugjp2l23H5raS/p+u77P3ZbFTRxX8zm8l4/BRxYPvFAndX6Iczfo5ZcY47ZeRy
         0Jn0yH/MZngpg8dWC6jTZGLgezotu9eFZTs6sMCdS7IlHcEVOmx45nUcM8r/N7J2EkRT
         ZXArlgs9zD7jKuPUhqhI+dKA4I+BIudyZfGoRrfsORN8nQKPhJTJVdC0shvaD6497EYS
         jImOMSSTFdWa4qMZIc9p+2y3EVl7RS729HwBB+PRKCjGSbsf3nZU8AqxbWJfjrgJB/Cw
         joGLhNUNd6nN/+llH5EpxEF24maSjPAgVQGZQYPsds5KP7MFR80gNJggpMKyftAFXshG
         m6Tg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mkaLKv2o;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mkaLKv2o;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gabriel Craciunescu <nix.or.die@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.16 024/110] x86/amd_nb: Add support for Raven Ridge CPUs
Date: Mon, 21 May 2018 23:11:21 +0200
Message-Id: <20180521210506.000026717@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110314179713251?=
X-GMAIL-MSGID: =?utf-8?q?1601110314179713251?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit f9bc6b2dd9cf025f827f471769e1d88b527bfb91 upstream.

Add Raven Ridge root bridge and data fabric PCI IDs.
This is required for amd_pci_dev_to_node_id() and amd_smn_read().

Cc: stable@vger.kernel.org # v4.16+
Tested-by: Gabriel Craciunescu <nix.or.die@gmail.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/amd_nb.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -14,8 +14,11 @@
 #include <asm/amd_nb.h>
 
 #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
+#define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
 #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
+#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
+#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 
 /* Protect the PCI config register pairs used for SMN and DF indirect access. */
 static DEFINE_MUTEX(smn_mutex);
@@ -24,6 +27,7 @@ static u32 *flush_words;
 
 static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
 	{}
 };
 
@@ -39,6 +43,7 @@ const struct pci_device_id amd_nb_misc_i
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
 	{}
 };
@@ -51,6 +56,7 @@ static const struct pci_device_id amd_nb
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_NB_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{}
 };
