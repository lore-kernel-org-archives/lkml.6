Return-Path: <ji_hun.kim@samsung.com>
X-Google-Smtp-Source: AB8JxZoBj3zu5e6VPEb1UWx98Pa8NvBEJ8zcQvUsudzyoA5CIbHP9NwixBhwqJb4e+7qp+erEiWE
ARC-Seal: i=1; a=rsa-sha256; t=1525824781; cv=none;
        d=google.com; s=arc-20160816;
        b=xJ9esiMIF/c/P+gNgHhGwkuyC91KLP3D6/3+zTHw0GrHS/rL4R/+k5Xi2b4SuBC8zL
         qWh3mv096vtnczOs2KCAY55ra0EzTh33YLBmXs5hty4xcH7APgg4XC2XHSUbe9nQHGYD
         3z1XGKfllCV3cOoNobnUtdg8Lz1Bu2VPD8DWvpjWKaod7n2uNML0gAgN5QP054uUzUlZ
         n5HeutImvZPcXb+xAE08sd4O+5t9pDrzQ+Q3CMeEMcQOEb0pkQt5qF6YfhygaT0Q3G0G
         ZXgbBJ1VqKi+fgJtlrDRgHWwpECriU3gVOrImgoEbhLKRJqnofStFjtaqFmcN6ArVK5h
         SpBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=WIIHrpnS9oI1xRXarDT9WU//sCuak4nTuRno49RDHL4=;
        b=x1V/aZoalbe/9rk0H0RvdsPs3d1qAeGXzlf+K/Mg+sqKGMDECbfIfLw5GKg27NmYV4
         PcCqQMTETVfnXviqcY++ZwPjykq1EPiqsgJximwFKj9wqj16BSCq6pVfyfPMAUOLz0CU
         ZV/ZEbJnko1xbkYk2lmenMcWnm9UKg6JxJL4tNQ+vagvJ10gcpkUXqgb5XUOTlEq3xqL
         avQ5ZyXbjrA51zI8r+0ILftxDe2QZ2pzgyQGve7DWP1QBNOGVvvE/7xUuJoUN+MTl4kJ
         K4jfyijZPTJCZia8kHlBkuMxig2AEJowymYw6EohrYdF5oegmjNL7+v4q5isEERLMCpo
         4GwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=c09WIxmU;
       spf=pass (google.com: domain of ji_hun.kim@samsung.com designates 203.254.224.33 as permitted sender) smtp.mailfrom=ji_hun.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=c09WIxmU;
       spf=pass (google.com: domain of ji_hun.kim@samsung.com designates 203.254.224.33 as permitted sender) smtp.mailfrom=ji_hun.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180509001259epoutp032dedef6f8922ca3be14601141bf93b9d~s0Y2UZSgc2679926799epoutp03d
X-AuditID: b6c32a37-511ff70000001030-ff-5af23d0a3908
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: peterhuewe@gmx.de, tweek@google.com
Cc: jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca, arnd@arndb.de,
	gregkh@linuxfoundation.org, javierm@redhat.com, sonnyrao@chromium.org,
	ji_hun.kim@samsung.com, enric.balletbo@collabora.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] tpm: replace kmalloc() + memcpy() with kmemdup()
Date: Wed, 09 May 2018 09:12:36 +0900
Message-id: <1525824757-21835-1-git-send-email-ji_hun.kim@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7bCmgS6X7acogxsHpC3+TjrGbrHm9iFG
	i+bF69ksvq9ysVg4bTmjxcwZJxgt+k9vZ7TYekva4sQ5oKrLu+awWbzd95Pd4smZmYwW8371
	Mjnwevz+NYnRY3bDRRaPHXeXMHp8+BjnsWBTqce8k4Ee++euYfd4v+8qm0ffllWMHp83yXls
	/XybJYA7KtUmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0z
	B+h6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUrShoZGeoYG5npERkDaPtTIyBSpJSM2Y
	82ARa0EPe8Wvl5MZGxj/s3YxcnJICJhI3N4+k62LkYtDSGAHo8TMk3dYIJzvjBIday+yw1T1
	L+pihUhsYJSY0LgMquUHo8SzpXvBZrEJaEps7L7GCGKLCKhLTJh8kgmkiFlgKZPEhiNn2UAS
	wgKuEi8PdoGNZRFQlfi18yMziM0r4Cax9u4yqHVyEiePTQZbJyFwgE3idf9+RoiEi8Tpbbug
	LheWeHV8C1ADB5AtLXHpqC1EuFpiwZUdLBB2jcTN/0uZIGxjid6eC2C7mAX4JN597WGFaOWV
	6GgTgijxkHix+CXUCY4SOy+sAGsVEoiV2H24mWkCo+QCRoZVjGKpBcW56anFhgXGesWJucWl
	eel6yfm5mxjBCUrLfAfjhnM+hxgFOBiVeHgldn6MEmJNLCuuzD3EKMHBrCTCK2v8KUqINyWx
	siq1KD++qDQntfgQoykwNCYyS4km5wOTZ15JvKGpkbGxsYWJmbmZqbGSOO9TnzNRQgLpiSWp
	2ampBalFMH1MHJxSDYxWRwsnSFZ1T9v0irtL3rSj6v/Ue78MHwmtXRsaN1v6wQLr567WCiLb
	S8wVzt3IyFN/y/LyLkNcSuGHX/2LZdy1VxxVm/CXt1rSSmHy7kMPC7dLiMia7em/HB+Z0cWg
	YWhXsr2Cw9a/0NIhxdLP9bNrqqLSsqjz27Skkpqyu3bkJu4qd2SpUGIpzkg01GIuKk4EACy3
	EdRmAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVy+t9jQV1O209RBpNvWFr8nXSM3WLN7UOM
	Fs2L17NZfF/lYrFw2nJGi5kzTjBa9J/ezmix9Za0xYlzQFWXd81hs3i77ye7xZMzMxkt5v3q
	ZXLg9fj9axKjx+yGiyweO+4uYfT48DHOY8GmUo95JwM99s9dw+7xft9VNo++LasYPT5vkvPY
	+vk2SwB3FJdNSmpOZllqkb5dAlfGnAeLWAt62Ct+vZzM2MD4n7WLkZNDQsBEon9RF5DNxSEk
	sI5RYs7H3UwQzg9Gic6PS5hBqtgENCU2dl9jBLFFBNQlJkw+CVbELLCUSaLl8w4WkISwgKvE
	y4Nd7CA2i4CqxK+dH8GaeQXcJNbeXcYOsU5O4uSxyawTGLkWMDKsYpRMLSjOTc8tNiowzEst
	1ytOzC0uzUvXS87P3cQIDMNth7X6djDeXxJ/iFGAg1GJh1di58coIdbEsuLK3EOMEhzMSiK8
	ssafooR4UxIrq1KL8uOLSnNSiw8xSnOwKInz3s47FikkkJ5YkpqdmlqQWgSTZeLglGpgVGi+
	1V98TKB7iv1FM9YVFb8uH//+rb1T8rJvidSUd858628KeM1aoXtEKThPNuR3zZcpusoeF2T+
	im/iTA0KesxfZZulcm69s6uZbKlBrLa9grf+rykXvz8Xstj3v5jT80Zu0ptzcQcdJkXvrHMV
	d086atbwaJ9D/6/5PhP7dgY8j7vrOz1JiaU4I9FQi7moOBEAjzq0ET8CAAA=
X-CMS-MailID: 20180509001258epcas1p4e8db163d8babd90284dd6afb6a96eb0f
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180509001258epcas1p4e8db163d8babd90284dd6afb6a96eb0f
X-RootMTR: 20180509001258epcas1p4e8db163d8babd90284dd6afb6a96eb0f
References: <CGME20180509001258epcas1p4e8db163d8babd90284dd6afb6a96eb0f@epcas1p4.samsung.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599943245926622446?=
X-GMAIL-MSGID: =?utf-8?q?1599943245926622446?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use kmemdup rather than duplicating its implementation.

Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
---
 drivers/char/tpm/eventlog/of.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index b7cac47..bba5fba 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -69,14 +69,12 @@ int tpm_read_log_of(struct tpm_chip *chip)
 		return -EIO;
 	}
 
-	log->bios_event_log = kmalloc(size, GFP_KERNEL);
+	log->bios_event_log = kmemdup(__va(base), size, GFP_KERNEL);
 	if (!log->bios_event_log)
 		return -ENOMEM;
 
 	log->bios_event_log_end = log->bios_event_log + size;
 
-	memcpy(log->bios_event_log, __va(base), size);
-
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		return EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
 	return EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
-- 
1.9.1
