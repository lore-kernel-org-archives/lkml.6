Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527160784-2-12732242230827501910
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527160784; b=Qs/kPf52c93Spi57TRghmsjIZEFGKv1RewxfpLhKwuZXBibm/2
    u8y3TC+HCCpNLsdr3MPlCkGS/kC4+HUTVmHCGwJxWPTCKxa/kZiwK3wqZUHssnb8
    5R+dRM+q/UNMOK/vFgox6G0jArtTVSBTELIxGe07mbD4jfBkmwTydvfetZpJDZo1
    dLpeGFCD1I2EwP0hFsGvBr5HYnxisDIeEpRr6ttQDqofKcx1/0voTiSMBDdLoYvq
    weGz0jWtqgvBCcYugexzZfzurkLRO60CRKEW4E3Jxymga0Lg0CbNzfgRIa7dX5ml
    rsJ5/BgKPiVOn5QtiUtlSzC2c6etGM/t6YIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160784; bh=gAxwZcFUA4YEfwJpO5UpoQStd0WAtd
    0jsfV9NDZAo7g=; b=BXIzTpPxX6LaPLFa8I8aVac0m9XilnqiVpSFXlmt/A3xIw
    yJ4RfPyYPC4nI0ohFdYvyPsc5V9pfKnsMpsgAXeKjj/wVTzRjvAghQE3r0wtRP4x
    HHvKmsLAMdjj0W9ab0wtTOFtQZD6z/9IqDJHUDJNz+dcUnaNEgmBHrib7UuY/vLh
    tjY9erYoeOOCuQAq3OFnksFTDeH0Wx89VynH0K72GAJSMKnFKi0oqP8gFFtt4K7t
    Nq/y1zPeXG7ln0OXQjlGNmuSu2GZH0+jekRKLDlOr05RN3/LPRklvRnP83tfbEUj
    n2yolsFblA1se5X2SMYY9tfET6fTPV+Fp8UyoctQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ScaXWmit x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=ScaXWmit x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfHyKuMBWnaDSVo0coQvpEnNpP3dMG7S63zbiFd06KNeVGzmbAFKuWS+xg9w2awTOREpu2ArgLfX2S/jgKvmnrZLty9lTK5eQ9LWQ3Z/B5zjbcQOIaZlw
    zesRhUNgCB5DE3qW8Bo/0/NLsg4tZOsNEs/eijUzdxa1Pwy7PasISNwk4ovlSiaQDbWmbpeK276RaPy36n4MCrbeHW7kaehBas2F6m2wcYKnj6h9U0yEPPD+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=vK4zaOes0TvFME1_7LIA:9 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967615AbeEXLTk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:19:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967925AbeEXJwq (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:52:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mohammed Gamal <mgamal@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 034/165] hv_netvsc: Fix net device attach on older Windows hosts
Date: Thu, 24 May 2018 11:37:20 +0200
Message-Id: <20180524093623.353204390@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohammed Gamal <mgamal@redhat.com>

[ Commit 55be9f25be1ca5bda75c39808fc77e42691bc07f upstream. ]

On older windows hosts the net_device instance is returned to
the caller of rndis_filter_device_add() without having the presence
bit set first. This would cause any subsequent calls to network device
operations (e.g. MTU change, channel change) to fail after the device
is detached once, returning -ENODEV.

Instead of returning the device instabce, we take the exit path where
we call netif_device_attach()

Fixes: 7b2ee50c0cd5 ("hv_netvsc: common detach logic")
Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
Reviewed-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/rndis_filter.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1276,7 +1276,7 @@ struct netvsc_device *rndis_filter_devic
 		   rndis_device->link_state ? "down" : "up");
 
 	if (net_device->nvsp_version < NVSP_PROTOCOL_VERSION_5)
-		return net_device;
+		goto out;
 
 	rndis_filter_query_link_speed(rndis_device, net_device);
 
