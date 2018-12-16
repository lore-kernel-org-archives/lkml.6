Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9901C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE4D217FA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGVUk96h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbeLPUGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 15:06:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44065 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbeLPUGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 15:06:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so5268343pfh.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 12:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+OxlBzAUm8KeZ1NfcFonsjitiYkavWAVTGD4jLz7Qk0=;
        b=QGVUk96hYrghzU5kpJJ5CAk6zGD1FBICbamz/soU9A+vlQCxHM98jEXsP0b9ilIR0T
         dnaXZV/Q5t1LAGJA3QyomYPpmDmR6ff1eOAm3nTfXS42HT6CWCfMIzFbRv1YGCvpMNpH
         WDN78FpVR6xBCJRng2VnoAza+QfAQF51WPLfuoCRmKjXTpNDx4zMmrQaCJHfsWIh3jic
         /5gLKH4srsx31QafrYmgBFhHZbHUsJAyLxzkV/meRQsYBx9jR/vXfuQI64dTELrozk1t
         8AXDHlILcMBRHKoaZzYvrfJFYxPD6sGtrOiqU3WkW8pY61515ouDUwydos4PfNZHzkTz
         laKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+OxlBzAUm8KeZ1NfcFonsjitiYkavWAVTGD4jLz7Qk0=;
        b=OCOoQfFSUcP14gECGcvsczUvyJrgMlG6Th6YiWahNTjItzDKoDQd1AVa7+xmN+kxSQ
         Iwo0Qrkm99W4vV73tzAoqruayaqhg94Q+oHwpeG/c1bKbZtdoIk786w3hIfe8snm2yqC
         VGhRxThHn8hEiwrdlIGxHl/snoZga7twyciwR2JAFRB6i+iB4GwU3MGI6jEz3hxXOPch
         2SMaanOcXw+6nDLWhu/9lXdPBCYbahWQyy9ejuak/JXehz0L98WIfL0LCipXtQI3Fo1v
         4T7xAgd3ZKW9uoDwRm9pJRpgWEwMKjET+iuhzVUXVbJeGDTa+0fWunGTGV7N0TsToFtt
         KSRg==
X-Gm-Message-State: AA+aEWaGKIUHv85IOxoEVQDgTX538TOnGusffOStg8xssBr3ek3Ichx0
        qF+OyfU3kh8qBKBYqHpmf1T5w2jy4DO0aHPuR8g=
X-Google-Smtp-Source: AFSGD/Xgql/Mbq+AfjtyLSgIwpGOXa/Ad7Ak/wnwj1z0QslKjBYdRUhEqp1xamcbMAFdvZRpKaIR56kUuLWnXAPg9ok=
X-Received: by 2002:a62:6dc7:: with SMTP id i190mr10345590pfc.166.1544990761776;
 Sun, 16 Dec 2018 12:06:01 -0800 (PST)
MIME-Version: 1.0
References: <1544879072-4251-1-git-send-email-carmeli.tamir@gmail.com>
 <1544879072-4251-4-git-send-email-carmeli.tamir@gmail.com> <87y38qbo7k.fsf@mail.parknet.co.jp>
In-Reply-To: <87y38qbo7k.fsf@mail.parknet.co.jp>
From:   Tamir Carmeli <carmeli.tamir@gmail.com>
Date:   Sun, 16 Dec 2018 22:05:28 +0200
Message-ID: <CAKxm1-GqB=K5mnwj1GAK0jWG6J0rHjbwsmSvpvaOVVDcoUR+Kw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fat: New inline functions to determine the FAT
 variant (32, 16 or 12)
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, jthumshirn@suse.de,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        akpm@linux-foundation.org, bvanassche@acm.org, axboe@kernel.dk,
        martin.petersen@oracle.com, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure. Published v3 with lower case chars. Fixed in both relevant patches.

On Sat, Dec 15, 2018 at 9:10 PM OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> wrote:
>
> Carmeli Tamir <carmeli.tamir@gmail.com> writes:
>
> > This patch introduces 3 new inline functions - IS_FAT12, IS_FAT16 and
> > IS_FAT32, and replaces every occurrence in the code in which the FS
> > variant (whether this is FAT12, FAT16 or FAT32) was previously checked
> > using msdos_sb_info->fat_bits.
>
> Could you use lower case chars for inline functions?
>
> > Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
> > ---
> >  fs/fat/cache.c  |  2 +-
> >  fs/fat/dir.c    |  4 ++--
> >  fs/fat/fat.h    | 25 ++++++++++++++++++++++---
> >  fs/fat/fatent.c | 16 +++++++---------
> >  fs/fat/inode.c  | 12 ++++++------
> >  fs/fat/misc.c   |  2 +-
> >  6 files changed, 39 insertions(+), 22 deletions(-)
> >
> > diff --git a/fs/fat/cache.c b/fs/fat/cache.c
> > index 78d501c..30c51b9 100644
> > --- a/fs/fat/cache.c
> > +++ b/fs/fat/cache.c
> > @@ -363,7 +363,7 @@ int fat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
> >
> >       *phys = 0;
> >       *mapped_blocks = 0;
> > -     if ((sbi->fat_bits != 32) && (inode->i_ino == MSDOS_ROOT_INO)) {
> > +     if (!IS_FAT32(sbi) && (inode->i_ino == MSDOS_ROOT_INO)) {
> >               if (sector < (sbi->dir_entries >> sbi->dir_per_block_bits)) {
> >                       *phys = sector + sbi->dir_start;
> >                       *mapped_blocks = 1;
> > diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> > index c8366cb..b0b8f44 100644
> > --- a/fs/fat/dir.c
> > +++ b/fs/fat/dir.c
> > @@ -57,7 +57,7 @@ static inline void fat_dir_readahead(struct inode *dir, sector_t iblock,
> >       if ((iblock & (sbi->sec_per_clus - 1)) || sbi->sec_per_clus == 1)
> >               return;
> >       /* root dir of FAT12/FAT16 */
> > -     if ((sbi->fat_bits != 32) && (dir->i_ino == MSDOS_ROOT_INO))
> > +     if (!IS_FAT32(sbi) && (dir->i_ino == MSDOS_ROOT_INO))
> >               return;
> >
> >       bh = sb_find_get_block(sb, phys);
> > @@ -1313,7 +1313,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
> >               }
> >       }
> >       if (dir->i_ino == MSDOS_ROOT_INO) {
> > -             if (sbi->fat_bits != 32)
> > +             if (!IS_FAT32(sbi))
> >                       goto error;
> >       } else if (MSDOS_I(dir)->i_start == 0) {
> >               fat_msg(sb, KERN_ERR, "Corrupted directory (i_pos %lld)",
> > diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> > index 11bc4a2..5b6f1c8 100644
> > --- a/fs/fat/fat.h
> > +++ b/fs/fat/fat.h
> > @@ -142,13 +142,32 @@ static inline struct msdos_sb_info *MSDOS_SB(struct super_block *sb)
> >       return sb->s_fs_info;
> >  }
> >
> > +/*
> > + * Functions that determine the variant of the FAT file system (i.e.,
> > + * whether this is FAT12, FAT16 or FAT32.
> > + */
> > +static inline bool IS_FAT12(const struct msdos_sb_info *sbi)
> > +{
> > +     return sbi->fat_bits == 12;
> > +}
> > +
> > +static inline bool IS_FAT16(const struct msdos_sb_info *sbi)
> > +{
> > +     return sbi->fat_bits == 16;
> > +}
> > +
> > +static inline bool IS_FAT32(const struct msdos_sb_info *sbi)
> > +{
> > +     return sbi->fat_bits == 32;
> > +}
> > +
> >  /* Maximum number of clusters */
> >  static inline u32 MAX_FAT(struct super_block *sb)
> >  {
> >       struct msdos_sb_info *sbi = MSDOS_SB(sb);
> >
> > -     return sbi->fat_bits == 32 ? MAX_FAT32 :
> > -             sbi->fat_bits == 16 ? MAX_FAT16 : MAX_FAT12;
> > +     return IS_FAT32(sbi) ? MAX_FAT32 :
> > +             IS_FAT16(sbi) ? MAX_FAT16 : MAX_FAT12;
> >  }
> >
> >  static inline struct msdos_inode_info *MSDOS_I(struct inode *inode)
> > @@ -266,7 +285,7 @@ static inline int fat_get_start(const struct msdos_sb_info *sbi,
> >                               const struct msdos_dir_entry *de)
> >  {
> >       int cluster = le16_to_cpu(de->start);
> > -     if (sbi->fat_bits == 32)
> > +     if (IS_FAT32(sbi))
> >               cluster |= (le16_to_cpu(de->starthi) << 16);
> >       return cluster;
> >  }
> > diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
> > index f58c0ca..9166d96 100644
> > --- a/fs/fat/fatent.c
> > +++ b/fs/fat/fatent.c
> > @@ -290,19 +290,17 @@ void fat_ent_access_init(struct super_block *sb)
> >
> >       mutex_init(&sbi->fat_lock);
> >
> > -     switch (sbi->fat_bits) {
> > -     case 32:
> > +     if (IS_FAT32(sbi)) {
> >               sbi->fatent_shift = 2;
> >               sbi->fatent_ops = &fat32_ops;
> > -             break;
> > -     case 16:
> > +     } else if (IS_FAT16(sbi)) {
> >               sbi->fatent_shift = 1;
> >               sbi->fatent_ops = &fat16_ops;
> > -             break;
> > -     case 12:
> > +     } else if (IS_FAT12(sbi)) {
> >               sbi->fatent_shift = -1;
> >               sbi->fatent_ops = &fat12_ops;
> > -             break;
> > +     } else {
> > +             fat_fs_error(sb, "invalid FAT variant, %u bits", sbi->fat_bits);
> >       }
> >  }
> >
> > @@ -310,7 +308,7 @@ static void mark_fsinfo_dirty(struct super_block *sb)
> >  {
> >       struct msdos_sb_info *sbi = MSDOS_SB(sb);
> >
> > -     if (sb_rdonly(sb) || sbi->fat_bits != 32)
> > +     if (sb_rdonly(sb) || !IS_FAT32(sbi))
> >               return;
> >
> >       __mark_inode_dirty(sbi->fsinfo_inode, I_DIRTY_SYNC);
> > @@ -327,7 +325,7 @@ static inline int fat_ent_update_ptr(struct super_block *sb,
> >       /* Is this fatent's blocks including this entry? */
> >       if (!fatent->nr_bhs || bhs[0]->b_blocknr != blocknr)
> >               return 0;
> > -     if (sbi->fat_bits == 12) {
> > +     if (IS_FAT12(sbi)) {
> >               if ((offset + 1) < sb->s_blocksize) {
> >                       /* This entry is on bhs[0]. */
> >                       if (fatent->nr_bhs == 2) {
> > diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> > index 708de6d..a84b61b 100644
> > --- a/fs/fat/inode.c
> > +++ b/fs/fat/inode.c
> > @@ -686,7 +686,7 @@ static void fat_set_state(struct super_block *sb,
> >
> >       b = (struct fat_boot_sector *) bh->b_data;
> >
> > -     if (sbi->fat_bits == 32) {
> > +     if (IS_FAT32(sbi)) {
> >               if (set)
> >                       b->fat32.state |= FAT_STATE_DIRTY;
> >               else
> > @@ -1397,7 +1397,7 @@ static int fat_read_root(struct inode *inode)
> >       inode->i_mode = fat_make_mode(sbi, ATTR_DIR, S_IRWXUGO);
> >       inode->i_op = sbi->dir_ops;
> >       inode->i_fop = &fat_dir_operations;
> > -     if (sbi->fat_bits == 32) {
> > +     if (IS_FAT32(sbi)) {
> >               MSDOS_I(inode)->i_start = sbi->root_cluster;
> >               error = fat_calc_dir_size(inode);
> >               if (error < 0)
> > @@ -1424,7 +1424,7 @@ static unsigned long calc_fat_clusters(struct super_block *sb)
> >       struct msdos_sb_info *sbi = MSDOS_SB(sb);
> >
> >       /* Divide first to avoid overflow */
> > -     if (sbi->fat_bits != 12) {
> > +     if (!IS_FAT12(sbi)) {
> >               unsigned long ent_per_sec = sb->s_blocksize * 8 / sbi->fat_bits;
> >               return ent_per_sec * sbi->fat_length;
> >       }
> > @@ -1744,7 +1744,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
> >       }
> >
> >       /* interpret volume ID as a little endian 32 bit integer */
> > -     if (sbi->fat_bits == 32)
> > +     if (IS_FAT32(sbi))
> >               sbi->vol_id = bpb.fat32_vol_id;
> >       else /* fat 16 or 12 */
> >               sbi->vol_id = bpb.fat16_vol_id;
> > @@ -1770,11 +1770,11 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
> >
> >       total_clusters = (total_sectors - sbi->data_start) / sbi->sec_per_clus;
> >
> > -     if (sbi->fat_bits != 32)
> > +     if (!IS_FAT32(sbi))
> >               sbi->fat_bits = (total_clusters > MAX_FAT12) ? 16 : 12;
> >
> >       /* some OSes set FAT_STATE_DIRTY and clean it on unmount. */
> > -     if (sbi->fat_bits == 32)
> > +     if (IS_FAT32(sbi))
> >               sbi->dirty = bpb.fat32_state & FAT_STATE_DIRTY;
> >       else /* fat 16 or 12 */
> >               sbi->dirty = bpb.fat16_state & FAT_STATE_DIRTY;
> > diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> > index fce0a76..5368c6a 100644
> > --- a/fs/fat/misc.c
> > +++ b/fs/fat/misc.c
> > @@ -64,7 +64,7 @@ int fat_clusters_flush(struct super_block *sb)
> >       struct buffer_head *bh;
> >       struct fat_boot_fsinfo *fsinfo;
> >
> > -     if (sbi->fat_bits != 32)
> > +     if (!IS_FAT32(sbi))
> >               return 0;
> >
> >       bh = sb_bread(sb, sbi->fsinfo_sector);
>
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
