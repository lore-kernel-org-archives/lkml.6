Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965043AbeE2QNW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:13:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:43448 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935383AbeE2QNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:13:21 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="53169757"
Date: Tue, 29 May 2018 09:13:20 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/mce: Fix incorrect "Machine check from unknown
 source" message
Message-ID: <20180529161319.GA935@agluck-desk>
References: <cover.1527283897.git.tony.luck@intel.com>
 <52e049a497e86fd0b71c529651def8871c804df0.1527283897.git.tony.luck@intel.com>
 <20180529104222.GA19870@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529104222.GA19870@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 12:42:22PM +0200, Borislav Petkov wrote:
> > +		 * fatal error. We call "mce_severity()" again to
> > +		 * make sure we have the right "msg".
> >  		 */
> > -		 if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3)
> > -			mce_panic("Machine check from unknown source",
> > -				NULL, NULL);
> > +		if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
> > +			severity = mce_severity(&m, cfg->tolerant, &msg, true);
> 
> Looking at this more while cleaning the whole thing up, that severity
> doesn't get read anywhere past this line, AFAICT...

Just making the call to update "msg" (see comment). But you are right
that we don't need to update the severity variable. I'll fix that in
the re-spin to make the messages more than slightly different.

-Tony
