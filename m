Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708C4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E840222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389065AbfBOUhh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:37:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:59789 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfBOUhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:37:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 12:37:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,373,1544515200"; 
   d="scan'208";a="124815301"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga008.fm.intel.com with ESMTP; 15 Feb 2019 12:37:36 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.11]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.106]) with mapi id 14.03.0415.000;
 Fri, 15 Feb 2019 12:37:36 -0800
From:   "Brown, Aaron F" <aaron.f.brown@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH] e1000e: Disable runtime PM on CNP+
Thread-Topic: [Intel-wired-lan] [PATCH] e1000e: Disable runtime PM on CNP+
Thread-Index: AQHUux5n57YOOkLR5ke7vFMTQ3bTCKXhZiRw
Date:   Fri, 15 Feb 2019 20:37:35 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96641B63@ORSMSX101.amr.corp.intel.com>
References: <20190202174016.28539-1-kai.heng.feng@canonical.com>
In-Reply-To: <20190202174016.28539-1-kai.heng.feng@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces@osuosl.org] On
> Behalf Of Kai-Heng Feng
> Sent: Saturday, February 2, 2019 9:40 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev@vger.kernel.org; Kai-Heng Feng
> <kai.heng.feng@canonical.com>; intel-wired-lan@lists.osuosl.org; linux-
> kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] e1000e: Disable runtime PM on CNP+
> 
> There are some new e1000e devices can only be woken up from D3 one
> time,
> by plugging ethernet cable. Subsequent cable plugging does set PME bit
> correctly, but it still doesn't get woken up.
> 
> Since e1000e connects to the root complex directly, we rely on ACPI to
> wake it up. In this case, the GPE from _PRW only works once and stops
> working after that. Though it appears to be a platform bug, e1000e
> maintainers confirmed that I219 does not support D3.
> 
> So disable runtime PM on CNP+ chips. We may need to disable earlier
> generations if this bug also hit older platforms.
> 
> Bugzilla: https://bugzilla.kernel.org/attachment.cgi?id=280819
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
