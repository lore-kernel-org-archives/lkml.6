Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224XDEjt3vQSm28nJTNdXJp56FmDfc2JcZ0+iASg+4N0cc0dDV0HvL/EVD5vlm05+fRBo0u5
ARC-Seal: i=1; a=rsa-sha256; t=1518707937; cv=none;
        d=google.com; s=arc-20160816;
        b=I+caeWqISIuIo2V5Zsox9ZrUjC+w9DCpmGIvQ9QqFEgCnXabYxRX4KjW7jPrIRQYEy
         OTgoNYAASd6WvDqvMYMKfgExnDiwdPO1smtSQSx3OHMgApdclnOn/7Kxy6UvF7SfU4bO
         BK32aGHKiq/qFfLQF5rWF5I2zv8WmOOE6LwA1hUhRlTsjkx7t+28OqpgnbGcfinWj/T6
         jgnKHvyVOOhm7zt3fmeHF9HGThPZKVhOj0XtAvKvdv628rMVS9CqPYECOKp7Jo4ds1zB
         G+uZUwcSqYp6/Hg6eKrmbAbJExoyMdGVcw/BIAx8AtgljM5cMIofXah/ELrvKWQn6gZu
         AWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CXIqNjaERiJQ9ibAqgy0AvncY6cAumVnlDB/rScTAlc=;
        b=ngzX5EYdA8qBlbKKR7qgQMDwUL3XPUP2bmVE5A6oEJYDcx5asD03AGHZ3qBBs9xoiW
         LGeLn0S7GAGnNJKkPg0PKaNwRMUFMwXvSkhtkItASoDqduc2ndG8KL2A46fja1yMdeeo
         SvQJw8SjSoBuwZpy4pUHs/lJAi/iWrFhST09pUNb3Y+/GbtFt4m/KUP4uoN5S9ALF7rk
         /IQGeNOa6qXlMGO4Qv+uSFMgd6GfuXVaKet0jzkZKlo2vYSspOsFOZgSk6KIm+mHvIr6
         JHUMtThXv+rJS8MEDZbTADNa9gAAJz2mi7ZIIMEdPRanuztfFSE0/MCmQhJpMN++uWrr
         Rdjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
	Kukjin Kim <kgene@kernel.org>,
	Guillaume Tucker <guillaume.tucker@collabora.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3.18 07/45] ARM: exynos_defconfig: Enable options to mount a rootfs via NFS
Date: Thu, 15 Feb 2018 16:16:58 +0100
Message-Id: <20180215144117.417228594@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480694306480970?=
X-GMAIL-MSGID: =?utf-8?q?1592480694306480970?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

commit 19f79ccf6d77409cd138bce8db206cdac7fd5ea7 upstream.

This patch enables the options to mount a rootfs over NFS and also
support for automatic configuration of IP addresses during boot as
needed by NFS.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Kukjin Kim <kgene@kernel.org>
Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/configs/exynos_defconfig |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -33,6 +33,10 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_NET_KEY=y
 CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
 CONFIG_RFKILL_REGULATOR=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
@@ -170,6 +174,8 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_CRAMFS=y
 CONFIG_ROMFS_FS=y
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
