Return-Path: <j.neuschaefer@gmx.net>
X-Google-Smtp-Source: AB8JxZp/mZNfx28AlW4ibNmCHAELWytAKNjqbOrIWzFuzo3rCZwnAZ33SV/0eXqk5/iqEsu2wrpx
ARC-Seal: i=1; a=rsa-sha256; t=1525702860; cv=none;
        d=google.com; s=arc-20160816;
        b=v8QD/8TWDLZ8wgNESHDhYQY6p/zQ2jE6UXedYHhGsR87eiPuBjgoO8xw/UPFuGUwO7
         e14bwD+knG+OigwNaSoc7v4t5eipqpwRWwe57U08abYtFTVf3/FYJA8K3my8YysIiw87
         3B+CiPwZLrqO5g61TmW0GwCwyZLUZdSIfQIjjbAtMn0dkwo595IS8EDj6eGT9oGKhAdq
         ZaZbxFeC0bPIzl6PnLCe6YgluFcq4SZAEigzF+k746qbJvLmDD5h2xTBNyRgYMrTEhZF
         9jGbdEYGGDAoK2/v1vhAECnpD3xclp3A43e/Xg6rLdTl+eby+CdUUKTZC1/87oJN8Ica
         K/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=m9/yX/A6QzwgktVbA0N0ZE9LfIS+31NtcC3Bb3+QjaA=;
        b=ejanBsD4TkWw7WUp/GSX0dwBK6HA6RS+GKPjVKzksWt+CCQqvsTyicysB7Zw9YXgs4
         31o7CUNDOvW6ZOl+JadzFr5QQ3WjS6wRos6CSY0ZqnW4jVjnIpl/30GkjJBlT9BgQ0G3
         dY7YjS7jRixZvWieet5+4YC+86VwOGIKSdx43lAxZoBrCzTdOtRsAZdiL0W9qFaIkSpl
         40He6bhDBFsywRq4smQYLEo7zOnZ+NZq00Tv/cZnVIjYXygxC7/eC7JR8ma7z2ebhQw5
         0p0InGAApwZ9N4WZCsM8pXmvN376yr1xJMq6HBL6IZariDqYodBlZUjuil7GeGgCFH+7
         2o1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.17.21 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.17.21 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Benjamin Gilbert <benjamin.gilbert@coreos.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] powerpc: wii_defconfig: Disable Ethernet driver support code
Date: Mon,  7 May 2018 16:20:16 +0200
Message-Id: <20180507142019.32669-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180507142019.32669-1-j.neuschaefer@gmx.net>
References: <20180507142019.32669-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hoqHEiE9z55io5mWgVsRbIeENhVm1Lnyg4GyY/xbaPBrWGk9VUb
 uI989b/m4GUvkt2qLPp8ZeDhV4sLkhtkZAQKhW/vC/ZzzulcGdAXChW0r2b13+HKYi0qwR8
 2NXgeQUo+obiGHowwTYZvnnN84Vd38CRdEdsj/ZBKC4Ch3jBymF6w/u65+q+cbLDADgei0u
 uu3JJrtLd4qoaAuySTHmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HNOAEqv+6oA=:R1LPhBfnY89sTDYJWatTdl
 IT/yG+wXL61YVEjIaplazL4E1jZf3Vus84XMKgxyhq6PayYzJRKu+KgCqsJX1Du6G6/XxfKRv
 U1yPA3K/ZhD6ePNLjgoeZidbdioZRcGN4sVN/gnBCBr4OxHFm+C8WAF0LGRnpmz/lbm0c2VhZ
 JtPWB8q9ztR2luA7dZCkrrgvaSS5FTsWwtJWTLQQdxAMOOAiAryeoRGigH9WEe0foJ8M7jH4v
 9v6r2UtQ3I5b5jM28rLkJIqNF83Ock+mw7UqRCTSpSe9T9+BBAuyKBUg+yml7mbli6JlpSwLa
 nvEqxpc3etS7hfMkQF3NV/5AuLCFVT3ItOSMQxNmB0Ixt03a9NXmDa8I9zR3KnYNyREYh9S5H
 KKN6vihotvbNT+AGERDFMBFSHCriC4EzByouoHv9M9YkcanGdU1L5kt27pu67sc24g/1FyERu
 hFqUzms0yXJuUiz7BI2rNajaaEaxIItf19aUF7Hg2RU/AVNxhTnXWK8f5c42WFLGaG7Joe35p
 Lm4S9Jc82S13Jq6x45ycl6bfa6oODCHfe0mY/kbgSgWa5NB3S3CizHFHeCeAiqewTU5SEZYgc
 jFhIj61IZ+S4m8yG0cYERjAApBiGeyWj8NEgV5o6C16cnjwSzp4K/+WGYHmvgugCYvgxF8WpL
 YJLkI17lYUkFxTEnukx74PlCgzjcpsrFYBVQ/7X8cM27pIoXpNbyDMMQWRmBgUxQ244++U4fd
 SIfyIHljrxJBm9SywyU9kHDqATZO2pCMUWyyiRKvT8dm3254EKG6gtH/GdnFEfezYRJVQKn9V
 +B8Ksn/
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599815401906137196?=
X-GMAIL-MSGID: =?utf-8?q?1599815401906137196?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Wii doesn't have built-in Ethernet and USB Ethernet adapters are in
a different menu. Disable CONFIG_ETHERNET to save some space in support
code for Ethernet drivers.

Note that this patch doesn't disable any Ethernet drivers, because they
are not enabled by default.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
v2:
- Drop the bloat-o-meter output from the commit message
---
 arch/powerpc/configs/wii_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index 0b0f78823a1b..3167b9d7f3e5 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -49,6 +49,7 @@ CONFIG_BLK_DEV_RAM_COUNT=2
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
+# CONFIG_ETHERNET is not set
 CONFIG_B43=y
 CONFIG_B43_SDIO=y
 # CONFIG_B43_PHY_LP is not set
-- 
2.17.0
