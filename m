Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1747912-1525524701-2-5722896347443080086
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525524700; b=gihWZqJ2MSh3K/UObBwfN4fup3hUKx+GHKpHbU+3wKbs1HblhO
    6Lg8VsXSs10PmeHIeyvxJ6L4Yi2hwsQa2lIDLzM34Wd/lglIZtqPtiKAidny0Py+
    DnJW9/QKl/it9OozBHQz3vF/PmmlEI3ZQrP41cqL7miAZseeIzO0PraTu7BMdAyM
    p5Q93ccVmVFPnZ7d2hOkZfmMQHDuvUcwPVxO5B446TuASvep5gEiYg/D+pxmB94I
    oId91vs1jpNdai5ZKAQIu7KfIjkS2Se4mfAcXyVKoT5QuEP95jwxw+Br3+l2e0EB
    BE4piM0Cj/V6GITezpxCN9cRrvSrQuDRFEvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:references:date:in-reply-to
    :message-id:mime-version:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525524700; bh=xF0hT
    uMaPgB1wHDcQkgnDriarBClA5GJbmpYDgC4axA=; b=QIjamiPgnekZJO7dkwpLL
    sb4579729w1W0DmBbtPlmJ1ncwqWt0PkCTFMB/CHflrR+JOaXqssj/4l3oGOZBSq
    WMN7BL9keMXPibsGxWgmPJa9uRBTsx6h2d4zy+1Lysq4uC3LA0NLCOy4gngobrOf
    tgEKTfuLFfyFi6hqUFCgdug5E19/Q/HIAgTSHfx/xxnWL/FuBhLAWBJgU5Rt5P/I
    qtWP0RXXtyjRqWfgoJkEjTKrlQ+3IbSAEFottpZHAi0F4JQEsdIzteHGvYN2uEkm
    lRuC4dj7p+DmDtJ9VPBFpakxld00LVeQJRtopX+buTf2Td0XUZDi0YvLgVe/mC3c
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=xmission.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=xmission.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEYrYkW59tnh0XQgBeKxHcIvbeqbTIOU3DtwdHLMNy1NiXWnAYuW2jdd1S5uF5c0+jdRrbM/UqgMzeGYsSJ95NqBPs0h7QnJm75D2So/QEsn0HH9AqZj
    1EOpx6AUvUCw/52FeQxfGYlWw0A6u9nEHG3Qn7RCrexQFShcIcfUy/wM2xBoVMb4Tgn0ED2ZYSDL+KLT8JwXLEuBrxX/xdIWHq+jUakqqbVsm2yk2W6HpViu
    H+zL+raIAJAS1SvCq6vVHg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=4a_A5sJuyYHrkWRXqyMA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christoph Hellwig <hch@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
 <20180425154827.32251-35-hch@lst.de>
Date: Sat, 05 May 2018 07:51:18 -0500
In-Reply-To: <20180425154827.32251-35-hch@lst.de> (Christoph Hellwig's message
 of "Wed, 25 Apr 2018 17:48:21 +0200")
Message-ID: <87r2mq2rll.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1fEwet-0001en-6w; ; ; mid=<87r2mq2rll.fsf@xmission.com>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=97.119.174.25; ; ; frm=ebiederm@xmission.com;
 ; ; spf=neutral
X-XM-AID: U2FsdGVkX1/dq8caLoWTrPLnINYgEt0D99p+s6Mn6vk=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;Christoph Hellwig <hch@lst.de>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 459 ms - load_scoreonly_sql: 0.05 (0.0%),
 signal_user_changed: 3.0 (0.6%), b_tie_ro: 2.0 (0.4%), parse: 1.25 (0.3%),
 extract_message_metadata: 24 (5.3%), get_uri_detail_list: 2.1 (0.5%),
 tests_pri_-1000: 12 (2.6%), tests_pri_-950: 2.1 (0.4%), tests_pri_-900: 1.77
 (0.4%), tests_pri_-400: 30 (6.6%), check_bayes: 28 (6.2%), b_tokenize: 12
 (2.6%), b_tok_get_all: 7 (1.5%), b_comp_prob: 3.6 (0.8%), b_tok_touch_all:
 2.9 (0.6%), b_finish: 0.80 (0.2%), tests_pri_0: 372 (80.9%),
 check_dkim_signature: 0.83 (0.2%), check_dkim_adsp: 4.4 (1.0%),
 tests_pri_500: 8 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 34/40] atm: simplify procfs code
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jiri Slaby <jslaby@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
 megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> Use remove_proc_subtree to remove the whole subtree on cleanup, and
> unwind the registration loop into individual calls.  Switch to use
> proc_create_seq where applicable.

Can you please explain why you are removing the error handling when
you are unwinding the registration loop?

>  int __init atm_proc_init(void)
>  {
> -	static struct atm_proc_entry *e;
> -	int ret;
> -
>  	atm_proc_root = proc_net_mkdir(&init_net, "atm", init_net.proc_net);
>  	if (!atm_proc_root)
> -		goto err_out;
> -	for (e = atm_proc_ents; e->name; e++) {
> -		struct proc_dir_entry *dirent;
> -
> -		dirent = proc_create(e->name, 0444,
> -				     atm_proc_root, e->proc_fops);
> -		if (!dirent)
> -			goto err_out_remove;
> -		e->dirent = dirent;
> -	}
> -	ret = 0;
> -out:
> -	return ret;
> -
> -err_out_remove:
> -	atm_proc_dirs_remove();
> -err_out:
> -	ret = -ENOMEM;
> -	goto out;
> +		return -ENOMEM;
> +	proc_create_seq("devices", 0444, atm_proc_root, &atm_dev_seq_ops);
> +	proc_create("pvc", 0444, atm_proc_root, &pvc_seq_fops);
> +	proc_create("svc", 0444, atm_proc_root, &svc_seq_fops);
> +	proc_create("vc", 0444, atm_proc_root, &vcc_seq_fops);
> +	return 0;
>  }

These proc entries could fail to register with -ENOMEM if for no other
reason.  Can you justify the removal of the error handling?

Can you please at least mention that removal in your change description
and explain why it is reasonable.

As it sits this is not a semantics preserving transformation, and the
difference is not documented.  Which raises red flags for me.

Eric

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
