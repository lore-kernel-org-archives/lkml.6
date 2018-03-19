Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966634AbeCSULB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:11:01 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34369 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S971068AbeCSUKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:10:53 -0400
X-Google-Smtp-Source: AG47ELtGlpHjmEpd+ldOrsaGAc3eUZ8bKh+/m0rJaQo0hdOa3GvalwaqUqrDqyjVKEqUC+gmt/z81ZhToF8J3L+PgVs=
MIME-Version: 1.0
In-Reply-To: <20180319194513.GA3160@lst.de>
References: <152112908134.24669.10222746224538377035.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152112914933.24669.5543317105428477772.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180319173345.GF1757@magnolia> <CAPcyv4hsLSR=eG8=yLtOhrOaUjqjV5S8pwwmP3oOLrknWQS6Mg@mail.gmail.com>
 <20180319194513.GA3160@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 19 Mar 2018 13:10:52 -0700
Message-ID: <CAPcyv4hhM3py_YG-qYcAxsqdCZT1aM+ziKffijVManPngbCg_A@mail.gmail.com>
Subject: Re: [PATCH v6 12/15] xfs: require mmap lock for xfs_break_layouts()
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 12:45 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Mar 19, 2018 at 10:57:55AM -0700, Dan Williams wrote:
>> I don't see anything to adapt with respect to mmap locks since reflink
>> and dax are mutually exclusive.
>
> For now.  I'll change that pretty soon.

Right, so which patch set will be staged first? This one or the one
that causes us to consider reflink vs dax locking?
