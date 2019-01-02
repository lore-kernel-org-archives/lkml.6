Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AE8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8177C206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546421817;
	bh=/IHJ6e1XvJmOE4NY+D1IxBXc82O14teXW9Nb6OCz3gM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kewtZz94e74sSSy/A/qKbu9JToNNCZd0HIBx/8bA2wc7+eH12Zi1b/3KbVw9bxbkZ
	 N12CND30uKxpOSfVhlSMMi2Lij9BfexuWTpFAg+LW94O8n8Az56y+vkwENYPedwV2f
	 uC9pIYfk/khLfL0p7f9YFnUM4xqgUjJxOwi2cO8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfABJg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:36:56 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46776 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfABJg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:36:56 -0500
Received: by mail-oi1-f193.google.com with SMTP id x202so24620146oif.13;
        Wed, 02 Jan 2019 01:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ktlCAQiQ55P2VdE/0bVc/O3M1HNF0+nFITFClIWrGAQ=;
        b=Y+SubDzVtALHVbuPwwNYCjO66Z8WCOR3YWs8elmtb5PRXCn0LELeDQDne4P+thW0+N
         OFKXjJs5ldtMbdQ4ZO6R+70/JrjX2RG7Ankozn/8q2tU0T5sIq76APCwXIuWsV1hRMkk
         n7TMp66mpEekhQSR0JB0nCRnmDD+H/tjmbh6l2HkprQIZDE1NpXPNdWSpBJHCmrz1EWI
         A6c1F5yzu7wfdrrVqdVMXTT7OLN2+3/16UjwIySJGDpsMQvnYaIgVO/cTB7nhZ2I0J0n
         1D9C6/932x2wUxY4ZFK6CSmRlieJfuVgDcuYksRM9QDoK0yoNPDgyUoToaOJfEQljbib
         Wv2Q==
X-Gm-Message-State: AJcUukfUvw1snsV24BvzlVYPLK3spRCiIUasEDImebDqmiphOqTn2rFZ
        LTCcsFPzEkW9jF5k4lXgoLQ9fVstOrefOl9krp0=
X-Google-Smtp-Source: ALg8bN6MTBq8j/Y28xyB3NUTLx7L7ZfP3ow0eZnfWfo3VQdmioL1zoE7Q0i0AhsHbS9JPvlTEuqDJlW2z+U0/340Nqo=
X-Received: by 2002:aca:e715:: with SMTP id e21mr12370996oih.76.1546421815136;
 Wed, 02 Jan 2019 01:36:55 -0800 (PST)
MIME-Version: 1.0
References: <20181230195612.6657-1-okaya@kernel.org> <20181230195612.6657-9-okaya@kernel.org>
 <CAJZ5v0hSpAPzi2EcFKD_Wh23SeYnoJCAaQMGW=fSqgmhmhr37A@mail.gmail.com>
In-Reply-To: <CAJZ5v0hSpAPzi2EcFKD_Wh23SeYnoJCAaQMGW=fSqgmhmhr37A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Jan 2019 10:36:43 +0100
Message-ID: <CAJZ5v0h3br9+a8x2Vy406hJ-Rp24zs+b-ijxGJx0z7=9msWE7g@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] ASoC: Intel: atom: Make PCI dependency explicit
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 10:34 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sun, Dec 30, 2018 at 8:56 PM Sinan Kaya <okaya@kernel.org> wrote:
> >
> > Code does unconditional select for IOSF_MBI. IOSF_MBI driver depends on
> > CONFIG_PCI set but this is not specified anywhere.
>
> IMO it would be better to say
>
> "After commit 5d32a66541c46 (PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set) dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly.  For this reason, add a direct dependency on
> CONFIG_PCI to the IOSF_MBI driver."
>
> If you did that, the reviewers would know upfront what this was about
> and that might save at least one back-and-forth e-mail exchange in
> each case.

But, of course, the changelog doesn't even match the patch contents in
this particular case.  Please fix that.
