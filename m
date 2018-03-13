Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2930626-1520938388-2-988763488546984878
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520938387; b=RVyTmNP2cXfURZWXO6r67nzsiFS0vucxFhAj/K/2k/9urlU
    d7RJ3RmCegOnv9DmZ7MJRS1YXwkNvOeH9BCQ8cwkJIgleaeHTiT/Y+tvIEZPojhO
    ifxX8und6lj2suJwCSNDrp5CqGCEsqGbzyYoq09a+31gtt6pIaY2Q8lnj8fAO/fY
    Q6zU/1M65dJ8KtgGUpVY9eQVjfN/BADuB9mDRj7bBZ25s/LA8Pry+OGqoUebBy+3
    WFW2KZydDoFq9vST42wxYQhZgpuVRxcsara0vI1YllY2CpdLWGxw/2DSgIWrVHhr
    OUEDb3GKZYI+gP7RFDOir28u7+gwJAzRXj/7muQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520938387; bh=T
    c6VToFSLzW5aV6/U6c5VC/imSCL4k0GCYHf4irwjXU=; b=dJ/9klMqmNOQ7zk4Y
    1UoY5bCuUyl/DplQcR/Sv1EkR6vkSZXBexZ/365lGnayJLCywQkWvXxttNzvhwdv
    rrVPP6GrOOcWK9ANs95Hi8uyhmCGMEeyCUeldXYSc/tJ08uADJj3tMa+FpaKmWSC
    MuX3cHYQWcLdVwq04MzIjMvILGCRAk81qA+m0REB0+H9Tay57JldGqdxRbRWTjPN
    vHOBmi4MKHmwH7sqQPMmhxsd1fOaZdrsSQS+ziW3EUFwy+Qys3S/BCB9zYU5OSHG
    vmfC0o7diErMHutA0iXMGBz1Jw5W37WxQGEVXWarkAOBPexobiNBriqLquQL1p0n
    Ti6jg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nR6Ue8G/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bkpTwE8z;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nR6Ue8G/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bkpTwE8z;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvNdsIwJjfQUE8kA3/pp52imDdasnXK6OoyH3KGa7sPxer9GRPGrCfR/IZ6T+cNrAkG4WDVcw==
From: hariprasath.elango@gmail.com
To: aditya.shankar@microchip.com,
	ganesh.krishna@microchip.com
Subject: [PATCH] staging: wilc1000: remove unwanted braces and correct code
 alignment
Date: Tue, 13 Mar 2018 16:22:38 +0530
Message-Id: <20180313105238.12838-1-hariprasath.elango@gmail.com>
X-Mailer: git-send-email 2.10.0.GIT
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 hariprasath.elango@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: HariPrasath Elango <hariprasath.elango@gmail.com>

Remove the unwated brace and corrected the code block alignment
accordingly

Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
---
 drivers/staging/wilc1000/host_interface.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/wilc1000/host_interface.c b/drivers/staging/wilc1000/host_interface.c
index a4ee175..0fac8e1 100644
--- a/drivers/staging/wilc1000/host_interface.c
+++ b/drivers/staging/wilc1000/host_interface.c
@@ -984,20 +984,19 @@ static s32 handle_connect(struct wilc_vif *vif,
 	wid_list[wid_cnt].val = (s8 *)(&(dummyval));
 	wid_cnt++;
 
-	{
-		wid_list[wid_cnt].id = WID_INFO_ELEMENT_ASSOCIATE;
-		wid_list[wid_cnt].type = WID_BIN_DATA;
-		wid_list[wid_cnt].val = hif_drv->usr_conn_req.ies;
-		wid_list[wid_cnt].size = hif_drv->usr_conn_req.ies_len;
-		wid_cnt++;
-
-		if (memcmp("DIRECT-", pstrHostIFconnectAttr->ssid, 7)) {
-			info_element_size = hif_drv->usr_conn_req.ies_len;
-			info_element = kmalloc(info_element_size, GFP_KERNEL);
-			memcpy(info_element, hif_drv->usr_conn_req.ies,
-			       info_element_size);
-		}
+	wid_list[wid_cnt].id = WID_INFO_ELEMENT_ASSOCIATE;
+	wid_list[wid_cnt].type = WID_BIN_DATA;
+	wid_list[wid_cnt].val = hif_drv->usr_conn_req.ies;
+	wid_list[wid_cnt].size = hif_drv->usr_conn_req.ies_len;
+	wid_cnt++;
+
+	if (memcmp("DIRECT-", pstrHostIFconnectAttr->ssid, 7)) {
+		info_element_size = hif_drv->usr_conn_req.ies_len;
+		info_element = kmalloc(info_element_size, GFP_KERNEL);
+		memcpy(info_element, hif_drv->usr_conn_req.ies,
+				info_element_size);
 	}
+
 	wid_list[wid_cnt].id = (u16)WID_11I_MODE;
 	wid_list[wid_cnt].type = WID_CHAR;
 	wid_list[wid_cnt].size = sizeof(char);
-- 
2.10.0.GIT

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
