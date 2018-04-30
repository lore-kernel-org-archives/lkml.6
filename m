Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbeD3Oth (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 10:49:37 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:38706 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754354AbeD3Otd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 10:49:33 -0400
X-Google-Smtp-Source: AB8JxZpY0flfz3iO/BsTAk9vffDL+sQv09jTqnORaY1A1fPu4rbDkHAL5tJewqFqwEf3NlLTMmFS7A==
Date: Mon, 30 Apr 2018 08:49:30 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: jackm <jackm@dev.mellanox.co.il>
Cc: =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Doug Ledford <dledford@redhat.com>, Don Hiatt <don.hiatt@intel.com>,
        Dasaratharaman Chandramouli
        <dasaratharaman.chandramouli@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Sean Hefty <sean.hefty@intel.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/core: Make ib_mad_client_id atomic
Message-ID: <20180430144930.GB26895@ziepe.ca>
References: <20180418142450.15581-1-Haakon.Bugge@oracle.com>
 <1524196555.11756.30.camel@redhat.com>
 <20180420153451.GF30433@ziepe.ca>
 <50E3FE4A-2C6E-4493-92E1-383C349FAE3A@oracle.com>
 <20180423221618.0000795d@dev.mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423221618.0000795d@dev.mellanox.co.il>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 10:16:18PM +0300, jackm wrote:

> > > TIDs need to be globally unique on the entire machine.  

> Jason, that is not exactly correct.

The expecation for /dev/umad users is that they all receive locally
unique TID prefixes. The kernel may be OK to keep things port-specific
but it is slightly breaking the API we are presenting to userspace to
allow them to alias..

Jason
