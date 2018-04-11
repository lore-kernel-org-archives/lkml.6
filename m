Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523479764-2-14506253646602970935
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479763; b=VFudiC1QmINmimiH/2xg/iEda/lQD4WAAW6GnoMXOEGOGwZdLN
    Ti+tz/ojk7RgGfKCHvqAjFfEdJqR3SVSTOGtef5aYjRl9CQa6h0BR87Eu+yfCHJc
    7P+QwjOKXSfFMHMYsWYg3oH2LsKCq9oiXGBhmhU4S8Xd1rJe/aJDwPEYrn/FuOUZ
    LJZcw/C0u3WiuazwR/9OgHlJmnKxqNl46DsO4mnZ3LCwq7nY6isVGRpNL6HUvFXp
    RmX93OPGrh66hQMKAC8F+qIE2Y1YX90QxaaIc14V1oTE3P5nIaU5NZBRR0DZroka
    Jy/C9Yrc/KHG4cCT9o9Tb0LyyaqedO+hqGcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479763; bh=KX5UZXrS+5So/h1A8CqaKtc7RmHUqx
    uG0XO9Oa0bX1E=; b=GmzF0Rl4dxnSFBuh+4KV9/AnzZ0FiH9aDIQVRv3LC2SJYB
    1YlZUNFCp9T/I+LXBMN4KoGPkWptA73Jw5yWBUPvJKRQti0mr3j64xNWdLK7vrgG
    GE4oRw/sYn1xxQjGpYh0Y//Vc+VcYlZlWZrRnvqNeZHBOI0A2Gir2NsKi2LMj3oO
    DWk3N3GVhXEKxpzWZtbaKjPw8HMffjjGWSnFRcwxoJudpx7QgvVy1yEjTlU3gPKu
    VWKPC3x8rIR5ztAAkHnKkke2rj/hb6am/2IpKQZB8XYqVYGKU3B/Ls9r8PhQAkBs
    gCoAKa3TZI7ASwoyhiB5v2fJJodA7zoHDuBNpePg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfIm0OflTxEN4i5aPjqFKSOoSGwqGm4JqGYuNHLazq5VryFgMm6bI57bJv09vRCyhtDldzuV5NYePD66qz2ZI+AqcLa1N7ThJlC03T7YIbjIaYzfzpbt0
    TlWeFblCqq1v5Kf8IGeN41DT04HLyFtbcmVIFY9xa1uuClzD1ZMd6lO1kPswqNM+BrlSA69UnkrNujEFNoYpj1lhVJ0GHg4qOtdEdwhHlNhyBXjgvBXzSD5y
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=vmLDa1wCAAAA:8 a=eh1Yez-EAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=eK2PtGytKguSqSfQ0NAA:9 a=QEXdDO2ut3YA:10
    a=h8Bt5HTj68qkN2fS7gvA:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755687AbeDKSqI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:46:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58814 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754877AbeDKSqH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:46:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
        Shrikrishna Khare <skhare@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 027/190] vmxnet3: ensure that adapter is in proper state during force_close
Date: Wed, 11 Apr 2018 20:34:33 +0200
Message-Id: <20180411183551.763375258@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neil Horman <nhorman@tuxdriver.com>


[ Upstream commit 1c4d5f51a812a82de97beee24f48ed05c65ebda5 ]

There are several paths in vmxnet3, where settings changes cause the
adapter to be brought down and back up (vmxnet3_set_ringparam among
them).  Should part of the reset operation fail, these paths call
vmxnet3_force_close, which enables all napi instances prior to calling
dev_close (with the expectation that vmxnet3_close will then properly
disable them again).  However, vmxnet3_force_close neglects to clear
VMXNET3_STATE_BIT_QUIESCED prior to calling dev_close.  As a result
vmxnet3_quiesce_dev (called from vmxnet3_close), returns early, and
leaves all the napi instances in a enabled state while the device itself
is closed.  If a device in this state is activated again, napi_enable
will be called on already enabled napi_instances, leading to a BUG halt.

The fix is to simply enausre that the QUIESCED bit is cleared in
vmxnet3_force_close to allow quesence to be completed properly on close.

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
CC: Shrikrishna Khare <skhare@vmware.com>
CC: "VMware, Inc." <pv-drivers@vmware.com>
CC: "David S. Miller" <davem@davemloft.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vmxnet3/vmxnet3_drv.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2789,6 +2789,11 @@ vmxnet3_force_close(struct vmxnet3_adapt
 	/* we need to enable NAPI, otherwise dev_close will deadlock */
 	for (i = 0; i < adapter->num_rx_queues; i++)
 		napi_enable(&adapter->rx_queue[i].napi);
+	/*
+	 * Need to clear the quiesce bit to ensure that vmxnet3_close
+	 * can quiesce the device properly
+	 */
+	clear_bit(VMXNET3_STATE_BIT_QUIESCED, &adapter->state);
 	dev_close(adapter->netdev);
 }
 
