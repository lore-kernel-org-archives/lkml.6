Return-Path: <arvindprasanna@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519834496; cv=none;
        d=google.com; s=arc-20160816;
        b=sDORH/9pW0RFoiM1XIa3awK/E+TYweHkKaw4hWKl3b309j5577jAB7xluiaLV3Ucxo
         /w6+kD8hY8rbgXyLqvayuLn+K4tDG1i+8qF3Y/UAbT/l3S/a0KKovDjRbaexRxzy/U7T
         ob5atUyRcw7i3GuFsqXySnVCHS7xGfZQIiKr7GjBMLcO90PK06UU5MWi/YypDX52yOEg
         Dk21ARfSu/rU2qwkomojjUta5JDA/CsDg00r/DduHbuVmfP1oA0NIFfi6NxJksFCuVmj
         JIooxzNWXy5e+fF3cdTNJh9uHLLvUEKcjRxpQvcFCm4zzWdtszuGMfVOBqwt6g0if7Tn
         P8jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=dgvS9OJRG6dxvgl4eqDdcJLvjuzXmJXF+my9OtHh7nY=;
        b=yn9LtC7K/P+JMiFYK3eCGhRd6uhC0oSF7+6E+tAAp9XF4b/V0vNP8h2VLlId9mJh1F
         QBhT6YsLyO1akKjoTpxhXulaNrwzXlONN6ry9r5ZXNBuZHXRnw1anS1AR9s/pivC1Y6c
         Ah2U/ARHHR8/QPAoHp3Q2UADM1KeLediOv097R3qfm/jHKYMM2i6BiHUBlxV261wYEcM
         XXK3mU3IPowVgkExM0dON/dvtUNCswQU9IF3imvPCO1g26mU9hmR/vjf6f3ESyovFcOf
         JZZpFmjdyPnoiA3zrEtJ42aSejka86+cjoZ6lg5GvSbdYD9Yl3AubQnzz2+4ej/lExal
         ryYw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O8pDCQJb;
       spf=pass (google.com: domain of arvindprasanna@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvindprasanna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O8pDCQJb;
       spf=pass (google.com: domain of arvindprasanna@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvindprasanna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuTsL2fbANdsocOrHaBLLxEj95dHt09nep7BuyIzbAuMGGh2uNq+iZj8nkAxu45qNnJeka5iQ==
From: Arvind Prasanna <arvindprasanna@gmail.com>
To: 
Cc: yamada.masahiro@socionext.com,
	Arvind Prasanna <arvindprasanna@gmail.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Documentation: Update ncurses package names for menuconfig
Date: Wed, 28 Feb 2018 11:14:40 -0500
Message-Id: <1519834482-1756-1-git-send-email-arvindprasanna@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAK7LNATafNCOBMsNezrCT8j_N2kJiLt7S063wRtjGsaJTgxLvA@mail.gmail.com>
References: <CAK7LNATafNCOBMsNezrCT8j_N2kJiLt7S063wRtjGsaJTgxLvA@mail.gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593627124178304067?=
X-GMAIL-MSGID: =?utf-8?q?1593661976803176034?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The package name is ncurses-devel for Redhat based distros
and libncurses-devel for Debian based distros.

Signed-off-by: Arvind Prasanna <arvindprasanna@gmail.com>
---

Changes in v2:
- Add a missing echo as pointed out by one of the reviewers.

 scripts/kconfig/lxdialog/check-lxdialog.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/lxdialog/check-lxdialog.sh b/scripts/kconfig/lxdialog/check-lxdialog.sh
index a10bd9d..6c0bcd9 100755
--- a/scripts/kconfig/lxdialog/check-lxdialog.sh
+++ b/scripts/kconfig/lxdialog/check-lxdialog.sh
@@ -55,7 +55,8 @@ EOF
 	    echo " *** required header files."                            1>&2
 	    echo " *** 'make menuconfig' requires the ncurses libraries." 1>&2
 	    echo " *** "                                                  1>&2
-	    echo " *** Install ncurses (ncurses-devel) and try again."    1>&2
+	    echo " *** Install ncurses (ncurses-devel or libncurses-dev " 1>&2
+	    echo " *** depending on your distribution) and try again."    1>&2
 	    echo " *** "                                                  1>&2
 	    exit 1
 	fi
-- 
2.7.4
