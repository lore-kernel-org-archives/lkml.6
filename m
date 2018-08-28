Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14093C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A4A20869
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A4A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeH1Phm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:37:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:54054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbeH1Phm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:37:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22634AEB8;
        Tue, 28 Aug 2018 11:46:24 +0000 (UTC)
Date:   Tue, 28 Aug 2018 13:46:23 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     AceLan Kao <acelan.kao@canonical.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Aaron Ma <aaron.ma@canonical.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: i2c-hid: Fix flooded incomplete report after S3 on
 Rayd touchscreen
In-Reply-To: <20180821085513.13739-1-acelan.kao@canonical.com>
Message-ID: <nycvar.YFH.7.76.1808281346150.25787@cbobk.fhfr.pm>
References: <20180821085513.13739-1-acelan.kao@canonical.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018, AceLan Kao wrote:

> The incomplete report flooded after S3 and touchscreen becomes
> malfunctioned.
> [ 1367.646244] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/18785)
> [ 1367.649471] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/28743)
> [ 1367.651092] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/26757)
> [ 1367.652658] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/52280)
> [ 1367.654287] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/56059)
> 
> Adding device ID, 04F3:30CC, to the quirk to re-send report description
> after resume.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

