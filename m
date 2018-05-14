Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526281378-2-16967026750575187178
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281377; b=XcFagfUp3/GAChAn0azzgDSFmbn4sOGU+cIybAgDMsZkb/1k2K
    TI7VGQwZnACLoIXFqAjEn58RqBJyMFLJPVaUGGxS/evbXJBZQWCmiSi+RV4K8PAY
    K5XKZADzmX9nXFKkIEtOzYntgWM67x/Qdv5r0bxvUPpGGrr2FNlZE3PLS3aZBAkC
    bM9il/nCZEPtwYpOY6sHKkLwToxfy8GTb8LgSUCDu9zDBQdzZDGVbQX8hipjQD4A
    p6+B5IlpYKwukShOZXK/oybZ+uxPBlNfg9FEl4ezmAXIIQE4qpkxEI+RzBKjfzuU
    o+0hk0uj1TJDAuthLh2ijnHFCs0B450uZVlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526281377; bh=D27wHOh2W+gd0KhE9/H4vhxGHjySAb
    VyTuwsRhJMeuQ=; b=ADLDQenEoNu9BUUSzR0UbZC6197x6qHTRyc3gLR8d+FHjS
    RVhXcD645Ki6F9zgW+k1zX8KlJR7zcpTyPo1eQ87XrLOe2K9I9iSTjgWHUF8ee2F
    AAX1dr0cZMwa782dVxn4mrGc0pwJF++ld/feFCGhZs8oL3ZBH/OuehjWhOY12RqE
    3zHZ5tkpRoPsxPVa7IIKNn4b7EKaT61NFaObIH4XISmQ/f8OCZzDXRmIZ+Sv6MQj
    0YIF31gTTCoxhQwTrKghlyAcxjyLXbu//gSKuVrleOgS0nrLr4S9WmEwjljVm77b
    d8JUe0nXTEL3ex9A6BV6VidVH9pFtBal4xXDWJYw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=cfd2Muek x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=cfd2Muek x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFUZ4YA8AAN/s7W/f0TMUOgEXGJgDzikJxnXPeuh/lJQzzM0bXJ3qWT/GV9viVcMLZdWB06MxePx3ldTkfVkAy8b6hSL9RWNC2MVaHJx5fEWoKq0KBPT
    OYRC1bNPKvVZCpRR3q1F25R+YeikFT31oxVRh09yMuBOEX7F8zAa+BG9iqTsAN3yU25m67qqTtCGVVgHi5dxejHVoc1A8VYMsEA5+3omnbjsS2qQ4LIED4OQ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8
    a=KRWfvM35QsivoisIQukA:9 a=QEXdDO2ut3YA:10 a=HUqATDVKn4QA:10 a=HUwBG1PIX8wA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=hdz0HP1aBki3x1LR5Ig0:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754169AbeENHAZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754161AbeENHAW (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 03:00:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 4.16 34/72] ceph: fix rsize/wsize capping in ceph_direct_read_write()
Date: Mon, 14 May 2018 08:48:51 +0200
Message-Id: <20180514064824.595090385@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit 3a15b38fd2efc1d648cb33186bf71e9138c93491 upstream.

rsize/wsize cap should be applied before ceph_osdc_new_request() is
called.  Otherwise, if the size is limited by the cap instead of the
stripe unit, ceph_osdc_new_request() would setup an extent op that is
bigger than what dio_get_pages_alloc() would pin and add to the page
vector, triggering asserts in the messenger.

Cc: stable@vger.kernel.org
Fixes: 95cca2b44e54 ("ceph: limit osd write size")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/file.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -878,6 +878,11 @@ ceph_direct_read_write(struct kiocb *ioc
 		size_t start = 0;
 		ssize_t len;
 
+		if (write)
+			size = min_t(u64, size, fsc->mount_options->wsize);
+		else
+			size = min_t(u64, size, fsc->mount_options->rsize);
+
 		vino = ceph_vino(inode);
 		req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
 					    vino, pos, &size, 0,
@@ -893,11 +898,6 @@ ceph_direct_read_write(struct kiocb *ioc
 			break;
 		}
 
-		if (write)
-			size = min_t(u64, size, fsc->mount_options->wsize);
-		else
-			size = min_t(u64, size, fsc->mount_options->rsize);
-
 		len = size;
 		pages = dio_get_pages_alloc(iter, len, &start, &num_pages);
 		if (IS_ERR(pages)) {
