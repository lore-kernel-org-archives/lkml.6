Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3256414-1519144446-2-9202452679734334691
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519144446; b=TgcEhTKZ1zFVs4IAGEysqfpHJmXd6S3uACW0XwQYSnQAK/y
    MWKU7xYvxHsTkva8IXEIUaLIblTerpatLsdhqjmPKa2FbkfAUYDNFHWd9y9wvEb/
    MiCuWJ17HrgQCmLOG7I8uzvzvHoUfguqlWh/XBJ1EKDx8jfcztG4oziKPJeY0oDe
    XtW3JhzA0fg2KPL6WazpM+fDjMd++sVIdp0VUgmnaJnz5MgNb6iQyh9d7jCs+E2x
    HfvdDu8Bb/U6Co4nM1nj9JMs4bRUX3rNg5h8wpiAkSYDZw8VNdJwbL3ScIvzUc1X
    4zXhaw8NPNwqbg5z+bDoPWrdi7hUUu7rTGa8YKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519144446; bh=4
    MEAhWH1HkQ4OdPOak3wWVHTNPwdVqPlDeVvt3v36ZA=; b=hozr6+F+06dDsopoq
    AsQNzOz/nUp1rGDNZ5GiLQAKajFiRroEZ/mU5bZV02p7h21bmxfxDDS1wKvFaNBd
    MoOWf2kh8PVpH1ZOwqPHgHzQz4YxhvzhJDMs9JdbzusTMuxCk76We59AcyIzq0Kb
    hdBQjC3IMU0wzCLvZtW7SfHdhVKlK1GmHRVDQKvsa4A7UpVcJafkz0PCAvTLOm84
    aRT5aY6LXtIlJosbYRC/bVh1fa54WbgYxpf9cPQlghyYJBiZHTFdNy4paPMKa7X+
    s+kADoFxShtTt6j617VzYjyzsUA4K42IlvrOKzVJXd8GpXfdlVsP8JB003AAIUVy
    u6UQg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gentoo.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gentoo.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gentoo.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gentoo.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christopher Diaz Riveros <chrisadr@gentoo.org>
To: gregkh@linuxfoundation.org, hadess@hadess.net, hdegoede@redhat.com,
 Larry.Finger@lwfinger.net
Subject: [PATCH-next] staging: rtl8723bs: Remove unneeded cast
Date: Tue, 20 Feb 2018 11:33:54 -0500
Message-Id: <20180220163354.14418-1-chrisadr@gentoo.org>
X-Mailer: git-send-email 2.16.2
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix Coccinelle alert:

drivers/staging//rtl8723bs/os_dep/sdio_intf.c:340:13-27: WARNING: casting value returned by memory allocation function to (struct adapter *) is useless.

This issue was detected by using the Coccinelle software.

Signed-off-by: Christopher Diaz Riveros <chrisadr@gentoo.org>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 943324877707..99c407ba0874 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -337,7 +337,7 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
 	struct adapter *padapter = NULL;
 	PSDIO_DATA psdio = &dvobj->intf_data;
 
-	padapter = (struct adapter *)vzalloc(sizeof(*padapter));
+	padapter = vzalloc(sizeof(*padapter));
 	if (padapter == NULL) {
 		goto exit;
 	}
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
