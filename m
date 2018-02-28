Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeB1RWd convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:22:33 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:34337 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753071AbeB1RWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:22:30 -0500
X-Google-Smtp-Source: AG47ELucTTieEMva7MFxbHpYXYLvvaE6IZSEAhxykbyK7HYrgUXqbFdwOuSVZ1yGD//eioB2XFfEsebDdxFyhQ9u3LQ=
MIME-Version: 1.0
In-Reply-To: <20180228191650-mutt-send-email-mst@kernel.org>
References: <20180215213312.29234-1-marcandre.lureau@redhat.com>
 <20180215213312.29234-12-marcandre.lureau@redhat.com> <20180227020104-mutt-send-email-mst@kernel.org>
 <CAMxuvay=4qSLZBVHoPPX+6ZNEmyS2G-69hHqW3HVdxFoS90h1g@mail.gmail.com>
 <20180228173444-mutt-send-email-mst@kernel.org> <CAMxuvax37dKhY0jTqbOqjOxQORA=hdDZc3S33b8RFiAbcOLWTg@mail.gmail.com>
 <20180228191650-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 28 Feb 2018 18:22:29 +0100
Message-ID: <CAMxuvayJD1O4gz-E0B--E1VMXqbb3u10D8W=CAtOaQPeoYuvuQ@mail.gmail.com>
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

On Wed, Feb 28, 2018 at 6:17 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Feb 28, 2018 at 04:41:51PM +0100, Marc-André Lureau wrote:
>> I don't know if it's always safe to enable dma in read_raw(), how
>> could we know? Is there a check we could use to choose one or ther
>> other (and thus avoiding explicit dma/readfn argument)?
>
> IMHO the way to go is not to try to do zero copy.
> Allocate a buffer and DMA there, then copy.

Sounds fine to me, I'll resend this patch separately if the rest from
v16 is applied.

thanks
