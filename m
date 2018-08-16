Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC1DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52732147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVjo/Tmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52732147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbeHPXKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbeHPXKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:10:15 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88BBF20BF3;
        Thu, 16 Aug 2018 20:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534450185;
        bh=bwB+iDPs8Lva6IQOv5X/U8rfuLwj2B/jPHKAXjFLn0Y=;
        h=Date:From:To:Cc:Subject:From;
        b=iVjo/Tmrljvj/r8gfJhz1Z4zWcsRQcV3GnTKwwBpdcUz8vTFinLzZZVdBgwfG75fg
         2esg6esV99AtLM8+eRBJRUnmo+i3GP9fC0z9Y0gXEydKUS19AAo5YGtJPm+VprSCc0
         unD0tkT4ec7R9WLqezcWNpAofNopzgrRYTE63TMM=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 51C72141C3A; Thu, 16 Aug 2018 17:09:42 -0300 (-03)
Date:   Thu, 16 Aug 2018 17:09:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     dwarves@vger.kernel.org
Cc:     Alexei Starovoitov <ast@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
        Yonghong Song <yhs@fb.com>, Martin Cermak <mcermak@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Thomas Girard <thomas.g.girard@free.fr>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        David Seifert <soap@gentoo.org>,
        Pavel Borzenkov <pavel.borzenkov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Wilcox <willy@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Eric Blake <eblake@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Thiago Macieira <thiago.macieira@intel.com>,
        Jakub Jelinek <jakub@redhat.com>,
        Tom Tromey <tromey@redhat.com>,
        Diego Elio =?iso-8859-1?Q?Petten=F2?= <flameeyes@flameeyes.eu>,
        Cody P Schafer <cody@linux.vnet.ibm.com>,
        Nicolas <nikos42@gmail.com>,
        Christophe Fergeau <cfergeau@redhat.com>,
        Benjamin Kosnik <bkoz@redhat.com>,
        Mark Wieelard <mjw@redhat.com>,
        Dodji Seketeli <dodji@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Linux Networking Development Mailing List 
        <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ANNOUNCE: pahole v1.12 (BTF edition)
Message-ID: <20180816200942.GA19939@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	After a long time without announces, here is pahole 1.12,
available at:

	https://fedorapeople.org/~acme/dwarves/dwarves-1.12.tar.bz2

	git://git.kernel.org/pub/scm/devel/pahole/pahole.git	

	Some distros haven't picked 1.11, that comes with several
goodies, my bad for not having announced it at that time more widely,
the most interesting changes are listed at the end of this message,

	Please report any problems to me, I'll try and get problems
fixed and implement any nice suggestion you guys may have, time
permitting 8-)

	Thanks a lot to all that reported problems and provided
suggestions over the years, that is really appreciated and is what makes
these tools to remain useful,

	Now lets try to get the packages in the distros updated...

Regards,

- Arnaldo

The changes in 1.12 are the following:

- Add a BTF encoder (Martin KaFai Lau)

	BTF (BPF Type Format) is the meta data format which describes
the data types of BPF program/map.  Hence, it basically focus on the C
programming language which the modern BPF is primary using.  The first
use case is to provide a generic pretty print capability for a BPF map.

	BTF has its root from CTF (Compact C-Type format).

- Add Documentation on how to use the BTF encoder: (Arnaldo Carvalho de Melo)

	Using the Linux 'perf' tools integration with BPF/llvm/clang to
show how to generate an object file that then gets its DWARF info used
to create a .BTF ELF section with this new BTF format. That augmented
eBPF ELF object file is then loaded while 'perf ftrace -g *bpf*' is used
to show the kernel BTF validation process.

- Initial support for DW_TAG_partial_unit (Arnaldo Carvalho de Melo)

	Just by treating these sections as DW_TAG_compile_unit, which is
enough for the structs that don't contain cross-section type references
to be correctly loaded and pretty-printed with pahole.

	This doesn't affect the kernel or modules, where such DWARF
compression techniques are not used so far. (Arnaldo Carvalho de Melo)

- Print cacheline boundaries in multiple union members, (Arnaldo Carvalho de Melo)

	We were showing it just on the first inner union member members,
as if it was a struct, now we restart the cacheline boundaries when
moving to print the next inner struct.

	As an example, look at 'struct audit_context' where the only
cacheline boundary printed for the following unnamed union was the first
one, for the 'socketcall' struct member, now that cacheline boundary
appears in each of the union member inner structs:

    struct audit_context {
    <SNIP>
            union {
                    struct {
                            int        nargs;                /*   824     4 */

                            /* XXX 4 bytes hole, try to pack */

                            /* --- cacheline 13 boundary (832 bytes) --- */
                            long int   args[6];              /*   832    48 */
                    } socketcall;                            /*   824    56 */
                    struct {
                            kuid_t     uid;                  /*   824     4 */
                            kgid_t     gid;                  /*   828     4 */
                            /* --- cacheline 13 boundary (832 bytes) --- */
                            umode_t    mode;                 /*   832     2 */

                            /* XXX 2 bytes hole, try to pack */

                            u32        osid;                 /*   836     4 */
                            int        has_perm;             /*   840     4 */
                            uid_t      perm_uid;             /*   844     4 */
                            gid_t      perm_gid;             /*   848     4 */
                            umode_t    perm_mode;            /*   852     2 */

                            /* XXX 2 bytes hole, try to pack */

                            long unsigned int qbytes;        /*   856     8 */
                    } ipc;                                   /*   824    40 */
                    struct {
                            mqd_t      mqdes;                /*   824     4 */

                            /* XXX 4 bytes hole, try to pack */

                            /* --- cacheline 13 boundary (832 bytes) --- */
                            struct mq_attr mqstat;           /*   832    64 */
                    } mq_getsetattr;                         /*   824    72 */
                    struct {
                            mqd_t      mqdes;                /*   824     4 */
                            int        sigev_signo;          /*   828     4 */
                    } mq_notify;                             /*   824     8 */
                    struct {
                            mqd_t      mqdes;                /*   824     4 */

                            /* XXX 4 bytes hole, try to pack */

                            /* --- cacheline 13 boundary (832 bytes) --- */
                            size_t     msg_len;              /*   832     8 */
                            unsigned int msg_prio;           /*   840     4 */

                            /* XXX 4 bytes hole, try to pack */

                            struct timespec64 abs_timeout;   /*   848    16 */
                    } mq_sendrecv;                           /*   824    40 */
                    struct {
                            int        oflag;                /*   824     4 */
                            umode_t    mode;                 /*   828     2 */

                            /* XXX 2 bytes hole, try to pack */

                            /* --- cacheline 13 boundary (832 bytes) --- */
                            struct mq_attr attr;             /*   832    64 */
                    } mq_open;                               /*   824    72 */
                    struct {
                            pid_t      pid;                  /*   824     4 */
                            struct audit_cap_data cap;       /*   828    32 */
                    } capset;                                /*   824    36 */
                    struct {
                            int        fd;                   /*   824     4 */
                            int        flags;                /*   828     4 */
                    } mmap;                                  /*   824     8 */
                    struct {
                            int        argc;                 /*   824     4 */
                    } execve;                                /*   824     4 */
                    struct {
                            char *     name;                 /*   824     8 */
                    } module;                                /*   824     8 */
            };                                               /*   824    72 */
            /* --- cacheline 14 boundary (896 bytes) --- */
            int                        fds[2];               /*   896     8 */
            struct audit_proctitle     proctitle;            /*   904    16 */

            /* size: 920, cachelines: 15, members: 46 */
            /* sum members: 912, holes: 2, sum holes: 8 */
            /* last cacheline: 24 bytes */
    };

- Show where a struct was used, e.g.

      $ pahole -I vmlinux
    <SNIP>
      /* Used at: /home/acme/git/perf/init/main.c */
      /* <1f4a5> /home/acme/git/perf/arch/x86/include/asm/orc_types.h:85 */
      struct orc_entry {
              s16                        sp_offset;            /*     0     2 */
              s16                        bp_offset;            /*     2     2 */
     <SNIP>

- Show offsets at union members (Arnaldo Carvalho de Melo, suggested by Matthew Wilcox):

	In complex structs with multiple complex unions figuring out the
offset for a given union member is difficult, as one needs to figure out
the union, go to the end of it to see the offset.

    This way, for instance, the Linux kernel's 'struct page' shows now as:

    struct page {
            long unsigned int          flags;                /*     0     8 */
            union {
                    struct address_space * mapping;          /*     8     8 */
                    void *             s_mem;                /*     8     8 */
                    atomic_t           compound_mapcount;    /*     8     4 */
            };                                               /*     8     8 */
            union {
                    long unsigned int  index;                /*    16     8 */
                    void *             freelist;             /*    16     8 */
            };                                               /*    16     8 */
            union {
                    long unsigned int  counters;             /*    24     8 */
                    struct {
                            union {
                                    atomic_t _mapcount;      /*    24     4 */
                                    unsigned int active;     /*    24     4 */
                                    struct {
                                            unsigned int inuse:16; /*    24:16  4 */
                                            unsigned int objects:15; /*    24: 1  4 */
                                            unsigned int frozen:1; /*    24: 0  4 */
                                    };                       /*    24     4 */
                                    int units;               /*    24     4 */
                            };                               /*    24     4 */
                            atomic_t   _refcount;            /*    28     4 */
                    };                                       /*    24     8 */
            };                                               /*    24     8 */
            union {
                    struct list_head   lru;                  /*    32    16 */
                    struct dev_pagemap * pgmap;              /*    32     8 */
                    struct {
                            struct page * next;              /*    32     8 */
                            int        pages;                /*    40     4 */
                            int        pobjects;             /*    44     4 */
                    };                                       /*    32    16 */
                    struct callback_head callback_head;      /*    32    16 */
                    struct {
                            long unsigned int compound_head; /*    32     8 */
                            unsigned int compound_dtor;      /*    40     4 */
                            unsigned int compound_order;     /*    44     4 */
                    };                                       /*    32    16 */
                    struct {
                            long unsigned int __pad;         /*    32     8 */
                            pgtable_t  pmd_huge_pte;         /*    40     8 */
                    };                                       /*    32    16 */
            };                                               /*    32    16 */
            union {
                    long unsigned int  private;              /*    48     8 */
                    spinlock_t         ptl;                  /*    48     4 */
                    struct kmem_cache * slab_cache;          /*    48     8 */
            };                                               /*    48     8 */
            struct mem_cgroup *        mem_cgroup;           /*    56     8 */

            /* size: 64, cachelines: 1, members: 7 */
    };

- Search and use running kernel vmlinux when no file is passed (Arnaldo Carvalho de Melo)

	Now it is possible to use it just as:

    $ pahole -C sk_buff_head
    struct sk_buff_head {
            struct sk_buff *           next;                 /*     0     8 */
            struct sk_buff *           prev;                 /*     8     8 */
            __u32                      qlen;                 /*    16     4 */
            spinlock_t                 lock;                 /*    20     4 */

            /* size: 24, cachelines: 1, members: 4 */
            /* last cacheline: 24 bytes */
    };
    $

	This will look at /sys/kernel/notes, find the running kernel
build-id, and then search the usual locations (vmlinux,
/lib/modules/`uname -r`/build/vmlinux, the debuginfo package paths, etc)
to find the matching vmlinux with the DWARF info to use. Build-ids are
now ubiquitous, so this shortens a the most common binary used.

- Document 'pahole --hex' in the man page (Arnaldo Carvalho de Melo)

	This option shows offsets and sizes in hexadecimal, helping to
correlate with reports using that notation.

	E.g.:

    $ pahole --hex -C sk_buff_head
    struct sk_buff_head {
            struct sk_buff *           next;                 /*     0   0x8 */
            struct sk_buff *           prev;                 /*   0x8   0x8 */
            __u32                      qlen;                 /*  0x10   0x4 */
            spinlock_t                 lock;                 /*  0x14   0x4 */

            /* size: 24, cachelines: 1, members: 4 */
            /* last cacheline: 24 bytes */
    };
    $

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

-------------------------------------------------------------------------------

Notable changes for v1.11:

    dwarves_fprintf: Find holes when expanding types
    
    When --expand_types/-E is used we go on expanding internal types, and
    when doing that for structs we were not looking for holes in them, only
    on the main struct, fix it.
    
    With that we can see these extra holes in a expanded Linux kernel's
    'struct task_struct':
    
    @@ -46,6 +46,9 @@
                            struct list_head * prev;                                         /*   176     8 */
                    } group_node; /*   168    16 */
                    unsigned int       on_rq;                                                /*   184     4 */
    +
    +               /* XXX 4 bytes hole, try to pack */
    +
                    /* --- cacheline 3 boundary (192 bytes) --- */
                    /* typedef u64 */ long long unsigned int exec_start;                     /*   192     8 */
                    /* typedef u64 */ long long unsigned int sum_exec_runtime;               /*   200     8 */
    @@ -86,9 +89,15 @@
                    } statistics; /*   232   216 */
                    /* --- cacheline 7 boundary (448 bytes) --- */
                    int                depth;                                                /*   448     4 */
    +
    +               /* XXX 4 bytes hole, try to pack */
    +
                    struct sched_entity * parent;                                            /*   456     8 */
                    struct cfs_rq *    cfs_rq;                                               /*   464     8 */
                    struct cfs_rq *    my_q;                                                 /*   472     8 */
    +
    +               /* XXX 32 bytes hole, try to pack */
    +
                    /* --- cacheline 8 boundary (512 bytes) --- */
                    struct sched_avg {
                            /* typedef u64 */ long long unsigned int last_update_time;       /*   512     8 */
    @@ -153,6 +162,9 @@
                            struct hrtimer_clock_base * base;                                /*   768     8 */
                            /* typedef u8 */ unsigned char state;                            /*   776     1 */
                            /* typedef u8 */ unsigned char is_rel;                           /*   777     1 */
    +
    +                       /* XXX 2 bytes hole, try to pack */
    +
                            int        start_pid;                                            /*   780     4 */
                            void *     start_site;                                           /*   784     8 */
                            char       start_comm[16];                                       /*   792    16 */
    @@ -197,6 +209,9 @@
            } tasks; /*   912    16 */
            struct plist_node {
                    int                prio;                                                 /*   928     4 */
    +
    +               /* XXX 4 bytes hole, try to pack */
    +
                    struct list_head {
                            struct list_head * next;                                         /*   936     8 */
                            struct list_head * prev;                                         /*   944     8 */
    @@ -258,12 +273,18 @@
                                    /* typedef u32 */ unsigned int val;                      /*  1136     4 */
                                    /* typedef u32 */ unsigned int flags;                    /*  1140     4 */
                                    /* typedef u32 */ unsigned int bitset;                   /*  1144     4 */
    +
    +                               /* XXX 4 bytes hole, try to pack */
    +
                                    /* --- cacheline 18 boundary (1152 bytes) --- */
                                    /* typedef u64 */ long long unsigned int time;           /*  1152     8 */
                                    u32 * uaddr2;                                            /*  1160     8 */
                            } futex;                                                         /*          40 */
                            struct {
                                    /* typedef clockid_t -> __kernel_clockid_t */ int clockid; /*  1128     4 */
    +
    +                               /* XXX 4 bytes hole, try to pack */
    +
                                    struct timespec * rmtp;                                  /*  1136     8 */
                                    struct compat_timespec * compat_rmtp;                    /*  1144     8 */
                                    /* typedef u64 */ long long unsigned int expires;        /*  1152     8 */
    @@ -426,6 +447,9 @@
            unsigned int               sessionid;                                            /*  1804     4 */
            struct seccomp {
                    int                mode;                                                 /*  1808     4 */
    +
    +               /* XXX 4 bytes hole, try to pack */
    +
                    struct seccomp_filter * filter;                                          /*  1816     8 */
            } seccomp; /*  1808    16 */
            /* typedef u32 */ unsigned int               parent_exec_id;                     /*  1824     4 */
    @@ -602,6 +626,9 @@
                    long unsigned int  backtrace[12];                                        /*  2472    96 */
                    /* --- cacheline 40 boundary (2560 bytes) was 8 bytes ago --- */
                    unsigned int       count;                                                /*  2568     4 */
    +
    +               /* XXX 4 bytes hole, try to pack */
    +
                    long unsigned int  time;                                                 /*  2576     8 */
                    long unsigned int  max;                                                  /*  2584     8 */
            } latency_record[32]; /*  2472  3840 */
    @@ -686,12 +713,18 @@
                    long unsigned int * io_bitmap_ptr;                                       /*  6600     8 */
                    long unsigned int  iopl;                                                 /*  6608     8 */
                    unsigned int       io_bitmap_max;                                        /*  6616     4 */
    +
    +               /* XXX 36 bytes hole, try to pack */
    +
                    /* --- cacheline 104 boundary (6656 bytes) --- */
                    struct fpu {
                            unsigned int last_cpu;                                           /*  6656     4 */
                            unsigned char fpstate_active;                                    /*  6660     1 */
                            unsigned char fpregs_active;                                     /*  6661     1 */
                            unsigned char counter;                                           /*  6662     1 */
    +
    +                       /* XXX 57 bytes hole, try to pack */
    +
                            /* --- cacheline 105 boundary (6720 bytes) --- */
                            union fpregs_state {
                                    struct fregs_state {
    @@ -751,6 +784,9 @@
                                            /* typedef u8 */ unsigned char no_update;        /*  6831     1 */
                                            /* typedef u8 */ unsigned char rm;               /*  6832     1 */
                                            /* typedef u8 */ unsigned char alimit;           /*  6833     1 */
    +
    +                                       /* XXX 6 bytes hole, try to pack */
    +
                                            struct math_emu_info * info;                     /*  6840     8 */
                                            /* typedef u32 */ unsigned int entry_eip;        /*  6848     4 */
                                    } soft; /*         136 */
    
-------------------------------------------------------------------------------------------------------

    dwarves_fprintf: Find holes on structs embedded in other structs
    
    Take 'struct task_struct' in the Linux kernel, these fields:
    
            /* --- cacheline 2 boundary (128 bytes) --- */
            struct sched_entity        se;                   /*   128   448 */
    
            /* XXX last struct has 24 bytes of padding */
    
            /* --- cacheline 9 boundary (576 bytes) --- */
            struct sched_rt_entity     rt;                   /*   576    48 */
    
    The sched_entity struct has 24 bytes of padding, and that info would
    only appear when printing 'struct task_struct' if class__find_holes()
    had previously been run on 'struct sched_entity' which wasn't always the
    case, make sure that happens.
    
    This results in this extra stat being printed for 'struct task_struct':
    
            /* paddings: 4, sum paddings: 38 */

-------------------------------------------------------------------------------------------------------

    dwarves_fprintf: Fixup cacheline boundary printing on expanded structs
    
    A diff for 'pahole -EC task_struct vmlinux' should clarify what this fixes:
    
      [acme@jouet linux]$ diff -u /tmp/before.c /tmp/after.c | head -30
      --- /tmp/before.c     2016-06-29 17:00:38.082647281 -0300
      +++ /tmp/a.c  2016-06-29 17:03:36.913124779 -0300
      @@ -43,8 +43,8 @@
                            struct list_head * prev;                                         /*   176     8 */
                    } group_node; /*   168    16 */
                    unsigned int       on_rq;                                                /*   184     4 */
      +             /* --- cacheline 3 boundary (192 bytes) --- */
                    /* typedef u64 */ long long unsigned int exec_start;                     /*   192     8 */
      -             /* --- cacheline 1 boundary (64 bytes) was 4 bytes ago --- */
                    /* typedef u64 */ long long unsigned int sum_exec_runtime;               /*   200     8 */
                    /* typedef u64 */ long long unsigned int vruntime;                       /*   208     8 */
                    /* typedef u64 */ long long unsigned int prev_sum_exec_runtime;          /*   216     8 */
      @@ -53,40 +53,40 @@
                            /* typedef u64 */ long long unsigned int wait_start;             /*   232     8 */
                            /* typedef u64 */ long long unsigned int wait_max;               /*   240     8 */
                            /* typedef u64 */ long long unsigned int wait_count;             /*   248     8 */
      +                     /* --- cacheline 4 boundary (256 bytes) --- */
                            /* typedef u64 */ long long unsigned int wait_sum;               /*   256     8 */
                            /* typedef u64 */ long long unsigned int iowait_count;           /*   264     8 */
                            /* typedef u64 */ long long unsigned int iowait_sum;             /*   272     8 */
                            /* typedef u64 */ long long unsigned int sleep_start;            /*   280     8 */
                            /* typedef u64 */ long long unsigned int sleep_max;              /*   288     8 */
      -                     /* --- cacheline 1 boundary (64 bytes) --- */
                            /* typedef s64 */ long long int sum_sleep_runtime;               /*   296     8 */
                            /* typedef u64 */ long long unsigned int block_start;            /*   304     8 */
                            /* typedef u64 */ long long unsigned int block_max;              /*   312     8 */
      +                     /* --- cacheline 5 boundary (320 bytes) --- */
                            /* typedef u64 */ long long unsigned int exec_max;               /*   320     8 */
                            /* typedef u64 */ long long unsigned int slice_max;              /*   328     8 */
                            /* typedef u64 */ long long unsigned int nr_migrations_cold;     /*   336     8 */
      [acme@jouet linux]$
    
    I.e. the boundary detection was being reset at each expanded struct, do the math globally,
    using the member offset, that was already done globally and correctly.
    
    Reported-and-Tested-by: Peter Zijlstra <peterz@infradead.org>

-------------------------------------------------------------------------------------------------------
