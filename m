Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeFEImY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbeFEImX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:42:23 -0400
Date: Tue, 5 Jun 2018 10:42:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
Cc: Sayali Lokhande <sayalil@codeaurora.org>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V1 3/3] scsi: ufs: Add sysfs support for ufs provision
Message-ID: <20180605084200.GB8665@kroah.com>
References: <1527849774-7623-1-git-send-email-sayalil@codeaurora.org>
 <1527849774-7623-4-git-send-email-sayalil@codeaurora.org>
 <MWHPR04MB113794E2654BEDA8E927F0FC9A660@MWHPR04MB1137.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR04MB113794E2654BEDA8E927F0FC9A660@MWHPR04MB1137.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 08:16:50AM +0000, Stanislav Nijnikov wrote:
> Hi Sayali,
> 
> I think that passing an array of values in a string is not proper way
> to work with a sysfs entry. There are binary attributes to do such
> things.

No, don't do that, sysfs is for "one value per file", and binary
attributes are for "hardware value pass-through" type stuff.  Unless
this is "raw" data straight from the hardware, binary does not work, and
neither does a normal sysfs file either.

So this needs to be reworked please.

thanks,

greg k-h
