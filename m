Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbeDJM4z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:56:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:65190 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752958AbeDJM4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:56:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,432,1517904000";
   d="scan'208";a="45711019"
Date: Tue, 10 Apr 2018 21:00:02 +0800
From: Yu Chen <yu.c.chen@intel.com>
To: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH][RFC] tools/power turbostat: if --max_loop, print for
 specific time of loops
Message-ID: <20180410130002.GB29464@yu-chen.sh.intel.com>
References: <20180410101831.28530-1-yu.c.chen@intel.com>
 <1523358141.2753.194.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523358141.2753.194.camel@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Apr 10, 2018 at 07:02:22PM +0800, Bityutskiy, Artem wrote:
> On Tue, 2018-04-10 at 18:18 +0800, Yu Chen wrote:
> > @@ -5076,6 +5084,15 @@ void cmdline(int argc, char **argv)
> >                         print_version();
> >                         exit(0);
> >                         break;
> > +               case 'x':
> > +                       {
> > +                               unsigned int loops = strtod(optarg, NULL);
> 
> It would make sense to error out here if you get a value <= 0.
> 
OK.
> > +
> > +                               if (loops % 2)
> > +                                       loops++;
> 
> What is this for?
> 
It was intended to make the number of loops even for simplify.
But after rethink about this, it might not be necessary. I'll
change it.

> > +                               max_loops = loops;
> 
> Is the "loops" variable really needed? Can you strtod directly to
> max_loops?
If the sanity check for user input is added then I think the local
variable is needed.

Thanks,
Yu
> 
> -- 
> Best Regards,
> Artem Bityutskiy
