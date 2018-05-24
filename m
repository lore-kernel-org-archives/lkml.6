Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527155447-2-14084971496032987738
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155446; b=FBkD/SdCQFdxGe+OVijHE9RDuAWZn6Zbdf+O/NPlMMGYRgXx5Y
    8zn5bnR+Kmo8je7Qvs6ww+a0ZDIjFur4pOrTINj7jEa8cKTMiDqhzYSs7iSmOyd9
    u48EYo+PeV1eJ3JaP+zAnC1WTkPhIjTeBVMXSH49XxU0g1NJHEJaVm6hN01YfF+j
    a1b7l10Z3UP4Z7TpNQKY8e/lP9XLx9ibs9BgWanoGdvOspdP1PkktCDmciW5pUKJ
    UU4H9ZDLtSkgSpND8sQV1ZCFbMZfmESe8/SYPoB7GfSUtRhXsxdueB97BG72jzA8
    JxMb3gNVJpUg/+bT54RUzc4Cx/7G8Cb/gwAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155446; bh=yQfiXnTRn67I+DxEO4uuS3B+EleyIX
    fwpt7JAagsy2k=; b=JX0zj/BN38X2k8dfHN1sX0M0gdmxjujmDYAbjVDrmf+Mor
    X5aMO5hxKNb/A3a2WZk8esCJJg2dz5QaOuBif8EfeEPtlIykzxrl9ZCXdFAf/G1W
    J9wm7kRAZ+WR/Nnbf3wDQW/7a3TnhT2UqGB0jDLd3W1eRgYBmWWyPXenBLwCjmGX
    sDDlWc7I0cHTnRxIR6lHW3I9ZFbAuIxz+T9sSkyZKiorstZ+xBH8TY6DnkM+gH6T
    9mb0Y81T1+6a3nCf+W51EzHRZpLyc9Qzx3msy2BQT1v+lxUNO07LbS2pwWKZ9qkF
    ELuMWlDHRmYVKAh7OhcuTEdFhKL8YCCYxC2TPlNA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=BomcxnyV x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=BomcxnyV x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKs7+CEmwmgt4NFJQ1uke0KsqXjEWV/j2n1TlI3QaWtygH1COYorlkY0k2gMJza/nc6PBrNFNLlZz3iL8QF6mNS0dqCqZGQZucYYvaPopwjOScbbOxd9
    jiPHFNOG0z21NXVlYy0MIldbdqxO6KGb5G4O+o05B71wmkht7VkUVudSLGRSMtaDwnbagikxzHQACFrIwHicSwIFbBMcFTMYP8E3meHWJLNpESAh9pO/+Pz2
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=AUd_NHdVAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=heRnysrUCs9H568S8msA:9 a=QEXdDO2ut3YA:10 a=NGXS0kB0m_rannUenejW:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967609AbeEXJul (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967238AbeEXJui (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:50:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 85/96] media: vivid: fix incorrect capabilities for radio
Date: Thu, 24 May 2018 11:39:08 +0200
Message-Id: <20180524093610.271506787@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil@xs4all.nl>

[ Upstream commit 65243386f41d38460bfd4375d231a7c0346d0401 ]

The vivid driver has two custom controls that change the behavior of RDS.
Depending on the control setting the V4L2_CAP_READWRITE capability is toggled.
However, after an earlier commit the capability was no longer set correctly.
This is now fixed.

Fixes: 9765a32cd8 ("vivid: set device_caps in video_device")

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/vivid/vivid-ctrls.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/platform/vivid/vivid-ctrls.c
+++ b/drivers/media/platform/vivid/vivid-ctrls.c
@@ -1167,6 +1167,7 @@ static int vivid_radio_rx_s_ctrl(struct
 		v4l2_ctrl_activate(dev->radio_rx_rds_ta, dev->radio_rx_rds_controls);
 		v4l2_ctrl_activate(dev->radio_rx_rds_tp, dev->radio_rx_rds_controls);
 		v4l2_ctrl_activate(dev->radio_rx_rds_ms, dev->radio_rx_rds_controls);
+		dev->radio_rx_dev.device_caps = dev->radio_rx_caps;
 		break;
 	case V4L2_CID_RDS_RECEPTION:
 		dev->radio_rx_rds_enabled = ctrl->val;
@@ -1241,6 +1242,7 @@ static int vivid_radio_tx_s_ctrl(struct
 		dev->radio_tx_caps &= ~V4L2_CAP_READWRITE;
 		if (!dev->radio_tx_rds_controls)
 			dev->radio_tx_caps |= V4L2_CAP_READWRITE;
+		dev->radio_tx_dev.device_caps = dev->radio_tx_caps;
 		break;
 	case V4L2_CID_RDS_TX_PTY:
 		if (dev->radio_rx_rds_controls)
