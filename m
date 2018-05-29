Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965524AbeE2Ruw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:50:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:49624 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965391AbeE2Ruu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:50:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="60084035"
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@suse.de>
CC: "Williams, Dan J" <dan.j.williams@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3 V2] x86/mce: Fix incorrect "Machine check from
 unknown source" message
Thread-Topic: [PATCH 2/3 V2] x86/mce: Fix incorrect "Machine check from
 unknown source" message
Thread-Index: AQHT92hO7MtQ6LEHR0WNUWwbTC53lqRHbveA//+MfVA=
Date: Tue, 29 May 2018 17:50:48 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D31E24F@ORSMSX110.amr.corp.intel.com>
References: <cover.1527283897.git.tony.luck@intel.com>
 <52e049a497e86fd0b71c529651def8871c804df0.1527283897.git.tony.luck@intel.com>
 <20180528204923.GB30792@zn.tnic> <20180529161549.GB935@agluck-desk>
 <20180529174105.GF19870@zn.tnic>
In-Reply-To: <20180529174105.GF19870@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTAwZTc2NzktOTBhYS00YTdhLWEzNTYtNjgyNDUxNDc4ZGM5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWkFDakYzaXo3U1lwNmR5ZW9EbWdkUXJRV0tzaVpnRVZwN0tsbTd6VkloWWMwMmxqb2Y4SWY2RzlaNnNodmJyMiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: timeout-no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4THp8NZ012421

> It is still assigning.

Ah. That would be because I forgot to "git add" before "git commit --amend" :-(

> I'll simply do:
>
>       if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
>               mce_severity(&m, cfg->tolerant, &msg, true);
>               mce_panic("Local fatal machine check!", &m, msg);
>       }
>
> when committing.

I had put:

		(void) mce_severity(&m, cfg->tolerant, &msg, true);

but either works.

> Btw, I did some cleaning up ontop. Please have a look and let me know if
> it is too ugly to live... :)
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=rc7%2b0-ras

Will look. I hope you didn't do too much to make the stable backport more difficult.

-Tony
 
