Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AG47ELsbrKKKC3awjUKPGVaRaxdcOW3nWwOVsu6dvt7KpAcnAZyhhdDJXMvctCcQMBkf1if5HopI
ARC-Seal: i=1; a=rsa-sha256; t=1521042222; cv=none;
        d=google.com; s=arc-20160816;
        b=aHU5+E13Qyie3Fh8TmTVa3lNbBMMeHhAmhEwMJyHA81QG8kdGKt01Lb9y8L1d4sktn
         nf6+TC1Co4V/22Zf3H1ewDdHHAjcElFGbUe2LSUIKfbLQiW22lHliHk/ppfMRa6kpBZc
         UEzUTwQsqAO2EeI8f4jPcxuDThqTQXOjtInrfAkLH3kJiYRY4aQl64ztL4XkiytIdLKY
         14yaEqyYbKricCrDcvcQCAz95YLKab3/faCrvzD+VGU3VtaGxxHRvZEG+E7eC1ftideV
         deVaBI5JDU9gNLRDIyLLtgikTFsVjm/FPUquqmgG1/Tc+MtnrlkgQDsQUVPRXfJ3EEdK
         ERUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=NJsg4/HA2RdJ5qczzs4XLQX5FCor31+ggFK4hGvBwdU=;
        b=MToyNwcUwU6spmKjLoYk0ZNqFsYfcZQk2zYBqoEowqcPZf8j6WtxQKknMsb1C3hezX
         wlNcve2KB8W7EEAZYqswX7U1rtzlMV4wBWg//8M+SFs6PPJUArWo/8XZI/fX7HZraVDk
         7jxKTEn/dTpjI78IXsomowPnDTYpWUr0MC4XfZj6ymZ2axUmrpHE1j5kzukwkVBDcpwf
         EMoFvIBlLvrvHgnXxKU9hFjXzR87fYcV+plvYzQCPoKotuGcxQn/PnxS42j3cq4Snqo6
         63xyJFJjJNaSQHctpnPnILdKo7j8vIGOUobMh1/m5WdF+Ti7jM+z4az4n3h62kRhvHwD
         15iw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.131 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.131 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Quentin Monnet <quentin.monnet@netronome.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Kicinski <jakub.kicinski@netronome.com>,
	Amir Levy <amir.jer.levy@intel.com>,
	Gerard Garcia <ggarcia@deic.uab.cat>,
	netdev@vger.kernel.org
Subject: [PATCH 05/47] net: remove cris etrax ethernet driver
Date: Wed, 14 Mar 2018 16:35:18 +0100
Message-Id: <20180314153603.3127932-6-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:9bJ1UXJThUnltjp0aNlUYhKdGGLSn9lva01LuQE4u44mcNZy25m
 f1lUKngBP+OWDJ3C3Q8coKf64Ey44qJWMa7D/FDZmXJX+tw2sE1TavY+d+Xu4k+MUXWT4XX
 wvY9KDv3cwKDhC5tz+r9IRZ+LAx2QK5QOZXT9UGFSelYV81MHCun8GMuAiAzyziRjHUATpj
 V+lQdneNox54Ild2qrxGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4EgH2CPWvGo=:gqlAFva14S+jB+iRjpwL+0
 vt8HPYaETjpzZD1HPwjXYX18s/aIjI4IwN0w3wGs4b8ugtkfiDSQgsPR6/C1TBGj0emc6D6Z+
 IvbdgkgY/QV+Lasr9cQG1Vjql0UvZZgJZy0b60TuXofwtcOyn6K8UM/ynjseMZLj6H19vIqsc
 khwno4kFPnDmWD5tR1GzpQwF21LYUQP0VojvC5EX5ZT0ZeRYcFTH8qaDc6lpEbB9QU2fZZCG5
 OCqdzqvtPpEF+bc1jfwGfAuz3HZF1Pbu3TNVXJNtxJTnH5gImgWSbXSNbYQGSRFbH2CWc2D1W
 O1U2vb8vAUVh9iw75J7Dql1dGq1R+3Ujk3ZXoh4LLpqJpbStQMQi9oEACpnXIj+f087OUHMYm
 UEhe1LByMI52OlmEjjxTAGT2hRzkgdxxyigS/o4LQkSTHhhIyY/OAnVfr1OosTc9nI9QRzCuP
 R7FA5noWmrPgf5/2TKNvbtWAbs7yfgZ9EuDEnEFPpMp9alHhriJ7DagAM4FQtZvDTx7LurJXe
 lr6TCPiC6wRb3UFG+0HgbRRCg6qbuPWFTf22y11RaXji9nMn7CpKa+ISl9sPzNDb+WLaLSmjj
 xNmxKtzXbCPc0IG5SsO2Vi1XeQIW02eMu1EtiVlmuvRsmlDKrLlKNYQFyPb4ooVfljg0v12Gj
 VMgac/8id5WiNZLfu/KbM8rePh5KM2un5rNoXZPXQRQQ5i2TuY3pbEOUu5np/ksFp+6jxkmTt
 n8twopmN084AdReTM2Uz6d/YCJZUYndlcXTl9Q==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594928369846121813?=
X-GMAIL-MSGID: =?utf-8?q?1594928369846121813?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The cris architecture is getting removed, so we don't need the
ethernet driver any more either.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/Makefile       |    1 -
 drivers/net/cris/Makefile  |    1 -
 drivers/net/cris/eth_v10.c | 1742 --------------------------------------------
 3 files changed, 1744 deletions(-)
 delete mode 100644 drivers/net/cris/Makefile
 delete mode 100644 drivers/net/cris/eth_v10.c

diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 04c3b747812c..91e67e375dd4 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -40,7 +40,6 @@ obj-$(CONFIG_ARCNET) += arcnet/
 obj-$(CONFIG_DEV_APPLETALK) += appletalk/
 obj-$(CONFIG_CAIF) += caif/
 obj-$(CONFIG_CAN) += can/
-obj-$(CONFIG_ETRAX_ETHERNET) += cris/
 obj-$(CONFIG_NET_DSA) += dsa/
 obj-$(CONFIG_ETHERNET) += ethernet/
 obj-$(CONFIG_FDDI) += fddi/
diff --git a/drivers/net/cris/Makefile b/drivers/net/cris/Makefile
deleted file mode 100644
index b4e8932227b6..000000000000
diff --git a/drivers/net/cris/eth_v10.c b/drivers/net/cris/eth_v10.c
deleted file mode 100644
index 8b1a859f5140..000000000000
-- 
2.9.0
