Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4087485-1525655943-2-15670799020307224184
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525655942; b=HoNCW8vyPZl9DXbVIG7o0EEYVPpZaIBslZbje9U6aaJsHVc7IP
    5d3CfZvnl4Ot6geA8rIVZVTj0s42X5+F+dE8WK12C9HrDKP+DAAH2q7n1VI40dWF
    eBOImVmmLFOD4HebP7yUTt0PdoPVZxo83H3sSrXSzROE5Kltx0wTNSkIG6u65N6b
    XpEXIN4ITjZFvh2SsMIATw9bfcQSMpxeywk7TT/QVCJAiW8F/7BDK4q0iGYliz/x
    WesV5McQkChYxTM15Ixn+HSCvCnWr/zqPyvgst55GZ9zDZvTyU0k7Xb4MUs8R49n
    wXw5ISTq1p2e+lfGNBPL9kZEhVrZlbze4l/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525655942; bh=rUCfQ
    zFKrlfQd4DUI5b6lD6G631QdNVLHLK7FZtAacw=; b=RRkJHjNvdbNgTt8RtMB4h
    R6ihTI6q7IjcjLuCiLxBHXsNTv0z01c6ux4xRjIbBcQmv9z1Ac5FnZUuSUp/Hkt1
    MhFBluR61iwr7L/UW5gw7623ujTifyVzSKb0bthVt2CixnswzJF69kH7l8cj+PAF
    A4Mp86k/scrFUv2lNTKXgXHiTqxdAqdfotR5woXHy3mrlRV2jJAJAYZaJOB2Wpze
    aLR0GtARiF2cSdtZnXI1nT4RPLXCbwUMiEruZ62Uv6x+ShY/19eyFhSol4wPwE6O
    adKsQFIYZt7+yznbQB48cnTqyb4k8+QLOT9WeoRnr3+oTNSOQlyEGsI4evSQIILr
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=OVOkHJEf x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=jBb7LIzq;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=OVOkHJEf x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=jBb7LIzq;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH1egt01YUUdlAXzH1fJU9BatMKKA5DaOYv/iANXjW6iW50a3097PZo78McFhdMkhH4CJs++eYJv8Z92U3ZKzCrk6ILHjYtaRaAvP5fXpbzUoDfSiC7f
    yFUToSIF60dUbgLGb5a7353m3WyQ0vYd2Lym/l1kv3w44KihcZ2UMl0iD9OiToici8W+umPrxwd2DBpnBxfW/qMjVw2/uRIjjf6JNpuJEnq+291atPcMoUnu
    sjxzosxZzIQJXgJjodIlww==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=MwIa9BDJGTSEi3Ny7j4A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZrlKcY5N1MdWzdVQUY5XEw7VfEc6by/PqyC1TsR5zyXfVae8E82pMMQSeLM/g1f/Um/qXLlbA==
From: Nathan Chancellor <natechancellor@gmail.com>
To: devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH 2/2] staging: android: ion: Remove unnecessary blank line
Date: Sun,  6 May 2018 18:18:54 -0700
Message-Id: <20180507011854.12627-2-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180507011854.12627-1-natechancellor@gmail.com>
References: <20180507011854.12627-1-natechancellor@gmail.com>
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
Cc: Todd Kjos <tkjos@android.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Martijn Coenen <maco@android.com>, Sumit Semwal <sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes a checkpatch.pl warning.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Laura Abbott <labbott@redhat.com>
---
 drivers/staging/android/ion/ion.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 269a431646be..d10b60fe4a29 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -95,7 +95,6 @@ static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
 		goto err1;
 	}
 
-
 	INIT_LIST_HEAD(&buffer->attachments);
 	mutex_init(&buffer->lock);
 	mutex_lock(&dev->buffer_lock);
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
