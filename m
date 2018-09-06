Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8718C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCB920659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BCB920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbeIFTIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:08:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:53194 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729124AbeIFTIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:08:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA75FAF43;
        Thu,  6 Sep 2018 14:32:27 +0000 (UTC)
Date:   Thu, 6 Sep 2018 16:32:26 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     benjamin.tissoires@redhat.com, hdegoede@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aaron Ma <aaron.ma@canonical.com>,
        AceLan Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH v2] HID: i2c-hid: Don't reset device upon system resume
In-Reply-To: <20180906025518.30191-1-kai.heng.feng@canonical.com>
Message-ID: <nycvar.YFH.7.76.1809061631250.15880@cbobk.fhfr.pm>
References: <20180906025518.30191-1-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2018, Kai-Heng Feng wrote:

> Raydium touchscreen triggers interrupt storm after system-wide suspend:
> [ 179.085033] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete
> report (58/65535)
> 
> According to Raydium, Windows driver does not reset the device after
> system resume.
> 
> The HID over I2C spec does specify a reset should be used at
> intialization, but it doesn't specify if reset is required for system
> suspend.
> 
> Tested this patch on other i2c-hid touchpanels I have and those
> touchpanels do work after S3 without doing reset. If any regression
> happens to other touchpanel vendors, we can use quirk for Raydium
> devices.
> 
> There's still one device uses I2C_HID_QUIRK_RESEND_REPORT_DESCR so keep
> it there.
> 
> Cc: Aaron Ma <aaron.ma@canonical.com>
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Queued in for-4.19/fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

