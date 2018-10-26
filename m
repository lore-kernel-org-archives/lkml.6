Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A550C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3C121479
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3C121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeJZXsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:48:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:47450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbeJZXsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:48:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2875CAE7A;
        Fri, 26 Oct 2018 15:11:06 +0000 (UTC)
Date:   Fri, 26 Oct 2018 17:11:05 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Laurent Bigonville <bigon@bigon.be>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "HID: add NOGET quirk for Eaton Ellipse MAX
 UPS"
In-Reply-To: <20181017070153.465-1-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.1810261710570.23511@cbobk.fhfr.pm>
References: <20181017070153.465-1-benjamin.tissoires@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018, Benjamin Tissoires wrote:

> This reverts commit 67ddbb3e6568fb1820b2cc45b00c50702b114801.
> 
> 67ddbb3e656 ("HID: add NOGET quirk for Eaton Ellipse MAX UPS") was reported
> by Laurent Bigonville. It turns out that a later model Laurent got
> doesn't need the quirk after all.
> 
> My take is that Eaton upgraded their firmwares, so we don't need it
> anymore.
> 
> The old model was from 2012, so better make sure the new line works
> properly by removing the quirk. This allows upower to actually fetch
> the current data.
> 
> Reported-by: Laurent Bigonville <bigon@bigon.be>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Ok, fingers crossed. Applied,

-- 
Jiri Kosina
SUSE Labs

