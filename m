Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E8DC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C316420827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C316420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388617AbeKGJwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:52:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35767 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388053AbeKGJwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:52:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id n4-v6so7018640plp.2;
        Tue, 06 Nov 2018 16:24:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IrjpMqS7wGoDq3mmH+w2WI8bPMV3SDBxIsZTD7K5R1M=;
        b=bnOYn0k8xXavIiS9/dYHSEg16CIdyFFK/kDXsOqoJnGgyVlKndkMBTAmXWDQT1hSFA
         LlD+01Xcxcn1fkWXYtNoTcvrRKfrVLV1N/6Rv5MJTzApYUi2lI6uWgtv3U1J0SX2lwlN
         XihOGR/m06iiPLk4QB0D4wDeCXJUbsjMeVCfSpSGDtGP/2j/lQSjHgFgv8ynHTwvAAlj
         fxrWEnDianZVbRw2VkzbNMAugPfiRHtS6WqVH7xwV1GxP2C2x9hagOdEXH6cVKesE4Wx
         pRnFNbMK6AqKgIEWu3+1qYxaL+FnabrLD2cH6YdW+jjA4g4cX69N5cO4+vr4ZrJO9BSv
         D/xA==
X-Gm-Message-State: AGRZ1gJFjSBIw26m+2lPrBm0p/GKwx3mhMlKVL7CUaeRkdZe7w5KMdke
        5onTFwkzmsTGMbDfgITInmw=
X-Google-Smtp-Source: AJdET5fnrKXrRd1rD7rNOVUU9r8jOq0aHkc+EgQVLIVQeV1I3R9+e16ktNNm5suMYIrkcsCyfHrH9Q==
X-Received: by 2002:a17:902:700b:: with SMTP id y11-v6mr2220525plk.323.1541550292141;
        Tue, 06 Nov 2018 16:24:52 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id f193-v6sm57993757pfc.74.2018.11.06.16.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 16:24:51 -0800 (PST)
Message-ID: <1541550290.196084.201.camel@acm.org>
Subject: Re: [driver-core PATCH v5 8/9] PM core: Use new async_schedule_dev
 command
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com
Date:   Tue, 06 Nov 2018 16:24:50 -0800
In-Reply-To: <154145234017.29224.9183571187943571535.stgit@ahduyck-desk1.jf.intel.com>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
         <154145234017.29224.9183571187943571535.stgit@ahduyck-desk1.jf.intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-05 at 13:12 -0800, Alexander Duyck wrote:
+AD4 This change makes it so that we use the device specific version of the
+AD4 async+AF8-schedule commands to defer various tasks related to power management.
+AD4 By doing this we should see a slight improvement in performance as any
+AD4 device that is sensitive to latency/locality in the setup will now be
+AD4 initializing on the node closest to the device.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

