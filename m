Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBDCC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736C225BE8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736C225BE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754572AbeGBJge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:36:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:10471 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753328AbeGBJgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:36:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 02:36:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,298,1526367600"; 
   d="scan'208";a="242290198"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2018 02:36:17 -0700
Received: from abityuts-desk.fi.intel.com (abityuts-desk.fi.intel.com [10.237.68.39])
        by linux.intel.com (Postfix) with ESMTP id 613C35802B1;
        Mon,  2 Jul 2018 02:36:15 -0700 (PDT)
Message-ID: <1530524174.469.95.camel@gmail.com>
Subject: Re: [PATCH v3 1/2] ubi: provide a way to skip CRC checks
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Date:   Mon, 02 Jul 2018 12:36:14 +0300
In-Reply-To: <20180702095121.67bc61ef@bbrezillon>
References: <cover.6d66955e7c1848c8255870deb42eddb69bd276f3.1530169759.git-series.quentin.schulz@bootlin.com>
         <3f9cef553d4f5da3fe2d76113d79ada1f0fe5224.1530169759.git-series.quentin.schulz@bootlin.com>
         <1530516625.469.82.camel@gmail.com> <20180702095121.67bc61ef@bbrezillon>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 09:51 +0200, Boris Brezillon wrote:
> Well, I thought checking the CRC just after updating the volume made
> sense, just to make sure things were written correctly on the medium.
> Let's add a comment explaining why we keep the check here, unless you
> see a strong reason to get rid of this check in the update path.

I am fine with this, thanks.
