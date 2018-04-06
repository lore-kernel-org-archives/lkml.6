Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1387311-1523021275-2-4421545263778941821
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021275; b=o3/39CU+xpj+PdPNhe3Mi7qaL/7/gPqv2oRc8uXKRCG/BfWQ6h
    VwtE4XCdovWe+a7ZbaVcHHhx5aJ3bxbJhoP9gpyrfeNP+I12A88J7nh4N63f43LM
    Nk5DbpD1If+PSt41Qfvngr6WiTxMPGsdsX0XM1b0nV/pDeQ0prwnp2fR/FtK5v/W
    dqZNCNAUr2+qCUjYBiWN1i/RCjk9A2eTYmHBf+nNiGv3JCoCp5VueHGIga9kXO8M
    Y82ud9v5LT8+1AzbLS0n8mg7Mqf31uOZWVEsJCSlLRTXKzXFO4fEgKAdiOB2zgfn
    BiXlNH1+R9xkM7AK/kqpsbLbY+f1LijeOjLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021275; bh=RJnnLGTeo1HBOAzBhhj4bWr5CoMbH9
    DkFvQg82FleU8=; b=O2PGqIIcjrVmLvKwD3zAWXp56xQUIOQ8RD5Unuxrg374Hb
    dkS/tY/PApgThJWNhsz0P0+TApdRwxdqK6T6diQiEeEuSZV/IgcbbMAQPFrMkKrB
    AL+EuQ4M7yuxdv2bLfzA0uK4Yw4iBIdCTi37iOFPeckw6DrEh4MF/WV8L3aSAJqT
    JrjghYY8a6FMVsBVbKhMvJFwkfBL8LNc2EY09C4cN9aQja08MsnsHSHXuAGCI7ZC
    /BhsRDSuq1UqElI898QHYFpyyGGcTo9sbxzEb2JltBxfceZi3T7UhJs0O/GPE1Ua
    vPwQcG6KHut2saI4/bxp5ktcTmO6+ThnXoJHnjUA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfPbr/H05K6hgEqSlqB8LdW+0cSwiR4LJO4N3CEZGrdQKpFOMXnDIbxN/kIUzWbhkRdSH3tZC+URepvjTKVDWLxpfX+R/8+BINcIOMSkEyKigXpvZFevh
    1f2k/Tw7ANZM8r/Um8DhF9M7h7ZFy//iadyD0RLd333MUXQ1fqVmb9qvq0bDQb+eSTjpwrxElPYwmSYCWHrrgCI99oTlle3LyjLqTsDDAgaaF32qe93gjJ5a
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=AUd_NHdVAAAA:8 a=QyXUC8HyAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=e2e2kAKvei7LNm6H0eYA:9 a=QEXdDO2ut3YA:10
    a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeDFN1v (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:27:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55158 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754234AbeDFN1s (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:27:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 68/93] media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type
Date: Fri,  6 Apr 2018 15:23:37 +0200
Message-Id: <20180406084227.979799823@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 169f24ca68bf0f247d111aef07af00dd3a02ae88 upstream.

There is nothing wrong with using an unknown buffer type. So
stop spamming the kernel log whenever this happens. The kernel
will just return -EINVAL to signal this.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -170,8 +170,6 @@ static int __get_v4l2_format32(struct v4
 		return copy_from_user(&kp->fmt.sliced, &up->fmt.sliced,
 				      sizeof(kp->fmt.sliced)) ? -EFAULT : 0;
 	default:
-		printk(KERN_INFO "compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-		       kp->type);
 		return -EINVAL;
 	}
 }
@@ -214,8 +212,6 @@ static int __put_v4l2_format32(struct v4
 		return copy_to_user(&up->fmt.sliced, &kp->fmt.sliced,
 				    sizeof(kp->fmt.sliced)) ?  -EFAULT : 0;
 	default:
-		printk(KERN_INFO "compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-		       kp->type);
 		return -EINVAL;
 	}
 }
