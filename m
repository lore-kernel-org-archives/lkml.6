Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ED7C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E2D2075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar-com.20150623.gappssmtp.com header.i=@cyphar-com.20150623.gappssmtp.com header.b="TjjW+XqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E2D2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeJIOSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:18:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33986 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJIOSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:18:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so359433pfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 00:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cyphar-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iou5yltQ5eHJbRd5RvxMZ/n9K0Xa+N0P0YTLzhawPio=;
        b=TjjW+XqSix4Uabi0/kpPHDk/1dfubiqk7gozRsnJjQ59ggRLpbHnyQWw3M5u5Dq/Lw
         y5qgUy2YLq7cS5W/SmC1SpEasYx43Ji+Uf/v68OER9z8kE0ZDvKR+LvYIk3J88Yb2Jpz
         ng+BV+dhCw3l18wR5Whs5+GKOe7nQDn2ovTqPvftGfchYQRPY+9TKfjVAN4eV4PgGoTW
         9uIN+LzSoRN+y7yfSAuwdAik6VImiikJ0bpakCY//kZN+jsJnZUUjsbKoKYgoZcHqDt9
         wpzsDQa1GCi4p2wCPhMvLbi2NUty1eySmUNY0DwwnMYmHhXepYvxzs0eyQnfug1ARzpg
         kVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iou5yltQ5eHJbRd5RvxMZ/n9K0Xa+N0P0YTLzhawPio=;
        b=hdEvufu5rUCwEFl4uZYyjVgfy7se+fE/q4Hev6P8CTOVMMhpLYuYx4iRt5hREkmdid
         HD7pyBas/L+MNbnZJ02wph1+NjW9jaQfDh75mNcUtZsrhp4c2nrB3TNJCOCZaUBu0e3r
         E2yLsciWwvOk1EAHi7eU5Mw6o0LYnqUtxTxXF5RQ7SPR7oAvG7mTJ9LbMfHzoNttAQFv
         Pe3tjSLV6cchdIuujLWwhzNY4S4sxyQlI3ybCsY07TwPGjt8uuEKbbxwkZFS6lJEvpjU
         7Xqfy0SSVqZjl4YWrfMgcB3bhdwlBitLlCO16Un5A6YrPfenFsBHuFLqx7noxhsAUwoi
         Hs3w==
X-Gm-Message-State: ABuFfojP95eEgnwh2h2/M8Jmm+yUlB/CPETml8ktjwdtVUqtx3Iz0eJj
        6xA+1h+nYgem4rmRXU50+p5Gvg==
X-Google-Smtp-Source: ACcGV63b/HKN2iFIvWizvqyvBfytfkB8yRV+Fucc8iqyWXTv1kU4pRllTfNYfH/ocKGb9Q/dj4bDuQ==
X-Received: by 2002:a63:f80a:: with SMTP id n10-v6mr24528263pgh.57.1539068563155;
        Tue, 09 Oct 2018 00:02:43 -0700 (PDT)
Received: from ?redacted? ([220.240.25.129])
        by smtp.gmail.com with ESMTPSA id y1-v6sm31179246pfy.89.2018.10.09.00.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 00:02:42 -0700 (PDT)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        David Drysdale <drysdale@google.com>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>, Tycho Andersen <tycho@tycho.ws>,
        dev@opencontainers.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v3 0/3] namei: implement various lookup restriction AT_* flags
Date:   Tue,  9 Oct 2018 18:02:27 +1100
Message-Id: <20181009070230.12884-1-cyphar@cyphar.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The need for some sort of control over VFS's path resolution (to avoid
malicious paths resulting in inadvertent breakouts) has been a very
long-standing desire of many userspace applications. This patchset is a
revival of Al Viro's old AT_NO_JUMPS[1,2] patchset (which was a variant
of David Drysdale's O_BENEATH patchset[3] which was a spin-off of the
Capsicum project[4]) with a few additions and changes made based on the
previous discussion within [5] as well as others I felt were useful.

As per the discussion in the AT_NO_JUMPS thread, AT_NO_JUMPS has been
split into separate flags.

  * AT_XDEV blocks mountpoint crossings (both upwards and downwards).
      openat("/", "tmp", AT_XDEV); // blocked
      openat("/tmp", "..", AT_XDEV); // blocked
      openat("/tmp", "/", AT_XDEV); // blocked

  * AT_NO_PROCLINKS blocks all resolution through /proc/$pid/fd/$fd
	"symlinks". Specifically, this blocks all jumps caused by a
	filesystem using nd_jump_link() to shove you around in the
	filesystem tree (these are referred to as "proclinks" in lieu of a
	better name).
	  openat(AT_FDCWD, "/proc/self/root", AT_NO_PROCLINKS); // blocked
	  openat(AT_FDCWD, "/proc/self/fd/0", AT_NO_PROCLINKS); // blocked
	  openat(AT_FDCWD, "/proc/self/ns/mnt", AT_NO_PROCLINKS); // blocked

  * AT_BENEATH disallows escapes from the starting dirfd using ".." or
	absolute paths (either in the path or during symlink resolution).
	Conceptually this flag ensures that you "stay below" the starting
	point in the filesystem tree. ".." resolution is allowed if it
	doesn't land you outside of the starting point (this is made safe
	against races by patch 3 in this series).
	  openat("/root", "foo", AT_BENEATH); // *not* blocked
	  openat("/root", "a/../b", AT_BENEATH); // *not* blocked
	  openat("/root", "a/../../root/b", AT_BENEATH); // blocked
	  openat("/root", "/root", AT_BENEATH); // blocked

	AT_BENEATH also currently disallows all "proclink" resolution
	because they can trivially throw you outside of the starting point.
	In a future patch we might allow such resolution (as long as it
	stays within the root).
	  openat("/", "proc/self/exe", AT_BENEATH); // blocked

In addition, two more flags have been added to the series:

  * AT_NO_SYMLINKS disallows *all* symlink resolution, and thus implies
	AT_NO_PROCLINKS. Linus mentioned this is something that git would
	like to have in the original discussion[5].
	  // assuming 'ln -s / /usr'
	  openat("/", "/usr/bin", AT_NO_SYMLINKS); // blocked
	  openat("/", "/proc/self/root", AT_NO_PROCLINKS); // blocked

  * AT_THIS_ROOT is a very similar idea to AT_BENEATH, but it serves a
    very different purpose. Rather than blocking resolutions if they
	would go outside of the starting point, it treats the starting point
	as a form of chroot(2). Container runtimes are one of the primary
	justifications for this flag, as they currently have to implement
	this sort of path handling racily in userspace[6].

	The restrictions on "proclink" resolution are the same as with
	AT_BENEATH (though in AT_THIS_ROOT's case it's not really clear how
	"proclink" jumps outside of the root should be handled), and patch 3
	in this series was also required to make ".." resolution safe.

Currently all of these flags are only enabled for openat(2) (and thus
have their own O_* flag names), but the corresponding AT_* flags have
been reserved so they can be added to syscalls where openat(O_PATH) is
not sufficient.

Patch changelog:
  v2:
    * Made ".." resolution with AT_THIS_ROOT and AT_BENEATH safe(r) with
	  some semi-aggressive __d_path checking (see patch 3).
    * Disallowed "proclinks" with AT_THIS_ROOT and AT_BENEATH, in the
	  hopes they can be re-enabled once safe.
    * Removed the selftests as they will be reimplemented as xfstests.
	* Removed stat(2) support, since you can already get it through
	  O_PATH and fstatat(2).

[1]: https://lwn.net/Articles/721443/
[2]: https://lore.kernel.org/patchwork/patch/784221/
[3]: https://lwn.net/Articles/619151/
[4]: https://lwn.net/Articles/603929/
[5]: https://lwn.net/Articles/723057/
[6]: https://github.com/cyphar/filepath-securejoin

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: David Drysdale <drysdale@google.com>
Cc: <containers@lists.linux-foundation.org>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-api@vger.kernel.org>

Aleksa Sarai (3):
  namei: implement O_BENEATH-style AT_* flags
  namei: implement AT_THIS_ROOT chroot-like path resolution
  namei: aggressively check for nd->root escape on ".." resolution

 fs/fcntl.c                       |   2 +-
 fs/namei.c                       | 241 +++++++++++++++++++++++--------
 fs/open.c                        |  10 ++
 fs/stat.c                        |   4 +-
 include/linux/fcntl.h            |   3 +-
 include/linux/namei.h            |   8 +
 include/uapi/asm-generic/fcntl.h |  20 +++
 include/uapi/linux/fcntl.h       |  10 ++
 8 files changed, 230 insertions(+), 68 deletions(-)

-- 
2.19.0

