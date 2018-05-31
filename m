Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755873AbeEaRa1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:30:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:32842 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755830AbeEaRa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:30:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="44300267"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: James Simmons <jsimmons@infradead.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "Drokin, Oleg" <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>,
        "Hammond, John" <john.hammond@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH v2 6/6] staging: lustre: mdc: use large xattr buffers
 for old servers
Thread-Topic: [PATCH v2 6/6] staging: lustre: mdc: use large xattr buffers
 for old servers
Thread-Index: AQHT+QAZU3E1b4pl5kivVFHYDbsEJ6RKjXSA
Date: Thu, 31 May 2018 17:30:24 +0000
Message-ID: <AE3B1D00-46A8-42FA-9025-2E680C185294@intel.com>
References: <1527603705-30450-1-git-send-email-jsimmons@infradead.org>
 <1527603705-30450-7-git-send-email-jsimmons@infradead.org>
 <20180531165426.GA23414@kroah.com>
In-Reply-To: <20180531165426.GA23414@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.6.188]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DA4F57CEC55E1840816133662E3612B0@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 31, 2018, at 18:54, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> On Tue, May 29, 2018 at 10:21:45AM -0400, James Simmons wrote:
>> From: "John L. Hammond" <john.hammond@intel.com>
>> 
>> Pre 2.10.1 MDTs will crash when they receive a listxattr (MDS_GETXATTR
>> with OBD_MD_FLXATTRLS) RPC for an orphan or dead object. So for
>> clients connected to these older MDTs, try to avoid sending listxattr
>> RPCs by making the bulk getxattr (MDS_GETXATTR with OBD_MD_FLXATTRALL)
>> more likely to succeed and thereby reducing the chances of falling
>> back to listxattr.
>> 
>> +#if LUSTRE_VERSION_CODE < OBD_OCD_VERSION(3, 0, 53, 0)
> 
> Why are you adding pointless version checks to mainline?  Please don't
> add new ones of these, you need to be working on removing the existing
> ones.

These are not Linux kernel version checks, but rather Lustre release version
checks.  This allows us to remove workarounds like this in the future when
they are no longer needed, rather than accumulating cruft forever.  It's like
the separation of NFSv2 vs NFSv3 vs NFSv4.

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
