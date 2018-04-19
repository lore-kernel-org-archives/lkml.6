Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753008AbeDSBwB convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 21:52:01 -0400
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:55809
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752700AbeDSBwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 21:52:00 -0400
X-ASG-Debug-ID: 1524102717-093b7e10b3c3990001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To: "sohil.mehta@intel.com" <sohil.mehta@intel.com>,
        "gary.hook@amd.com" <gary.hook@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "ghook@amd.com" <ghook@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Thread-Topic: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
X-ASG-Orig-Subj: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Thread-Index: AQHT1tpRJAZW59A4ZEqPfHlYD/OogKQFmZcAgAAR5ACAAMT2gIAACcYAgABT/QA=
Date: Thu, 19 Apr 2018 01:52:02 +0000
Message-ID: <1524102722.10902.1.camel@hxt-semitech.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
         <152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
         <1523664612.2747.13.camel@intel.com>
         <efa2b7a3-04a7-20b1-3651-89ebafa85c27@amd.com>
         <1524031122.4031.5.camel@hxt-semitech.com>
         <1524036520.2747.31.camel@intel.com>
         <1524040290.4031.25.camel@hxt-semitech.com>
         <1524082659.2747.37.camel@intel.com>
         <151f3396-959b-86f6-e056-58d38682d858@amd.com>
In-Reply-To: <151f3396-959b-86f6-e056-58d38682d858@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.6.5]
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <156E9AA99371004CA43B33CE2A76ADFD@hxt-semitech.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: localhost[10.128.0.15]
X-Barracuda-Start-Time: 1524102717
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.6345 1.0000 0.9281
X-Barracuda-Spam-Score: 1.43
X-Barracuda-Spam-Status: No, SCORE=1.43 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.50042
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Gary,

On Wed, 2018-04-18 at 16:51 -0400, Hook, Gary wrote:
> On 4/18/2018 4:16 PM, Mehta, Sohil wrote:
> > 
> > On Wed, 2018-04-18 at 08:31 +0000, Yang, Shunyong wrote:
> > > 
> > > Maybe the original design is to call debugfs_initialized() before
> > > calling debugfs_create_xxx()?
> > I am unaware of the original design. Someone else would probably
> > have
> > more context. However, looking at other places in the kernel where
> > debugfs_create_xx() is used, the common convention seems to be to
> > avoid
> > calling debugfs_initialized().
> > 
> >   Sohil
> > 
> debugfs_initialized() was introduced in commit c0f92ba99 back in 
> 2.6.30-rc1. It was intended as a helper, not as a gatekeeper, which
> is 
> why one doesn't see it used. Given that my use in this proposed patch
> is 
> straightforward, I'm not seeing the need here. I had just seen some 
> other code that used it, and copied the model.
> 
> Unless someone comes along to say, yes, use it, I'll not.
> 

I agree with you and Sohil on removing the unnecessary function
calling.

Thanks.
Shunyong.


> Gary
