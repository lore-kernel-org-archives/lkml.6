Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967192AbeBNKZ1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:25:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:55254 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966996AbeBNKZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:25:26 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,511,1511856000";
   d="scan'208";a="17790904"
Date: Wed, 14 Feb 2018 12:25:21 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Radion Mirchevsky <radion.mirchevsky@intel.com>
Subject: Re: [PATCH 12/18] thunderbolt: Add tb_xdomain_find_by_route()
Message-ID: <20180214102521.GO27191@lahna.fi.intel.com>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
 <20180213170018.9780-13-mika.westerberg@linux.intel.com>
 <CAHp75Vcz8vpW0Ahev8NgpO6irV-btmvkrbyuTjXYdQitAw2HQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vcz8vpW0Ahev8NgpO6irV-btmvkrbyuTjXYdQitAw2HQQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 07:51:21PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 13, 2018 at 7:00 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > From: Radion Mirchevsky <radion.mirchevsky@intel.com>
> >
> > This is needed by the new ICM interface to find xdomains by route string
> > instead of link and depth.
> 
> > +       xd = switch_find_xdomain(tb->root_switch, &lookup);
> 
> > +       if (xd) {
> > +               get_device(&xd->dev);
> > +               return xd;
> > +       }
> > +
> > +       return NULL;
> 
> return tb_xdomain_get(xd);

Indeed, that can be used here as well. I'll change it in v2.
