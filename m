Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv+6mGLBskPL5tsa4JyoHvQJa+lv/rmxSvXWQe+kDX1mo7CT9namypXyUpFvqfq9xsqBodK
ARC-Seal: i=1; a=rsa-sha256; t=1519411206; cv=none;
        d=google.com; s=arc-20160816;
        b=BHI8ZUzCePH4CMSwWUVi1bnfi9P3djlHv6cWJwS5oTwPr52n/ArPsdOfgDOffW8BVD
         E4+PL6Inh4x3fnPK4mgzgdp9R0wSGjEnEb/no2xLqT8+5KzmznKof41+wY/RPdeKlpf4
         ps7n8SLUOs1ANy40gHY0dgtPoRdlgrX2/aVH/n/ASATr1oM8gXp5GlRgYdiIyoMZEcUL
         JjdfyM94PI9pe9gIQewGDd9KpiqV3QGCRtCfAdDh4ZRCaPiMiEa4MMlHvughmbbQIaJe
         5IdbYiJE/MWSzQZNugVa4NiN151xc3eNOqmHrdmhxwCGYE64RbRc3sB9M3Zl4cfhei3c
         AmkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TP9fQ2PQLOdxbBjTlHBoF1OGRpw8KN10Leg+2C3+Ox0=;
        b=qFACgDovlxKD/5ZL+a12F43ts38w2K7WyZthXiXi8Wl7N2Sfg4TiSYOm8GxN05qiOl
         XEmLu3ftcgijAlIBNjtOLefSQ/aVK047s5Qq9F5sq6LuFcZ5O12noWlUB0EFTIQVn9FH
         ZySxNiXLkINmnro/OsRYhgg3dhCW1Vl/fHkDmKvrwWrMZffbaUXnvk2O2SrZyWARHo1k
         FWla9oWqyNRC2T0vz/aiLP6b4uhVbCeedPey6LurpBZQuLbSfQ2OvXKr7RssPmsTIHz1
         z6oXkRZVzzJ35lqL9ehPqtkDaueLhXiwwtb8VJ1XGnyfvYBKUIF0RBeNNgk/6STa3eZW
         xrlw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 120/193] tlan: avoid unused label with PCI=n
Date: Fri, 23 Feb 2018 19:25:53 +0100
Message-Id: <20180223170344.676395351@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218125842050582?=
X-GMAIL-MSGID: =?utf-8?q?1593218125842050582?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 1e09c106a44c2b2685a77a1ef27951381c9fcd23 upstream.

While build testing with randconfig on x86, I ran into this warning
that appears to have been around forever

drivers/net/ethernet/ti/tlan.c: In function ‘tlan_probe1’:
drivers/net/ethernet/ti/tlan.c:614:1: error: label ‘err_out’ defined but not used [-Werror=unused-label]

This can be trivially avoided by just moving the label into the
existing #ifdef.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/ti/tlan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/ti/tlan.c
+++ b/drivers/net/ethernet/ti/tlan.c
@@ -610,8 +610,8 @@ err_out_regions:
 #ifdef CONFIG_PCI
 	if (pdev)
 		pci_release_regions(pdev);
-#endif
 err_out:
+#endif
 	if (pdev)
 		pci_disable_device(pdev);
 	return rc;
