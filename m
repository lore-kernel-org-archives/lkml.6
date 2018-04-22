Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406125-2-695049166234261301
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES daen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406124; b=Yl0OwpQmp/KQrkhDoQGgnO6hF7QlRdwR8GsZuSX+cC72Htw9fq
    tDRs4LRhFo6DKIaFl9ESoHnjX7cyRjoM06m1Eh5LplEI9GA6q6A0qjJMp+kOpI9c
    Esgv3lSw6KVd6dR6I+u8NRSgqJX6p/MIRLVg5PVaFTO8N30DZPgyP6iPNJLDwB18
    ioMMOpPFyTGOz+zYQtxdlVTQzJ+wbdDFe0fRG8E0VEH1fO73qDsVsAPng6q0zbS6
    U69wMOAkhKcvavpT+oYKL/BDm9inTRHYyzuVSJuZy86112uCOGuyPHM9sjo+q+ph
    t/EhnuLW7o/ABIFGh2qG4KhFhPasI5KlCOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406124; bh=tnZp2Kb8vHrFRf19gMz9zK+9EckfiD
    VgDV6W2+qop7A=; b=L1+gvkKC8sZBrrsZkPHfUmkyMuSzx/kbV6/DD5yvvMbC1A
    /F/D8+PlKnRRkcnByStRh5mMipeZ5WTrOQv4sETO7GzXIdNTrzJGl5XV9BgmoE/Z
    s4wVjv0FYgEDd6HIl3Y7s4NSOT6szznJoBGo3/lEh7onxaAsQ8YeMFpDv81zg0Te
    1rDkKXSBxez8Mko8yRctoe+poCV0VQKFTxDd6K2TH0eZ0O6X50uIsXEMeePcZ/HH
    dMZEnoR1jv3URUFQL7l0WIofhT234JlZx0+AneS+hDS8vahrdzd7VuerA6mw9l0b
    2JOtuxKpGtyaL2A44W24hJ8RDVwon9Knm5urNHag==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEfO3Zmwm3WR2SQ3sdWYNY0X9F1D2q4vUqXXURQj50Od1Co5q5irAto62Jhq0GyAnTKmgumfI8vSybaeloyvfXAM3dnjgXTDK/2PSSTdpDmmHMG0QWMU
    2e6YxG9MVBVwcrjol5dW734MiAM5u1CWubtw0kR1uXQ8AnRUbbIT6Mh2sqwQ+nMr/9PfsUuNvtK6sPy77Y7MhxloV7qRuwut2ZlAxl2PP8V4LfXuZtJxjVZT
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=zd2uoN0lAAAA:8 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=1ovJ5eJvCVTbVPaWQJkA:9 a=QEXdDO2ut3YA:10 a=Vxmtnl_E_bksehYqCbjh:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755744AbeDVOIl (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:08:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52458 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755730AbeDVOIi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:08:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 120/164] drm/amdgpu: Add an ATPX quirk for hybrid laptop
Date: Sun, 22 Apr 2018 15:53:07 +0200
Message-Id: <20180422135140.321033890@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
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

From: Alex Deucher <alexander.deucher@amd.com>

commit 13b40935cf64f59b93cf1c716a2033488e5a228c upstream.

_PR3 doesn't seem to work properly, use ATPX instead.

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=104064
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -569,6 +569,7 @@ static const struct amdgpu_px_quirk amdg
 	{ 0x1002, 0x6900, 0x1002, 0x0124, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0x1002, 0x6900, 0x1028, 0x0812, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0x1002, 0x6900, 0x1028, 0x0813, AMDGPU_PX_QUIRK_FORCE_ATPX },
+	{ 0x1002, 0x67DF, 0x1028, 0x0774, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0, 0, 0, 0, 0 },
 };
 
