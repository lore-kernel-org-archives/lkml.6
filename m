Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZrqkgveJuzJH0wCRfCnpvJjaLBDSmCjXX2+namx8a6DsIH8k0u1Xr/u8XfgauOx1dZ7nGra
ARC-Seal: i=1; a=rsa-sha256; t=1525719086; cv=none;
        d=google.com; s=arc-20160816;
        b=e8EmfVFKLfexpojSKZGBV1wCiOvvmMP4LO3Pn9MljopbxxeyNf6Uh34CCe6x3yaG3H
         I/P5MqizOEJhCzdYCdg3bOovnmGiRvooNsQGG9idlOiEgpNmsPbjc/jfqBDSqunvseaa
         2ZIDHcRZ92P3ShNNs7qlL2xGOcmZSFehi1YaonG43orE9IKpIdo3cpHfC52P1owDa0C0
         4uk3NLPkHl2CRDj6WU7RD55T5DWXDIQeueRwUX2hDc5JrudvvPIk9J746QTzgastdCbW
         2GlmZNqgxRYjpfoFbB4uqvq0nUJ0N9uwAboldDQPPP4YqcdLkScWG4S27KoyXRE5GrAB
         idTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=DnPSSLswozn6C5y7Q7Df4Ar4c+7LioJh6awb+JAKyPI=;
        b=U/u4gLRBGO0I+xyofmr11RdCw9xbky6DZHNQVmRuYBPBq4pUQOU+emW2mVPI53jos/
         oC1b6YybJOKAZwJCgyvoK/rymlSIBHlLA3MD/3AmTE/eI2OKg+1st0gxLUrILTsQmYFG
         I4OS7yqwHsoXCgslsI1AsW7rLETkt7u1r/3QST6hZJALaMcXzmFeKv4kH7WXladsyG0m
         aZGjFhg5AR+dbczVB0hrHxDKdqjAZh1ZJVhir+mCV1vw1MxWE7+fcWhXzZLQTyN9pwku
         8oWY04PuheaYi3hQAefoJgUM9MN4f8jPwt/IUUqBwgg5ZqV/AULZ9rH1euoFb/MnbYOG
         XXUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Mon, 7 May 2018 18:51:24 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>
Cc: davem@davemloft.net, daniel@iogearbox.net,
	torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
	luto@amacapital.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@fb.com,
	Juergen Gross <jgross@suse.com>, Eric Paris <eparis@redhat.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Josh Triplett <josh@joshtriplett.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Stephen Smalley <sds@tycho.nsa.gov>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@linux.ie>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, pjones@redhat.com,
	Michael Matz <matz@suse.de>, mjg59@google.com,
	linux-security-module <linux-security-module@vger.kernel.org>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/4] net: add skeleton of bpfilter kernel
 module
Message-ID: <20180507185124.GA18195@wotan.suse.de>
References: <20180503043604.1604587-1-ast@kernel.org>
 <20180503043604.1604587-3-ast@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503043604.1604587-3-ast@kernel.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599416225694736469?=
X-GMAIL-MSGID: =?utf-8?q?1599832416685143371?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 09:36:02PM -0700, Alexei Starovoitov wrote:
> bpfilter.ko consists of bpfilter_kern.c (normal kernel module code)
> and user mode helper code that is embedded into bpfilter.ko
> 
> The steps to build bpfilter.ko are the following:
> - main.c is compiled by HOSTCC into the bpfilter_umh elf executable file
> - with quite a bit of objcopy and Makefile magic the bpfilter_umh elf file
>   is converted into bpfilter_umh.o object file
>   with _binary_net_bpfilter_bpfilter_umh_start and _end symbols
>   Example:
>   $ nm ./bld_x64/net/bpfilter/bpfilter_umh.o
>   0000000000004cf8 T _binary_net_bpfilter_bpfilter_umh_end
>   0000000000004cf8 A _binary_net_bpfilter_bpfilter_umh_size
>   0000000000000000 T _binary_net_bpfilter_bpfilter_umh_start
> - bpfilter_umh.o and bpfilter_kern.o are linked together into bpfilter.ko
> 
> bpfilter_kern.c is a normal kernel module code that calls
> the fork_usermode_blob() helper to execute part of its own data
> as a user mode process.
> 
> Notice that _binary_net_bpfilter_bpfilter_umh_start - end
> is placed into .init.rodata section, so it's freed as soon as __init
> function of bpfilter.ko is finished.
> As part of __init the bpfilter.ko does first request/reply action
> via two unix pipe provided by fork_usermode_blob() helper to
> make sure that umh is healthy. If not it will kill it via pid.

It does this very fast, right away. On a really slow system how are you sure
that this won't race and the execution of the check happens early on prior to
letting the actual setup trigger? After all, we're calling the userpsace
process in async mode. We could preempt it now.

> Later bpfilter_process_sockopt() will be called from bpfilter hooks
> in get/setsockopt() to pass iptable commands into umh via bpfilter.ko
> 
> If admin does 'rmmod bpfilter' the __exit code bpfilter.ko will
> kill umh as well.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/bpfilter.h      | 15 +++++++
>  include/uapi/linux/bpfilter.h | 21 ++++++++++
>  net/Kconfig                   |  2 +
>  net/Makefile                  |  1 +
>  net/bpfilter/Kconfig          | 17 ++++++++
>  net/bpfilter/Makefile         | 24 +++++++++++
>  net/bpfilter/bpfilter_kern.c  | 93 +++++++++++++++++++++++++++++++++++++++++++
>  net/bpfilter/main.c           | 63 +++++++++++++++++++++++++++++
>  net/bpfilter/msgfmt.h         | 17 ++++++++
>  net/ipv4/Makefile             |  2 +
>  net/ipv4/bpfilter/Makefile    |  2 +
>  net/ipv4/bpfilter/sockopt.c   | 42 +++++++++++++++++++
>  net/ipv4/ip_sockglue.c        | 17 ++++++++
>  13 files changed, 316 insertions(+)
>  create mode 100644 include/linux/bpfilter.h
>  create mode 100644 include/uapi/linux/bpfilter.h
>  create mode 100644 net/bpfilter/Kconfig
>  create mode 100644 net/bpfilter/Makefile
>  create mode 100644 net/bpfilter/bpfilter_kern.c
>  create mode 100644 net/bpfilter/main.c
>  create mode 100644 net/bpfilter/msgfmt.h
>  create mode 100644 net/ipv4/bpfilter/Makefile
>  create mode 100644 net/ipv4/bpfilter/sockopt.c
> 
> diff --git a/include/linux/bpfilter.h b/include/linux/bpfilter.h
> new file mode 100644
> index 000000000000..687b1760bb9f
> --- /dev/null
> +++ b/include/linux/bpfilter.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_BPFILTER_H
> +#define _LINUX_BPFILTER_H
> +
> +#include <uapi/linux/bpfilter.h>
> +
> +struct sock;
> +int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char *optval,
> +			    unsigned int optlen);
> +int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char *optval,
> +			    int *optlen);
> +extern int (*bpfilter_process_sockopt)(struct sock *sk, int optname,
> +				       char __user *optval,
> +				       unsigned int optlen, bool is_set);
> +#endif
> diff --git a/include/uapi/linux/bpfilter.h b/include/uapi/linux/bpfilter.h
> new file mode 100644
> index 000000000000..2ec3cc99ea4c
> --- /dev/null
> +++ b/include/uapi/linux/bpfilter.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _UAPI_LINUX_BPFILTER_H
> +#define _UAPI_LINUX_BPFILTER_H
> +
> +#include <linux/if.h>
> +
> +enum {
> +	BPFILTER_IPT_SO_SET_REPLACE = 64,
> +	BPFILTER_IPT_SO_SET_ADD_COUNTERS = 65,
> +	BPFILTER_IPT_SET_MAX,
> +};
> +
> +enum {
> +	BPFILTER_IPT_SO_GET_INFO = 64,
> +	BPFILTER_IPT_SO_GET_ENTRIES = 65,
> +	BPFILTER_IPT_SO_GET_REVISION_MATCH = 66,
> +	BPFILTER_IPT_SO_GET_REVISION_TARGET = 67,
> +	BPFILTER_IPT_GET_MAX,
> +};
> +
> +#endif /* _UAPI_LINUX_BPFILTER_H */
> diff --git a/net/Kconfig b/net/Kconfig
> index b62089fb1332..ed6368b306fa 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -201,6 +201,8 @@ source "net/bridge/netfilter/Kconfig"
>  
>  endif
>  
> +source "net/bpfilter/Kconfig"
> +
>  source "net/dccp/Kconfig"
>  source "net/sctp/Kconfig"
>  source "net/rds/Kconfig"
> diff --git a/net/Makefile b/net/Makefile
> index a6147c61b174..7f982b7682bd 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_TLS)		+= tls/
>  obj-$(CONFIG_XFRM)		+= xfrm/
>  obj-$(CONFIG_UNIX)		+= unix/
>  obj-$(CONFIG_NET)		+= ipv6/
> +obj-$(CONFIG_BPFILTER)		+= bpfilter/
>  obj-$(CONFIG_PACKET)		+= packet/
>  obj-$(CONFIG_NET_KEY)		+= key/
>  obj-$(CONFIG_BRIDGE)		+= bridge/
> diff --git a/net/bpfilter/Kconfig b/net/bpfilter/Kconfig
> new file mode 100644
> index 000000000000..782a732b9a5c
> --- /dev/null
> +++ b/net/bpfilter/Kconfig
> @@ -0,0 +1,17 @@
> +menuconfig BPFILTER
> +	bool "BPF based packet filtering framework (BPFILTER)"
> +	default n
> +	depends on NET && BPF
> +	help
> +	  This builds experimental bpfilter framework that is aiming to
> +	  provide netfilter compatible functionality via BPF
> +
> +if BPFILTER
> +config BPFILTER_UMH
> +	tristate "bpftiler kernel module with user mode helper"
> +	default m
> +	depends on m
> +	help
> +	  This builds bpfilter kernel module with embedded user mode helper
> +endif
> +
> diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
> new file mode 100644
> index 000000000000..897eedae523e
> --- /dev/null
> +++ b/net/bpfilter/Makefile
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the Linux BPFILTER layer.
> +#
> +
> +hostprogs-y := bpfilter_umh
> +bpfilter_umh-objs := main.o
> +HOSTCFLAGS += -I. -Itools/include/
> +
> +# a bit of elf magic to convert bpfilter_umh binary into a binary blob
> +# inside bpfilter_umh.o elf file referenced by
> +# _binary_net_bpfilter_bpfilter_umh_start symbol
> +# which bpfilter_kern.c passes further into umh blob loader at run-time
> +quiet_cmd_copy_umh = GEN $@
> +      cmd_copy_umh = echo ':' > $(obj)/.bpfilter_umh.o.cmd; \
> +      $(OBJCOPY) -I binary -O $(CONFIG_OUTPUT_FORMAT) \
> +      -B `$(OBJDUMP) -f $<|grep architecture|cut -d, -f1|cut -d' ' -f2` \
> +      --rename-section .data=.init.rodata $< $@

Cool, but so our expectation is that the compiler sets this symbol, how
are we sure it will always be set?

> +
> +$(obj)/bpfilter_umh.o: $(obj)/bpfilter_umh
> +	$(call cmd,copy_umh)
> +
> +obj-$(CONFIG_BPFILTER_UMH) += bpfilter.o
> +bpfilter-objs += bpfilter_kern.o bpfilter_umh.o
> diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
> new file mode 100644
> index 000000000000..e0a6fdd5842b
> --- /dev/null
> +++ b/net/bpfilter/bpfilter_kern.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/umh.h>
> +#include <linux/bpfilter.h>
> +#include <linux/sched.h>
> +#include <linux/sched/signal.h>
> +#include <linux/fs.h>
> +#include <linux/file.h>
> +#include "msgfmt.h"
> +
> +#define UMH_start _binary_net_bpfilter_bpfilter_umh_start
> +#define UMH_end _binary_net_bpfilter_bpfilter_umh_end
> +
> +extern char UMH_start;
> +extern char UMH_end;
> +
> +static struct umh_info info;
> +
> +static void shutdown_umh(struct umh_info *info)
> +{
> +	struct task_struct *tsk;
> +
> +	tsk = pid_task(find_vpid(info->pid), PIDTYPE_PID);
> +	if (tsk)
> +		force_sig(SIGKILL, tsk);
> +	fput(info->pipe_to_umh);
> +	fput(info->pipe_from_umh);
> +}
> +
> +static void stop_umh(void)
> +{
> +	if (bpfilter_process_sockopt) {
> +		bpfilter_process_sockopt = NULL;
> +		shutdown_umh(&info);
> +	}
> +}
> +
> +static int __bpfilter_process_sockopt(struct sock *sk, int optname,
> +				      char __user *optval,
> +				      unsigned int optlen, bool is_set)
> +{
> +	struct mbox_request req;
> +	struct mbox_reply reply;
> +	loff_t pos;
> +	ssize_t n;
> +
> +	req.is_set = is_set;
> +	req.pid = current->pid;
> +	req.cmd = optname;
> +	req.addr = (long)optval;
> +	req.len = optlen;
> +	n = __kernel_write(info.pipe_to_umh, &req, sizeof(req), &pos);
> +	if (n != sizeof(req)) {
> +		pr_err("write fail %zd\n", n);
> +		stop_umh();
> +		return -EFAULT;
> +	}
> +	pos = 0;
> +	n = kernel_read(info.pipe_from_umh, &reply, sizeof(reply), &pos);
> +	if (n != sizeof(reply)) {
> +		pr_err("read fail %zd\n", n);
> +		stop_umh();
> +		return -EFAULT;
> +	}
> +	return reply.status;
> +}
> +
> +static int __init load_umh(void)
> +{
> +	int err;
> +
> +	err = fork_usermode_blob(&UMH_start, &UMH_end - &UMH_start, &info);
> +	if (err)
> +		return err;
> +	pr_info("Loaded umh pid %d\n", info.pid);
> +	bpfilter_process_sockopt = &__bpfilter_process_sockopt;
> +
> +	if (__bpfilter_process_sockopt(NULL, 0, 0, 0, 0) != 0) {

See, here, what if the userspace process gets preemtped and we run this
check afterwards? Is that possible?

  Luis

> +		stop_umh();
> +		return -EFAULT;
> +	}
> +	return 0;
> +}
> +
> +static void __exit fini_umh(void)
> +{
> +	stop_umh();
> +}
> +module_init(load_umh);
> +module_exit(fini_umh);
> +MODULE_LICENSE("GPL");
> diff --git a/net/bpfilter/main.c b/net/bpfilter/main.c
> new file mode 100644
> index 000000000000..81bbc1684896
> --- /dev/null
> +++ b/net/bpfilter/main.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <sys/uio.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <sys/socket.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include "include/uapi/linux/bpf.h"
> +#include <asm/unistd.h>
> +#include "msgfmt.h"
> +
> +int debug_fd;
> +
> +static int handle_get_cmd(struct mbox_request *cmd)
> +{
> +	switch (cmd->cmd) {
> +	case 0:
> +		return 0;
> +	default:
> +		break;
> +	}
> +	return -ENOPROTOOPT;
> +}
> +
> +static int handle_set_cmd(struct mbox_request *cmd)
> +{
> +	return -ENOPROTOOPT;
> +}
> +
> +static void loop(void)
> +{
> +	while (1) {
> +		struct mbox_request req;
> +		struct mbox_reply reply;
> +		int n;
> +
> +		n = read(0, &req, sizeof(req));
> +		if (n != sizeof(req)) {
> +			dprintf(debug_fd, "invalid request %d\n", n);
> +			return;
> +		}
> +
> +		reply.status = req.is_set ?
> +			handle_set_cmd(&req) :
> +			handle_get_cmd(&req);
> +
> +		n = write(1, &reply, sizeof(reply));
> +		if (n != sizeof(reply)) {
> +			dprintf(debug_fd, "reply failed %d\n", n);
> +			return;
> +		}
> +	}
> +}
> +
> +int main(void)
> +{
> +	debug_fd = open("/dev/console", 00000002 | 00000100);
> +	dprintf(debug_fd, "Started bpfilter\n");
> +	loop();
> +	close(debug_fd);
> +	return 0;
> +}
> diff --git a/net/bpfilter/msgfmt.h b/net/bpfilter/msgfmt.h
> new file mode 100644
> index 000000000000..94b9ac9e5114
> --- /dev/null
> +++ b/net/bpfilter/msgfmt.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _NET_BPFILTER_MSGFMT_H
> +#define _NET_BPFTILER_MSGFMT_H
> +
> +struct mbox_request {
> +	__u64 addr;
> +	__u32 len;
> +	__u32 is_set;
> +	__u32 cmd;
> +	__u32 pid;
> +};
> +
> +struct mbox_reply {
> +	__u32 status;
> +};
> +
> +#endif
> diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
> index b379520f9133..7018f91c5a39 100644
> --- a/net/ipv4/Makefile
> +++ b/net/ipv4/Makefile
> @@ -16,6 +16,8 @@ obj-y     := route.o inetpeer.o protocol.o \
>  	     inet_fragment.o ping.o ip_tunnel_core.o gre_offload.o \
>  	     metrics.o
>  
> +obj-$(CONFIG_BPFILTER) += bpfilter/
> +
>  obj-$(CONFIG_NET_IP_TUNNEL) += ip_tunnel.o
>  obj-$(CONFIG_SYSCTL) += sysctl_net_ipv4.o
>  obj-$(CONFIG_PROC_FS) += proc.o
> diff --git a/net/ipv4/bpfilter/Makefile b/net/ipv4/bpfilter/Makefile
> new file mode 100644
> index 000000000000..ce262d76cc48
> --- /dev/null
> +++ b/net/ipv4/bpfilter/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_BPFILTER) += sockopt.o
> +
> diff --git a/net/ipv4/bpfilter/sockopt.c b/net/ipv4/bpfilter/sockopt.c
> new file mode 100644
> index 000000000000..42a96d2d8d05
> --- /dev/null
> +++ b/net/ipv4/bpfilter/sockopt.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/uaccess.h>
> +#include <linux/bpfilter.h>
> +#include <uapi/linux/bpf.h>
> +#include <linux/wait.h>
> +#include <linux/kmod.h>
> +
> +int (*bpfilter_process_sockopt)(struct sock *sk, int optname,
> +				char __user *optval,
> +				unsigned int optlen, bool is_set);
> +EXPORT_SYMBOL_GPL(bpfilter_process_sockopt);
> +
> +int bpfilter_mbox_request(struct sock *sk, int optname, char __user *optval,
> +			  unsigned int optlen, bool is_set)
> +{
> +	if (!bpfilter_process_sockopt) {
> +		int err = request_module("bpfilter");
> +
> +		if (err)
> +			return err;
> +		if (!bpfilter_process_sockopt)
> +			return -ECHILD;
> +	}
> +	return bpfilter_process_sockopt(sk, optname, optval, optlen, is_set);
> +}
> +
> +int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char __user *optval,
> +			    unsigned int optlen)
> +{
> +	return bpfilter_mbox_request(sk, optname, optval, optlen, true);
> +}
> +
> +int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char __user *optval,
> +			    int __user *optlen)
> +{
> +	int len;
> +
> +	if (get_user(len, optlen))
> +		return -EFAULT;
> +
> +	return bpfilter_mbox_request(sk, optname, optval, len, false);
> +}
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index 5ad2d8ed3a3f..e0791faacb24 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -47,6 +47,8 @@
>  #include <linux/errqueue.h>
>  #include <linux/uaccess.h>
>  
> +#include <linux/bpfilter.h>
> +
>  /*
>   *	SOL_IP control messages.
>   */
> @@ -1244,6 +1246,11 @@ int ip_setsockopt(struct sock *sk, int level,
>  		return -ENOPROTOOPT;
>  
>  	err = do_ip_setsockopt(sk, level, optname, optval, optlen);
> +#ifdef CONFIG_BPFILTER
> +	if (optname >= BPFILTER_IPT_SO_SET_REPLACE &&
> +	    optname < BPFILTER_IPT_SET_MAX)
> +		err = bpfilter_ip_set_sockopt(sk, optname, optval, optlen);
> +#endif
>  #ifdef CONFIG_NETFILTER
>  	/* we need to exclude all possible ENOPROTOOPTs except default case */
>  	if (err == -ENOPROTOOPT && optname != IP_HDRINCL &&
> @@ -1552,6 +1559,11 @@ int ip_getsockopt(struct sock *sk, int level,
>  	int err;
>  
>  	err = do_ip_getsockopt(sk, level, optname, optval, optlen, 0);
> +#ifdef CONFIG_BPFILTER
> +	if (optname >= BPFILTER_IPT_SO_GET_INFO &&
> +	    optname < BPFILTER_IPT_GET_MAX)
> +		err = bpfilter_ip_get_sockopt(sk, optname, optval, optlen);
> +#endif
>  #ifdef CONFIG_NETFILTER
>  	/* we need to exclude all possible ENOPROTOOPTs except default case */
>  	if (err == -ENOPROTOOPT && optname != IP_PKTOPTIONS &&
> @@ -1584,6 +1596,11 @@ int compat_ip_getsockopt(struct sock *sk, int level, int optname,
>  	err = do_ip_getsockopt(sk, level, optname, optval, optlen,
>  		MSG_CMSG_COMPAT);
>  
> +#ifdef CONFIG_BPFILTER
> +	if (optname >= BPFILTER_IPT_SO_GET_INFO &&
> +	    optname < BPFILTER_IPT_GET_MAX)
> +		err = bpfilter_ip_get_sockopt(sk, optname, optval, optlen);
> +#endif
>  #ifdef CONFIG_NETFILTER
>  	/* we need to exclude all possible ENOPROTOOPTs except default case */
>  	if (err == -ENOPROTOOPT && optname != IP_PKTOPTIONS &&
> -- 
> 2.9.5

-- 
Do not panic
