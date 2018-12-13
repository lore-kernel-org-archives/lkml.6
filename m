Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14F5C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2944D20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrbK8IHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2944D20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbeLMMay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:30:54 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51642 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbeLMMay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:30:54 -0500
Received: by mail-it1-f194.google.com with SMTP id x19so3386654itl.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 04:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwzqeSKwsrnU2tfndaSuGeSXgAOVE2Uo9XTs4RpoPv0=;
        b=qrbK8IHJMbyWNOKunC7E6tQ0of4rGl/gvHkrlXA9FsGFwbRy/4iz8t2HgIBqE9435a
         I4lVf9CS/slnkY1Qi9rNyHrheHk/GAY73muRh1fKhKXgzs62qKRYvU9AStNt2WSafnga
         cZXB/HHUOGoHBjGfCdquRPmA6BR6FzR62k2H+jb5cp15B0Olahst0pkvgugNH7ftpVxA
         pSlrdZdIhZnjVe0iJ5lDWl1Ba1qVCHI8OvE6xIts6mHX3rDCg84lfTPCYOOXvbOoJzzB
         IH2znA2PUutMNOmwHJvh/Whj9qNLB7v1szD2dZ1pBB/bq6b9tF/HLO3TgRhRtQyKaRBU
         xzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwzqeSKwsrnU2tfndaSuGeSXgAOVE2Uo9XTs4RpoPv0=;
        b=lO5ZxyXCVBPMIvVvurqKJlQLwZOkqNdf3bpohwnNpKuxpLdprIWAGp3OyHSNcf8BIC
         mOskfgCpt6tBMn0SHXoKmNHcXedEeFzS9SkZAOHr0s5u5k/8FMlo5wHeEYE5/QsqG/9q
         f9xrfGLmVUfXorvKo85TJbNwyh/D1ua54gqfbU6GL23F2WrXzj9KCctsUreyPkYkOOfL
         OgQz8hsGFcgcpxHii0DPwRO9U7sG2M4tMADH/1YGS/rLZbpyRkSRlIJWQ8iAmYdtr580
         GHdyjwSJobkgWSYc22OlUSaDH4ZpU2ZSusvbdw0gkumj2/RaXdjR8BRYDTcHGYR9YTD8
         AEkQ==
X-Gm-Message-State: AA+aEWadiGqAu354LVxRi25cV/HUCFiO/wItTBO6f5cXswf1RLN6vCUn
        J/7ko0PYs87RNZ8mX6jLTRSNYXgJbWGluDYTkEE=
X-Google-Smtp-Source: AFSGD/Ul4aWnPRRNdr/KM6dgHdJROOThTDHLVrcbTn+vvh5oFkePGvF/eXKRf0pnqVgtYZcRj8Yf+5GNZf9F+JjnPGQ=
X-Received: by 2002:a24:6e88:: with SMTP id w130mr8958893itc.103.1544704250079;
 Thu, 13 Dec 2018 04:30:50 -0800 (PST)
MIME-Version: 1.0
References: <20180907165635.8469-1-kent.overstreet@gmail.com> <20180907165635.8469-7-kent.overstreet@gmail.com>
In-Reply-To: <20180907165635.8469-7-kent.overstreet@gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Thu, 13 Dec 2018 21:30:47 +0900
Message-ID: <CADvbK_ccPYY5jGRV+cLNc5Nzcfv0mq0eNMeU-ALvepax0ZSizQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] Drop flex_arrays
To:     kent.overstreet@gmail.com
Cc:     LKML <linux-kernel@vger.kernel.org>, dave.hansen@intel.com,
        willy@infradead.org, davem <davem@davemloft.net>,
        Neil Horman <nhorman@tuxdriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 1:57 AM Kent Overstreet
<kent.overstreet@gmail.com> wrote:
>
> All existing users have been converted to generic radix trees
NAK, SCTP is still using flex_arrays,
# grep flex_array net/sctp/*

This patch will break the build.

>
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> Acked-by: Dave Hansen <dave.hansen@intel.com>
> ---
>  Documentation/core-api/flexible-arrays.rst | 130 -------
>  Documentation/flexible-arrays.txt          | 123 -------
>  include/linux/flex_array.h                 | 149 --------
>  include/linux/poison.h                     |   3 -
>  lib/Makefile                               |   2 +-
>  lib/flex_array.c                           | 398 ---------------------
>  tools/include/linux/poison.h               |   3 -
>  7 files changed, 1 insertion(+), 807 deletions(-)
>  delete mode 100644 Documentation/core-api/flexible-arrays.rst
>  delete mode 100644 Documentation/flexible-arrays.txt
>  delete mode 100644 include/linux/flex_array.h
>  delete mode 100644 lib/flex_array.c
>
> diff --git a/Documentation/core-api/flexible-arrays.rst b/Documentation/core-api/flexible-arrays.rst
> deleted file mode 100644
> index b6b85a1b51..0000000000
> --- a/Documentation/core-api/flexible-arrays.rst
> +++ /dev/null
> @@ -1,130 +0,0 @@
> -
> -===================================
> -Using flexible arrays in the kernel
> -===================================
> -
> -Large contiguous memory allocations can be unreliable in the Linux kernel.
> -Kernel programmers will sometimes respond to this problem by allocating
> -pages with :c:func:`vmalloc()`.  This solution not ideal, though.  On 32-bit
> -systems, memory from vmalloc() must be mapped into a relatively small address
> -space; it's easy to run out.  On SMP systems, the page table changes required
> -by vmalloc() allocations can require expensive cross-processor interrupts on
> -all CPUs.  And, on all systems, use of space in the vmalloc() range increases
> -pressure on the translation lookaside buffer (TLB), reducing the performance
> -of the system.
> -
> -In many cases, the need for memory from vmalloc() can be eliminated by piecing
> -together an array from smaller parts; the flexible array library exists to make
> -this task easier.
> -
> -A flexible array holds an arbitrary (within limits) number of fixed-sized
> -objects, accessed via an integer index.  Sparse arrays are handled
> -reasonably well.  Only single-page allocations are made, so memory
> -allocation failures should be relatively rare.  The down sides are that the
> -arrays cannot be indexed directly, individual object size cannot exceed the
> -system page size, and putting data into a flexible array requires a copy
> -operation.  It's also worth noting that flexible arrays do no internal
> -locking at all; if concurrent access to an array is possible, then the
> -caller must arrange for appropriate mutual exclusion.
> -
> -The creation of a flexible array is done with :c:func:`flex_array_alloc()`::
> -
> -    #include <linux/flex_array.h>
> -
> -    struct flex_array *flex_array_alloc(int element_size,
> -                                       unsigned int total,
> -                                       gfp_t flags);
> -
> -The individual object size is provided by ``element_size``, while total is the
> -maximum number of objects which can be stored in the array.  The flags
> -argument is passed directly to the internal memory allocation calls.  With
> -the current code, using flags to ask for high memory is likely to lead to
> -notably unpleasant side effects.
> -
> -It is also possible to define flexible arrays at compile time with::
> -
> -    DEFINE_FLEX_ARRAY(name, element_size, total);
> -
> -This macro will result in a definition of an array with the given name; the
> -element size and total will be checked for validity at compile time.
> -
> -Storing data into a flexible array is accomplished with a call to
> -:c:func:`flex_array_put()`::
> -
> -    int flex_array_put(struct flex_array *array, unsigned int element_nr,
> -                      void *src, gfp_t flags);
> -
> -This call will copy the data from src into the array, in the position
> -indicated by ``element_nr`` (which must be less than the maximum specified when
> -the array was created).  If any memory allocations must be performed, flags
> -will be used.  The return value is zero on success, a negative error code
> -otherwise.
> -
> -There might possibly be a need to store data into a flexible array while
> -running in some sort of atomic context; in this situation, sleeping in the
> -memory allocator would be a bad thing.  That can be avoided by using
> -``GFP_ATOMIC`` for the flags value, but, often, there is a better way.  The
> -trick is to ensure that any needed memory allocations are done before
> -entering atomic context, using :c:func:`flex_array_prealloc()`::
> -
> -    int flex_array_prealloc(struct flex_array *array, unsigned int start,
> -                           unsigned int nr_elements, gfp_t flags);
> -
> -This function will ensure that memory for the elements indexed in the range
> -defined by ``start`` and ``nr_elements`` has been allocated.  Thereafter, a
> -``flex_array_put()`` call on an element in that range is guaranteed not to
> -block.
> -
> -Getting data back out of the array is done with :c:func:`flex_array_get()`::
> -
> -    void *flex_array_get(struct flex_array *fa, unsigned int element_nr);
> -
> -The return value is a pointer to the data element, or NULL if that
> -particular element has never been allocated.
> -
> -Note that it is possible to get back a valid pointer for an element which
> -has never been stored in the array.  Memory for array elements is allocated
> -one page at a time; a single allocation could provide memory for several
> -adjacent elements.  Flexible array elements are normally initialized to the
> -value ``FLEX_ARRAY_FREE`` (defined as 0x6c in <linux/poison.h>), so errors
> -involving that number probably result from use of unstored array entries.
> -Note that, if array elements are allocated with ``__GFP_ZERO``, they will be
> -initialized to zero and this poisoning will not happen.
> -
> -Individual elements in the array can be cleared with
> -:c:func:`flex_array_clear()`::
> -
> -    int flex_array_clear(struct flex_array *array, unsigned int element_nr);
> -
> -This function will set the given element to ``FLEX_ARRAY_FREE`` and return
> -zero.  If storage for the indicated element is not allocated for the array,
> -``flex_array_clear()`` will return ``-EINVAL`` instead.  Note that clearing an
> -element does not release the storage associated with it; to reduce the
> -allocated size of an array, call :c:func:`flex_array_shrink()`::
> -
> -    int flex_array_shrink(struct flex_array *array);
> -
> -The return value will be the number of pages of memory actually freed.
> -This function works by scanning the array for pages containing nothing but
> -``FLEX_ARRAY_FREE`` bytes, so (1) it can be expensive, and (2) it will not work
> -if the array's pages are allocated with ``__GFP_ZERO``.
> -
> -It is possible to remove all elements of an array with a call to
> -:c:func:`flex_array_free_parts()`::
> -
> -    void flex_array_free_parts(struct flex_array *array);
> -
> -This call frees all elements, but leaves the array itself in place.
> -Freeing the entire array is done with :c:func:`flex_array_free()`::
> -
> -    void flex_array_free(struct flex_array *array);
> -
> -As of this writing, there are no users of flexible arrays in the mainline
> -kernel.  The functions described here are also not exported to modules;
> -that will probably be fixed when somebody comes up with a need for it.
> -
> -
> -Flexible array functions
> -------------------------
> -
> -.. kernel-doc:: include/linux/flex_array.h
> diff --git a/Documentation/flexible-arrays.txt b/Documentation/flexible-arrays.txt
> deleted file mode 100644
> index a0f2989dd8..0000000000
> --- a/Documentation/flexible-arrays.txt
> +++ /dev/null
> @@ -1,123 +0,0 @@
> -===================================
> -Using flexible arrays in the kernel
> -===================================
> -
> -:Updated: Last updated for 2.6.32
> -:Author: Jonathan Corbet <corbet@lwn.net>
> -
> -Large contiguous memory allocations can be unreliable in the Linux kernel.
> -Kernel programmers will sometimes respond to this problem by allocating
> -pages with vmalloc().  This solution not ideal, though.  On 32-bit systems,
> -memory from vmalloc() must be mapped into a relatively small address space;
> -it's easy to run out.  On SMP systems, the page table changes required by
> -vmalloc() allocations can require expensive cross-processor interrupts on
> -all CPUs.  And, on all systems, use of space in the vmalloc() range
> -increases pressure on the translation lookaside buffer (TLB), reducing the
> -performance of the system.
> -
> -In many cases, the need for memory from vmalloc() can be eliminated by
> -piecing together an array from smaller parts; the flexible array library
> -exists to make this task easier.
> -
> -A flexible array holds an arbitrary (within limits) number of fixed-sized
> -objects, accessed via an integer index.  Sparse arrays are handled
> -reasonably well.  Only single-page allocations are made, so memory
> -allocation failures should be relatively rare.  The down sides are that the
> -arrays cannot be indexed directly, individual object size cannot exceed the
> -system page size, and putting data into a flexible array requires a copy
> -operation.  It's also worth noting that flexible arrays do no internal
> -locking at all; if concurrent access to an array is possible, then the
> -caller must arrange for appropriate mutual exclusion.
> -
> -The creation of a flexible array is done with::
> -
> -    #include <linux/flex_array.h>
> -
> -    struct flex_array *flex_array_alloc(int element_size,
> -                                       unsigned int total,
> -                                       gfp_t flags);
> -
> -The individual object size is provided by element_size, while total is the
> -maximum number of objects which can be stored in the array.  The flags
> -argument is passed directly to the internal memory allocation calls.  With
> -the current code, using flags to ask for high memory is likely to lead to
> -notably unpleasant side effects.
> -
> -It is also possible to define flexible arrays at compile time with::
> -
> -    DEFINE_FLEX_ARRAY(name, element_size, total);
> -
> -This macro will result in a definition of an array with the given name; the
> -element size and total will be checked for validity at compile time.
> -
> -Storing data into a flexible array is accomplished with a call to::
> -
> -    int flex_array_put(struct flex_array *array, unsigned int element_nr,
> -                      void *src, gfp_t flags);
> -
> -This call will copy the data from src into the array, in the position
> -indicated by element_nr (which must be less than the maximum specified when
> -the array was created).  If any memory allocations must be performed, flags
> -will be used.  The return value is zero on success, a negative error code
> -otherwise.
> -
> -There might possibly be a need to store data into a flexible array while
> -running in some sort of atomic context; in this situation, sleeping in the
> -memory allocator would be a bad thing.  That can be avoided by using
> -GFP_ATOMIC for the flags value, but, often, there is a better way.  The
> -trick is to ensure that any needed memory allocations are done before
> -entering atomic context, using::
> -
> -    int flex_array_prealloc(struct flex_array *array, unsigned int start,
> -                           unsigned int nr_elements, gfp_t flags);
> -
> -This function will ensure that memory for the elements indexed in the range
> -defined by start and nr_elements has been allocated.  Thereafter, a
> -flex_array_put() call on an element in that range is guaranteed not to
> -block.
> -
> -Getting data back out of the array is done with::
> -
> -    void *flex_array_get(struct flex_array *fa, unsigned int element_nr);
> -
> -The return value is a pointer to the data element, or NULL if that
> -particular element has never been allocated.
> -
> -Note that it is possible to get back a valid pointer for an element which
> -has never been stored in the array.  Memory for array elements is allocated
> -one page at a time; a single allocation could provide memory for several
> -adjacent elements.  Flexible array elements are normally initialized to the
> -value FLEX_ARRAY_FREE (defined as 0x6c in <linux/poison.h>), so errors
> -involving that number probably result from use of unstored array entries.
> -Note that, if array elements are allocated with __GFP_ZERO, they will be
> -initialized to zero and this poisoning will not happen.
> -
> -Individual elements in the array can be cleared with::
> -
> -    int flex_array_clear(struct flex_array *array, unsigned int element_nr);
> -
> -This function will set the given element to FLEX_ARRAY_FREE and return
> -zero.  If storage for the indicated element is not allocated for the array,
> -flex_array_clear() will return -EINVAL instead.  Note that clearing an
> -element does not release the storage associated with it; to reduce the
> -allocated size of an array, call::
> -
> -    int flex_array_shrink(struct flex_array *array);
> -
> -The return value will be the number of pages of memory actually freed.
> -This function works by scanning the array for pages containing nothing but
> -FLEX_ARRAY_FREE bytes, so (1) it can be expensive, and (2) it will not work
> -if the array's pages are allocated with __GFP_ZERO.
> -
> -It is possible to remove all elements of an array with a call to::
> -
> -    void flex_array_free_parts(struct flex_array *array);
> -
> -This call frees all elements, but leaves the array itself in place.
> -Freeing the entire array is done with::
> -
> -    void flex_array_free(struct flex_array *array);
> -
> -As of this writing, there are no users of flexible arrays in the mainline
> -kernel.  The functions described here are also not exported to modules;
> -that will probably be fixed when somebody comes up with a need for it.
> diff --git a/include/linux/flex_array.h b/include/linux/flex_array.h
> deleted file mode 100644
> index b94fa61b51..0000000000
> --- a/include/linux/flex_array.h
> +++ /dev/null
> @@ -1,149 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _FLEX_ARRAY_H
> -#define _FLEX_ARRAY_H
> -
> -#include <linux/types.h>
> -#include <linux/reciprocal_div.h>
> -#include <asm/page.h>
> -
> -#define FLEX_ARRAY_PART_SIZE PAGE_SIZE
> -#define FLEX_ARRAY_BASE_SIZE PAGE_SIZE
> -
> -struct flex_array_part;
> -
> -/*
> - * This is meant to replace cases where an array-like
> - * structure has gotten too big to fit into kmalloc()
> - * and the developer is getting tempted to use
> - * vmalloc().
> - */
> -
> -struct flex_array {
> -       union {
> -               struct {
> -                       int element_size;
> -                       int total_nr_elements;
> -                       int elems_per_part;
> -                       struct reciprocal_value reciprocal_elems;
> -                       struct flex_array_part *parts[];
> -               };
> -               /*
> -                * This little trick makes sure that
> -                * sizeof(flex_array) == PAGE_SIZE
> -                */
> -               char padding[FLEX_ARRAY_BASE_SIZE];
> -       };
> -};
> -
> -/* Number of bytes left in base struct flex_array, excluding metadata */
> -#define FLEX_ARRAY_BASE_BYTES_LEFT                                     \
> -       (FLEX_ARRAY_BASE_SIZE - offsetof(struct flex_array, parts))
> -
> -/* Number of pointers in base to struct flex_array_part pages */
> -#define FLEX_ARRAY_NR_BASE_PTRS                                                \
> -       (FLEX_ARRAY_BASE_BYTES_LEFT / sizeof(struct flex_array_part *))
> -
> -/* Number of elements of size that fit in struct flex_array_part */
> -#define FLEX_ARRAY_ELEMENTS_PER_PART(size)                             \
> -       (FLEX_ARRAY_PART_SIZE / size)
> -
> -/*
> - * Defines a statically allocated flex array and ensures its parameters are
> - * valid.
> - */
> -#define DEFINE_FLEX_ARRAY(__arrayname, __element_size, __total)                \
> -       struct flex_array __arrayname = { { {                           \
> -               .element_size = (__element_size),                       \
> -               .total_nr_elements = (__total),                         \
> -       } } };                                                          \
> -       static inline void __arrayname##_invalid_parameter(void)        \
> -       {                                                               \
> -               BUILD_BUG_ON((__total) > FLEX_ARRAY_NR_BASE_PTRS *      \
> -                       FLEX_ARRAY_ELEMENTS_PER_PART(__element_size));  \
> -       }
> -
> -/**
> - * flex_array_alloc() - Creates a flexible array.
> - * @element_size:      individual object size.
> - * @total:             maximum number of objects which can be stored.
> - * @flags:             GFP flags
> - *
> - * Return:             Returns an object of structure flex_array.
> - */
> -struct flex_array *flex_array_alloc(int element_size, unsigned int total,
> -               gfp_t flags);
> -
> -/**
> - * flex_array_prealloc() - Ensures that memory for the elements indexed in the
> - * range defined by start and nr_elements has been allocated.
> - * @fa:                        array to allocate memory to.
> - * @start:             start address
> - * @nr_elements:       number of elements to be allocated.
> - * @flags:             GFP flags
> - *
> - */
> -int flex_array_prealloc(struct flex_array *fa, unsigned int start,
> -               unsigned int nr_elements, gfp_t flags);
> -
> -/**
> - * flex_array_free() - Removes all elements of a flexible array.
> - * @fa:                array to be freed.
> - */
> -void flex_array_free(struct flex_array *fa);
> -
> -/**
> - * flex_array_free_parts() - Removes all elements of a flexible array, but
> - * leaves the array itself in place.
> - * @fa:                array to be emptied.
> - */
> -void flex_array_free_parts(struct flex_array *fa);
> -
> -/**
> - * flex_array_put() - Stores data into a flexible array.
> - * @fa:                array where element is to be stored.
> - * @element_nr:        position to copy, must be less than the maximum specified when
> - *             the array was created.
> - * @src:       data source to be copied into the array.
> - * @flags:     GFP flags
> - *
> - * Return:     Returns zero on success, a negative error code otherwise.
> - */
> -int flex_array_put(struct flex_array *fa, unsigned int element_nr, void *src,
> -               gfp_t flags);
> -
> -/**
> - * flex_array_clear() - Clears an individual element in the array, sets the
> - * given element to FLEX_ARRAY_FREE.
> - * @element_nr:        element position to clear.
> - * @fa:                array to which element to be cleared belongs.
> - *
> - * Return:     Returns zero on success, -EINVAL otherwise.
> - */
> -int flex_array_clear(struct flex_array *fa, unsigned int element_nr);
> -
> -/**
> - * flex_array_get() - Retrieves data into a flexible array.
> - *
> - * @element_nr:        Element position to retrieve data from.
> - * @fa:                array from which data is to be retrieved.
> - *
> - * Return:     Returns a pointer to the data element, or NULL if that
> - *             particular element has never been allocated.
> - */
> -void *flex_array_get(struct flex_array *fa, unsigned int element_nr);
> -
> -/**
> - * flex_array_shrink() - Reduces the allocated size of an array.
> - * @fa:                array to shrink.
> - *
> - * Return:     Returns number of pages of memory actually freed.
> - *
> - */
> -int flex_array_shrink(struct flex_array *fa);
> -
> -#define flex_array_put_ptr(fa, nr, src, gfp) \
> -       flex_array_put(fa, nr, (void *)&(src), gfp)
> -
> -void *flex_array_get_ptr(struct flex_array *fa, unsigned int element_nr);
> -
> -#endif /* _FLEX_ARRAY_H */
> diff --git a/include/linux/poison.h b/include/linux/poison.h
> index 15927ebc22..10173f989a 100644
> --- a/include/linux/poison.h
> +++ b/include/linux/poison.h
> @@ -83,9 +83,6 @@
>  #define MUTEX_DEBUG_FREE       0x22
>  #define MUTEX_POISON_WW_CTX    ((void *) 0x500 + POISON_POINTER_DELTA)
>
> -/********** lib/flex_array.c **********/
> -#define FLEX_ARRAY_FREE        0x6c    /* for use-after-free poisoning */
> -
>  /********** security/ **********/
>  #define KEY_DESTROY            0xbd
>
> diff --git a/lib/Makefile b/lib/Makefile
> index 3038c54d6e..fed4cc550c 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -35,7 +35,7 @@ obj-y += lockref.o
>
>  obj-y += bcd.o div64.o sort.o parser.o debug_locks.o random32.o \
>          bust_spinlocks.o kasprintf.o bitmap.o scatterlist.o \
> -        gcd.o lcm.o list_sort.o uuid.o flex_array.o iov_iter.o clz_ctz.o \
> +        gcd.o lcm.o list_sort.o uuid.o iov_iter.o clz_ctz.o \
>          bsearch.o find_bit.o llist.o memweight.o kfifo.o \
>          percpu-refcount.o percpu_ida.o rhashtable.o reciprocal_div.o \
>          once.o refcount.o usercopy.o errseq.o bucket_locks.o \
> diff --git a/lib/flex_array.c b/lib/flex_array.c
> deleted file mode 100644
> index 2eed22fa50..0000000000
> --- a/lib/flex_array.c
> +++ /dev/null
> @@ -1,398 +0,0 @@
> -/*
> - * Flexible array managed in PAGE_SIZE parts
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> - *
> - * Copyright IBM Corporation, 2009
> - *
> - * Author: Dave Hansen <dave@linux.vnet.ibm.com>
> - */
> -
> -#include <linux/flex_array.h>
> -#include <linux/slab.h>
> -#include <linux/stddef.h>
> -#include <linux/export.h>
> -#include <linux/reciprocal_div.h>
> -
> -struct flex_array_part {
> -       char elements[FLEX_ARRAY_PART_SIZE];
> -};
> -
> -/*
> - * If a user requests an allocation which is small
> - * enough, we may simply use the space in the
> - * flex_array->parts[] array to store the user
> - * data.
> - */
> -static inline int elements_fit_in_base(struct flex_array *fa)
> -{
> -       int data_size = fa->element_size * fa->total_nr_elements;
> -       if (data_size <= FLEX_ARRAY_BASE_BYTES_LEFT)
> -               return 1;
> -       return 0;
> -}
> -
> -/**
> - * flex_array_alloc - allocate a new flexible array
> - * @element_size:      the size of individual elements in the array
> - * @total:             total number of elements that this should hold
> - * @flags:             page allocation flags to use for base array
> - *
> - * Note: all locking must be provided by the caller.
> - *
> - * @total is used to size internal structures.  If the user ever
> - * accesses any array indexes >=@total, it will produce errors.
> - *
> - * The maximum number of elements is defined as: the number of
> - * elements that can be stored in a page times the number of
> - * page pointers that we can fit in the base structure or (using
> - * integer math):
> - *
> - *     (PAGE_SIZE/element_size) * (PAGE_SIZE-8)/sizeof(void *)
> - *
> - * Here's a table showing example capacities.  Note that the maximum
> - * index that the get/put() functions is just nr_objects-1.   This
> - * basically means that you get 4MB of storage on 32-bit and 2MB on
> - * 64-bit.
> - *
> - *
> - * Element size | Objects | Objects |
> - * PAGE_SIZE=4k |  32-bit |  64-bit |
> - * ---------------------------------|
> - *      1 bytes | 4177920 | 2088960 |
> - *      2 bytes | 2088960 | 1044480 |
> - *      3 bytes | 1392300 |  696150 |
> - *      4 bytes | 1044480 |  522240 |
> - *     32 bytes |  130560 |   65408 |
> - *     33 bytes |  126480 |   63240 |
> - *   2048 bytes |    2040 |    1020 |
> - *   2049 bytes |    1020 |     510 |
> - *       void * | 1044480 |  261120 |
> - *
> - * Since 64-bit pointers are twice the size, we lose half the
> - * capacity in the base structure.  Also note that no effort is made
> - * to efficiently pack objects across page boundaries.
> - */
> -struct flex_array *flex_array_alloc(int element_size, unsigned int total,
> -                                       gfp_t flags)
> -{
> -       struct flex_array *ret;
> -       int elems_per_part = 0;
> -       int max_size = 0;
> -       struct reciprocal_value reciprocal_elems = { 0 };
> -
> -       if (element_size) {
> -               elems_per_part = FLEX_ARRAY_ELEMENTS_PER_PART(element_size);
> -               reciprocal_elems = reciprocal_value(elems_per_part);
> -               max_size = FLEX_ARRAY_NR_BASE_PTRS * elems_per_part;
> -       }
> -
> -       /* max_size will end up 0 if element_size > PAGE_SIZE */
> -       if (total > max_size)
> -               return NULL;
> -       ret = kzalloc(sizeof(struct flex_array), flags);
> -       if (!ret)
> -               return NULL;
> -       ret->element_size = element_size;
> -       ret->total_nr_elements = total;
> -       ret->elems_per_part = elems_per_part;
> -       ret->reciprocal_elems = reciprocal_elems;
> -       if (elements_fit_in_base(ret) && !(flags & __GFP_ZERO))
> -               memset(&ret->parts[0], FLEX_ARRAY_FREE,
> -                                               FLEX_ARRAY_BASE_BYTES_LEFT);
> -       return ret;
> -}
> -EXPORT_SYMBOL(flex_array_alloc);
> -
> -static int fa_element_to_part_nr(struct flex_array *fa,
> -                                       unsigned int element_nr)
> -{
> -       /*
> -        * if element_size == 0 we don't get here, so we never touch
> -        * the zeroed fa->reciprocal_elems, which would yield invalid
> -        * results
> -        */
> -       return reciprocal_divide(element_nr, fa->reciprocal_elems);
> -}
> -
> -/**
> - * flex_array_free_parts - just free the second-level pages
> - * @fa:                the flex array from which to free parts
> - *
> - * This is to be used in cases where the base 'struct flex_array'
> - * has been statically allocated and should not be free.
> - */
> -void flex_array_free_parts(struct flex_array *fa)
> -{
> -       int part_nr;
> -
> -       if (elements_fit_in_base(fa))
> -               return;
> -       for (part_nr = 0; part_nr < FLEX_ARRAY_NR_BASE_PTRS; part_nr++)
> -               kfree(fa->parts[part_nr]);
> -}
> -EXPORT_SYMBOL(flex_array_free_parts);
> -
> -void flex_array_free(struct flex_array *fa)
> -{
> -       flex_array_free_parts(fa);
> -       kfree(fa);
> -}
> -EXPORT_SYMBOL(flex_array_free);
> -
> -static unsigned int index_inside_part(struct flex_array *fa,
> -                                       unsigned int element_nr,
> -                                       unsigned int part_nr)
> -{
> -       unsigned int part_offset;
> -
> -       part_offset = element_nr - part_nr * fa->elems_per_part;
> -       return part_offset * fa->element_size;
> -}
> -
> -static struct flex_array_part *
> -__fa_get_part(struct flex_array *fa, int part_nr, gfp_t flags)
> -{
> -       struct flex_array_part *part = fa->parts[part_nr];
> -       if (!part) {
> -               part = kmalloc(sizeof(struct flex_array_part), flags);
> -               if (!part)
> -                       return NULL;
> -               if (!(flags & __GFP_ZERO))
> -                       memset(part, FLEX_ARRAY_FREE,
> -                               sizeof(struct flex_array_part));
> -               fa->parts[part_nr] = part;
> -       }
> -       return part;
> -}
> -
> -/**
> - * flex_array_put - copy data into the array at @element_nr
> - * @fa:                the flex array to copy data into
> - * @element_nr:        index of the position in which to insert
> - *             the new element.
> - * @src:       address of data to copy into the array
> - * @flags:     page allocation flags to use for array expansion
> - *
> - *
> - * Note that this *copies* the contents of @src into
> - * the array.  If you are trying to store an array of
> - * pointers, make sure to pass in &ptr instead of ptr.
> - * You may instead wish to use the flex_array_put_ptr()
> - * helper function.
> - *
> - * Locking must be provided by the caller.
> - */
> -int flex_array_put(struct flex_array *fa, unsigned int element_nr, void *src,
> -                       gfp_t flags)
> -{
> -       int part_nr = 0;
> -       struct flex_array_part *part;
> -       void *dst;
> -
> -       if (element_nr >= fa->total_nr_elements)
> -               return -ENOSPC;
> -       if (!fa->element_size)
> -               return 0;
> -       if (elements_fit_in_base(fa))
> -               part = (struct flex_array_part *)&fa->parts[0];
> -       else {
> -               part_nr = fa_element_to_part_nr(fa, element_nr);
> -               part = __fa_get_part(fa, part_nr, flags);
> -               if (!part)
> -                       return -ENOMEM;
> -       }
> -       dst = &part->elements[index_inside_part(fa, element_nr, part_nr)];
> -       memcpy(dst, src, fa->element_size);
> -       return 0;
> -}
> -EXPORT_SYMBOL(flex_array_put);
> -
> -/**
> - * flex_array_clear - clear element in array at @element_nr
> - * @fa:                the flex array of the element.
> - * @element_nr:        index of the position to clear.
> - *
> - * Locking must be provided by the caller.
> - */
> -int flex_array_clear(struct flex_array *fa, unsigned int element_nr)
> -{
> -       int part_nr = 0;
> -       struct flex_array_part *part;
> -       void *dst;
> -
> -       if (element_nr >= fa->total_nr_elements)
> -               return -ENOSPC;
> -       if (!fa->element_size)
> -               return 0;
> -       if (elements_fit_in_base(fa))
> -               part = (struct flex_array_part *)&fa->parts[0];
> -       else {
> -               part_nr = fa_element_to_part_nr(fa, element_nr);
> -               part = fa->parts[part_nr];
> -               if (!part)
> -                       return -EINVAL;
> -       }
> -       dst = &part->elements[index_inside_part(fa, element_nr, part_nr)];
> -       memset(dst, FLEX_ARRAY_FREE, fa->element_size);
> -       return 0;
> -}
> -EXPORT_SYMBOL(flex_array_clear);
> -
> -/**
> - * flex_array_prealloc - guarantee that array space exists
> - * @fa:                        the flex array for which to preallocate parts
> - * @start:             index of first array element for which space is allocated
> - * @nr_elements:       number of elements for which space is allocated
> - * @flags:             page allocation flags
> - *
> - * This will guarantee that no future calls to flex_array_put()
> - * will allocate memory.  It can be used if you are expecting to
> - * be holding a lock or in some atomic context while writing
> - * data into the array.
> - *
> - * Locking must be provided by the caller.
> - */
> -int flex_array_prealloc(struct flex_array *fa, unsigned int start,
> -                       unsigned int nr_elements, gfp_t flags)
> -{
> -       int start_part;
> -       int end_part;
> -       int part_nr;
> -       unsigned int end;
> -       struct flex_array_part *part;
> -
> -       if (!start && !nr_elements)
> -               return 0;
> -       if (start >= fa->total_nr_elements)
> -               return -ENOSPC;
> -       if (!nr_elements)
> -               return 0;
> -
> -       end = start + nr_elements - 1;
> -
> -       if (end >= fa->total_nr_elements)
> -               return -ENOSPC;
> -       if (!fa->element_size)
> -               return 0;
> -       if (elements_fit_in_base(fa))
> -               return 0;
> -       start_part = fa_element_to_part_nr(fa, start);
> -       end_part = fa_element_to_part_nr(fa, end);
> -       for (part_nr = start_part; part_nr <= end_part; part_nr++) {
> -               part = __fa_get_part(fa, part_nr, flags);
> -               if (!part)
> -                       return -ENOMEM;
> -       }
> -       return 0;
> -}
> -EXPORT_SYMBOL(flex_array_prealloc);
> -
> -/**
> - * flex_array_get - pull data back out of the array
> - * @fa:                the flex array from which to extract data
> - * @element_nr:        index of the element to fetch from the array
> - *
> - * Returns a pointer to the data at index @element_nr.  Note
> - * that this is a copy of the data that was passed in.  If you
> - * are using this to store pointers, you'll get back &ptr.  You
> - * may instead wish to use the flex_array_get_ptr helper.
> - *
> - * Locking must be provided by the caller.
> - */
> -void *flex_array_get(struct flex_array *fa, unsigned int element_nr)
> -{
> -       int part_nr = 0;
> -       struct flex_array_part *part;
> -
> -       if (!fa->element_size)
> -               return NULL;
> -       if (element_nr >= fa->total_nr_elements)
> -               return NULL;
> -       if (elements_fit_in_base(fa))
> -               part = (struct flex_array_part *)&fa->parts[0];
> -       else {
> -               part_nr = fa_element_to_part_nr(fa, element_nr);
> -               part = fa->parts[part_nr];
> -               if (!part)
> -                       return NULL;
> -       }
> -       return &part->elements[index_inside_part(fa, element_nr, part_nr)];
> -}
> -EXPORT_SYMBOL(flex_array_get);
> -
> -/**
> - * flex_array_get_ptr - pull a ptr back out of the array
> - * @fa:                the flex array from which to extract data
> - * @element_nr:        index of the element to fetch from the array
> - *
> - * Returns the pointer placed in the flex array at element_nr using
> - * flex_array_put_ptr().  This function should not be called if the
> - * element in question was not set using the _put_ptr() helper.
> - */
> -void *flex_array_get_ptr(struct flex_array *fa, unsigned int element_nr)
> -{
> -       void **tmp;
> -
> -       tmp = flex_array_get(fa, element_nr);
> -       if (!tmp)
> -               return NULL;
> -
> -       return *tmp;
> -}
> -EXPORT_SYMBOL(flex_array_get_ptr);
> -
> -static int part_is_free(struct flex_array_part *part)
> -{
> -       int i;
> -
> -       for (i = 0; i < sizeof(struct flex_array_part); i++)
> -               if (part->elements[i] != FLEX_ARRAY_FREE)
> -                       return 0;
> -       return 1;
> -}
> -
> -/**
> - * flex_array_shrink - free unused second-level pages
> - * @fa:                the flex array to shrink
> - *
> - * Frees all second-level pages that consist solely of unused
> - * elements.  Returns the number of pages freed.
> - *
> - * Locking must be provided by the caller.
> - */
> -int flex_array_shrink(struct flex_array *fa)
> -{
> -       struct flex_array_part *part;
> -       int part_nr;
> -       int ret = 0;
> -
> -       if (!fa->total_nr_elements || !fa->element_size)
> -               return 0;
> -       if (elements_fit_in_base(fa))
> -               return ret;
> -       for (part_nr = 0; part_nr < FLEX_ARRAY_NR_BASE_PTRS; part_nr++) {
> -               part = fa->parts[part_nr];
> -               if (!part)
> -                       continue;
> -               if (part_is_free(part)) {
> -                       fa->parts[part_nr] = NULL;
> -                       kfree(part);
> -                       ret++;
> -               }
> -       }
> -       return ret;
> -}
> -EXPORT_SYMBOL(flex_array_shrink);
> diff --git a/tools/include/linux/poison.h b/tools/include/linux/poison.h
> index 9fdcd3eaac..d297257691 100644
> --- a/tools/include/linux/poison.h
> +++ b/tools/include/linux/poison.h
> @@ -87,9 +87,6 @@
>  #define MUTEX_DEBUG_INIT       0x11
>  #define MUTEX_DEBUG_FREE       0x22
>
> -/********** lib/flex_array.c **********/
> -#define FLEX_ARRAY_FREE        0x6c    /* for use-after-free poisoning */
> -
>  /********** security/ **********/
>  #define KEY_DESTROY            0xbd
>
> --
> 2.19.0.rc2
>
