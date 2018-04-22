Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524405676-2-5134724328252153679
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524405675; b=XGFreevzvgjT70xGjg3OUSs+b5sNCY3rYl+MbUuvhLFH0O66Fg
    V7cf9buLqFBJi6talTZZneT+0uuMkh1DXzEPq1FC3aotKdwpjWnHRX5ylUFrwXjh
    8FASCkg34B4TY7xNw6CjxavUiLqS8vSxSgHEyv7FzQW6m8DhXWzMblAMHCq3u5h2
    DnTRKZhnxyLWUTGHaq3F1F3zwjydDhyAerjjfFohfCbj4dS7dwPP8qy0a3SJp7jW
    gEt9bqCf8LEnf8Bcy2byc+V+2Fv5qQ/sEGb+PUprAG8G5DC30ReXnBPIolARoZ+t
    R7X074opK+1bAdrTEJf+NqsUPNg4uCl2ItGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405675; bh=fNaEqOl443OZw5fSmYIapLt2Agju11
    1C/cz9JeLdvxE=; b=r5UzegkAlID7lmYYtnnFWQ0m/TsfFT+xvbkfzg2Icj9nCd
    99MDMeuJHUjq7s8SdeIgz/IMdLognZa65V6CZ6hOcOJrQqGlCiqwrN2KH2CH5tKh
    OCXIlhpfGyVrCmorxU8kZ7AIl9Duorgp7q7Oub9HYjew3eg+Q2admXyjxoeAVHwu
    ZXgQru6bY4H+0ttJ3OdutN9pK5l8cJB67vFWSXRpzNS+JbVbY89TdlKB2ohq1l8I
    2BlARWBSogmXl79Mu4mrkof3Clb/uYkpykEpYeY3ZLX4MSoX+m/AOBFoPYmz6KH8
    Cd+dWpz4w8/Ku55Y3B0Hzv15W+zVdhENbZjJvzqA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfCf+VWbvvdG4K0uSop9TsttW3by/qdbdj12uBQqXZF6JFWsK/Dk2nY/T+2IGbAmS0pBM2cdpOVtAqpkGip5SZU+vVoRq50tqiWLhVeXn/S6kRjRVBiXW
    VLzDMZB7FXdE78UQC6SIKZIG2G9ydKh/uwanya54kVIQ7CxjHbtTUcA63XTrc6P/316dOZwLyl0wPMkyQqCsLa1T/mpJzW9/Mmvig4oB31AlhB9BRjYCCXgr
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=zd2uoN0lAAAA:8 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=1ovJ5eJvCVTbVPaWQJkA:9 a=QEXdDO2ut3YA:10 a=Vxmtnl_E_bksehYqCbjh:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754672AbeDVOBL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:01:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47814 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754664AbeDVOBJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:01:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.16 150/196] drm/amdgpu: Add an ATPX quirk for hybrid laptop
Date: Sun, 22 Apr 2018 15:52:50 +0200
Message-Id: <20180422135112.002289720@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
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
 
