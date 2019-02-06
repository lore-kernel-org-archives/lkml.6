Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B99C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB9C2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ly9hAvUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfBFRWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:22:36 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:39468 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfBFRWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:22:36 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id D0DA924E0809;
        Wed,  6 Feb 2019 09:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549473755; bh=NPQ+S2m/YnJ38E578d+Uytmhk+4TPkrgDMBY70GG91s=;
        h=From:To:Cc:Subject:Date:From;
        b=Ly9hAvUxeyZZif0PB9rioiRJNrQexbGl5huOn+2pJrq49mldrhI7Rpi6J9wzlRUGk
         Dnv0RGWyYLT4Ko8K3o82xJp/iJ5ze9QquYqOjC7ZFGBIYKoyvp0XudyPB8r+yz2en4
         Tsrp0g3knlo8b94t42s/QM864l7/1CUeIn5lxxr7tbbU/fBZA6z3lnBFV2o+bN2a+N
         Q8rzr1cCxJHZvgGq3ERdobsn2A+n5jtUiQpYyBQ6eNAe1bsZQ6BiA2Q72RlMTzcBmX
         K04WU12PaF49//GiPqvQIxK6/nVw8Sc8z35q4N94gGt432Yx1dW27zGEqv+W0rvuJN
         3OrtS5Ci8pY6A==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id DBF86A0091;
        Wed,  6 Feb 2019 17:22:31 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>, khilman@baylibre.com,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [RFC 0/2] ARC: rework U-boot arguments handling
Date:   Wed,  6 Feb 2019 20:22:26 +0300
Message-Id: <20190206172228.9261-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eugeniy Paltsev (2):
  ARC: U-boot: check arguments paranoidly
  ARC: U-boot: check magic number passed from u-boot

 arch/arc/kernel/head.S  |  7 ++--
 arch/arc/kernel/setup.c | 91 +++++++++++++++++++++++++++++++++++++------------
 2 files changed, 74 insertions(+), 24 deletions(-)

-- 
2.14.5
