Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA30FC64EB4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A60C20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A60C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbeLCAxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 19:53:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725795AbeLCAxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 19:53:36 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB30mdD4107685
        for <linux-kernel@vger.kernel.org>; Sun, 2 Dec 2018 19:53:31 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p4snw9cw0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 19:53:31 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sbobroff@linux.ibm.com>;
        Mon, 3 Dec 2018 00:53:28 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 3 Dec 2018 00:53:26 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB30rPJC39518228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 00:53:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 132CB5204E;
        Mon,  3 Dec 2018 00:53:25 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B4B2A52050;
        Mon,  3 Dec 2018 00:53:24 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 0FBACA0129;
        Mon,  3 Dec 2018 11:53:22 +1100 (AEDT)
From:   Sam Bobroff <sbobroff@linux.ibm.com>
To:     daniel@ffwll.ch, airlied@redhat.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Two AST driver fixes
Date:   Mon,  3 Dec 2018 11:53:19 +1100
X-Mailer: git-send-email 2.19.0.2.gcad72f5712
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18120300-4275-0000-0000-000002EB09C3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120300-4276-0000-0000-000037F809FE
Message-Id: <cover.1543798395.git.sbobroff@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-02_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=687 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here are two (attempted) fixes for the AST DRM driver. The issues they fix are
both seen when the ast driver is unloaded (tested on Power9, although it looks
like the second one is architecture independent).

I'm fairly confident about the first fix, as it looks pretty straight forward.

The second seems reasonable, but I don't know this area of the kernel very well.

Cheers,
Sam.

Patch set changelog follows:

Patch set v2: 
Patch 1/2: drm/ast: Fix incorrect free on ioregs
Patch 2/2: drm/ast: Fix connector leak during driver unload
* Changed to use drm_crtc_force_disable_all().

Patch set v1:
Patch 1/2: drm/ast: Fix incorrect free on ioregs
Patch 2/2: drm/ast: Fix connector leak during driver unload

Sam Bobroff (2):
  drm/ast: Fix incorrect free on ioregs
  drm/ast: Fix connector leak during driver unload

 drivers/gpu/drm/ast/ast_fb.c   | 1 +
 drivers/gpu/drm/ast/ast_main.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.19.0.2.gcad72f5712

