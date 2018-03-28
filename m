Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbeC1WAu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 18:00:50 -0400
Received: from resqmta-ch2-11v.sys.comcast.net ([69.252.207.43]:53560 "EHLO
        resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752738AbeC1WAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 18:00:49 -0400
Date: Wed, 28 Mar 2018 17:00:46 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Shakeel Butt <shakeelb@google.com>
cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Greg Thelen <gthelen@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab, slub: skip unnecessary kasan_cache_shutdown()
In-Reply-To: <20180327230603.54721-1-shakeelb@google.com>
Message-ID: <alpine.DEB.2.20.1803281700230.23247@nuc-kabylake>
References: <20180327230603.54721-1-shakeelb@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfIm8wOy0fVHbrEK7c4LQ6CLQMvQH6VB76EdtC50D+iRjSImjqcsfmh2dTW/HkCf368F4LYraN43YZ5vtAQy+oqdC5u6lhL72o5TZ+BP9nIX/xKB9WgWP
 kkDjW08V9ncjq/WoE/C8wjLmI3siQL0/A0QcbcnOIacnmQ4nz94q08lRlb1qh1hX7tqGceS0601iDr9bSzkSbwxpYWkPeyiDL5pp8vlzSIhi7bp9jzxtpZTG
 q/2DBpkqwIdNhAhtmRjQf7AHuZtiWppICr5d5gCqtxpOZYcKo0UjKZqe0BQkZL6BXu9uUCRThtqZiRUdt2T4+oxmht6WT955d/IuMVgVQWFbsmrf0o6q5W+h
 IgoFOLm1KjAQYjAuwZq8LF3iaRb4bLAiP2ihPoxh1Ok4cejVJC1b6W9aFKAmC9TQoJmUjnj1M5iOdQdc0h04WWn/2z9MZdVyEzXug9D+cUMPGinnk5zb9mVU
 XoE3nYb/dQUtMIcQBGFs5RUQynguafj607GcF2dOaqVVRwBQ8YrrL6e5gxE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018, Shakeel Butt wrote:

> The kasan quarantine is designed to delay freeing slab objects to catch
> use-after-free. The quarantine can be large (several percent of machine
> memory size). When kmem_caches are deleted related objects are flushed
> from the quarantine but this requires scanning the entire quarantine
> which can be very slow. We have seen the kernel busily working on this
> while holding slab_mutex and badly affecting cache_reaper, slabinfo
> readers and memcg kmem cache creations.

Acked-by: Christoph Lameter <cl@linux.com>
