Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeDYGMN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 02:12:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:53696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbeDYGMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 02:12:12 -0400
Subject: Re: [Xen-devel] [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper
 DRM driver
To: Dongwon Kim <dongwon.kim@intel.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: Wei Liu <wei.liu2@citrix.com>, Artem Mygaiev <Artem_Mygaiev@epam.com>,
        konrad.wilk@oracle.com, airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "Potrola, MateuszX" <mateuszx.potrola@intel.com>,
        daniel.vetter@intel.com, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>
References: <41487acb-a67a-8933-d0c3-702c19b0938e@gmail.com>
 <20180418073508.ptvntwedczpvl7bx@MacBook-Pro-de-Roger.local>
 <ebcbf6ce-1d7a-5f3e-cff8-546d1c010e59@gmail.com>
 <20180418101058.hyqk3gr3b2ibxswu@MacBook-Pro-de-Roger.local>
 <20180420071914.GG31310@phenom.ffwll.local>
 <76cdc65a-7bb1-9377-7bc5-6164e32f7b5d@gmail.com>
 <20180423115242.ywdwqblj2aseu3fr@citrix.com>
 <61105351-8896-072b-abf0-757c7f6c0edf@gmail.com>
 <20180424115437.GT31310@phenom.ffwll.local>
 <18ab5f76-00b0-42a0-fcb8-e0cbf4cdd527@gmail.com>
 <20180424203514.GA26787@downor-Z87X-UD5H>
From: Juergen Gross <jgross@suse.com>
Message-ID: <bdeeb76f-ea65-083b-dde4-450584edb068@suse.com>
Date: Wed, 25 Apr 2018 08:12:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424203514.GA26787@downor-Z87X-UD5H>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/18 22:35, Dongwon Kim wrote:
> Had a meeting with Daniel and talked about bringing out generic
> part of hyper-dmabuf to the userspace, which means we most likely
> reuse IOCTLs defined in xen-zcopy for our use-case if we follow
> his suggestion.
> 
> So assuming we use these IOCTLs as they are,
> Several things I would like you to double-check..
> 
> 1. returning gref as is to the user space is still unsafe because
> it is a constant, easy to guess and any process that hijacks it can easily
> exploit the buffer. So I am wondering if it's possible to keep dmabuf-to
> -gref or gref-to-dmabuf in kernel space and add other layers on top
> of those in actual IOCTLs to add some safety.. We introduced flink like
> hyper_dmabuf_id including random number but many says even that is still
> not safe.

grefs are usable by root only. When you have root access in dom0 you can
do evil things to all VMs even without using grants. That is in no way
different to root being able to control all other processes on the
system.


Juergen
