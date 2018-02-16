Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2939088-1518744307-2-9862786764876595140
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enroda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518744306; b=iosdSnRvp1R6a4gTQzQAHk2CutV6db2OYop44WmzFtCj8xW
    SbCyzKjATXVrEOdJMW/UkPfO8+5Co67EGUr9Sh2xjcLHYM/S6FcM/Ky3LCCLK+j8
    yNk7Qp0vZfYcWi7hWlKl3RVrhuinzFEAvCfbrmeycewuDmty9S9HFs7vdPyUD03c
    tKYLfkvmn9/1ETgTNGYwLoh66sVkTvlx07pJ7a2HuASIEqNmfJtGq342MCZR2+J+
    xARt38iCNe4DLdhJEk5QDZSfOD96vP3bx9DhZsmy7JknoE8nMcRLFMETp6AhCU0p
    iRCeF9c1cwKvrIc6dBT0A4f0/wYb0/8Guo3VHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518744306; bh=5
    ZDxjsO25FdtvPjK6ywv1ypXeVki5WSw4SpuND4ZQ4I=; b=aJNTd9y/9SRH2LJ2q
    pg58pSJ7I+Q40LN/3pOP9G4kHayWo1Xlw5lhKutStd8AB/eb64LKZ3ZcwQxoyObN
    tHUkqNOT8G2BtCuBMSC+mb/ULT1yWCAw39zmN0T9nfU0nBvzmd5XISTLOF8Rkp3y
    WzvpqwTdeIhSf0DUd84Rtqu9WIye/hFl98eNz6tWKCBlw9rAKDd9r7zEY9Hv9QCI
    i2S2qZyBvhz7PbJCP7ti2v/myrzUpPfSj9LErCRwi/j3DdyXKog4ueuHXRFligp4
    rUYMMkrmg8HtxkxLWXhrQskdlQ0PiLVJq8/EL5LoEUQDrpFHrG2HeikbzZNYvo0y
    qx5yQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=A4kUtIwh;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=A4kUtIwh;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x227/yHkRwUvDT6ckRaU4WHKLYCsN2BVHAFiWP4gVR6TwNQP2+HWz8mDllhTNGUUZOMoobC8obA==
From: Laura Abbott <labbott@redhat.com>
To: Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH 1/2] selftests: ion: Remove some prints
Date: Thu, 15 Feb 2018 17:24:44 -0800
Message-Id: <20180216012445.17264-2-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216012445.17264-1-labbott@redhat.com>
References: <20180216012445.17264-1-labbott@redhat.com>
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
Cc: devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Chris Wilson <chris@chris-wilson.co.uk>, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


There's no need to print messages each time we alloc and free. Remove them.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 tools/testing/selftests/android/ion/ionutils.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/android/ion/ionutils.c b/tools/testing/selftests/android/ion/ionutils.c
index ce69c14f51fa..7d1d37c4ef6a 100644
--- a/tools/testing/selftests/android/ion/ionutils.c
+++ b/tools/testing/selftests/android/ion/ionutils.c
@@ -80,11 +80,6 @@ int ion_export_buffer_fd(struct ion_buffer_info *ion_info)
 	heap_id = MAX_HEAP_COUNT + 1;
 	for (i = 0; i < query.cnt; i++) {
 		if (heap_data[i].type == ion_info->heap_type) {
-			printf("--------------------------------------\n");
-			printf("heap type: %d\n", heap_data[i].type);
-			printf("  heap id: %d\n", heap_data[i].heap_id);
-			printf("heap name: %s\n", heap_data[i].name);
-			printf("--------------------------------------\n");
 			heap_id = heap_data[i].heap_id;
 			break;
 		}
@@ -204,7 +199,6 @@ void ion_close_buffer_fd(struct ion_buffer_info *ion_info)
 		/* Finally, close the client fd */
 		if (ion_info->ionfd > 0)
 			close(ion_info->ionfd);
-		printf("<%s>: buffer release successfully....\n", __func__);
 	}
 }
 
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
