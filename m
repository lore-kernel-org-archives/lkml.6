Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-22565-1522168867-2-4884020168095023434
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522168867; b=DtNwfnJLmgDtiT2aI3vf4NOI4tF32PKMZ3lSU8pTVkTAgxU
    4LXvGp83EuVh+IvVeVZ7ZRSbexU+7cs8VJem4mPR9F+y4MdRQmuwEjw1yi9kYaC7
    o1QS3pIXmm0QSIAibjf96ZpILB4LYaRPsJd4m4gc+UWuAHOpbzyxH/F422lkprEE
    oCUj9CJRPc22xiJVGhbTiZMdReo0Uw/QLu2us9YgPL6dNCHRNcn5GsY6ql+xK351
    EZ7hbSh18D0vSDa4p7KggKtJW4CWOyJldaxO89T9Xr2nORsZ+1/EiomjbHOsnrbT
    /zU9Nl31viSWHhirUYRvS35y+DpXD+0tFJIf1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522168867; bh=K41au4u/6CAu6LmQHVlHUmp4kK
    aS/y6NNDT3bQIqDO0=; b=f9LDs1mNIintagFtj+0vDD4O7UGP4f/j6XqsC8LqCW
    uR3D1nfIyPvS7eL65NcxDEL5yU8k8aTPkNtYJHWatXF6igPdF3avOW3N5w1OJg/Z
    t4rlhJGblz+qmUVqB13auDDaZMpjjABHoPwo8ELDaA1EBJwYvTTI/dhb2Jf0laJ2
    Bui1EaOBHi1k9T8idn08pby9/hIwuf717IWT8NJOmsoJuzhwgv3wdQfjBTdf8MzH
    zmv+PCfJHGfCc2ZesCJIYvi2t/tNj+HpMm5RypANOSNdkfil5rW9/y7TMFcqkuTk
    0/A4oJJlyI0ljxas5IvdEwjk6SBZKyb5L+yApVrloRZQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfPKG+dM4Rm+2nie3Y2dhLiybJ8CGUBaMgQkZ0TrKXPGp9cw5xMIxyDLqcdIRMUpXu3EvdJ7ydyQezV6r4oB/9+/vxNlX4tURROU+gUoM6DUKHN9G60c1
    7lPDCSjpZDBHVOwRnI9nFv4mUKPieI+q2TA1g8fr+EKOc3CP10JPr2T0LlahTknZomwkSDUqKD2Py02zaeepRqlDtzeTi2ujjVYFD9euntPfM4X+XH38P7Sp
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=DSkIZ9S5f_qbzkZLzQQA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932459AbeC0QlE (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:41:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48558 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932218AbeC0QlB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:41:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.15 058/105] drm/amd/display: We shouldnt set format_default on plane as atomic driver
Date: Tue, 27 Mar 2018 18:27:38 +0200
Message-Id: <20180327162801.019334252@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harry Wentland <harry.wentland@amd.com>

commit 509648fcf0ce8650184649b43ad039f78dde155f upstream.

This is still a leftover from early atomic brinup days.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3090,8 +3090,6 @@ static int amdgpu_dm_plane_init(struct a
 
 	switch (aplane->base.type) {
 	case DRM_PLANE_TYPE_PRIMARY:
-		aplane->base.format_default = true;
-
 		res = drm_universal_plane_init(
 				dm->adev->ddev,
 				&aplane->base,
