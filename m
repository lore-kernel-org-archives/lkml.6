Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2676370-1525981373-2-3998800848927544203
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525981372; b=gqTWZgpQUxgH05+twv7wFUyM5zABNp3eQL3k4YYvsdSHs/qEfy
    ndHJbDosxchOkdMYU5KTnyQs3CWXr5doUzyxDXY39O1x8LqQ/v19ydXAcbSSiPLF
    Ezatz7lguLt15K1Ab32+4qc2m3fXbudYTw7Gv5E2tT20ShfoMoIwUzS9TjooyzjI
    t9PNynREmhP7As9JPLPlDtop6BBX3HeyKEMfDuVw6W73AcZjc02U5br7eHwZPa+0
    lBA2nLRkTIoGvEfEOueIFQvVlde7/I6o8xqLq22iBzJM2kRV7QlCbG0lG0j4pLGC
    qbg7IWMfn0V9YzEehj6nc3eleAkIsyFkK1EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525981372; bh=F/Ny6
    naOIF3fcrj5sFOv6LH7AsSVlbx36dTxkQTP7+o=; b=QLUTaZqLt0G/sVB2v4J3L
    8K7CkbauxsBNgGwApgAad3nAwDG+18mW7yZVNUDd6F7FRJmT+79AhMefzQipNvsD
    kAu/+JijSo/wkgeFXIWoenrpnTImzNaNBfR+uu1OtIECKtjTpVgcoJwcc/A6adYG
    D8y+fAcXHMkoZwteHjxGUVPmw/smaUiruKo6xhEbN4WjTs75IV1jx53nbekrF2YM
    6F4JVXzAFcY3ZwIMSlnykAPzDZQynVxstNh7oXSctSepJKiPQRYX7z+5+caOtW6K
    oTa97tLV2Dm4S0gEksEHeFFaSdPkl2JEtQcn9HZwZ+cGFoXxpC+GL+iOoEfwTEVb
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHEjFRV1bjSnTlCxHH8nkROJQx0pBMnECpa48STSkmMpnrWtww6hSx5/IKNU8qtd1o2Exnu8Uw+o6AcpvURt4vuUxB/sv08ZNFl9F8ScRwR2Vkx4LeX1
    U7fZPhPmrf9YHzUcuorlFjY7GJyI2YCq8iZj0hj2M8wRJJKUGuK88HLwcA0GUGsi5jYj2hyVPmpWLwGRhlF2E0xcr9tfphWqtcmrzkej2Z7Jb3E6fmVYDsMC
    ERNZ26vMnpeJrfO3BmsoEg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=WFZIRff2AAAA:8 a=-VAfIpHNAAAA:8
    a=DDOyTI_5AAAA:8 a=KWyNAHtvoOK4y_B08nIA:9 a=CjuIK1q_8ugA:10
    a=srlwD-8ojaedGGhPAyx8:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 08/15] staging: bcm2835-camera: Add multiple include protection
Date: Thu, 10 May 2018 12:42:12 -0700
Message-Id: <20180510194220.30675-9-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510194220.30675-1-eric@anholt.net>
References: <20180510194220.30675-1-eric@anholt.net>
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
Cc: Eric Anholt <eric@anholt.net>,
 Dave Stevenson <dave.stevenson@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

mmal-parameters.h didn't have the normal

...

protection to stop it being included multiple times.  Add it.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../staging/vc04_services/bcm2835-camera/mmal-parameters.h   | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-parameters.h b/drivers/staging/vc04_services/bcm2835-camera/mmal-parameters.h
index 1607bc4c0347..3dc50593a665 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-parameters.h
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-parameters.h
@@ -18,6 +18,9 @@
  * @{
  */
 
+#ifndef __MMAL_PARAMETERS_H
+#define __MMAL_PARAMETERS_H
+
 /** Common parameter ID group, used with many types of component. */
 #define MMAL_PARAMETER_GROUP_COMMON            (0<<16)
 /** Camera-specific parameter ID group. */
@@ -682,3 +685,5 @@ struct mmal_parameter_camera_info_t {
 	struct mmal_parameter_camera_info_flash_t
 				flashes[MMAL_PARAMETER_CAMERA_INFO_MAX_FLASHES];
 };
+
+#endif
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
