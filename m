Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2585ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2C520C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2C520C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbeGQOLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:11:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46857 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731580AbeGQOLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:11:37 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1ffQBn-0000U2-Tg
        for linux-kernel@vger.kernel.org; Tue, 17 Jul 2018 13:38:52 +0000
Received: by mail-it0-f71.google.com with SMTP id u140-v6so1099872itc.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 06:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+yQY7FvTHCpbGgdxFop6GN3WoT4q87ln2NXbseabOX0=;
        b=Z/xeVHzEE5DzwWcn+WmqThnxEhdyNFQ4BzPxjhIoKKg2EozDm0sQBYPVjj4XTAfKl1
         LIQHL0QHAzM0S2zrQQXO31AFesE9TSAWKn2dpBJvm/H9RDdIT5ytHUDAHrS0larkD9c3
         Felv1bK7JODIYdufDJWkwNsB4iWEMCPXmY6QER90e7ctEYihH+TMx5TF2EHQHFGqv1JI
         NTPLf1G6PUsQWbMcl7TF99D8mLraUoQ7PdE9Gr4fE4lA8/87JSwjZUPlECTC947IGX9d
         MF6KpUfZJkVlLeso6jf/z0OtM7ojVPov74lXL6R4xZBE236lM0GoZTJ46+pNDgXdRD+V
         t3iQ==
X-Gm-Message-State: AOUpUlER8Tpy3cL1REB7ngYDp3y+yU0/M1FuK28umQN4hboJwUqRh1rl
        J1QzwepX9g+C0HvUXhjZNUADJloDx3xYvrNWeWjH2EdtISk+FgND2tTZ/5xUlKKgoQR9RBUDJ0w
        vKDivyQeYJHxa9zNkx0ivKC4qd8uwWstqKCUrHeqQLA==
X-Received: by 2002:a6b:df07:: with SMTP id w7-v6mr1445942iog.20.1531834730390;
        Tue, 17 Jul 2018 06:38:50 -0700 (PDT)
X-Google-Smtp-Source: AA+uWPzNK3UglJluyZhfVdUW2VFjcmickL34gaKsHQfJ69kD5M/A0RUABldZvbW9OpbBD6fpw7KvhQ==
X-Received: by 2002:a6b:df07:: with SMTP id w7-v6mr1445911iog.20.1531834730055;
        Tue, 17 Jul 2018 06:38:50 -0700 (PDT)
Received: from localhost ([2605:a601:ac7:2a20:60d3:8c04:9844:c5ad])
        by smtp.gmail.com with ESMTPSA id o139-v6sm693269itc.21.2018.07.17.06.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 06:38:49 -0700 (PDT)
Date:   Tue, 17 Jul 2018 08:38:47 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        containers@lists.linux-foundation.org,
        Phil Estes <estesp@gmail.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v3 0/1] shiftfs: uid/gid shifting filesystem
Message-ID: <20180717133847.GB15620@ubuntu-xps13>
References: <1529098514.4048.41.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1529098514.4048.41.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc David

On Fri, Jun 15, 2018 at 02:35:14PM -0700, James Bottomley wrote:
> This is a repost of the v2 patch updated for the d_real changes
> 
> For those who want to test it out, there's a git tree here
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/binfmt_misc.git
> 
> on the shiftfs-v3 branch
> 
> v2:
> 
> This is a rewrite of the original shiftfs code to make use of super
> block user namespaces.  I've also removed the mappings passed in as
> mount options in favour of using the mappings in s_user_ns.  The upshot
> is that it probably needs retesting for all the bugs people found,
> since there's a lot of new code, and the use case has changed.  Now, to
> use it, you have to mark the filesystems you want to be mountable
> inside a user namespace as root:
> 
> mount -t shiftfs -o mark <origin> <mark location>
> 
> The origin should be inaccessible to the unprivileged user, and the
> access to the <mark location> can be controlled by the usual filesystem
> permissions.  Once this is done, any user who can get access to the
> <mark location> can do (as the local user namespace root):
> 
> mount -t shiftfs <mark location> <somewhere in my local mount ns>

David, I wanted to pull you in here based on something you said on the
most recent filesystem context thread (thought it would make more sense
here rather than piggypacking on that already massive thread).

> I want to be able to add support for a bunch of things:
> 
>  (1) UID, GID and Project ID mapping/translation.  I want to be able to
>      install a translation table of some sort on the superblock to translate
>      source identifiers (which may be foreign numeric UIDs/GIDs, text names,
>      GUIDs) into system identifiers.  This needs to be done before the
>      superblock is published[*].
> 
>      Note that this may, for example, involve using the context and the
>      superblock held therein to issue an RPC to a server to look up
>      translations.
> 
>      [*] By "published" I mean made available through mount so that other
>      	 userspace processes can access it by path.
> 
>      Maybe specifying a translation range element with something like:
> 
> 	write(fd, "t uid <srcuid> <nsuid> <count>");
> 
>      The translation information also needs to propagate over an automount in
>      some circumstances.
> 
>  (2) Namespace configuration.  I want to be able to tell the superblock
>      creation process what namespaces should be applied when it created (in
>      particular the userns and netns) for containerisation purposes, e.g.:
> 
> 	write(fd, "n user=<fd> net=<fd>");

There's some obvious overlap between shiftfs and (1), but also important
differences. Primarily that shiftfs tries to make something that looks
like a bind mount rather than applying the mappings to new superblocks
for arbitrary filesystems.

I've already been playing with shiftfs on top of the filesystem context
patches, because I thought it would allow getting rid of the
intermediate "mark" mount described above. I have a hacky proof of
concept implementation that I've pushed to the shiftfs-fscontext branch
of

 git://git.kernel.org/pub/scm/linux/kernel/git/sforshee/linux.git

Basically the idea is that the more privileged "host" context can create
the fs fd and set the source on it to "bless" a subtree for id shifted
mounting, and the less privileged "client" context can use the fd to do
the mount (test program below). But I had to mess with fc->user_ns to
ensure s_user_ns gets set correctly, and it would likely be nicer to do
something more like (2) above.

The idea is that we need the more privileged "host" context to bless the
subtree being id shifted before actually executing the mount in the less
privileged "client" context. I'm doing this by having the host set the
source, then have the client use the fd to create the superblock (my
test program is below). This leads to some undesirable changing of the
fs contexts user ns in shiftfs (so that s_user_ns is the client's
namespace), which could likely be eliminated by doing something like
what's described in (2) and having the super block created on the host
side.

However, maybe these things are similar enough to settle on a common
solution, such as supporting id mapping at the vfsmount level.

Seth

---

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <fcntl.h>
#include <sched.h>
#include <sys/wait.h>
#include <limits.h>

#define __NR_move_mount		336
#define __NR_fsopen		337
#define __NR_fsmount		338

#define FSOPEN_CLOEXEC			0x00000001
#define FSMOUNT_CLOEXEC			0x00000001
#define MOVE_MOUNT_F_EMPTY_PATH         0x00000004

static int move_mount(int from_dfd, const char *from_pathname,
		      int to_dfd, const char *to_pathname, unsigned int flags)
{
	return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd, to_pathname,
		       flags);
}

static int fsopen(const char *fs_name, unsigned int flags)
{
	return syscall(__NR_fsopen, fs_name, flags);
}

static int fsmount(int fsfd, unsigned int flags, unsigned int ms_flags)
{
	return syscall(__NR_fsmount, fsfd, flags, ms_flags);
}

static void write_idmap(char *path, char *map)
{
	int fd;
	size_t map_len;

	map_len = strlen(map);
	fd = open(path, O_RDWR);
	if (fd == -1) {
		perror("open");
		exit(1);
	}

	if (write(fd, map, map_len) != map_len) {
		perror("write");
		exit(1);
	}
}

#define CHILD_STACK_SIZE (1024 * 1024)
static char child_stack[CHILD_STACK_SIZE];

struct child_args {
	int inp[2];
	int outp[2];
	int fsfd;
	char *dest;
	uid_t uid;
	uid_t gid;
};

static int child_func(void *arg)
{
	struct child_args *args = arg;
	char ch;
	int fsfd = args->fsfd, mfd;
	int ret;

	close(args->inp[1]);
	close(args->outp[0]);

	/* Change to uid/gid for root in the user ns */
	if (setgid(args->gid) == -1) {
		perror("setgid");
		exit(-1);
	}
	if (setuid(args->uid) == -1) {
		perror("setgid");
		exit(-1);
	}

	if (unshare(CLONE_NEWNS | CLONE_NEWUSER) == -1) {
		perror("unshare");
		exit(1);
	}

	/* Close write pipe to signal unshare has completed */
	close(args->outp[1]);

	/* Wait for uid/gid maps to be written */
	if (read(args->inp[0], &ch, 1) != 0) {
		perror("read");
		exit(1);
	}
	close(args->inp[0]);

	/* Now we are root in user ns; proceed with mount */
	ret = write(fsfd, "x create", 9);
	if (ret == -1) {
		perror("write \"x create\"");
		exit(1);
	}

	mfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
	if (mfd < 0) {
		perror("fsmount");
		exit(1);
	}

	ret = move_mount(mfd, "", AT_FDCWD, args->dest, MOVE_MOUNT_F_EMPTY_PATH);
	if (ret < 0) {
		perror("move_mount");
		exit(1);
	}

	close(fsfd);
	close(mfd);

	execl("/bin/sh", "/bin/sh", NULL);
	perror("execl");
	exit(1);
}

int main(int argc, char *argv[])
{
	char *src, *dest;
	uid_t root_uid;
	gid_t root_gid;
	int fsfd;
	char buf[PATH_MAX + 2];
	int len, ret;
	struct child_args args;
	pid_t child_pid;
	int *inp, *outp;
	char map_buf[100];
	char map_path[PATH_MAX];
	char ch;

	if (argc != 5) {
		printf("Usage: %s <src> <dest> <root_uid> <root_gid>\n", argv[0]);
		exit(1);
	}

	src = argv[1];
	dest = argv[2];
	root_uid = atoi(argv[3]);
	root_gid = atoi(argv[4]);

	fsfd = fsopen("shiftfs", FSOPEN_CLOEXEC);
	if (fsfd < 0) {
		perror("fsopen");
		exit(1);
	}

	/*
	 * Set source subtree; we do it on this side of clone(2) so that
	 * the kernel can check for permissions wrt src. The rest of the
	 * mount will happen in the child process after unsharing the
	 * user/mount namespaces.
	 */
	len = snprintf(buf, sizeof(buf), "s %s", src);
	if (len >= sizeof(buf)) {
		fprintf(stderr, "src too large\n");
		exit(1);
	}
	ret = write(fsfd, buf, len);
	if (ret == -1) {
		perror("write \"s src\"");
		exit(1);
	}

	if (pipe(args.inp) == -1) {
		perror("pipe");
		exit(1);
	}
	if (pipe(args.outp) == -1) {
		perror("pipe");
		exit(1);
	}
	args.fsfd = fsfd;
	args.dest = dest;
	args.uid = root_uid;
	args.gid = root_gid;
	child_pid = clone(child_func, child_stack + CHILD_STACK_SIZE, SIGCHLD, &args);

	/* Pipe directions reversed wrt child */
	inp = args.outp;
	outp = args.inp;
	close(inp[1]);
	close(outp[0]);

	/* Wait for child to set ids and unshare */
	if (read(inp[0], &ch, 1) != 0) {
		perror("read");
		exit(1);
	}

	snprintf(map_buf, sizeof(map_buf), "0 %ld 1", (long)root_uid);
	snprintf(map_path, sizeof(map_path), "/proc/%ld/uid_map",
		 (long)child_pid);
	write_idmap(map_path, map_buf);

	snprintf(map_buf, sizeof(map_buf), "0 %ld 1", (long)root_gid);
	snprintf(map_path, sizeof(map_path), "/proc/%ld/gid_map",
		 (long)child_pid);
	write_idmap(map_path, map_buf);

	/* Signal child that id maps have been updated */
	close(outp[1]);

	if (waitpid(child_pid, NULL, 0) == -1) {
		perror("waitpid");
		exit(1);
	}

	exit(0);
}
