Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1474721-1526333729-2-14534414828757365960
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526333729; b=LqORRfRTRKs4XHHcaS1L1pG9RHOqia9M9DK11ppu7Dnflvgwg4
    0pLvKcwhcyytMPUq0XY5T/3VFg1smVLmQkG4d1YRpVH7z/t5HtibAA3gN5ET8k1E
    Nw6nQsaM6Mp12tdd0xCtsu6iMVIYgqNyvGmcATt+JhNnxY7flFLTtHcN3XnnnY1F
    lHIIZZ2SlLIlB29wm73N3XUAVnnkMj0d0ELueFsm6hjiwx8so//DlnETL3VEyd1U
    DoD1t3VocSUjtgJAX/vEYqL8tBu04M7oXg/cxFWUynZfRS4VtkGu2uQ46BN5AyxQ
    ID/BgwQGqvqMVCLjs05Ts7ivZkSyDn5wQFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333729; bh=nqbzD
    1aNdAhofjUCnG7ohd8qcdrSQo8Ean60uqhjads=; b=EvubKZ6d/DaSnIYZQhi2f
    BAjfz2NXQFOSycx8PEzMVddsPJZ/Qr0QUnIr+h7uF8IxlBTEunzD3SILBvFjc7f4
    DJ5NQrT/LOiHtytjhm6dzFb0UcK9oudFtzayPruAHsNWDa7RK4vYZhY7KWuYQ0fQ
    7ZQUMUJ8qrLgIhcZvf7R5fMwNz8fLQnQZcokHYEctGYkZxpXGpKkkW4p1oMyJMos
    JmxMQXaamW7/mrZ6HA1foOgxtrnFKhCuBGL3nyelI0Mm6gSXLS7C1ZCX21vlEY95
    idTY9EDQRGvOiIir/EjHE0+eJiLqt50pMg9dYdqq/TRmEKfzudy2hkhEPrubImLv
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=J4BkS+0I;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=redhat.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=J4BkS+0I;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=redhat.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMUBrN6DeGeq5bawag51eu7BP1NHvilY1kPZSSs6bu3tUcK5lQ9ozZKyKGSLBcYqXkBGazlotVNlPOB1n2NWdZ5aZKDPoYrWCroN/EY0AVl1IWQeoC9v
    TL6YoPGBVPbLXYpIFeqSdH+KZlJFrEkHVtm8znLgQRDiXwdmehgi1HavLwTfVJOXAV8CJyPc3Tqh1RoML68eDrvfYVC+Zsxqz22JCChiEZoOYTJhXYOqba+r
    w/FA5hgGmUNCzjnDuMR8nA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=hSkVLCK3AAAA:8
    a=4RBUngkUAAAA:8 a=20KFwNOVAAAA:8 a=DDOyTI_5AAAA:8 a=kisfkIdBKPTy4GAyi1cA:9
    a=CjuIK1q_8ugA:10 a=cQPPKAXgyycSBL8etih5:22 a=_sbA2Q-Kp09kWB8D3iXc:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZr0NHv1oVwhG0Z1QZojr9kCbxU4jlTKf9Qnsv43SP9/f0QQyacrsMr2zyiSrkQkBMYQiyM3bA==
From: Laura Abbott <labbott@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH] staging: android: ion: Switch to pr_warn_once in
 ion_buffer_destroy
Date: Mon, 14 May 2018 14:35:09 -0700
Message-Id: <20180514213509.25171-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.0
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
 LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Martijn Coenen <maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Syzbot reported yet another warning with Ion:

WARNING: CPU: 0 PID: 1467 at drivers/staging/android/ion/ion.c:122
ion_buffer_destroy+0xd4/0x190 drivers/staging/android/ion/ion.c:122
Kernel panic - not syncing: panic_on_warn set ...

This is catching that a buffer was freed with an existing kernel mapping
still present. This can be easily be triggered from userspace by calling
DMA_BUF_SYNC_START without calling DMA_BUF_SYNC_END. Switch to a single
pr_warn_once to indicate the error without being disruptive.

Reported-by: syzbot+cd8bcd40cb049efa2770@syzkaller.appspotmail.com
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/staging/android/ion/ion.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index e74db7902549..a68329411b29 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -114,8 +114,11 @@ static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
 
 void ion_buffer_destroy(struct ion_buffer *buffer)
 {
-	if (WARN_ON(buffer->kmap_cnt > 0))
+	if (buffer->kmap_cnt > 0) {
+		pr_warn_once("%s: buffer still mapped in the kernel\n",
+			     __func__);
 		buffer->heap->ops->unmap_kernel(buffer->heap, buffer);
+	}
 	buffer->heap->ops->free(buffer);
 	kfree(buffer);
 }
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
