Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48ZcfptUBdTkYa1TJjxbvTpVWK8xrvWoAIj9EEivQKW986GqgJMj2nBhUiHaIR9ezzpBUvm
ARC-Seal: i=1; a=rsa-sha256; t=1522346631; cv=none;
        d=google.com; s=arc-20160816;
        b=cniHUFpc230CDJm65JWSBOwL1yi8kvdFmqc7riuzl1Zk4p26oDinY+PZzRTJoH5mME
         AAVKRDsLf31LD83LUuSmEsvE6qJe3VCvyORG3lcsX+kti0AxCg5FrhK/Y2OR/aTmwhCb
         7kaM3XlbQSJw0cA5Iqb9YtBtX0wyo0SVsPBQYPEGI2E/SAHDwfUY6QGZukvn8JywwLv7
         O6+R8fueeP36tFfoKy5aMdau61ysk4NObhIOrcziOF+DrtCd7vFp6MF5IlZDiSAUUpVo
         ZgzZTQeQlDEASAmPoLhVFcNz8WLhLdYoDgablHfrIU2BoGaE+0nFDznmOU0fp6W+gspK
         jGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=D2fNgAZQD93AtHZIsw0T8QmDfCaqT1VBNTfiartabMk=;
        b=QRRYipVLhD5SszIGsbzqAvE/hSLsciqcaj7ci0prkUW3R4LC88d7JOcgYZo5tOzyKW
         wfbJO0D8FmBd0g2bRVm09iisLt8pbeJzht+WOFwxEa6nA35T2rMsWUSAWaDKi+TlWy2J
         ko5sV07ZFdWbR/5VntTjF2wHUB/snoZRzHEzKNBvJLcRQxB/pGHfR1rtGNeVjKfVUAGV
         4KlhJSkdRRhikRjovE0HgC28vaf6V61FVw/A/Kg1VJehqSOgETom1cwjcfv00N46aRnd
         VcAwAahiMys73f8TMj3M6hWwP5sgdxOiR2Jb8c6pU48TJG4aVstz7pg41cM84eZ1BN6c
         ijCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 06/47] sysfs: symlink: export sysfs_create_link_nowarn()
Date: Thu, 29 Mar 2018 19:59:47 +0200
Message-Id: <20180329175729.602192724@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296141904379331?=
X-GMAIL-MSGID: =?utf-8?q?1596296141904379331?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Grygorii Strashko <grygorii.strashko@ti.com>


[ Upstream commit 2399ac42e762ab25c58420e25359b2921afdc55f ]

The sysfs_create_link_nowarn() is going to be used in phylib framework in
subsequent patch which can be built as module. Hence, export
sysfs_create_link_nowarn() to avoid build errors.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Fixes: a3995460491d ("net: phy: Relax error checking on sysfs_create_link()")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/sysfs/symlink.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/sysfs/symlink.c
+++ b/fs/sysfs/symlink.c
@@ -107,6 +107,7 @@ int sysfs_create_link_nowarn(struct kobj
 {
 	return sysfs_do_create_link(kobj, target, name, 0);
 }
+EXPORT_SYMBOL_GPL(sysfs_create_link_nowarn);
 
 /**
  *	sysfs_delete_link - remove symlink in object's directory.
