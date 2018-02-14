Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031040AbeBNPCb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:02:31 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:54507 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030382AbeBNPCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:02:30 -0500
Subject: Re: plan9 semantics on Linux - mount namespaces
To: Richard Weinberger <richard@sigma-star.at>
Cc: Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net>
 <2658681.ustYaP9yci@blindfold>
 <a2a6f189-008e-38f2-afcb-b9393d8d440a@metux.net>
 <2050418.Dl5pXkWGsk@blindfold>
From: Enrico Weigelt <lkml@metux.net>
Organization: metux IT consult
Message-ID: <4f620eb7-c00c-487b-2e06-8cc4c97af38c@metux.net>
Date: Wed, 14 Feb 2018 16:02:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <2050418.Dl5pXkWGsk@blindfold>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:wwyCoKdvNT5gsZdRaTqb0PKEVg6noveQPI8kXpE9nXV+jA+4Ex3
 augysGiB24ZnVA6VEfnQi4DTZLjzko3mniycetn5uEmP9IznRgEFtQreBKJ8anfDAc5Cv3Z
 qE6SAkWmYFvYsP3rFObxJ1eVNxLzlWErHO7yhwN6lwM9AWtYjSI5HevQKm27VE5bW9NRPZO
 0/m1UHN3awJjoro7qMs/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bf2TkpsisQ4=:A57LJQiwY/dKcg5g2CMjLN
 ECPpTyTId3EcKNe6k/W4IqCd1Ydiq4BAUuRLqv0yZM+XsghyTbJb9TWqcI2ofPT9r82HRRIbk
 RQLbbjkJXdKTjtBX/uCzudX5sf8T0Gskfm5eIRc6LAO6FfHrzJOQgaP61L0z+1HNLnss2j+90
 l2+kOuNzDwJVdTh/WFVvBqN6e6A0gknmEoIfPi0x7bHcVTltK+bfufcXXjRR0Q7DRuRex+2aI
 Jh3IH89lS7MrQMu1dBijfdBxMDVDADole6LNdiOTmuWRZRa2Fla0V6wHv+76Tcy8xilmALu5k
 xuhek6zRLmzMcatulRkwN0fRXcRNLw6qQU0Ecz4I2daPrGYhqYyCBpjoh62IwR6iJyav/OJjX
 bkYge8qoFqvwX70LwUEjhVk1swOdUwnJ/ykOo3DolPxNaWeQEiUNdVyUV+x+ePRw9Yun0XOCp
 M5MjXLvkfeBuiOTZVxh0ysGT+F0PeiEElfQiWYdm1Hnv89AVxiPvVqygdrEFP5Vin9LLHISrY
 WH6tdpNtKGIfv9nVNPgICy8EnoG+WCs/goB3Mhl6FW3rbVQMe3CX0Pt0XKyFFHOD+JyItnYEU
 dJXz8/1P5sloiHa+Pmexn6T8GPuQ9un+maKpVZjlj/CoQTVeEjLlPzUh1rX260JYbn/Umq8Xq
 0jXqqXUSIDZNl30fkuWeqBv0PB+YV4gz6SBRY3qi+bR4m7KdpVkIsC86pRaFY3XQqtwJuPnyK
 5wGipGGB7b0GgzWucbZpQtPXLCsWMm1+cGyKQKVJYlKlFd7FuzhhrUsx1ny8IlAeJ8UjmKjJW
 0kypKDw8h5eP8woDPkgx66QZrr6PMcNmYjiof7wIGvMvSYemK9dyYgmlba2Rng0/K9iRP0Z
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.2018 15:19, Richard Weinberger wrote:

> Works here(tm).
> Can you debug it? Maybe we miss something obvious.

daemon@alphabox:~ strace unshare -U -r --setgroups=deny
execve("/bin/unshare", ["unshare", "-U", "-r", "--setgroups=deny"], 
0x7ee51e0c /* 11 vars */) = 0
brk(NULL)                               = 0x58000
fcntl64(0, F_GETFD)                     = 0
fcntl64(1, F_GETFD)                     = 0
fcntl64(2, F_GETFD)                     = 0
access("/etc/suid-debug", F_OK)         = -1 ENOENT (No such file or 
directory)
uname({sysname="Linux", nodename="alphabox", ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0x76f90000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file 
or directory)
open("/lib/tls/v7l/neon/vfp/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT 
(No such file or directory)
stat64("/lib/tls/v7l/neon/vfp", 0x7eae8710) = -1 ENOENT (No such file or 
directory)
open("/lib/tls/v7l/neon/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No 
such file or directory)
stat64("/lib/tls/v7l/neon", 0x7eae8710) = -1 ENOENT (No such file or 
directory)
open("/lib/tls/v7l/vfp/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No 
such file or directory)
stat64("/lib/tls/v7l/vfp", 0x7eae8710)  = -1 ENOENT (No such file or 
directory)
open("/lib/tls/v7l/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such 
file or directory)
stat64("/lib/tls/v7l", 0x7eae8710)      = -1 ENOENT (No such file or 
directory)
open("/lib/tls/neon/vfp/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No 
such file or directory)
stat64("/lib/tls/neon/vfp", 0x7eae8710) = -1 ENOENT (No such file or 
directory)
open("/lib/tls/neon/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such 
file or directory)
stat64("/lib/tls/neon", 0x7eae8710)     = -1 ENOENT (No such file or 
directory)
open("/lib/tls/vfp/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such 
file or directory)
stat64("/lib/tls/vfp", 0x7eae8710)      = -1 ENOENT (No such file or 
directory)
open("/lib/tls/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file 
or directory)
stat64("/lib/tls", 0x7eae8710)          = -1 ENOENT (No such file or 
directory)
open("/lib/v7l/neon/vfp/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No 
such file or directory)
stat64("/lib/v7l/neon/vfp", 0x7eae8710) = -1 ENOENT (No such file or 
directory)
open("/lib/v7l/neon/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such 
file or directory)
stat64("/lib/v7l/neon", 0x7eae8710)     = -1 ENOENT (No such file or 
directory)
open("/lib/v7l/vfp/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such 
file or directory)
stat64("/lib/v7l/vfp", 0x7eae8710)      = -1 ENOENT (No such file or 
directory)
open("/lib/v7l/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file 
or directory)
stat64("/lib/v7l", 0x7eae8710)          = -1 ENOENT (No such file or 
directory)
open("/lib/neon/vfp/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such 
file or directory)
stat64("/lib/neon/vfp", 0x7eae8710)     = -1 ENOENT (No such file or 
directory)
open("/lib/neon/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such 
file or directory)
stat64("/lib/neon", 0x7eae8710)         = -1 ENOENT (No such file or 
directory)
open("/lib/vfp/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file 
or directory)
stat64("/lib/vfp", 0x7eae8710)          = -1 ENOENT (No such file or 
directory)
open("/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, 
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0Yi\1\0004\0\0\0"..., 512) 
= 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=878136, ...}) = 0
mmap2(NULL, 947496, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x76e82000
mprotect(0x76f55000, 61440, PROT_NONE)  = 0
mmap2(0x76f64000, 12288, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd2000) = 0x76f64000
mmap2(0x76f67000, 9512, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x76f67000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0x76f8f000
set_tls(0x76f8f4c0, 0x76f8fb98, 0x76f92050, 0x76f8f4c0, 0x76f92050) = 0
mprotect(0x76f64000, 8192, PROT_READ)   = 0
mprotect(0x76f91000, 4096, PROT_READ)   = 0
getuid32()                              = 1
stat64("/etc/busybox.conf", {st_mode=S_IFREG|0644, st_size=198, ...}) = 0
brk(NULL)                               = 0x58000
brk(0x79000)                            = 0x79000
open("/etc/busybox.conf", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=198, ...}) = 0
read(3, "[SUID]\n#lines starting with # ar"..., 1024) = 198
read(3, "", 1024)                       = 0
close(3)                                = 0
getgid32()                              = 1
setgid32(1)                             = 0
setuid32(1)                             = 0
geteuid32()                             = 1
getegid32()                             = 1
unshare(CLONE_NEWUTS|CLONE_NEWUSER)     = 0
open("/proc/self/setgroups", O_WRONLY|O_LARGEFILE) = 3
write(3, "deny", 4)                     = 4
close(3)                                = 0
open("/proc/self/uid_map", O_WRONLY|O_LARGEFILE) = 3
write(3, "1 0 1", 5)                    = -1 EPERM (Operation not permitted)
write(2, "unshare: write error: Operation "..., 46unshare: write error: 
Operation not permitted
) = 46
exit_group(1)                           = ?
+++ exited with 1 +++

Seems it fails to write the uid map.
Is the order of setgroups vs uid_map correct ?

>> What's the exact relation between user and mnt namespace ?
>> Why do I need an own user ns for private mnt ns ? (except for the suid
>> bit, which I wanna get rid of anyways).
> 
> mount related system calls are root-only. Therefore you need the user
> namespace to become a root in your own little world. :)

I'm looking for a way to do that w/o being root (or something similar).
Actually, I don't like to change the user namespace, as it would cause
a lot of trouble w/ the /dev/cap[hash|use] devices, which I'm using for
user switching (as said: I'm going to get rid of suid completely).

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
