Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELugaO9w0ni4Qp+pBVaFqrWW+FAcpighmRoSUzBR5WVLBT0RJdcWo8ch9TcuN+G8Fvx7XaYb
ARC-Seal: i=1; a=rsa-sha256; t=1519411317; cv=none;
        d=google.com; s=arc-20160816;
        b=fciYCfDpUdWJuer7+PfKMPq/a4FDfr2m8Ql9MjZQFl/hoAdpuaNNCLzn8cIkPloVkj
         AF/PrYrjSV03eSrXWAUnkyU3HOldAkcZqS9al5heoU5RbeDmukSof+5lNz9nI5W+m9cP
         ra2Gj9xl7kES3fBBrw0e4KfB46/Rcd0fBnQWv5iFnmBHER/xCGbO1/xSf6EP345c4nRA
         PR0cettXwr6yotkSIP6V5aC5wjdr1JAyHpSSO1kn/RfIdY4eTA7DwwLUA9do18DgMnFA
         QmLgP7+kdvA+ThQvL7W6B5n/M4rSVnVRnvpUqvWtTUxpKa844GyYUoY6WYVPES4L7RCW
         /dBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=umWiwgfzD3BUC9HMc96fUbtnjP2OhdYrW9rGMTye+So=;
        b=jhqULYG+TfzIli/x06hn6zFLNOY7G3BMLgHwL+7+CjjimDX+H/KqmiHa3yrfERpCfX
         b1fWXGtJ/EyhsWAps2rvDS71Wx35nTKPNMeQc4voLH5nR45IySEVhA0EWYGhVY6QWJ+P
         VRMWNrhfEj8u4w7JVRBRvzA2OCg8ewI4sA7sFivuhYKJ2YhuNZpznC0/6wyfz+YkttXB
         dasUF6PhkDS/dp+lOFmGE20/UeGofz2upRKZnTawjafSVTSLjM1LUIXicEhqlgMFC9jj
         inehIqCao+QfLpXRJLb1thMY6u9LVGqgmpntSEXJW/7jM/nKCpNVPrLv0wPvmb1vpTSt
         eviA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Darren Hart <dvhart@linux.intel.com>
Subject: [PATCH 4.4 159/193] dell-wmi, dell-laptop: depends DMI
Date: Fri, 23 Feb 2018 19:26:32 +0100
Message-Id: <20180223170350.842671168@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218241717203994?=
X-GMAIL-MSGID: =?utf-8?q?1593218241717203994?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit a570af4850043260b87fb1b8aa27a4484e648878 upstream.

dell-wmi and dell-laptop will compile but won't work right if DMI
isn't selected.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Pali Rohár <pali.rohar@gmail.com>
[arnd: Use depends instead of selects to avoid recursive dependencies]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Darren Hart <dvhart@linux.intel.com>
[arnd: rebase to 4.4-stable]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -95,6 +95,7 @@ config DELL_LAPTOP
 	tristate "Dell Laptop Extras"
 	depends on X86
 	depends on DCDBAS
+	depends on DMI
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	depends on RFKILL || RFKILL = n
@@ -110,6 +111,7 @@ config DELL_LAPTOP
 config DELL_WMI
 	tristate "Dell WMI extras"
 	depends on ACPI_WMI
+	depends on DMI
 	depends on INPUT
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	select INPUT_SPARSEKMAP
