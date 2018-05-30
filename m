Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030253AbeE3Igv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:36:51 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46760 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936044AbeE3Igr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:36:47 -0400
X-Google-Smtp-Source: ADUXVKIh0dsrrow5cPZAO5HO8uTQreKdJt6Cb55e4mV0NzONYAzXjwru7A0fAm09fBlu/Bwi1DDKX7BRFNpq3aHgQiY=
MIME-Version: 1.0
X-Originating-IP: [194.176.227.33]
In-Reply-To: <CAJfpeguJ+h5A4ALS3=actNH5UMSWF8Fgoo-RLbmfGuDf0tJicA@mail.gmail.com>
References: <20180529132148.GC23785@veci.piliscsaba.redhat.com>
 <20180529135938.GA5631@infradead.org> <CAJfpeguJ+h5A4ALS3=actNH5UMSWF8Fgoo-RLbmfGuDf0tJicA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 30 May 2018 10:36:46 +0200
Message-ID: <CAJfpegvCR4+j0t1dzM=Mvh05JBkz4R5A4Jp=USTtGBeWEL6dGQ@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs update for 4.18
To: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 4:12 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Tue, May 29, 2018 at 3:59 PM, Christoph Hellwig <hch@infradead.org> wrote:

>>>       vfs: export vfs_dedupe_file_range_one() to modules
>>
>> Please use EXPORT_SYMBOL_GPL for all these crazy low-level exports.

I'd argue with the "crazy" part.  This should have been the primary
interface from the start.  The batched dedupe interface is the crazy
one:

 - deduping is page size granularity at worst; performance would not
be horrible even if we had to do one syscall per page
 - vast majority of the time it will be file size granularity

Why was that batching invented in the first place?

Thanks,
Miklos
