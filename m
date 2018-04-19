Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx4/f+7obqQibCOSSBvoQ/nKPWzgFfxP092PpLBP2FU28i8oPSN3udYaCQXAAMLRkyF0hCrfg
ARC-Seal: i=1; a=rsa-sha256; t=1524141747; cv=none;
        d=google.com; s=arc-20160816;
        b=Zjy+jURgOVBRh48F2Vq7bW9ALFkvy6vxQzGlYbqwSkHmHgt9MSBwWvzUiB5Dvys7ct
         B+tephwJe9yKQnZZI+bHW/FxP89Drc6fPYmDcgV0/8gDEEcp79/li/yQnqK35u/Lqbky
         Uu2D004csRSMHS6D0CBusC97UvLv8cwdbr/M1eUQ3voGbNm5+jaNrD1hDomKyxicF8rD
         0cWrY/eE5P2tXTjUkxaHP7Gg3XTgeThZ2dKeFCXHvODZm+8wCfKOfaIyJECh8+bnsplW
         zJ34miEqyGyXE8C2kyoJ7SNwWmm52fu8RzJtPe09bTkbn4shqN0kU36WdLCiZdwRWNrI
         UcDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=0GJDPceBFANlSuzJjjMNdrs9rQcv0ykXgTB/FocL2Ug=;
        b=flPLVEvd0L0CqL8zgY6IGjbzAaMTXLjyfMsN4QWLcj+VI5nFnudURRQegnhxuYAbhX
         AyAsIOWIdLf1vQFR8zQ0b9/duT+8wMDvcoJUwB6DUrH0wzin5sgvXD+c8NULRcrC3vtz
         P5Pkv7VvpeZEXaqt+gtoy8luQVmgEV691GwFE6Soy6DVmyw6baIY+9/K6KZtoXhDEDqR
         sDZxMsXwJ+xXPKbwujfSRu/6KOFMicQ1/1MuO6IjItiZOlf4qDfrmnJixnFAwdqM13+3
         OMRROCm8uJDkxQibXeIQZGAvoqAB0V8Tg8ozFCVROMlTcI1ruGpDqHFvaQiuMuyXxhe6
         BP+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=qOXr9G4/;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=qOXr9G4/;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	Corey Minyard <minyard@acm.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-acpi@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	linux-ide@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-afs@lists.infradead.org,
	linux-ext4@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/39] net: move seq_file_single_net to <linux/seq_file_net.h>
Date: Thu, 19 Apr 2018 14:41:13 +0200
Message-Id: <20180419124140.9309-13-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178456769960137?=
X-GMAIL-MSGID: =?utf-8?q?1598178456769960137?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This helper deals with single_{open,release}_net internals and thus
belongs here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/seq_file_net.h | 13 +++++++++++++
 include/net/ip_vs.h          | 12 ------------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/seq_file_net.h b/include/linux/seq_file_net.h
index 43ccd84127b6..ed20faa99e05 100644
--- a/include/linux/seq_file_net.h
+++ b/include/linux/seq_file_net.h
@@ -28,4 +28,17 @@ static inline struct net *seq_file_net(struct seq_file *seq)
 #endif
 }
 
+/*
+ * This one is needed for single_open_net since net is stored directly in
+ * private not as a struct i.e. seq_file_net can't be used.
+ */
+static inline struct net *seq_file_single_net(struct seq_file *seq)
+{
+#ifdef CONFIG_NET_NS
+	return (struct net *)seq->private;
+#else
+	return &init_net;
+#endif
+}
+
 #endif
diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index eb0bec043c96..aea7a124e66b 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -41,18 +41,6 @@ static inline struct netns_ipvs *net_ipvs(struct net* net)
 	return net->ipvs;
 }
 
-/* This one needed for single_open_net since net is stored directly in
- * private not as a struct i.e. seq_file_net can't be used.
- */
-static inline struct net *seq_file_single_net(struct seq_file *seq)
-{
-#ifdef CONFIG_NET_NS
-	return (struct net *)seq->private;
-#else
-	return &init_net;
-#endif
-}
-
 /* Connections' size value needed by ip_vs_ctl.c */
 extern int ip_vs_conn_tab_size;
 
-- 
2.17.0
