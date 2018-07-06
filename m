Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEDEC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C499240BE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C499240BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753770AbeGFAwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 20:52:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:53028 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753495AbeGFAwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 20:52:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 17:52:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,314,1526367600"; 
   d="scan'208";a="243364839"
Received: from spandruv-mobl.amr.corp.intel.com ([10.252.205.236])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jul 2018 17:52:09 -0700
Message-ID: <681dbd37f209a29be46e9c4ff102631cfa841ec0.camel@linux.intel.com>
Subject: Re: [RFC PATCH] ata: ahci: Enable DEVSLP by default on x86 modern
 standby platform
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc:     rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mario.Limonciello@dell.com
Date:   Thu, 05 Jul 2018 17:52:08 -0700
In-Reply-To: <660d4e4b-361f-e6b1-ef21-3985c321183a@redhat.com>
References: <20180702190845.7456-1-srinivas.pandruvada@linux.intel.com>
         <20180702202151.GK533219@devbig577.frc2.facebook.com>
         <5493bfdb-14a9-a55d-f96e-b9c8a29f1d63@redhat.com>
         <ca753f719e123d8e3c2306b8d55f3d4a656cbd2f.camel@linux.intel.com>
         <fefe0ef4-e21f-72cc-18d6-a5a6693c21c6@redhat.com>
         <660d4e4b-361f-e6b1-ef21-3985c321183a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,


[...]

> So digging a bit deeper I just realized that another important
> difference
> between med_power_with_dipm and min_power is that min_power by
> default
> set the ASP bits making the link go to the slumber state instead of
> to
> the partial (power-saving) state.
> 
> According to:
> https://www.intel.com/content/dam/doc/reference-guide/sata-devices-im
> plementation-recommendations.pdf
> 
> ASP defaults to off in the iRST drivers. But that is a document from
> before DEVSLP got introduced.
> 
> So we need to know if Windows and/or the iRST drivers use HIPM and
> ASP by default on these systems. If they do then using min_power
> is fine. If they don't use one or the other we are going to need
> a new policy reflecting those settings and use that.
Good point. In Windows there are various registry settings, so they can
be tuned. It is difficult to know what they mean.
Let me do some experiments to check impact of ASP on SLP_S0. Then I
will resubmit this patch.

Thanks,
Srinivas

> 
> Regards,
> 
> Hans
> 
