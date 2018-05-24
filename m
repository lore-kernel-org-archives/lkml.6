Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527160878-2-15475799802824965865
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
    1527160878; b=UQgb+HeoVcQh6nRrgQLcHVX0E0ApQh0vD5tvDSlA9++pCww3x7
    8/zoTslcnWyi9bsGTH+ucwjmkCzVLE+ta7XN5Ab7LON68vs7AmnaJ+fyELXODUy3
    7Od3Vcety9tsBzVtvBqpxSegMDM5vmItQb/acjm1UPVjW0TgFo03X6pLWlrN2PG/
    QEq3IFd1u+/SiwYgw+2lSrD9ADtx5ClESAnfhAmet0ix4lHUvfu02ncG2FcuN0OB
    vA/s5xREbfHFJ/34b9gWFysdapvc7YfogvzCWtpZQk4hXxoRbo4gcGeb1L6xihAF
    EnJzPuslZ+bIWwqwAuH7ZAg4+/33ooBRFpnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160878; bh=mlDYV8LHY2izse1JYSdt4naG7CFWHl
    8c6raHyMd4qiQ=; b=avOO9jfco1XvI0DEj7P8JNXSqUqp4svkcEx1II8E9sZdmC
    wjJ6PKuEQcIvOhwUwfYdRgADLtwz0t2Kf5ATVrRFYxuaMtE7PUoVWa5iHP7wh2o0
    1NqcfHqwAiNHqCDZKxSGhCbhOagLmT8Ys6xOKgEYPBuKSms0Zb4C+/Hm5vPwrJIr
    N7bKA4cy0F2kKEmn4PObztQH79Va5XU3s87R0GvhfjYGy0XavjbOUEBI6Wg50pVP
    dnxQWdMHsKLxuuOFihBXGH678TWmsCD1I1d+mT1vCF/yhIT3qAGF/Kb6HMAQbHPj
    StphVRtnwAkx/JiiApfYwsj1Hs885N4r47njK78w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=i35rkWN2 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=i35rkWN2 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfN9XCenFL0mV8xLF2Mn0l74ogQ5A3mns/ow9ZZSjSfghRx0lHQBFNVd2MEkuILZ/SbqR+KGZGEghuIMqcLZuXWVjH8I+EpEN3W+sKC0LDT1MfyCJtnbd
    OV/4Ct5sdzQyhXUpxWoA2xcJ1Z72hD+glE9Hi4yuPGF3Es7PQAba9e3YmMMeMUdfflUeCnMiwgKkC3iNR6GXKVUvRUIyatAP9qox9P/QgEg/cdmUTMXIVmxh
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=NTFMMAV7LSwOL6p3xP4A:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967955AbeEXLVD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:21:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967891AbeEXJwg (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:52:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mohammed Gamal <mgamal@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 031/165] hv_netvsc: Use Windows version instead of NVSP version on GPAD teardown
Date: Thu, 24 May 2018 11:37:17 +0200
Message-Id: <20180524093623.233619150@linuxfoundation.org>
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

commit 2afc5d61a7197de25a61f54ea4ecfb4cb62b1d42A upstram

When changing network interface settings, Windows guests
older than WS2016 can no longer shutdown. This was addressed
by commit 0ef58b0a05c12 ("hv_netvsc: change GPAD teardown order
on older versions"), however the issue also occurs on WS2012
guests that share NVSP protocol versions with WS2016 guests.
Hence we use Windows version directly to differentiate them.

Fixes: 0ef58b0a05c12 ("hv_netvsc: change GPAD teardown order on older versions")
Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -569,13 +569,13 @@ void netvsc_device_remove(struct hv_devi
 	netdev_dbg(ndev, "net device safe to remove\n");
 
 	/* older versions require that buffer be revoked before close */
-	if (net_device->nvsp_version < NVSP_PROTOCOL_VERSION_4)
+	if (vmbus_proto_version < VERSION_WIN10)
 		netvsc_teardown_gpadl(device, net_device);
 
 	/* Now, we can close the channel safely */
 	vmbus_close(device->channel);
 
-	if (net_device->nvsp_version >= NVSP_PROTOCOL_VERSION_4)
+	if (vmbus_proto_version >= VERSION_WIN10)
 		netvsc_teardown_gpadl(device, net_device);
 
 	/* Release all resources */
