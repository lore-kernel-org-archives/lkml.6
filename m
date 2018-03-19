Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965290AbeCSVXX convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:23:23 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:54408 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934724AbeCSVXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:23:20 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Zhenyu Wang" <zhenyuw@linux.intel.com>,
        "Zhi Wang" <zhi.a.wang@intel.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "David Airlie" <airlied@linux.ie>
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <8f70ff7b-9575-006b-2384-88899f24fda6@embeddedor.com>
Cc: intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180319193053.GA7016@embeddedgus>
 <152149190651.3594.5036347331521892974@mail.alporthouse.com>
 <8f70ff7b-9575-006b-2384-88899f24fda6@embeddedor.com>
Message-ID: <152149459549.3594.15219721825785440264@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH] drm/i915/gvt/scheduler: fix potential NULL pointer dereference
Date: Mon, 19 Mar 2018 21:23:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gustavo A. R. Silva (2018-03-19 20:50:12)
> Hi Chris,
> 
> On 03/19/2018 03:38 PM, Chris Wilson wrote:
> > Quoting Gustavo A. R. Silva (2018-03-19 19:30:53)
> >> _workload_ is being dereferenced before it is null checked, hence
> >> there is a potential null pointer dereference.
> >>
> >> Fix this by moving the pointer dereference after _workload_ has
> >> been null checked.
> > 
> > The checks are misleading and not required.
> 
> All of them?
> 
> if (!workload || !reg_state || workload->ring_id != RCS)
>         return;

workload can not be NULL (dereference in caller), reg_state can not be
NULL (by construct from kmap()).

It may be not an RCS ring through.
-Chris
