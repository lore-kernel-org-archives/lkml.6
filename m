Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754789AbeCGXKh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 18:10:37 -0500
Received: from mga02.intel.com ([134.134.136.20]:16980 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754052AbeCGXKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 18:10:36 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,437,1515484800";
   d="scan'208";a="206369776"
Date: Wed, 7 Mar 2018 15:45:36 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc: "jonas.rabenstein@studium.uni-erlangen.de"
        <jonas.rabenstein@studium.uni-erlangen.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH][RESEND] block: sed-opal: fix response string extraction
Message-ID: <20180307224535.g4qo2abw3vyyfxlp@sbauer-Z170X-UD5>
References: <20180301132637.1230-1-jonas.rabenstein@studium.uni-erlangen.de>
 <1520382203.4178.87.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520382203.4178.87.camel@intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 04:23:24PM -0800, Derrick, Jonathan wrote:
> This looks correct.
> 
> Adding my Ack unless Scott has objections
> 
> Acked-by: Jonathan Derrick <jonathan.derrick@intel.com>


Reviewed-by: Scott Bauer <scott.bauer@intel.com>

Nice catch Jonas! Sorry you had to resend, my message filtering was a little
too agressive and this slipped through the cracks, that has been remediated.


> 
> On Thu, 2018-03-01 at 14:26 +0100, Jonas Rabenstein wrote:
> > Tokens are prefixed by a variable length of bytes. If a bytestring is
> > not stored in an tiny or short atom, we have to skip more than one
> > byte
> > in order to have the actual bytes not prefixed by the bytes
> > describing
> > the actual length of the string.
> > 
> > Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlange
> > n.de>
> > ---
> >  block/sed-opal.c | 26 +++++++++++++++++++++++---
> >  1 file changed, 23 insertions(+), 3 deletions(-)
