Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqgZP0UKln17DewQuKauZTVJAix/f2mh1SkuGAiSASaC7lzDztheoBEu+Mek1pUslcb24st
ARC-Seal: i=1; a=rsa-sha256; t=1524838324; cv=none;
        d=google.com; s=arc-20160816;
        b=vwPUNbBLn5vM0AzNfnngCqUMgszZo8sjqgLn9QRdB0OAn5NJkBmtTFNbYeHLxrZQRr
         ztHq7XMrCLJtJbjkcoB3M+49eNg/UvzeF4uPbZT4bezNglyqNZScNUtQ7qBcKuTp/B73
         9LueNm1UI5+FvNuUhJ2+JLIIA2btBM5fB0eH0m1n/ctd6lAd1HMGxfGvTvqw9Nx+QoqV
         fFxzC4XeQ+hb5g3DRAPfxa59a7OjNX1PiVdh1BDNJ85RbML4QDlfyzRnzBGjEv+q07yl
         b6Et63aIB7BJGFoW1IBZ6o7ua/qtDQ/uRmA3LwE0Nd6W2bMF8e7gG0AHWGfZrmtvhRl3
         Bznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=xW7GQyWDMEKacUR/0C8oFrSYE7HP/IPeNljD+4IC/Lw=;
        b=CwB52WlU0Scx0S65qc92Aph/ujzBHpyLJn5I52wS7hXh3Z/SyfjFb1DV7nss3sWqzu
         6mvlvNO0ti/UndKmPsoY8wRMBvADVUCu0yUmvTlZW4GVD6Ar7dAxWDRXGkhoIkoIyObS
         JK9XlA3Rkm8aRQkYqTLYCXRFuAmAgMp7AyqQzw4tAWgeWtXa6xTztbUUkeI3KTORFa2q
         gxxB2A4Z39HfD/k/1+uIaMOxlTsiZr9z5OFPpL6wggWwIVpyg7wJPWUyOtf+9iJoL2Lx
         MmWEqmY2t93AKPeKvW/8FNzfWDwySlKTeAH5RTCpKbQanidyN+YFUqTfnL0JtIGLfmMp
         COgg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CA02189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nikola Ciprich <nikola.ciprich@linuxbox.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.16 62/81] scsi: mptsas: Disable WRITE SAME
Date: Fri, 27 Apr 2018 15:59:04 +0200
Message-Id: <20180427135746.957806631@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908124902978465?=
X-GMAIL-MSGID: =?utf-8?q?1598908870746872916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin K. Petersen <martin.petersen@oracle.com>

commit 94e5395d2403c8bc2504a7cbe4c4caaacb7b8b84 upstream.

First generation MPT Fusion controllers can not translate WRITE SAME
when the attached device is a SATA drive. Disable WRITE SAME support.

Reported-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/message/fusion/mptsas.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -1994,6 +1994,7 @@ static struct scsi_host_template mptsas_
 	.cmd_per_lun			= 7,
 	.use_clustering			= ENABLE_CLUSTERING,
 	.shost_attrs			= mptscsih_host_attrs,
+	.no_write_same			= 1,
 };
 
 static int mptsas_get_linkerrors(struct sas_phy *phy)
