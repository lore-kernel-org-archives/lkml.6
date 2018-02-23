Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227kOlw5Cx/yiJf4HeJqoJ4MI0zttEAkQjUliRDw49y8CFwDwo/XE8gJCSA+zBmD9Qx0AHbq
ARC-Seal: i=1; a=rsa-sha256; t=1519412270; cv=none;
        d=google.com; s=arc-20160816;
        b=xzdELbHhDqY3B8y+Z1r8g6uoxXPEOCxB0D94lFZxvOcLjH6Oe9F7lasHgGq+hgTRNC
         CsZd/bh5s37SkfyaUn04NvDUMQ4Zdwjj0w8ruSGD0VNX8tHedBNR8HD6rZribdw3EQuI
         AlGnwDZUclmyGCGT5dGHp7uPw6O9F868gUOztLejsKykEKm7QpaOFbgTyKX74s6NvLgE
         HYrJnVUgZ8c5NMAAH86sh7aCQ8OZJRPx9e4DWtju8rt7+TcpHKT1Ttd06vRZtqUUMlJ9
         0ngtQGy35PblfLFltXWudv8XrBvEnfemTbbZpuiJ6KlqdrYfbSuXektZz0l+LNdJeqNj
         ohIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aV3J4r/ME+Wr5NOLObNrLn+Y825aPYrJSFuua1jAcok=;
        b=v8haCMRXnx8NVWNTGL0Exsg0+de7vQJm6yPymMsuDCTH7IwqzZwkHSPYMoGpzn95NG
         9fPJ5MI6EuLVDLFeAmotT2sC7LW4hg+vZZpJVbwktS5lltFuXIo7N054Knu80AcEuhuW
         TKKT8Kow4MWFDI3vQltERkoiqZIBdsHpk44kHYz4sb3NjCV+rShFI3i3eUpXXzZou+PS
         1gyGjXDZhtas91RY4l093IzI1etRVFfdP6M0/sZiJNzunBeNPZBW40mTggtTfafoq5MZ
         dE0ETwMDdZqi4QEJ/nw+PYcHFXDBg8O84XwBxE36HTw7KcLvw6YniXJw9ZHKwPmiU22y
         qQOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jesse Chan <jc@linux.com>,
	Andy Gross <andy.gross@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.15 23/45] soc: qcom: rmtfs_mem: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Fri, 23 Feb 2018 19:29:02 +0100
Message-Id: <20180223170718.919513898@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219241022737824?=
X-GMAIL-MSGID: =?utf-8?q?1593219241022737824?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit 3b229bdb54cc83061b4b7840e3532316cb1ac7ce upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/soc/qcom/rmtfs_mem.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soc/qcom/rmtfs_mem.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -267,3 +267,7 @@ static void qcom_rmtfs_mem_exit(void)
 	unregister_chrdev_region(qcom_rmtfs_mem_major, QCOM_RMTFS_MEM_DEV_MAX);
 }
 module_exit(qcom_rmtfs_mem_exit);
+
+MODULE_AUTHOR("Linaro Ltd");
+MODULE_DESCRIPTION("Qualcomm Remote Filesystem memory driver");
+MODULE_LICENSE("GPL v2");
