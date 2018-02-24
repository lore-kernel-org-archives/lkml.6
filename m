Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-803568-1519459163-2-9966948384769050023
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519459162; b=K2LDYtzocdN4xQ0BGqfR6jCXASAvA6OJQycoCKVEd/gebId
    VI51YE97x1eeOOJezNbB45C7GgnLRCGb5GsyzKz9XVHX7dETu3RLXuNPM+1TBcN4
    H4Uku+fpTnQyzycjj0lo7xguGvZY2O878AU10i8MZH9/dYPjFeCdqa+PvofkkNxV
    HWMod6fFXcLyNiEoKAgAcJB3IQ8l819TdSSo3hokz0HeXsX7DkzQNkXxbeiWM/42
    CREqk1zaB75DU+cWpTCs/72Xxb4ayqOFXTKvM1SWth2t3diTk8R9dc1VTqc7fBns
    QZ8Ui6lOnRmNhNtzw1hwHVq8sYreBGZMcBtGSHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519459162; bh=q
    di73nVb5UcPj5CaDAle5clHFCAQfX6xFRKy7ycHQOg=; b=r/zHhHbP340I7yB+k
    BV7JedXlNw4sw40dyr+p8J697/M13SpkwYAo3WJjvsregOOs3nI/UdaGOsh79IPj
    SK928rKUzSwhSv1cMHm3JGey92fVyGTgf/Yocd6v0lOAwvSEaEeXfzRo+mUkuaju
    Ps43/v1N/rgQEKQOwO+V6XSpfFALgDMUz+a7y1YjyxS6NC4JbaEuKl6YIsPgIYAP
    eWTFBVJC04MNqtbNd8qR/Y1PvqL95KkDoc27HFlxVwfh73+VkDaw7bxTLnjtAVXs
    9fOqpW/NSa7tRDQrtVJnjFQ4oOkgoFZ8IiFlXPT06CgCLm9HJ5aHz+/0xNbntGD1
    RXKXw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	christian.gromm@microchip.com
Subject: [PATCH 2/4] staging: most: Replace calls to BUG_ON() with WARN_ONCE()
 and return.
Date: Fri, 23 Feb 2018 23:58:33 -0800
Message-Id: <20180224075835.11618-2-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180224075835.11618-1-quytelda@tamalin.org>
References: <20180224075835.11618-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:FYU909ctc9yRhlJjtYmHmIbFm6Ku+mp0Skq0GHh2TfXhf/GnjwK
 we4IE2YiZCVhNwpZxhUDL/Le5/nQZwN7h5eC2zXNqpqfC6r3j9Xuoae8ZYb9094QBh+KNQr
 uRA6hiRtAQyINPpwF2KHHrUUNDFPi95wKxlsBoYWJI/fmTGrGoCRWGlVEPSvTQP0MDtp0hv
 wzPqWhEYJWoEuP9YgljGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iv1NPe9SzPQ=:88Oc5UXcEtDW6kyVbIvhfv
 8QCZ7DsW6Wf/thKaU8LarVIa5IeHy+VJgtVbFhsfz3Itu2axEhT8qNX7ahaCPQYQiSKbjYtNA
 hbGHEA4FYOfdedz36+clIvm5c7vrf7f//SEBZturNqJRlM7ZaAJE4kBtzzMVEcb80kpYldaj9
 0NSrxqLann6F+TTHnno7aA0/ySPz4x6xmeFZNZERzwKXPddyE3hEh610/gsMkysALQb+eGPSb
 uYoX5+P3VX1T3ncnxaJdwyJhR30dowS4qrXaFEkF3/K4yaDXit12RX0A6B4i+vrfFOXViRqRQ
 s8r7v+fORF0Z5Q/N0gwMuNVEgdoI6KX8XWmG05K7GUUOwVglTidq9tca5dV4ih/sYc86ci444
 SguQeHPm81LAOBrdXBzoHBM4LE59QfblCdLDOKOyAtu2sYVTDckyAUpqKoX47S7CWFByS9e26
 j5idD7HlcFWK1EpHnR67Fj2OUGFEjsi1EAmE7JSbBETErhZZr5Szig5KN0qM0W7mxjD6rjDSf
 PnuTRjqyOvmrkzNtrGKeeKPWUnEq7CNBtWfn2fzcJILa+Fn6tkLd2aIZ/AJy1l1luUc8DXsul
 CcyMLmgQjoiwnEjKk3mzUvnSDoU5KUNXVJW+TeHAfyCtysQr2kWqe6T3t8bJ/sS5ikISNdF/7
 JAVEaNBi921qVx6GYIVYMVQNPuLyzQ6RQWGMWRcfu8hJRzqCdh5K8Bh9t3GuhowrE2rEX+9aL
 NsXnbErl8YSnUiZFteG9qcjoVlrAOHRL7qRWIA==
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
Cc: devel@driverdev.osuosl.org, Michael.Fabry@microchip.com,
 Quytelda Kahja <quytelda@tamalin.org>, chris@engineersdelight.de,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace calls to BUG_ON() used to check for NULL pointers with WARN_ONCE()
followed by a return.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/most/core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
index 18157dd80324..3f65390a6e17 100644
--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -916,7 +916,11 @@ static void arm_mbo(struct mbo *mbo)
 	unsigned long flags;
 	struct most_channel *c;
 
-	BUG_ON((!mbo) || (!mbo->context));
+	if (WARN_ONCE(!mbo || !mbo->context,
+		      "Bad mbo or missing channel reference.\n")) {
+		return;
+	}
+
 	c = mbo->context;
 
 	if (c->is_poisoned) {
@@ -1001,7 +1005,7 @@ static int arm_mbo_chain(struct most_channel *c, int dir,
 void most_submit_mbo(struct mbo *mbo)
 {
 	if (WARN_ONCE(!mbo || !mbo->context,
-		      "bad mbo or missing channel reference\n"))
+		      "Bad mbo or missing channel reference.\n"))
 		return;
 
 	nq_hdm_mbo(mbo);
@@ -1019,7 +1023,10 @@ static void most_write_completion(struct mbo *mbo)
 {
 	struct most_channel *c;
 
-	BUG_ON((!mbo) || (!mbo->context));
+	if (WARN_ONCE(!mbo || !mbo->context,
+		      "Bad mbo or missing channel reference.\n")) {
+		return;
+	}
 
 	c = mbo->context;
 	if (mbo->status == MBO_E_INVAL)
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
