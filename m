Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932638AbeB1QBB convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:01:01 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39983 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932207AbeB1QA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:00:59 -0500
X-Google-Smtp-Source: AG47ELsInYbYyjxuWmAPLuCvk0NR6SThppepSKPGux8wpAYRYxmlZtDqEpl53Ydvpz9n/3uc3KUsS2HsGCyYvkfqFzs=
MIME-Version: 1.0
In-Reply-To: <20180228174635-mutt-send-email-mst@kernel.org>
References: <20180215213312.29234-1-marcandre.lureau@redhat.com>
 <20180215213312.29234-12-marcandre.lureau@redhat.com> <20180227020104-mutt-send-email-mst@kernel.org>
 <CAMxuvay=4qSLZBVHoPPX+6ZNEmyS2G-69hHqW3HVdxFoS90h1g@mail.gmail.com>
 <20180228173444-mutt-send-email-mst@kernel.org> <CAMxuvax37dKhY0jTqbOqjOxQORA=hdDZc3S33b8RFiAbcOLWTg@mail.gmail.com>
 <20180228174635-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 28 Feb 2018 17:00:58 +0100
Message-ID: <CAMxuvaw-v3BagJ6-50sxW24X3c=S-4Xfd5e1Unq8ScNbxKvkSQ@mail.gmail.com>
Subject: Re: [PATCH v15 11/11] RFC: fw_cfg: do DMA read operation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergio Lopez Pascual <slp@redhat.com>, Baoquan He <bhe@redhat.com>,
        "Somlo, Gabriel" <somlo@cmu.edu>, xiaolong.ye@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Wed, Feb 28, 2018 at 4:48 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Feb 28, 2018 at 04:41:51PM +0100, Marc-André Lureau wrote:
>> I don't know if it's always safe to enable dma in read_raw(), how
>> could we know? Is there a check we could use to choose one or ther
>> other (and thus avoiding explicit dma/readfn argument)?
>
> I'm not sure - but does it really matter? Is anyone reading large files
> like this in production where speed matters?
> Why even bother with DMA?

The difference is quite significante for not so small files, as shown above.

And if they access the fw_cfg entries at boot time, or when starting
things etc, this may speed things up.
