Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5977C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5002206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5002206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeKUBgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:36:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:41592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbeKUBgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:36:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 232A0B0F1;
        Tue, 20 Nov 2018 15:06:35 +0000 (UTC)
Message-ID: <1542725830.28362.12.camel@suse.com>
Subject: Re: [PATCH v3] usb: hub: add retry routine after intr URB submit
 error
From:   Oliver Neukum <oneukum@suse.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Tue, 20 Nov 2018 15:57:10 +0100
In-Reply-To: <20181120143438.18296-1-nsaenzjulienne@suse.de>
References: <20181120143438.18296-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 2018-11-20 at 15:34 +0100, Nicolas Saenz Julienne wrote:
> The hub sends hot-plug events to the host trough it's interrupt URB. The
> driver takes care of completing the URB and re-submitting it. Completion
> errors are handled in the hub_event() work, yet submission errors are
> ignored, rendering the device unresponsive. All further events are lost.
> 

Hi,

almost. There is no point in kicking of an error handling while aq
reset is underway. You are checking only "quiescing" but not
"in_reset".

	Regards
		Oliver

