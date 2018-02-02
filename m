Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227GEhUTecHO9ql7qoA5ddVvAshshoMSL1MxUn1/55zjJw1juWvH+OTESFocsC0NLTHWl2gj
ARC-Seal: i=1; a=rsa-sha256; t=1517591281; cv=none;
        d=google.com; s=arc-20160816;
        b=eDYt4tRxKnjiIHSDBxLxHKRsoaa4y4jVBdTHI68/ngBvCgT2XErdaftinkMxvKJniJ
         9olxaCCum8yVm6zks/W2ZTXma0d1wvHdFvApVi27xn9OsHQb97G+fHRsV0m2uKksJPOX
         Oy9lSQKem2SHRohAVUF76YumDkRb1Gy5qUB9GXtm4IBw6PIESgi7kPmJOWjTkNZ0Is1H
         raEf+jozC09M0LhlAG3AJjXeEyT9BFbw2woa7q41zEy3E64JXD2IPblCPqY4IdjunXqo
         CscsdeZ+uFtZBWDUN9tXEPSraRjFjg2G+3ZD8Y8Vira+kd997q7dCjkAJYTUHLzeCJ+O
         AXBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nDLdhFcEIM7HuvZA4vWUYm+gwMC72buvyaA6eDGEM9c=;
        b=dOy5yebNZNQyN04xnTTXyo0lD7LIPWsZvQwkKEscI+JI+Iv657oE5n83vT3Hkft8wL
         1lK5iPaF/9w1RHgzBbdgrry6+SZxxfFyspxI81sR4q4cRqoEgfTpADzSiW7y72QKlwgY
         qeDRZnc/wip9Z98zFDJdSPyZYw78BUN4SYJP3StIocs6D1pxlF1jhRmCn9aW6Kcxxpe6
         MT8kmBtb3v9moeLV5cfQLs1TOnudtgxDjr6voosyWuehV20KRG0SCbjkL8pXrg8/PiiI
         AebCoDwaSBhykxJ1lA857Q7jVmhcal1M3z66W0MNd6A5ofBH03yivtU4zt2bFKdB39is
         bETQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jesse Chan <jc@linux.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 4.14 025/156] mtd: nand: denali_pci: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Fri,  2 Feb 2018 17:56:46 +0100
Message-Id: <20180202140841.447677293@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309293811887541?=
X-GMAIL-MSGID: =?utf-8?q?1591309795617886319?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit d822401d1c6898a4a4ee03977b78b8cec402e88a upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/mtd/nand/denali_pci.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/denali_pci.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/mtd/nand/denali_pci.c
+++ b/drivers/mtd/nand/denali_pci.c
@@ -124,3 +124,7 @@ static struct pci_driver denali_pci_driv
 };
 
 module_pci_driver(denali_pci_driver);
+
+MODULE_DESCRIPTION("PCI driver for Denali NAND controller");
+MODULE_AUTHOR("Intel Corporation and its suppliers");
+MODULE_LICENSE("GPL v2");
