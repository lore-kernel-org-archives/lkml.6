Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4874DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B91B20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B91B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387773AbeKFTfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:35:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:52477 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387480AbeKFTfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:35:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 02:11:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,471,1534834800"; 
   d="scan'208";a="89813630"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 06 Nov 2018 02:11:00 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1gJyK2-0003Vt-Od; Tue, 06 Nov 2018 12:10:58 +0200
Date:   Tue, 6 Nov 2018 12:10:58 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        guneshwor.o.singh@intel.com, naveen.m@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com,
        rakesh.a.ughreja@intel.com, sanyog.r.kale@intel.com,
        sriramx.periyasamy@intel.com, Mark Brown <broonie@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, liam.r.girdwood@linux.intel.com,
        yang.jie@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: skl: always select SND_SOC_HDAC_HDA
Message-ID: <20181106101058.GQ10650@smile.fi.intel.com>
References: <20181102112456.780127-1-arnd@arndb.de>
 <943d10e2-299c-4393-f2f5-4ac8bbe400c3@linux.intel.com>
 <CAK8P3a1FCVTuB+ydE6syMHYPWnUW0WTCFDuyMmm35VNnpTTGBw@mail.gmail.com>
 <adc83eaa-b7c0-2c76-a434-f1d5872337f6@linux.intel.com>
 <20181105133545.GF10650@smile.fi.intel.com>
 <CAK8P3a0kdUtK_UuSJEPiWPxhdDULmW6RYEzu-Ug7f8VBoeWVog@mail.gmail.com>
 <s5h1s7z35t8.wl-tiwai@suse.de>
 <5c21e5d9-6a14-ff4f-04f2-9dbfc8665250@linux.intel.com>
 <CAHp75Vc8W6sOOOF4WUaoVD2rGijwG_5J083UG1YFgptTkuzk=w@mail.gmail.com>
 <CAK8P3a3yWJJMqV8mRB9bS0K=+s-nvygCEk+zdSQBU8YjGwx2iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3yWJJMqV8mRB9bS0K=+s-nvygCEk+zdSQBU8YjGwx2iQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 10:19:02PM +0100, Arnd Bergmann wrote:
> On 11/5/18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Nov 5, 2018 at 7:19 PM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:

> >> >> config SND_SOC_HDAC_HDA_FORCE
> >> >>           tristate
> >
> >> >>           depends on SND_SOC_ALL_CODECS != n
> >
> > Forgot to mention that AFAIU above line is no-op in symbols which are
> > hidden.
> >
> 
> It's not. In this case, it will prevent SND_SOC_HDAC_HDA_FORCE
> from being turned on by the 'default ...' line. In other cases, it can
> generate a warning if you have a hidden symbol that is selected
> by some other symbol while the dependency is missing.

Something new to learn.
Thanks, Arnd, for describing this case.

-- 
With Best Regards,
Andy Shevchenko


