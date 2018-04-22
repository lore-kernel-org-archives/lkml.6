Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406003-2-9815775833075422608
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
    1524406002; b=sxAO5eui+mGx/kh8JoxAMrpy6ihFPhcZmJ9cWMVGW1fmaBhrHL
    u+pibhXVL7ezjfejC2dSMTDWsLGJWjGwPrjYFZ+QmsUaMo7GqxknmG/9ont1/mkE
    8IZYWBNxIQH1T/fyNXquVq2aP5TklkDM4OtI63kkGEJKKvLFnxIdBIKQ7ouJnXLQ
    gg2MD5VD0I/lpo8JTHSBfolCajW4RDKyUgI45DY5eAeUVxHegQyQpA2en1bImk56
    Wr8FBysRhZQmIyrGq7zAY/2tNB3xkfk3CWaM3a3MkdaKC5BQH1m8le0B3IPXKxM7
    EOorYKjaeI5QFnJgvvRYfKSCDtaBoAbo2MlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406002; bh=xXxRPsUXFJxzAmgdy/0dPjQFXtxLBc
    em81Oq5k7+t0c=; b=EDvIfkplK57cE6WxR1auKtQqjant5nHao5jnf4hxkGpSIM
    7WkMucqBxo/SAP4zVFNdvuWtzZYamNiwgezzL+Ks/0dqKp2MZIiz5boqo3v88qvg
    GpqriynCi/JdnwhoGedQP3SqIqUgCz0Q2RePfy0Cf1SL3uHrK8SnNrvNUoM3YcIw
    qfedynAFzWnpBAsbluhZ7IXMvBFNvXwvlG001r7IGCjYJnF2LQCRMcQkEg5SzxUw
    eC1NlKdazhTbw9PshwcGqWutNknZ4TlFsWrw88dHWu4De8+cMwCwlyr+UkJzxfNZ
    n4ll2UZAuJVwZbFY2mu4pfedgawvQ0tZS2kIWujQ==
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
X-CM-Envelope: MS4wfL3uqGu70zqHktNV8ojjRQAe4g2w9/nu24Vo5EdkxwP6vfUN9qn+RPAfUVDYFe7r+sqeB3Ds4qhgpuRUtO/bPQ62Icm0kGh2UZK57WJZOL0JGkwlo1D7
    YO3VG5bgbGTZkoDliuJne4xhXkVqFHBNA27kVXutxWXeDHCMirgXKYTEYgrLxk+xJFen2kjxYnCk04TNCb1RRbnH/b821K5VgdYw4P+z4JK9D9TVlh+zynvH
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=AUd_NHdVAAAA:8 a=vQBBkBfzAAAA:8 a=ag1SF4gXAAAA:8
    a=V5WjWFwnxehWDg8QpVsA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755602AbeDVOGj (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:06:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51460 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755594AbeDVOGg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:06:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.14 030/164] media: vivid: check if the cec_adapter is valid
Date: Sun, 22 Apr 2018 15:51:37 +0200
Message-Id: <20180422135136.640353014@linuxfoundation.org>
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

From: Hans Verkuil <hverkuil@xs4all.nl>

commit ed356f110403f6acc64dcbbbfdc38662ab9b06c2 upstream.

If CEC is not enabled for the vivid driver, then the adap pointer is NULL
and 'adap->phys_addr' will fail.

Cc: <stable@vger.kernel.org>      # for v4.12 and up
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/vivid/vivid-vid-common.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/media/platform/vivid/vivid-vid-common.c
+++ b/drivers/media/platform/vivid/vivid-vid-common.c
@@ -858,7 +858,8 @@ int vidioc_g_edid(struct file *file, voi
 		return -EINVAL;
 	if (edid->start_block + edid->blocks > dev->edid_blocks)
 		edid->blocks = dev->edid_blocks - edid->start_block;
-	cec_set_edid_phys_addr(dev->edid, dev->edid_blocks * 128, adap->phys_addr);
+	if (adap)
+		cec_set_edid_phys_addr(dev->edid, dev->edid_blocks * 128, adap->phys_addr);
 	memcpy(edid->edid, dev->edid + edid->start_block * 128, edid->blocks * 128);
 	return 0;
 }
