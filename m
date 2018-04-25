Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/oj+T6OMJ6KoFEqD4Os57Q22rG81nMtjC+BWjftmXZOHbx3zGwcZ8t2UhHMXXxC5ishDnh
ARC-Seal: i=1; a=rsa-sha256; t=1524652785; cv=none;
        d=google.com; s=arc-20160816;
        b=rj9jZJpCIfG7LdadRrV7NC/o6ztrfclvaED9QDoy440l8Gg9l2vZ723ETfxMOUThyM
         p9LA/tXctKczj0UT0wyWGenXYwl/O3nqUbOAwsKPskNHYd1PzGltff73916ojrImJ74L
         YMiueHSLEfL56Kv5QVL40spdGfaDiX9j01ZZ4OPwI9XdClMAVIRQtRCYBpGUEd1We93G
         zSJHqrHLvWV5AwEyO7XzTJ49A+ZJMizoCBCsLiCoKodheix/+Lm2tVGHe6YJZddB3pM1
         8pWrizF78kKY5tFtCZJ3HBUVO8pY+elMA0nEivMofXOJdfR/Whu3N7sjGjHLbc2zztaC
         JYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4RaL809pqBEMRFRPdBhoqZRblWN6q/SMpHoEHWLlPPw=;
        b=Q6Nu63uguqIMy577n/IiCots4CMgUfZvPidu5DaEHmo2UysGO7/CAbrx9nOtEbf+/1
         8ClRF3g6Qv0q9X4TUxHYnETCa+qWkiDQQNeQE8r9RtHxNbqeoJEfvGWSNV09NPESj54a
         7AatFwNSdyOMsZfSt/phh6Bin3ukgOObsMsGMRVJPYJd5Ms1bX7bLAisk61ONgQ8cCg/
         +czj8YWJQ/tpRGSufQ28WbEn2LSfJ7Q8m6Lva3F9GQKc0e03LU9pEYrAfx5My94A1lPv
         eXds7tOF7ao7appAFWWZTMswamUjRADHOMtq0bb6VAknMCfMYIP/of/NNNl+aSqauKXB
         b4RQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Binarus <lists@binarus.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 031/183] PCI: Add function 1 DMA alias quirk for Marvell 9128
Date: Wed, 25 Apr 2018 12:34:11 +0200
Message-Id: <20180425103243.834569835@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714318861675778?=
X-GMAIL-MSGID: =?utf-8?q?1598714318861675778?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Williamson <alex.williamson@redhat.com>


[ Upstream commit aa008206634363ef800fbd5f0262016c9ff81dea ]

The Marvell 9128 is the original device generating bug 42679, from which
many other Marvell DMA alias quirks have been sourced, but we didn't have
positive confirmation of the fix on 9128 until now.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=42679
Link: https://www.spinics.net/lists/kvm/msg161459.html
Reported-by: Binarus <lists@binarus.de>
Tested-by: Binarus <lists@binarus.de>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/quirks.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3879,6 +3879,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_M
 			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9123,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9128,
+			 quirk_dma_func1_alias);
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c14 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9130,
 			 quirk_dma_func1_alias);
