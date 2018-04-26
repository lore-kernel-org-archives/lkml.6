Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2209064-1524729713-2-9039621474529590700
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524729712; b=aGu2K8wY7CHSmmnW2CDpEUKESyUnSidvfNSW+WTXsYmd9/eI9u
    bK19UxDl19OuBqjWtZmTyckUmmZmwsXWIWNuY24Aniun4V9Pp4mhyzmAvNHYCMAW
    zAmQ2JHUCroF6RAscQTOdCECWPiz+q7AkXK661i/KW+zr06mNw6QMYDmLgkYeCHx
    +u7+7w05gXSF/0JgJ2VPxpTZDwhyx0Gdwymtkdrz1ON0ZCoAaIrDBuRk0nxM/f6V
    NKbBLaDG903mj37v+GM7IK/dSFu/Rwktwf1LiKqN4q2FKgSwAdAry6/94K5d6xHJ
    GpjoXKw8sPDPZVWENsoorjMePAd6o80zq6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524729712;
    bh=mUqd8Wbq4hshrxvFX/5+q9mq9PSqOzdtnnYdepw6E58=; b=cKwY7xgelR7s
    o1XiNvBGKLYCW8IVybh7HNRWtTUgzCB+o11Vbej2g17QsxXdfNW/hhczPwFbORtf
    RJCvZZDezaaa0ADrraMvRLspGg1DHxpBltzl49DLTjVrE9i81bpQ3tqDdnrvcF4N
    cZUGL7uVKBjWl96uzxq/jG9/MHW404xgSQUFWpJHoUyCV9lugFdY+a98/nmW3Uz4
    aig8XPp0JFm0OJOzlvbCIjYFYYxR5fnkMkXp6N5fLIhdtr4J7xjI3EtI1nZ3l4PN
    1qMBvhUv4zlap+m6oMLMKlchMvnUq2Yaen2PJttH5bBkT3PpdWepcWGdB7th4GZJ
    vmiImKNpag==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPsTIfz5o2GO7ZTt8v5VsgNVeKwhbJ3JPxHWBwDb2e5+BnDu7Tr3rMsQwG2vsWEb8G19r5JIk3D0t8EGickfKIucJ2N/wO4Be8+CIXm6NJQH4Yp/y+sk
    6pWClxQVQ4R9tbrK+/7qhWEwQro7VaaEPhWRNSD4HVrxXtTxODV9pL8Zv+aD2HBVrHM8GtGlgbkv+XTJj90ByLwxHqfynKPqKUQErrp1pNoYVtMZzp4ezCDG
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=J1Y8HTJGAAAA:8
    a=Z4Rwk6OoAAAA:8 a=meVymXHHAAAA:8 a=Sd5zeZbm3VBT58TPNTkA:9
    a=A8n3pYzLYUwXOHTo:21 a=QkHJN1ATiCJIMmOg:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbeDZIBt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 04:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751528AbeDZIBs (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 04:01:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A254E21745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Thu, 26 Apr 2018 17:01:44 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, akpm@linux-foundation.org, acme@kernel.org,
        rostedt@goodmis.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Fix random address output of blacklist file
Message-Id: <20180426170144.56ff7de34c56902066a044cf@kernel.org>
In-Reply-To: <20180426071959.82407-1-tmricht@linux.ibm.com>
References: <20180426071959.82407-1-tmricht@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 26 Apr 2018 09:19:59 +0200
Thomas Richter <tmricht@linux.ibm.com> wrote:

> File /sys/kernel/debug/kprobes/blacklist displays random addresses:
> 
> [root@s8360046 linux]# cat /sys/kernel/debug/kprobes/blacklist
> 0x0000000047149a90-0x00000000bfcb099a	print_type_x8
> ....
> 
> This breaks 'perf probe' which uses the blacklist file to prohibit
> probes on certain functions by checking the address range.
> 
> Fix this by printing the correct (unhashed) address.

Yeah, but I'm not sure recent "%px" policy. I think if the user can
dump kallsyms, this also can be dumped. But kallsyms seems different
policy...

Anyway, please check my series.

https://patchwork.kernel.org/patch/10183629/

It uses to check the kallsyms policy function to check.

Unfortunately, this is not merged. Anyway, I'll repost it (on the top of tip tree)

> 
> The file mode is read all but this is not an issue as the file
> hierarchy points out:
>  # ls -ld /sys/ /sys/kernel/ /sys/kernel/debug/ /sys/kernel/debug/kprobes/
> 	/sys/kernel/debug/kprobes/blacklist
> dr-xr-xr-x 12 root root 0 Apr 19 07:56 /sys/
> drwxr-xr-x  8 root root 0 Apr 19 07:56 /sys/kernel/
> drwx------ 16 root root 0 Apr 19 06:56 /sys/kernel/debug/
> drwxr-xr-x  2 root root 0 Apr 19 06:56 /sys/kernel/debug/kprobes/
> -r--r--r--  1 root root 0 Apr 19 06:56 /sys/kernel/debug/kprobes/blacklist
> 
> Everything in and below /sys/kernel/debug is rwx to root only,
> no group or others have access.
> 
> Background:
> Directory /sys/kernel/debug/kprobes is created by debugfs_create_dir()
> which sets the mode bits to rwxr-xr-x. Maybe change that to use the
> parent's directory mode bits instead?

Good catch! Yes, it should be hardened. 
Anyway, that is out of this topic. I just change blacklist file mode bits
in my series.

Thank you,

> 
> Fixes: ad67b74d2469 ("printk: hash addresses printed with %p")
> Cc: <stable@vger.kernel.org> # v4.15+
> Cc: <linux-kernel@vger.kernel.org>
> To: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
> To: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> To: David S Miller <davem@davemloft.net>
> To: Masami Hiramatsu <mhiramat@kernel.org>
> To: Andrew Morton <akpm@linux-foundation.org>
> To: acme@kernel.org
> To: Steven Rostedt <rostedt@goodmis.org>
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  kernel/kprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 102160ff5c66..ea619021d901 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2428,7 +2428,7 @@ static int kprobe_blacklist_seq_show(struct seq_file *m, void *v)
>  	struct kprobe_blacklist_entry *ent =
>  		list_entry(v, struct kprobe_blacklist_entry, list);
>  
> -	seq_printf(m, "0x%p-0x%p\t%ps\n", (void *)ent->start_addr,
> +	seq_printf(m, "0x%px-0x%px\t%ps\n", (void *)ent->start_addr,
>  		   (void *)ent->end_addr, (void *)ent->start_addr);
>  	return 0;
>  }
> -- 
> 2.14.3
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
