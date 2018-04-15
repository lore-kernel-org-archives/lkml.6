Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1009161-1523815741-2-2484252671476622453
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523815741; b=PNgy5bLtbeqbCRjPpfsYhBU+prYGdXSWgyLbtPUBtM1/ksVjCC
    TgKiCSOxhEF5zb6WpSu9EFk/d9lpTYIuBJ+qjU4ii6Fsw1Q+uIE+c8SiwkmeOvdv
    zHo8K2amJPDFilqdsQSFQJFID2Ta1QAQb/gzfIsnAQfg1u1A9kyp7/y6WbHDe9qp
    qazymSf0ayYG/1Ga/kPFfMZHSgfHnvnEB62hIC48mV3A7vuHC8Kwmwaw2vif/gFf
    HtlPWXtTxcn6XEwsRPzfh+IV9Hi3Dr6NedW4pdOeGdOvtYQW/VPqV/6SgI0CqpUW
    NliUj3kFntad9AZF7rn0uBiIzmTzGgMZThvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523815741; bh=DEOJX
    7r51WLjXsTR+o3gsvJJrfIt6/9X8SBIZ1E2ZoA=; b=ug4TXs/vIzDZvLm4/MKCl
    2TRD5sNvVuaLpopZNUqkbzKFesY1pLP4zzLAzUpj/O0dwrUbyQ4mxQwkiUf6K5NE
    F/ojGEndKvgHuCWKr85HJC4Si28J82fMxl/ZEYqV7Rri1tnQ6vVbbY15SdaASdx0
    bidGsN76U7UpEBJDhV+//DtFvvAT/H9ZMMncZEmKKsx2mt7rApVWucelSjrjzD6b
    yIOibynaagAtN7jGaNplvzzAHEyfGp152cQZetII+Q4tfAC9X+fkcsQ0pGd4N0lO
    vzDvtZdtbmXL64myvRfm4qRtKEzzvnlECzf3sONyCn6QtdUvtMb9BufpQ0zNUvbm
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=E+fxU0qt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ro6xYT8U;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=E+fxU0qt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ro6xYT8U;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE2M4r2cqaFzYnb8JFCicc9RAfAyPTTr6LZd7SukzXVIZ/rmjlSFmRf/aCTOym2pCx/QuBE+gZ4KPM8gs76CX7T7iYuZg1eFKwxVS7gHi+UfwlZPlAZU
    ODjeYqY1teAlqQKgSJnHRNIrK6CEE/S80bfTLDy7hPFvJN0Poj6R/Pyb5mB6aL9ZgZu2tA5rgHT0AvIDnWISchdkzJWi+qNSxM+E69IqyvOfZ83S6osXybYV
    Zp0TLjbUz0E3qGD9v5snRQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=oFiBeRr11AUA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=xOnVCH4iesp3lWdZ7IYA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx49Xmae+VnKkH3kxvLnN7+3DuO7+X/bp5MYoOiwzD2fPHfnFyHjgP/M5VGqd0gkPJbnOHql5Pw==
Date: Sun, 15 Apr 2018 15:08:42 -0300
From: Daniel Junho <djunho@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] staging: vboxvideo: Fix line size exceeding 80 columns.
Message-ID: <20180415180842.kfoxhnm6ys5vtokw@djunho-Latitude-E6410>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
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
Cc: devel@driverdev.osuosl.org, lkcamp@lists.libreplanetbr.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch fixes the checkpatch.pl warning:

WARNING: line over 80 characters
+               vbva = (void __force *)vbox->vbva_buffers + i *
VBVA_MIN_BUFFER_SIZE;

Signed-off-by: Daniel Junho <djunho@gmail.com>
---
 drivers/staging/vboxvideo/vbox_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vboxvideo/vbox_main.c b/drivers/staging/vboxvideo/vbox_main.c
index 973b3bcc04b1..9d2018cd544e 100644
--- a/drivers/staging/vboxvideo/vbox_main.c
+++ b/drivers/staging/vboxvideo/vbox_main.c
@@ -61,7 +61,8 @@ void vbox_enable_accel(struct vbox_private *vbox)
 		if (vbox->vbva_info[i].vbva)
 			continue;
 
-		vbva = (void __force *)vbox->vbva_buffers + i * VBVA_MIN_BUFFER_SIZE;
+		vbva = (void __force *)vbox->vbva_buffers +
+			i * VBVA_MIN_BUFFER_SIZE;
 		if (!vbva_enable(&vbox->vbva_info[i],
 				 vbox->guest_pool, vbva, i)) {
 			/* very old host or driver error. */
-- 
2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
