Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224hUzgmjFEsTx0xvEmEV2pBQpUEkupzb8do+QHT4MRNfMxYt0hm2naYB6DeXL8SZo8qZ+uI
ARC-Seal: i=1; a=rsa-sha256; t=1518707940; cv=none;
        d=google.com; s=arc-20160816;
        b=jzNKEqz2EL+CovarJDCzPLTwEJfiaDgJ0FhhG50PSrmtYeRJVgOeodCCMBAZvli3ec
         VhOvU6ZFfCgfC0Hzu1lYp5CML/eNlNr5sB6WMnl4FPW5UM+bN/IiZFHnTw/P8G4YmoJJ
         pSW+JRAFqj0Pr617pWMsXxbcokxj3TlmqPv17lw0M62FEVvCYzwimhIlDcYM4uqAdfQ8
         qRzUkuHeyd77eudVH4eynmlCgz1qg+i+QR+gszgd52kqtTLKzXuwZoZLypnOhonYxUNx
         YzRI4Lvifui2N/GTtbzYc4oAmUQMC0/mPIcHeL5eAbR8nXigNCGk6Y81tlYkMSG3G0hY
         W67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=a336PNi7Ep9FUJQP9/thQ971vudN0+E3dyGcUHfMkJY=;
        b=QS/PUjWClSnkTBxLLqfhL3gupY7YrRXhxtScNp5TViHYlLFSxca99S6hyuEQg3cMmG
         swFWOVSMStsV8GPKecBGLffnNfX8nXJgIp4ZIPH/VP8w5ti2QnxeMr3A63+LEUGfq1y3
         t/qFy7eJgHIE5gmobtRBL+ydbY3p/Mnk8YoxviiCuGaFC79YulcJnKTHNYPRB4DOtXzp
         R4KgUGJ6mdlrqC/Nyo/25prSV2dj+OhXC9klC0aXsnGHDxgOFxyY2gnd85G5RkKUOG6z
         TO3VHHnviireJdHVOji1tsIfqm1aanEhlrwJl38OfGLlZ2eMKxsC3Wi7y4NCa/n8dzEC
         k/tQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Guillaume Tucker <guillaume.tucker@collabora.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3.18 08/45] ARM: exynos_defconfig: Enable NFSv4 client
Date: Thu, 15 Feb 2018 16:16:59 +0100
Message-Id: <20180215144117.650848341@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480697084227495?=
X-GMAIL-MSGID: =?utf-8?q?1592480697084227495?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

commit 1c1fb9b0c89a2506e556114c813a606bc1508d49 upstream.

NFS client is already enabled (NFS_FS) and by default it enables clients
for version 2 and 3. Enable explicitly the version 4 client to utilize
the newer protocol.

The NFS client is especially useful for testing kernel in automated
environments (network boot with network file system).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/configs/exynos_defconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -175,6 +175,7 @@ CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_CRAMFS=y
 CONFIG_ROMFS_FS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
