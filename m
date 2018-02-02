Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225qH7PuzwA96EsPuP1wFBxeWTLili17Yd0m3weCcXFiLhoWeGpipDsFNmSpZF7LBGA+2Tkr
ARC-Seal: i=1; a=rsa-sha256; t=1517590802; cv=none;
        d=google.com; s=arc-20160816;
        b=vvH9Jr5ARqdYyV6d8L4793Sba5Sco9d0QhbMHvm/08ayd+QvNrSSNbEoQ000HwgNAQ
         13uNhcLgfGAlibTXwYzx/UG19w+6pw4fiSr09tSDKUiTCcTf6Nv+CqbN/5aG00FHr9nT
         o10uTgDBvcM4mRe9hI4Irhupt0POruJlv+HzdKgXOhjZET+v67Kxf4Aux0zFtDHIdV+4
         i9irc2Kgkwl/X5eGdM3pm5FZCflPHLx7UP+R64dfUOkaaMRteU+MTTCzqWUJ86SEDvTI
         N9I1JsmTIs8nYiynUWb4lg/q3fKxQCgklQxz+erR/dB4TUK2F+kdTD7rmyKv8tGQXHqJ
         TR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KA5JATH+jYKhDyUM/MfdLkQjacijLwFpog7WwRnLfZY=;
        b=wHi1jkp94+6D70lMjYlU2X6iE1By0Izt/io0cgFvPAi4QcrJ2y2thaTS1eE4o1Gs59
         R/vYoOrT9Q8twLH1JznbSk9HRiBlAYgSeViYiS3cNf0qGeP3fytVDsy6WS5cFbEuaOld
         w3Y4nHZ+/HvqnfyodKRgjxrUZUiFahtcCpHz7A4tKj+4ZJXLxZbd15jQwczrc86Y0l5K
         uzxpU4o8g6AzkZnIWyyAhVTiZbBFIfBFnKZy5qiL4Ig54vu1EcJ6I14uQCMbTf/O3qby
         jtsuetGrVflkEKUJvaNUfRZU/YmMchLYKthXD5FVNDrY3LM0cAdFUWLISUsOzcmciShC
         4eNg==
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
Subject: [PATCH 4.4 19/67] mtd: nand: denali_pci: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Fri,  2 Feb 2018 17:57:48 +0100
Message-Id: <20180202140817.396784160@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309293811887541?=
X-GMAIL-MSGID: =?utf-8?q?1591309293811887541?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -119,3 +119,7 @@ static struct pci_driver denali_pci_driv
 };
 
 module_pci_driver(denali_pci_driver);
+
+MODULE_DESCRIPTION("PCI driver for Denali NAND controller");
+MODULE_AUTHOR("Intel Corporation and its suppliers");
+MODULE_LICENSE("GPL v2");
