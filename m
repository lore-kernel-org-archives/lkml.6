Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48tTAGxtxo52N+I+Mw016WTiqSuKLXuB2Sblb+k2dAzCV47xgTUQENBLMlPR/+xjVYNasze
ARC-Seal: i=1; a=rsa-sha256; t=1522168800; cv=none;
        d=google.com; s=arc-20160816;
        b=y2pKeft3gMmVpVb0SZKxubxl0S5Yp4u0gCfiesoleSl943T7Ixt+sGti2SYLIX8/Mu
         PujrwLjICg0YjOs0gDvkh8Yc7+zBXyi09Oeks4DfbMMb00li2R2WnnbI9c+fuDKN1Bn1
         4eHpMZvdK8jQLpO57UfjSPX3VAAcOxwVhcpn+SCiEsniFYYNpm/Wwg0xLioPtJIVeE7S
         I3JokrvCIlpcbUDjQVqPN/rvtc7aHpKuWbbwKrUMiBKB+aHp4v9wmeYwQOPLlg3ZFPee
         hwL0S2fVozCCX0Rp18CwyNSdLkz3K5mV4B7d2OWCKytePqC8z8/hVX+Yzhv9m2Xe+E2z
         IW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6H1gBsZRTV8HLfIXV40IYPE+NGUvHHkJFK8P40VUyBc=;
        b=b5tYGeZXUmlyI83JX5PlG+fvtf5+EZ317dhuwcCFC/j7FJuVpjnPOQ+LFAu8LKIyEw
         jGvt2r6co/Pqor45fYsID0LUZA8EmOfXDLnZCmwl3SUdPFX84giXPQlOX6sYNiHIiqBE
         n7CkHHsJX9LtHSEagFQ5tR5DZbnKMdaCgjIS46IeLZYxUh6BosQp//cylPSxx9dca8o3
         QQ+o7p3ar0fJmbng5Tz6wONNIFP3DLuLAvafL8mQ4CQFGZ1/AlRm2i+ND34S91Qjvv86
         qV+YQEFqURoBGiqOvEpMQaPLdUm/25eGha0vgh0HZXKiiNn1HhdA6A9faVv5jY/DWfKl
         YR4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mathias Kresin <dev@kresin.me>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	John Crispin <john@phrozen.org>,
	linux-mips@linux-mips.org,
	James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.15 005/105] MIPS: lantiq: ase: Enable MFD_SYSCON
Date: Tue, 27 Mar 2018 18:26:45 +0200
Message-Id: <20180327162758.066164568@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109323601662590?=
X-GMAIL-MSGID: =?utf-8?q?1596109671651245876?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Kresin <dev@kresin.me>

commit a821328c2f3003b908880792d71b2781b44fa53c upstream.

Enable syscon to use it for the RCU MFD on Amazon SE as well.

The Amazon SE also has similar reset controller system as Danube and
XWAY and use their drivers mostly. As these drivers now need syscon also
activate the syscon subsystem for for Amazon SE.

Fixes: 2b6639d4c794 ("MIPS: lantiq: Enable MFD_SYSCON to be able to use it for the RCU MFD")
Signed-off-by: Mathias Kresin <dev@kresin.me>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.14+
Patchwork: https://patchwork.linux-mips.org/patch/18817/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lantiq/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/lantiq/Kconfig
+++ b/arch/mips/lantiq/Kconfig
@@ -13,6 +13,8 @@ choice
 config SOC_AMAZON_SE
 	bool "Amazon SE"
 	select SOC_TYPE_XWAY
+	select MFD_SYSCON
+	select MFD_CORE
 
 config SOC_XWAY
 	bool "XWAY"
