Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAB3C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A8D21871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfADPXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:23:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:39055 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbfADPXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:23:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 07:23:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; 
   d="scan'208";a="106972027"
Received: from lculbert-x1y7.amr.corp.intel.com (HELO [10.252.194.2]) ([10.252.194.2])
  by orsmga008.jf.intel.com with ESMTP; 04 Jan 2019 07:23:39 -0800
Subject: Re: [alsa-devel] ALSA:usb audio Higher sample rates on usb audio no
 longer working.
To:     Takashi Iwai <tiwai@suse.de>, Con Kolivas <kernel@kolivas.org>
Cc:     saranya.gopal@intel.com, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        felipe.balbi@linux.intel.com
References: <CABqErrECNH+gRiZXM+z=igjAw895e7KLeV6H0EKvMkW0UsVvJw@mail.gmail.com>
 <s5hsgy96fiu.wl-tiwai@suse.de>
 <CABqErrHKFshAMBPHJp2vmGFE6k1GL1oDMSMbDRcBJNfUSxt9KQ@mail.gmail.com>
 <s5hd0pdey4e.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5c7b2c6b-5dcc-7170-f6e1-bf6021bbb72a@linux.intel.com>
Date:   Fri, 4 Jan 2019 09:23:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <s5hd0pdey4e.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> [ Adding linux-usb ML to Cc, as it's a core USB issue ]
>
> So the device seems incorrectly advertising as if it were supporting
> UAC3 -- assuming the device is still not UAC3-capable.
>
> IOW, it's a buggy firmware.  We need some blacklisting, or revert the
> commit for now, unless any real UAC3 device comes up to the market.

IIRC an UAC3-capable device is required to expose a backwards-compatible 
configuration (either UAC1 or UAC2). Maybe an additional test can be 
done to harden the detection so that UAC3 is only chosen if indeed a 
second audio configuration is present as well.

I also vaguely recall there was talk about adding information in the BOS 
descriptor, but I don't know if this was ever published.

-Pierre

