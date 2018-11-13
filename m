Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E29C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB06216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB06216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeKNFpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:45:11 -0500
Received: from mga07.intel.com ([134.134.136.100]:38024 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725748AbeKNFpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:45:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 11:45:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,229,1539673200"; 
   d="scan'208";a="107786174"
Received: from yadappan-mobl.ger.corp.intel.com (HELO localhost) ([10.252.41.77])
  by fmsmga001.fm.intel.com with ESMTP; 13 Nov 2018 11:45:30 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Christoph Niedermaier <cniedermaier@dh-electronics.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, C.Emde@osadl.org
Subject: Re: [PATCH 0/2] Docs/EDID: Fixed and improved EDID documentation
In-Reply-To: <20181106073536.58b14759@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1541407715-5417-1-git-send-email-cniedermaier@dh-electronics.de> <20181106073536.58b14759@lwn.net>
Date:   Tue, 13 Nov 2018 21:45:29 +0200
Message-ID: <87lg5wg3s6.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Nov 2018, Jonathan Corbet <corbet@lwn.net> wrote:
> On Mon, 5 Nov 2018 09:48:33 +0100
> Christoph Niedermaier <cniedermaier@dh-electronics.de> wrote:
>
>> A problem was found when EDID data sets for displays other
>> than the provided samples were generated. The patch series has
>> no effect on the provided samples that still match the data
>> used in drivers/gpu/drm/drm_edid_load.c.
>> The provided samples use small values for XOFFSET, XPULSE,
>> YOFFSET and YPULSE, where the error doesn't occur. This fix
>> corrects the use of that values in case of high values, because
>> the most significant bits were treated incorrectly.
>> 
>> The previous version made it necessary to first generate an
>> EDID data set without correct CRC and then to fix the CRC in
>> a second step. This patch series adds the CRC calculation to the
>> makefile in such a way that a correct EDID data set is generated
>> in a single build step.
>
> This seems reasonable, I guess; I've applied both.  It seems to me, though,
> that this stuff is in the wrong place.  Perhaps we should go one step
> further and move it to tools/ ?

And then the next step further would be to write a tool in a high level
language to generate the data rather than assemble the binary. Such a
tool would, of course, catch errors like the ones fixed by this patch.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
