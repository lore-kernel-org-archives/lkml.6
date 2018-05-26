Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-593036-1527304609-2-1342283919709155994
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527304608; b=c6C9CLKjw3UjLfl/f/P4mcdgBpKJ3wBkmK+nTxWvtPGqcKOMc2
    y9JajLGNlfwb+o333Ix2aftAzyj4QsxkyFgHFU8DMG0Ssls+SwAr8G6COuZdULRD
    MTcrUalUKLCE26B5vu6Jd7YT+UOZSSVt+Dy/3rTDlXZsKaenFyHfMK6+9+FQhGLN
    qjM83Zr1pTNjVfV11UyExOwEYJKYlCn52702qmSOAzDzCbqyZT1U/nAvLMwkFTal
    LI6kzQEcAo/TN/IVhS+Sy61R0TYf3XsGYWGn7sTpbIG5bPr8ak2O53/v9j+3y9py
    ruWc3PNpVUjKRF5QnmxagigJR5zlLmg2fI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527304608; bh=tc5KU5ifK7lP/MbVxHPNmON3nVzs/o0YEyYd3EgJG5
    s=; b=B+8c4/z8y+s3zNYKd2lJSesXUDjVmN9Ph4S7YGTYPePTd5JGhoZGCjIVdG
    NsQ59x0CcT2NYFqsUYd6Hjc5/D907MYPqm25UofOpM3gG+3gKYEVV6HwD6Ld7ipc
    GUP4R6OpNre0x9u1tDnVfuwKxvChZtn4n9DDL8sMM0i/7nfLNAZR8uPuFRD5/DlI
    oQCLzIvzsjveZLnjwWm2fABGciNEM9mnCc/LjV4s9OVB73XmTOfIkmQxdwxg+oEL
    tZIejs2yIVYaHl6Dn/2hx+jPW08badTHqomJOxZys4mmWedWCjQ7S2scvoaMHkJT
    QdrM4B28QBonvHnTZ7iYem3ElSHw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=aaCGdDdi x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=VmWqc1/6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=aaCGdDdi x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=VmWqc1/6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHszq5VUKF1DoMKP8MUMKmlU5mVFHbbSRvghnT3kki84An7yzq8evtKjbiLrM6aOo1fbsoNDta9m/xpskUUkw+jAF1LZu1ktnVlwkemT/12PBKqsX8fV
    CiVtwClB9+2HgFAKbgW3tFJUl8oCNb9/PIp95D5sXG9/5dsIfJ/bEyAJM3RlhRIL4jv3UTYkuYxmgh9MXZiZGkQuGA8z+Za9FnFG9IIUcDMXSS4ljChdgLoT
    saOTkLZrio6e08MBDjb4KA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=AvUfc4v9OEsA:10 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=ZtZl2rhw0XZwCaXzJHMA:9 a=jyJw8FAKdObJTJxW:21 a=j3_S7beV_tdLqdmq:21
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031031AbeEZDQp (ORCPT <rfc822;linux@kroah.com>);
        Fri, 25 May 2018 23:16:45 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51771 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030998AbeEZDQo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 25 May 2018 23:16:44 -0400
X-Google-Smtp-Source: ADUXVKLJdf337wGzHJ06qiltbIOmi2agBW7ZPntzN1gq/bsdeH89MDPLl/IK4TeiMSBkgdrHDrLcnGOO74NUSdOhV7g=
MIME-Version: 1.0
In-Reply-To: <20180523011821.12165-1-kent.overstreet@gmail.com>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
From: Liu Bo <obuil.liubo@gmail.com>
Date: Sat, 26 May 2018 11:16:42 +0800
Message-ID: <CANQeFDCLc56thuuGYBMdb_qvw_O=t7sLkJiP-LNYfKwgz74H_w@mail.gmail.com>
Subject: Re: [PATCH 1/6] Generic radix trees
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, willy@infradead.org,
        gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, dev@openvswitch.org, shli@kernel.org,
        linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Kent,

(Add all ML to cc this time.)

On Wed, May 23, 2018 at 9:18 AM, Kent Overstreet
<kent.overstreet@gmail.com> wrote:
> Very simple radix tree implementation that supports storing arbitrary
> size entries, up to PAGE_SIZE - upcoming patches will convert existing
> flex_array users to genradixes. The new genradix code has a much simpler
> API and implementation, and doesn't have a hard limit on the number of
> elements like flex_array does.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  include/linux/generic-radix-tree.h | 222 +++++++++++++++++++++++++++++
>  lib/Makefile                       |   3 +-
>  lib/generic-radix-tree.c           | 180 +++++++++++++++++++++++
>  3 files changed, 404 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/generic-radix-tree.h
>  create mode 100644 lib/generic-radix-tree.c
>
> diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
> new file mode 100644
> index 0000000000..3328813322
> --- /dev/null
> +++ b/include/linux/generic-radix-tree.h
> @@ -0,0 +1,222 @@
> +#ifndef _LINUX_GENERIC_RADIX_TREE_H
> +#define _LINUX_GENERIC_RADIX_TREE_H
> +
> +/*
> + * Generic radix trees/sparse arrays:
> + *
> + * Very simple and minimalistic, supporting arbitrary size entries up to
> + * PAGE_SIZE.
> + *
> + * A genradix is defined with the type it will store, like so:
> + * static GENRADIX(struct foo) foo_genradix;
> + *
> + * The main operations are:
> + * - genradix_init(radix) - initialize an empty genradix
> + *
> + * - genradix_free(radix) - free all memory owned by the genradix and
> + *   reinitialize it
> + *
> + * - genradix_ptr(radix, idx) - gets a pointer to the entry at idx, returning
> + *   NULL if that entry does not exist
> + *
> + * - genradix_ptr_alloc(radix, idx, gfp) - gets a pointer to an entry,
> + *   allocating it if necessary
> + *
> + * - genradix_for_each(radix, iter, p) - iterate over each entry in a genradix
> + *
> + * The radix tree allocates one page of entries at a time, so entries may exist
> + * that were never explicitly allocated - they will be initialized to all
> + * zeroes.
> + *
> + * Internally, a genradix is just a radix tree of pages, and indexing works in
> + * terms of byte offsets. The wrappers in this header file use sizeof on the
> + * type the radix contains to calculate a byte offset from the index - see
> + * __idx_to_offset.
> + */
> +
> +#include <asm/page.h>
> +#include <linux/bug.h>
> +#include <linux/kernel.h>
> +#include <linux/log2.h>
> +
> +struct genradix_node;
> +
> +struct __genradix {
> +       struct genradix_node            *root;
> +       size_t                          depth;
> +};
> +
> +#define __GENRADIX_INITIALIZER                                 \
> +       {                                                       \
> +               .tree = {                                       \
> +                       .root = NULL,                           \
> +                       .depth = 0,                             \
> +               }                                               \
> +       }
> +
> +/*
> + * We use a 0 size array to stash the type we're storing without taking any
> + * space at runtime - then the various accessor macros can use typeof() to get
> + * to it for casts/sizeof - we also force the alignment so that storing a type
> + * with a ridiculous alignment doesn't blow up the alignment or size of the
> + * genradix.
> + */
> +
> +#define GENRADIX(_type)                                                \
> +struct {                                                       \
> +       struct __genradix       tree;                           \
> +       _type                   type[0] __aligned(1);           \
> +}
> +
> +#define DEFINE_GENRADIX(_name, _type)                          \
> +       GENRADIX(_type) _name = __GENRADIX_INITIALIZER
> +
> +/**
> + * genradix_init - initialize a genradix
> + * @_radix:    genradix to initialize
> + *
> + * Does not fail
> + */
> +#define genradix_init(_radix)                                  \
> +do {                                                           \
> +       *(_radix) = (typeof(*_radix)) __GENRADIX_INITIALIZER;   \
> +} while (0)
> +
> +void __genradix_free(struct __genradix *);
> +
> +/**
> + * genradix_free: free all memory owned by a genradix
> + *
> + * After freeing, @_radix will be reinitialized and empty
> + */
> +#define genradix_free(_radix)  __genradix_free(&(_radix)->tree)
> +
> +static inline size_t __idx_to_offset(size_t idx, size_t obj_size)
> +{
> +       if (__builtin_constant_p(obj_size))
> +               BUILD_BUG_ON(obj_size > PAGE_SIZE);
> +       else
> +               BUG_ON(obj_size > PAGE_SIZE);
> +
> +       if (!is_power_of_2(obj_size)) {
> +               size_t objs_per_page = PAGE_SIZE / obj_size;
> +
> +               return (idx / objs_per_page) * PAGE_SIZE +
> +                       (idx % objs_per_page) * obj_size;
> +       } else {
> +               return idx * obj_size;
> +       }
> +}
> +
> +#define __genradix_cast(_radix)                (typeof((_radix)->type[0]) *)
> +#define __genradix_obj_size(_radix)    sizeof((_radix)->type[0])
> +#define __genradix_idx_to_offset(_radix, _idx)                 \
> +       __idx_to_offset(_idx, __genradix_obj_size(_radix))
> +
> +void *__genradix_ptr(struct __genradix *, size_t);
> +
> +/**
> + * genradix_ptr - get a pointer to a genradix entry
> + * @_radix:    genradix to access
> + * @_idx:      index to fetch
> + *
> + * Returns a pointer to entry at @_idx, or NULL if that entry does not exist.
> + */
> +#define genradix_ptr(_radix, _idx)                             \
> +       (__genradix_cast(_radix)                                \
> +        __genradix_ptr(&(_radix)->tree,                        \
> +                       __genradix_idx_to_offset(_radix, _idx)))
> +
> +void *__genradix_ptr_alloc(struct __genradix *, size_t, gfp_t);
> +
> +/**
> + * genradix_ptr - get a pointer to a genradix entry, allocating it if necessary
> + * @_radix:    genradix to access
> + * @_idx:      index to fetch
> + * @_gfp:      gfp mask
> + *
> + * Returns a pointer to entry at @_idx, or NULL on allocation failure
> + */
> +#define genradix_ptr_alloc(_radix, _idx, _gfp)                 \
> +       (__genradix_cast(_radix)                                \
> +        __genradix_ptr_alloc(&(_radix)->tree,                  \
> +                       __genradix_idx_to_offset(_radix, _idx), \
> +                       _gfp))
> +
> +struct genradix_iter {
> +       size_t                  offset;
> +       size_t                  pos;
> +};
> +
> +/**
> + * genradix_iter_init - initialize a genradix_iter
> + * @_radix:    genradix that will be iterated over
> + * @_idx       index to start iterating from
> + */
> +#define genradix_iter_init(_radix, _idx)                       \
> +       ((struct genradix_iter) {                               \
> +               .pos    = (_idx),                               \
> +               .offset = __genradix_idx_to_offset((_radix), (_idx)),\
> +       })
> +
> +void *__genradix_iter_peek(struct genradix_iter *, struct __genradix *, size_t);
> +
> +/**
> + * genradix_iter_peek - get first entry at or above iterator's current
> + *                     position
> + * @_iter:     a genradix_iter
> + * @_radix:    genradix being iterated over
> + *
> + * If no more entries exist at or above @_iter's current position, returns NULL
> + */
> +#define genradix_iter_peek(_iter, _radix)                      \
> +       (__genradix_cast(_radix)                                \
> +        __genradix_iter_peek(_iter, &(_radix)->tree,           \
> +                             PAGE_SIZE / __genradix_obj_size(_radix)))
> +
> +static inline void __genradix_iter_advance(struct genradix_iter *iter,
> +                                          size_t obj_size)
> +{
> +       iter->offset += obj_size;
> +
> +       if (!is_power_of_2(obj_size) &&
> +           (iter->offset & (PAGE_SIZE - 1)) + obj_size > PAGE_SIZE)
> +               iter->offset = round_up(iter->offset, PAGE_SIZE);
> +
> +       iter->pos++;
> +}
> +
> +#define genradix_iter_advance(_iter, _radix)                   \
> +       __genradix_iter_advance(_iter, __genradix_obj_size(_radix))
> +
> +/**
> + * genradix_for_each - iterate over entry in a genradix
> + * @_radix:    genradix to iterate over
> + * @_iter:     a genradix_iter to track current position
> + * @_p:                pointer to genradix entry type
> + *
> + * On every iteration, @_p will point to the current entry, and @_iter.pos
> + * will be the current entry's index.
> + */
> +#define genradix_for_each(_radix, _iter, _p)                   \
> +       for (_iter = genradix_iter_init(_radix, 0);             \
> +            _p = genradix_iter_peek(&(_iter), _uradix);        \
> +            genradix_iter_advance(&(_iter), _uradix))
> +
> +int __genradix_prealloc(struct __genradix *, size_t, gfp_t);
> +
> +/**
> + * genradix_prealloc - preallocate entries in a generic radix tree
> + * @_radix:    genradix to preallocate
> + * @_nr:       number of entries to preallocate
> + * @_gfp:      gfp mask
> + *
> + * Returns 0 on success, -ENOMEM on failure
> + */
> +#define genradix_prealloc(_radix, _nr, _gfp)                   \
> +        __genradix_prealloc(&(_radix)->tree,                   \
> +                       __genradix_idx_to_offset(_radix, _nr + 1),\
> +                       _gfp)
> +
> +
> +#endif /* _LINUX_GENERIC_RADIX_TREE_H */
> diff --git a/lib/Makefile b/lib/Makefile
> index a90d4fcd74..5db5a7fb1e 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -39,7 +39,8 @@ obj-y += bcd.o div64.o sort.o parser.o debug_locks.o random32.o \
>          gcd.o lcm.o list_sort.o uuid.o flex_array.o iov_iter.o clz_ctz.o \
>          bsearch.o find_bit.o llist.o memweight.o kfifo.o \
>          percpu-refcount.o percpu_ida.o rhashtable.o reciprocal_div.o \
> -        once.o refcount.o usercopy.o errseq.o bucket_locks.o
> +        once.o refcount.o usercopy.o errseq.o bucket_locks.o \
> +        generic-radix-tree.o
>  obj-$(CONFIG_STRING_SELFTEST) += test_string.o
>  obj-y += string_helpers.o
>  obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
> diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
> new file mode 100644
> index 0000000000..4537c7c62c
> --- /dev/null
> +++ b/lib/generic-radix-tree.c
> @@ -0,0 +1,180 @@
> +
> +#include <linux/export.h>
> +#include <linux/generic-radix-tree.h>
> +#include <linux/gfp.h>
> +
> +#define GENRADIX_ARY           (PAGE_SIZE / sizeof(struct genradix_node *))
> +#define GENRADIX_ARY_SHIFT     ilog2(GENRADIX_ARY)
> +
> +struct genradix_node {
> +       union {
> +               /* Interior node: */
> +               struct genradix_node    *children[GENRADIX_ARY];
> +
> +               /* Leaf: */
> +               u8                      data[PAGE_SIZE];
> +       };
> +};
> +
> +static inline unsigned genradix_depth_shift(unsigned depth)
> +{
> +       return PAGE_SHIFT + GENRADIX_ARY_SHIFT * depth;
> +}
> +
> +/*
> + * Returns size (of data, in bytes) that a tree of a given depth holds:
> + */
> +static inline size_t genradix_depth_size(unsigned depth)
> +{
> +       return 1UL << genradix_depth_shift(depth);
> +}
> +
> +/*
> + * Returns pointer to the specified byte @offset within @radix, or NULL if not
> + * allocated
> + */
> +void *__genradix_ptr(struct __genradix *radix, size_t offset)
> +{
> +       size_t level = radix->depth;
> +       struct genradix_node *n = radix->root;
> +
> +       if (offset >= genradix_depth_size(radix->depth))
> +               return NULL;
> +
> +       while (1) {
> +               if (!n)
> +                       return NULL;
> +               if (!level)
> +                       break;
> +
> +               level--;
> +
> +               n = n->children[offset >> genradix_depth_shift(level)];
> +               offset &= genradix_depth_size(level) - 1;
> +       }
> +
> +       return &n->data[offset];
> +}
> +EXPORT_SYMBOL(__genradix_ptr);
> +
> +/*
> + * Returns pointer to the specified byte @offset within @radix, allocating it if
> + * necessary - newly allocated slots are always zeroed out:
> + */
> +void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
> +                          gfp_t gfp_mask)
> +{
> +       struct genradix_node **n;

Any reason that " struct genradix_node ** " is used here instead of "
struct genradix_node * "?

Looks like this function only manipulates *n, am I missing something?

thanks,
liubo

> +       size_t level;
> +
> +       /* Increase tree depth if necessary: */
> +
> +       while (offset >= genradix_depth_size(radix->depth)) {
> +               struct genradix_node *new_root =
> +                       (void *) __get_free_page(gfp_mask|__GFP_ZERO);
> +
> +               if (!new_root)
> +                       return NULL;
> +
> +               new_root->children[0] = radix->root;
> +               radix->root = new_root;
> +               radix->depth++;
> +       }
> +
> +       n = &radix->root;
> +       level = radix->depth;
> +
> +       while (1) {
> +               if (!*n) {
> +                       *n = (void *) __get_free_page(gfp_mask|__GFP_ZERO);
> +                       if (!*n)
> +                               return NULL;
> +               }
> +
> +               if (!level)
> +                       break;
> +
> +               level--;
> +
> +               n = &(*n)->children[offset >> genradix_depth_shift(level)];
> +               offset &= genradix_depth_size(level) - 1;
> +       }
> +
> +       return &(*n)->data[offset];
> +}
> +EXPORT_SYMBOL(__genradix_ptr_alloc);
> +
> +void *__genradix_iter_peek(struct genradix_iter *iter,
> +                          struct __genradix *radix,
> +                          size_t objs_per_page)
> +{
> +       struct genradix_node *n;
> +       size_t level, i;
> +
> +       if (!radix->root)
> +               return NULL;
> +restart:
> +       if (iter->offset >= genradix_depth_size(radix->depth))
> +               return NULL;
> +
> +       n       = radix->root;
> +       level   = radix->depth;
> +
> +       while (level) {
> +               level--;
> +
> +               i = (iter->offset >> genradix_depth_shift(level)) &
> +                       (GENRADIX_ARY - 1);
> +
> +               while (!n->children[i]) {
> +                       i++;
> +                       iter->offset = round_down(iter->offset +
> +                                          genradix_depth_size(level),
> +                                          genradix_depth_size(level));
> +                       iter->pos = (iter->offset >> PAGE_SHIFT) *
> +                               objs_per_page;
> +                       if (i == GENRADIX_ARY)
> +                               goto restart;
> +               }
> +
> +               n = n->children[i];
> +       }
> +
> +       return &n->data[iter->offset & (PAGE_SIZE - 1)];
> +}
> +EXPORT_SYMBOL(__genradix_iter_peek);
> +
> +static void genradix_free_recurse(struct genradix_node *n, unsigned level)
> +{
> +       if (level) {
> +               unsigned i;
> +
> +               for (i = 0; i < GENRADIX_ARY; i++)
> +                       if (n->children[i])
> +                               genradix_free_recurse(n->children[i], level - 1);
> +       }
> +
> +       free_page((unsigned long) n);
> +}
> +
> +int __genradix_prealloc(struct __genradix *radix, size_t size,
> +                       gfp_t gfp_mask)
> +{
> +       size_t offset;
> +
> +       for (offset = 0; offset < size; offset += PAGE_SIZE)
> +               if (!__genradix_ptr_alloc(radix, offset, gfp_mask))
> +                       return -ENOMEM;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(__genradix_prealloc);
> +
> +void __genradix_free(struct __genradix *radix)
> +{
> +       genradix_free_recurse(radix->root, radix->depth);
> +
> +       radix->root = NULL;
> +       radix->depth = 0;
> +}
> +EXPORT_SYMBOL(__genradix_free);
> --
> 2.17.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
