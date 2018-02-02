Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591839-2-628033488992515214
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591838; b=PYMW7XNBbqhcw1fF1WxCbWIuk2mslIWEtUzy4PHrVHmfqIQ
    JuecrNnZqtPu6YzsOYzQIa0i7rYDiqatCoxd/NG+8tlcF7wgqY1a/ZCspOoluzhL
    Nl/M1WHWoWsdMRoiUaPZSjCz/KQ9dM86v/VBn/eeauWjDwLBFld2F+gc6z0uTYK4
    4Vv/8ZkGVEyuJRjBoEut7KNh+V6Huiqf9jFcDEsveJrMtRUj4BmFi+4hk/W4GR/x
    qkSqg6RmGNfbt9SHjx/4w68E49j5Isk/0gyv3dp+Ht1PIcnMFc4vZ1rrFUr5ZLf/
    A6PruFGhp/Ey6nSZiMBDqsfqqDCeFrOtE0qV3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591838; bh=aDrIUP8MYqdnHe4SOIOiHu5aUW
    KZZSmgieC3j7X/3Lc=; b=AB3j49wd/ZIsUX62TmyVv3ToosdrKAXsocvT62I6eF
    5wqFepHjm+R8sdb0ZnsxgMhz3MRgyfCQ0ZSuwYh3y0G1MCj4ZlK/3AkD932cMOPy
    axH/HPYkHp6t33KX5u72ETi6zmsShhUi2Qp2J7wUcpU/ZFAe/6LGtyAIvy2gF5tu
    Qy3wa86/yqUmxaPVT3cLBfR9oN7XSidXHViHP/LAEzcECxGfFWqjhHv3y+E8U36g
    p/4XVxZKHU55LZV2SdVGSrihpkf0pjzyjjxrU0+Jb/VlU6z/Ng507KLP4bL9MSRc
    nBHmG230qCmzJvFvsRRRl+qC9B3xxKYCLcT59lK0qnKw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753678AbeBBRRO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:17:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41170 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753156AbeBBRRM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:17:12 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.15 51/55] iio: chemical: ccs811: Fix output of IIO_CONCENTRATION channels
Date: Fri,  2 Feb 2018 17:59:09 +0100
Message-Id: <20180202140830.999369123@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>

commit 8f114acd4e1a9cfa05b70bcc4219bc88197b5c9b upstream.

in_concentration_raw should report, according to sysfs-bus-iio documentation,
a "Raw (unscaled no offset etc.) percentage reading of a substance."

Modify scale to convert from ppm/ppb to percentage:
1 ppm = 0.0001%
1 ppb = 0.0000001%

There is no offset needed to convert the ppm/ppb to percentage,
so remove offset from IIO_CONCENTRATION (IIO_MOD_CO2) channel.

Cc'd stable to reduce chance of userspace breakage in the long
run as we fix this wrong bit of ABI usage.

Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/chemical/ccs811.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -96,7 +96,6 @@ static const struct iio_chan_spec ccs811
 		.channel2 = IIO_MOD_CO2,
 		.modified = 1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_OFFSET) |
 				      BIT(IIO_CHAN_INFO_SCALE),
 		.scan_index = 0,
 		.scan_type = {
@@ -255,24 +254,18 @@ static int ccs811_read_raw(struct iio_de
 			switch (chan->channel2) {
 			case IIO_MOD_CO2:
 				*val = 0;
-				*val2 = 12834;
+				*val2 = 100;
 				return IIO_VAL_INT_PLUS_MICRO;
 			case IIO_MOD_VOC:
 				*val = 0;
-				*val2 = 84246;
-				return IIO_VAL_INT_PLUS_MICRO;
+				*val2 = 100;
+				return IIO_VAL_INT_PLUS_NANO;
 			default:
 				return -EINVAL;
 			}
 		default:
 			return -EINVAL;
 		}
-	case IIO_CHAN_INFO_OFFSET:
-		if (!(chan->type == IIO_CONCENTRATION &&
-		      chan->channel2 == IIO_MOD_CO2))
-			return -EINVAL;
-		*val = -400;
-		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
