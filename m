Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1758260-1527157603-2-14933920567921915577
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
    1527157603; b=gIbzMrB9MWfa6K3YaRiomBe8XI8ZRx+BtMkGHqBVwyngrhK7rN
    PtkENlj6h63de4/8lNGFrrdJDgAbmK7i0sZcUk3VIhgNwr79V+mcbDmdDdx9JXg9
    AeIl/FPknz3DvcEIFnP3VRbWCiVPfBKbQtZ93gIOWEqzXcd09DT7ksugRCIrwWoH
    otIywuecu53AzvzR4Z8aNca+IhklYyqegqtzeuzKHowIJaLJb+6gylTS9WsY8Fgq
    EqeiYeUbaMrywGuoKGvEDzaUG+tqmt+4cBFCB4DwOIiAklRzEs6TmGl10k/43lG/
    xexAvxwFBSp2vBXF5xQ3oX+8IMsiG+XIFGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527157603; bh=x5JR7RnQKuYGc68WLy6Fbv1sm7/Qnk
    GRogEvEj+PZDk=; b=GB2tWbtsKDUSN0NgLUIP+Hc0FTBZK3vK0kChZngSnq9GZE
    7Ie8pi1LPLcQ5QNslk+LcBKMR/XfmBCKI0jN9rj7AUaXbW54TZWCsU1H8kFSVQWw
    mXP3WjmSJ/8zV5BK7ClEgOpU9BKBmu6DxPYjJu2qO2wD7/fqsGC5YMU46NK90KR6
    hSTVFnptQ2Fx1bJZOZhIURLkHz32umBYW5STqGbT0RlUQfV2Gd2Tey60um4I5Dcx
    oT35VSKKIOxPKOM79CFHvsSwN09ZFpl6NOXC50mDhOAJOo2deqimsvoPMmc4+aNS
    2L7UhtXgF0h4lHRAdDohW73LFslx1VMYhJYQXcAA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=nWeyRlzN x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=nWeyRlzN x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfMNlJlRDohBz9hsGm/0PkL7eoILXbbpNpG/NGxXFXwPagkDgMZexUqlcgJ2CbPTV91DDEh1v1vFWP1GeoWPsrexBlJD1mrkzL5a4G2yQ47MmRJccjcuz
    nqzk+Ez0UeLMbFW9fwFh+ewFVh5+x8AhKAYAxWixq71xNFEzD/3Egx17yJzBiqkjusTTsA6WVQAvrbfV8WHF/Lm/nYPxy4X05x+E/BMARoUaf4whOm87PE1P
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=JfrnYn6hAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=HtlbcJ_Q4UZFFvZ5v7sA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031480AbeEXK03 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:26:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031015AbeEXKB5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:01:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 070/161] usb: dwc3: Makefile: fix link error on randconfig
Date: Thu, 24 May 2018 11:38:15 +0200
Message-Id: <20180524093026.901898446@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
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

From: Felipe Balbi <felipe.balbi@linux.intel.com>

[ Upstream commit de948a74ad6f0eefddf36d765b8f2dd6df82caa0 ]

If building a kernel without FTRACE but with TRACING, dwc3.ko fails to
link due to missing trace events. Fix this by using the correct
Kconfig symbol on Makefile.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_USB_DWC3)			+= dwc3.o
 
 dwc3-y					:= core.o
 
-ifneq ($(CONFIG_FTRACE),)
+ifneq ($(CONFIG_TRACING),)
 	dwc3-y				+= trace.o
 endif
 
