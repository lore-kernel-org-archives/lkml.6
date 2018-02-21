Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2591082-1519251961-2-2772622566087051426
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enroda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519251960; b=tE48FIqpLD2ne3JgVlHkPr3sjCRgSc04K5/zC5tu3iXO5Nt
    FJvo43S+X48DRyhwhbxwg2isvXEEyoKGuDaTf5IjAx4xQeHxma/J7a7o+Wwa6gVf
    iIt+psyK9JzSHbqTrH7/jOGIBR46L6lR70m40A6kAfBAZfRSq6zrbDDlKqxFU30V
    Czv7HW+wYNE9CjHhfj2hLQKEd3Ed3QraDNr7WyyMWCiwrpg0a/67AX7ZNkKymySx
    xwmSnnD6hmjf4pV796RJcYYzIkZp0tZChTOxvqkM8AT+/PU/0Y1fyg+z0TXNeVLs
    bpGJWEhhyVJf8Gj0M7PKhFOAoK4XVi7wsMe7Nrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519251960; bh=n
    GM7Y64hjEybKH6z9DNkMqV06OEOp8jPeMkKgsOBc8o=; b=cKNjiFL4K+coCh17Q
    tEvhLf8005wJ3Db/mbX/zFpbHStuJq4RJEp7WXpAwjO7kMTaVZ7Ed0DhK/XtLvAO
    JsHd4yyz4TkaSt9MjltrDxZEv9SvjyByaOaCRRMt+TcU1B9f54XbCu/XJqMioE/h
    T8jxqm1gLyJZMUS1PYjZtVWD2RAVT/5A/htPV/xm1FdadlS8SR3bHmw2SjIDKIUf
    wlXMS4Zl4ZRer8PXpzamgvrpbFpgr1fJ4nD7wDOOoLHAdiFi3fmwnKdWkf7oJZv9
    XyJ/Nj6YVEXaURSn25b+B7G17DNtbyP0w21c3JaP9KXqU9mEzcVyx/8KnBuuvIkV
    uyu9Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AYB2nRlr;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AYB2nRlr;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x2272egcD4J3PprQi0kXLnmpJ7eFC6fCdhQNtOcyHnfFygjIUeAYNlVpmI8t+x4IatwT9ab3LTw==
From: Laura Abbott <labbott@redhat.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCHv2 1/2] selftests: ion: Remove some prints
Date: Wed, 21 Feb 2018 14:25:42 -0800
Message-Id: <20180221222543.13633-2-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180221222543.13633-1-labbott@redhat.com>
References: <20180221222543.13633-1-labbott@redhat.com>
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
v2: No changes
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
