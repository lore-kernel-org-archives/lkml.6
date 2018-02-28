Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933710AbeB1RRm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:17:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932224AbeB1RRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:17:40 -0500
Date: Wed, 28 Feb 2018 19:17:38 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergio Lopez Pascual <slp@redhat.com>, Baoquan He <bhe@redhat.com>,
        "Somlo, Gabriel" <somlo@cmu.edu>, xiaolong.ye@intel.com
Subject: Re: [PATCH v15 11/11] RFC: fw_cfg: do DMA read operation
Message-ID: <20180228191650-mutt-send-email-mst@kernel.org>
References: <20180215213312.29234-1-marcandre.lureau@redhat.com>
 <20180215213312.29234-12-marcandre.lureau@redhat.com>
 <20180227020104-mutt-send-email-mst@kernel.org>
 <CAMxuvay=4qSLZBVHoPPX+6ZNEmyS2G-69hHqW3HVdxFoS90h1g@mail.gmail.com>
 <20180228173444-mutt-send-email-mst@kernel.org>
 <CAMxuvax37dKhY0jTqbOqjOxQORA=hdDZc3S33b8RFiAbcOLWTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvax37dKhY0jTqbOqjOxQORA=hdDZc3S33b8RFiAbcOLWTg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 04:41:51PM +0100, Marc-André Lureau wrote:
> I don't know if it's always safe to enable dma in read_raw(), how
> could we know? Is there a check we could use to choose one or ther
> other (and thus avoiding explicit dma/readfn argument)?

IMHO the way to go is not to try to do zero copy.
Allocate a buffer and DMA there, then copy.

-- 
MST
