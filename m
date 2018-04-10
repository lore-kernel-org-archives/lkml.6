Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49BYuDdvKGoTcct5FY/yz5wZvMHzLIVvugQJi4r4ucn8IzA8qYHi3uccxE1HHnLhrOIXzim
ARC-Seal: i=1; a=rsa-sha256; t=1523399060; cv=none;
        d=google.com; s=arc-20160816;
        b=s5Ms0ExhMpE74FdCeaOmZ2/IofOBDIfrMUdTzeK9fNQwjsWJg07Pn3Ep8ePqlllxra
         Kq0mzHlx22ZMp98QP+XkUeMRx4fvzPdk3exfhn+JSrTbFPA3yfsXY6iL64utaev3DFx/
         IMOYEqI/92dX7K8thcDsR8D4qEe02wEF8PKKPvtvMDhSLxo7AwEsDNyRzp+s2AQtq1rc
         2j/yh3mS4YzX9OYGywc9P/Xk3tCFURJClQ2VABEKfFUFNpZ9css/kzWg0jt8JkNN5b5l
         7WFIcOQzmedUsy7stxTA+Br3Subm9LEA9LUvEdik3OjTaiCloWhE0tkHbne6wK0FN9H5
         Nfgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zEQ8N40iIsno1tpxutKcVVkWocfTNsxhhPjdbaV+nNA=;
        b=tVJCuqV56oABsE61+sT1M2+E6Vdxj755rKv5VjoETkcvgLyXLXb+1sgWsn4BzPlOV9
         Gn7KY01uvhcvPMJE4KRP14sKGwzXfWiOAuOaVPInSuPd1VHd38So1U9vVhlu7NeKDhAT
         m1ohNE7Tb7obK2DBDA1yjfEVCPbLWeMNIncbn4NsPoQN0jNvHG2Vqw3qFpkbeZr/iPgZ
         U6zgj3XBo+IXSXkm3NpqsqS/8jJgo4qOUEOyRrrZTEzEHOBuKQxE9ZofZkaG4YSdZD1/
         DvftIoJiqeRMRfEcY62/Ki07ls5wPnxzOIVklU3WucIoke4mCPQjfoAF0craLt1YMN+n
         wErA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Guenter Roeck <linux@roeck-us.net>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 01/18] sparc64: Oracle DAX driver depends on SPARC64
Date: Wed, 11 Apr 2018 00:23:36 +0200
Message-Id: <20180410212758.638047196@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212758.564682823@linuxfoundation.org>
References: <20180410212758.564682823@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399692722941424?=
X-GMAIL-MSGID: =?utf-8?q?1597399692722941424?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit 9c548bb5823dfcf7a16c6e65976d84d9581208c9 upstream.

sparc:allmodconfig fails to build as follows.

ERROR: "mdesc_release" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "sun4v_hvapi_register" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "mdesc_get_property" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "mdesc_node_by_name" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "mdesc_grab" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "sun4v_ccb_info" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "sun4v_ccb_submit" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "sun4v_ccb_kill" [drivers/sbus/char/oradax.ko] undefined!

The symbols are only available with SPARC64 builds, thus the driver
depends on it.

Fixes: dd0273284c74 ("sparc64: Oracle DAX driver")
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/sbus/char/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/sbus/char/Kconfig
+++ b/drivers/sbus/char/Kconfig
@@ -72,7 +72,8 @@ config DISPLAY7SEG
 
 config ORACLE_DAX
 	tristate "Oracle Data Analytics Accelerator"
-	default m if SPARC64
+	depends on SPARC64
+	default m
 	help
 	 Driver for Oracle Data Analytics Accelerator, which is
 	 a coprocessor that performs database operations in hardware.
