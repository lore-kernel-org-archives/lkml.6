Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeC2Wr7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:47:59 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:37143 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbeC2Wr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:47:56 -0400
X-Google-Smtp-Source: AIpwx49fdpjjycbDRgk8whpUVv/f0reLv3Vl0PeV3PHAt9OeL9iJ8Haw8/0Q/ieDJeE4ulXKimHISAv467kKGn71p68=
MIME-Version: 1.0
In-Reply-To: <20180329180927.GA16055@lst.de>
References: <152167302988.5268.4370226749268662682.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152167305782.5268.13485258587227210521.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180329154035.lvsepjvt6vcplshw@quack2.suse.cz> <20180329180927.GA16055@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 29 Mar 2018 15:47:55 -0700
Message-ID: <CAPcyv4gknYC3WUEEfGjNH8ufFvokdZarSaZUm-cczCXyEz_D0w@mail.gmail.com>
Subject: Re: [PATCH v7 05/14] ext4, dax: introduce ext4_dax_aops
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>, david <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 11:09 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Thu, Mar 29, 2018 at 05:40:35PM +0200, Jan Kara wrote:
>> So ext4_direct_IO() for IS_DAX() files will just bail out. So could you
>> just provide ext4_dax_direct_IO() which will bail out and use it here? With
>> a similar comment as in xfs_vm_direct_IO() that open still needs this
>> method set... Thanks!
>
> In fact a common noop_direct_IO might make sense.

Ok, I introduced noop_direct_IO() in "fs, dax: prepare for
dax-specific address_space_operations", and cleaned up xfs, ext4, and
ext2 accordingly. Let me know if you want to see a resend of the
series with those changes. Otherwise this will appear in -next
shortly.
