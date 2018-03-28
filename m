Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2888441-1522261123-2-9108293727252186738
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522261122; b=ZGkUmbk/G9v9/0erdyVIigIEISBhGkXxCm30PM+Dk7MjDyt
    q1W/PxRsmG+Q2U24usqKLcIyuAcKp+aaI89FRnoa8KRmAuUwjn9MLAvjH5uCkZq3
    9lEOAEaMMdda2RKwdCek1DPewaq55x2F6t0c0iJ7x9eF8fS1rvMw8KMO/+5Kp8nN
    bmmRY+2h2G/2mxRNR0Q0aiLcgFYnRFyWfLL1nRyW40jIWO2znsDQMM5MY6vopMmI
    uuKN57fTlT3HjtBveVOU44MbEkQYPrf/K8OuwBE9Tq9/YTBCaBIXEhf5oTGPevUR
    bg6KU1fcdhQHssv+WjJ0xpmrJR4RXF2QK0K+U6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1522261122; bh=GqAFyOZETuTzmN5AD5SwUxgskrMmm/NYmTr
    BSmtcb2o=; b=N+5AEl4lHP8UnAc8IStxVBXotnCNnnK+SNbPSEnPGVglHBCIOZv
    H1msrQYSM5iphxs1gDxbCXmXfOXTObNj7gSXEFyuNsa5aVJshkmu8zph+vIY6S7w
    iBAm18X/zaEjZKhMFbgitsnR/CNLT8dbPucBLci+PovR03ojutgfL2DoLlCCOVqx
    9Fr5L3N0nG2jxUVC43Q1kNVwlIZ7/IxTDjM6HQ6duEMLjMTMdsvK8kIu4TWWGaLy
    WQHPgQ6dgQVQUQQNfTMj5zt+BhwAdksdRPXhxzAsKJpVnXeVDX9aOVqV+oVZI4AQ
    7BKwofI4HTQnP/V9XCfisMghRga558QRaog==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL1+Mc7TCic30Pem1WdJMGjEYugeTD8tPrIMDJ/MN+O02AYuEZQnzLMK+irGE+cLPV1rAjPui4hH5ICaE/Ca/jcXjbaXSeskuMyWcl8kyL3i9IZAoO7W
    u/28q04RAbXtDvN0HmK+ff130fpdncGHH1XfR+e5nWgNQx7PrnhU7E+qH1HT7DUvObVq6O13j7+HaOfImIZnFJMDAOuRDk27EPpH8COi9f6soeZ4afMtf2gO
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=AUd_NHdVAAAA:8
    a=QyXUC8HyAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=MslXCsIYsFUQHOJYlawA:9
    a=NGXS0kB0m_rannUenejW:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbeC1SMz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 14:12:55 -0400
Received: from osg.samsung.com ([64.30.133.232]:42815 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752455AbeC1SMx (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 14:12:53 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Media Mailing List <linux-media@vger.kernel.org>,
        stable@vger.kernel.org
Cc: Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH for v3.18 03/18] media: v4l2-compat-ioctl32.c: add missing VIDIOC_PREPARE_BUF
Date: Wed, 28 Mar 2018 15:12:22 -0300
Message-Id: <c5d1ae82ac9e4cc7e61abf6ac04c1c10b3a7f062.1522260310.git.mchehab@s-opensource.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1522260310.git.mchehab@s-opensource.com>
References: <cover.1522260310.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1522260310.git.mchehab@s-opensource.com>
References: <cover.1522260310.git.mchehab@s-opensource.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 3ee6d040719ae09110e5cdf24d5386abe5d1b776 upstream.

The result of the VIDIOC_PREPARE_BUF ioctl was never copied back
to userspace since it was missing in the switch.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
index aa11f02c0a8f..fc4f92a0c985 100644
--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -996,6 +996,7 @@ static long do_video_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 		err = put_v4l2_create32(&karg.v2crt, up);
 		break;
 
+	case VIDIOC_PREPARE_BUF:
 	case VIDIOC_QUERYBUF:
 	case VIDIOC_QBUF:
 	case VIDIOC_DQBUF:
-- 
2.14.3
