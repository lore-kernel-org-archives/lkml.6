Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt5GIkJnOAwjz5hZZQZAaK1btYzTa+r2webD8/dgaltiDEkCHyEdZHlbm5a9iMX8mTH5jpj
ARC-Seal: i=1; a=rsa-sha256; t=1519981448; cv=none;
        d=google.com; s=arc-20160816;
        b=1CXnv1lgd/R1EaTdhm2j9ML23NfoxdKtfn46x+LzSSZJ0lshRo+u+2br4f7yHBWt85
         RmeuRvkpwGpW1JeMxq/2FlBbEmRhkILEBOgrNAI7mm2+E6EIZ4ZNDswIdE7h6HlQLq+k
         c1aCVCfL4dr1qseuNelNu5PGk9dK4TbkB+kXFvP/LkKonJEa3dT2kXuOrF5T7U9fEe6J
         4WPCpNPNnglVGDHF57Trk/CNUmjzGTjZ/SBtJC00BqhHDY+vykyjHB456Lq5drkmuWx7
         bLEN0GO5xHXLr6s4yBZBWFXTdWq4YLCT3QvPA/jxHmUUG7NayoyCoyvC7mBTWTSiPRxL
         uGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EgMF122GKtP6loz+pqXMCKtf0mLkD2Oeog60fQwMLEY=;
        b=GdRIGTqXSipTydO6BDfmZMvHu1qL/DmVg/pxTKHanS8YpNjitGgBQ4JEr4l6iAtun+
         63KMBYFbY+EO0WjcKDAUTQ3M0e7SooMVZTIxyqK/mxnbI9FCeKNW/fIOjFDGNMbFpM+6
         ftbUHjutjcvT8hWRoTFwDGJAG9oQf1Ev5RKlAvHRwNDokiGjjAZ6vKO0Vj15+FChM0Oz
         JRAMTaDLfGvAYQl8GoqbHy/PauSPD91xwDhHopLo+KGyjuEQbnYKuoGMqrZ4ChSM0Oqp
         WEdkcpdJ0DoW3yRdhkEAWeLV8rMl1xDo6B+V+mo1cMIMIVDOh3+Oew26sLnYkH05FoBz
         fx3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Ewan D. Milne" <emilne@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 093/115] nvme-fabrics: initialize default host->id in nvmf_host_default()
Date: Fri,  2 Mar 2018 09:51:36 +0100
Message-Id: <20180302084507.611408005@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816067367103126?=
X-GMAIL-MSGID: =?utf-8?q?1593816067367103126?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Ewan D. Milne" <emilne@redhat.com>


[ Upstream commit 6b018235b4daabae96d855219fae59c3fb8be417 ]

The field was uninitialized before use.

Signed-off-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/fabrics.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -74,6 +74,7 @@ static struct nvmf_host *nvmf_host_defau
 		return NULL;
 
 	kref_init(&host->ref);
+	uuid_gen(&host->id);
 	snprintf(host->nqn, NVMF_NQN_SIZE,
 		"nqn.2014-08.org.nvmexpress:uuid:%pUb", &host->id);
 
