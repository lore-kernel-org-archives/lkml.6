Return-Path: <ebiggers3@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517527816; cv=none;
        d=google.com; s=arc-20160816;
        b=AmYCgMWzUu+7GsjTne+C2bOaA3UDWHtS2ywCySnIRC8/0XspaSiRf62H0sAEuzyTRm
         RGXOVhEs7rLD1F6uqXTLqsjg0oavTu+TBkYBc++ADQtrqfiUizj2g5rPIyf/dNJg7Xlg
         Q8F+Unj+IPzd3+1cw7Ut70IJ4oKWePRkxAUsTM919vjiq7WQ683FUQMChMfL5n9AuGQj
         Bot3v1kyXCVyhXBmqr/8RmYuxyWE2qYB8FZFAX/Vu2SDmWsbH9xntqEOPLKqEOuya3qm
         xr/ZUCbq7kKgTqPaaVcLZIwn7G5PbOxt+1yilfe3kzF4/SA3lQqTOehZS4nvh4ua9mT1
         1m3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=/mXTsFUiOXiMf0Rp/PH3TVdHJAltuS2FrYHo29036YQ=;
        b=TlIl+8ay57O41dSBHeMSeZV0LYJsrbrPv+QW9oCQxDX+DJFjKkY77A2IUv1bwzxBHV
         UsVpjR6iCgwBOXFBEUuuGIwRODLB1dhjd3rUIKg2UESASd605bwoMCH5VA3RGF2f5hVJ
         Qa0rVEPeLx2nB9WKG2snZ7q/3R2KF0Y0KU9BYC6f2/7lKi1bdRpZlQ9rEMUqKldJ/9E9
         dBNXAl/iUji8gx4rNwpoFn8l1BDTtv8Z9AfCGzqm8XOEobhnh0KfYjcyXov1TSBHRqDt
         lV/KJfsJgAs8K9sqkZHx5/9mLdRl003v+IUJxeuTRVMcet1yTqIuro3807tlS/9IWdgZ
         OrCA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GxG9rcd9;
       spf=pass (google.com: domain of ebiggers3@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ebiggers3@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GxG9rcd9;
       spf=pass (google.com: domain of ebiggers3@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ebiggers3@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227b20zv8l9+/Zi00YiNTbXGCFDNd8oUP83LubORVIuvzuZT3ocK1bw2v/j4mvj85cHVRQECUQ==
Date: Thu, 1 Feb 2018 15:30:12 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot <syzbot+c0ea2226f77a42936bf7@syzkaller.appspotmail.com>
Cc: adobriyan@gmail.com, davem@davemloft.net, gregkh@linuxfoundation.org,
	kraig@google.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pombredanne@nexb.com,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: WARNING in reuseport_add_sock
Message-ID: <20180201233012.fgcve3ohufcspb2c@gmail.com>
References: <94eb2c1fcf4cdda26b05629d08d4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94eb2c1fcf4cdda26b05629d08d4@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589433054887734562?=
X-GMAIL-MSGID: =?utf-8?q?1591243247671500884?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Jan 12, 2018 at 03:58:01PM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 30a7acd573899fd8b8ac39236eff6468b195ac7d
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c0ea2226f77a42936bf7@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> ------------[ cut here ]------------
> socket already in reuseport group
> WARNING: CPU: 0 PID: 3496 at net/core/sock_reuseport.c:119
> reuseport_add_sock+0x742/0x9b0 net/core/sock_reuseport.c:117
> Kernel panic - not syncing: panic_on_warn set ...
> 
> CPU: 0 PID: 3496 Comm: syzkaller869503 Not tainted 4.15.0-rc6+ #245
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  panic+0x1e4/0x41c kernel/panic.c:183
>  __warn+0x1dc/0x200 kernel/panic.c:547
>  report_bug+0x211/0x2d0 lib/bug.c:184
>  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:1079
> RIP: 0010:reuseport_add_sock+0x742/0x9b0 net/core/sock_reuseport.c:117
> RSP: 0018:ffff8801bf5f7968 EFLAGS: 00010286
> RAX: dffffc0000000008 RBX: ffff8801bf4905c0 RCX: ffffffff8159d9de
> RDX: 0000000000000000 RSI: 1ffff10037ebeee8 RDI: 0000000000000293
> RBP: ffff8801bf5f7b00 R08: 1ffff10037ebeeaa R09: 0000000000000000
> R10: ffff8801bf5f7820 R11: 0000000000000000 R12: 1ffff10037ebef37
> R13: ffff8801bf47b930 R14: ffff8801bf5f7ad8 R15: 1ffff10037ebef3b
>  inet_reuseport_add_sock net/ipv4/inet_hashtables.c:456 [inline]
>  __inet_hash+0x767/0xb90 net/ipv4/inet_hashtables.c:477
>  inet_hash+0x61/0x90 net/ipv4/inet_hashtables.c:501
>  inet_csk_listen_start+0x38f/0x460 net/ipv4/inet_connection_sock.c:885
>  inet_listen+0x19a/0x440 net/ipv4/af_inet.c:228
>  SYSC_listen net/socket.c:1483 [inline]
>  SyS_listen+0x1aa/0x350 net/socket.c:1469
>  entry_SYSCALL_64_fastpath+0x23/0x9a
> RIP: 0033:0x445639
> RSP: 002b:00007f2966197db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000032
> RAX: ffffffffffffffda RBX: 00000000006dac24 RCX: 0000000000445639
> RDX: 0000000000445639 RSI: 0000000000000000 RDI: 0000000000000006
> RBP: 00000000006dac20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffc328a273f R14: 00007f29661989c0 R15: 0000000000000008
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 

Still happens.  Here's a simplified reproducer:

#include <linux/filter.h>
#include <linux/in.h>
#include <sys/socket.h>

int main()
{
	struct sock_filter filt = { .code = 6 };
	struct sock_fprog prog = { .len = 1, .filter = &filt };
	struct sockaddr_in addr = {
		.sin_family = AF_INET,
		.sin_port = htobe16(20000),
	};

	for (;;) {
		int fd = socket(AF_INET, SOCK_STREAM, 0);
		setsockopt(fd, IPPROTO_TCP, IP_TRANSPARENT, &(int){ 1 }, 4);
		setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &(int){ 1 }, 4);
		setsockopt(fd, SOL_SOCKET, SO_ATTACH_REUSEPORT_CBPF,
			   &prog, sizeof(prog));
		bind(fd, (void *)&addr, sizeof(addr));
		listen(fd, 0);
	}
}
