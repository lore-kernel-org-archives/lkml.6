Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeDBOTG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 10:19:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:12098 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751418AbeDBOTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 10:19:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,395,1517904000";
   d="scan'208";a="29487120"
Date: Mon, 2 Apr 2018 08:21:42 -0600
From: Keith Busch <keith.busch@intel.com>
To: Rodrigo Rosatti Galvao <rosattig@linux.vnet.ibm.com>
Cc: chaitany kulkarni <ckulkarnilinux@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet: fix nvmet_execute_write_zeroes function
Message-ID: <20180402142141.GC28945@localhost.localdomain>
References: <1522444730-2060-1-git-send-email-rosattig@linux.vnet.ibm.com>
 <20180330212439.GA28945@localhost.localdomain>
 <93622938-f532-b8ac-2bca-fe40ed759e71@linux.vnet.ibm.com>
 <CAK0tqikdyFoZGuRnh3_YXKtrY9NqEZVv5AysL+xGKpvGJ762fA@mail.gmail.com>
 <8a3d1471-571d-3352-1414-bf2051e2ebb9@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a3d1471-571d-3352-1414-bf2051e2ebb9@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 10:47:10AM -0300, Rodrigo Rosatti Galvao wrote:
> One thing that I just forgot to explain previously, but I think its
> relevant:
> 
> 1. The command is failing with 4k logical block size, but works with 512B
> 
> 2. With the patch, the command is working for both 512B and 4K.

While you're not getting errors with your patch, you're not zeroing out
the requested blocks, so that's a data corruption.

The issue is the +1 is in the wrong place. It needs to be added to the
native format prior to converting it to a 512b sector count. Do you want
to resend with that change?
