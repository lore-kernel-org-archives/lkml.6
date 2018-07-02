Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1362EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C448F25DA6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C448F25DA6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeGBNuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:50:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:29278 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752390AbeGBNuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:50:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 06:50:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,299,1526367600"; 
   d="scan'208";a="51434702"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 02 Jul 2018 06:49:59 -0700
Received: from abityuts-desk.fi.intel.com (abityuts-desk.fi.intel.com [10.237.68.39])
        by linux.intel.com (Postfix) with ESMTP id BA119580117;
        Mon,  2 Jul 2018 06:49:57 -0700 (PDT)
Message-ID: <1530539396.469.98.camel@gmail.com>
Subject: Re: [PATCH v5 0/2] ubi: add possibility to skip CRC check for
 static UBI volumes
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Quentin Schulz <quentin.schulz@bootlin.com>, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, marek.vasut@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Date:   Mon, 02 Jul 2018 16:49:56 +0300
In-Reply-To: <cover.ab725a3c64626915f8184e28937870f36684db61.1530524405.git-series.quentin.schulz@bootlin.com>
References: <cover.ab725a3c64626915f8184e28937870f36684db61.1530524405.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 11:43 +0200, Quentin Schulz wrote:
> Some users of static UBI volumes implement their own integrity check, thus
> making the volume CRC check done at open time useless. For instance, this
> is the case when one use the ubiblock + dm-verity + squashfs combination,
> where dm-verity already checks integrity of the block device but this time
> at the block granularity instead of verifying the whole volume.
> 
> Skipping this test drastically improves the boot-time.
> 
> mtd-utils patches are already merged. See:
> http://git.infradead.org/mtd-utils.git/commit/9095d213f536aec0f3c37f6666177f3b907afde7
> http://git.infradead.org/mtd-utils.git/commit/7b4a65a27d2621b58c634d02c6a068ed9562383c
> http://git.infradead.org/mtd-utils.git/commit/5e9bc0daa41d84ce5de81c4a1665d65f51893c10
> http://git.infradead.org/mtd-utils.git/commit/8ba21ab75b41a1f9a6e27eed3ea80c9829669c5a

For the whole patch-set,

Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

