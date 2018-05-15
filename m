Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2893015-1526400721-2-11836892977619830637
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='dk',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526400721; b=JliB7GS0YvocK4XIvq781XfcBqwbWiCjYTFyKXbtSHHCLoE4tx
    mc3YB5BvgRV+1uPapQ3T2+Qirjn6TpWdfcT/nS5HQSVj9EcRoRSqGefGKaenwoZf
    0utYl53FcZNn4nbUYHF+xIspOFAGIpbfwU+JalESrNspuNXCw6zEUh0y/XkGwJA7
    bfY/0MXUl40RKxR1hgTo38Z7qeiOkCUNua4lY+WPdiD0b1JHr/t4HDR8hpddAXDo
    zsdRJr6mkJXXpRJaPHJIEDw+DmJHjU7sATNLBrPBWGrCPrLt5kIrZYmpOFVWsP6h
    iJsEu8KPA3cfj03AkyvNPK4+z1dXuBkHkqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526400721;
    bh=tprdVAtIxK6kGYl+3JAgMdUdLAdrYr9A0iZbEjlDomI=; b=nv9cGaci639P
    sruSyZayptYDMYxrWkwfA7Na67ls4b2PvrDDx2WA5gLik69AnXfW27ibpa0zTKd9
    m3TQMz40gmb+HB7lfzwg/yg1et+12Jrc1ptQi27NPL5QJGiW/JGq1xs1l+R2ejV/
    N+0IrcdmP/qsqrjO0N8/1IoyJPPk42iP3BiG0pPoU3lc6lRWmhjv/key8vvuwN9E
    rPiWybRI3l3QKhRL692KRUFdijZoTerjYv6We8x1O7Yd/iz6l207Mgr6+jPxGwJS
    D5X7oxdJyee1tgpny2Bx+1fupYgpeTjLkzk08sGYbpoSBdRa3yZU/SFww9a0/Vhc
    WhnuZsiNOg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=kernel-dk.20150623.gappssmtp.com
    header.i=@kernel-dk.20150623.gappssmtp.com header.b=oWPpZKTT
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Z68630eY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=kernel-dk.20150623.gappssmtp.com
      header.i=@kernel-dk.20150623.gappssmtp.com header.b=oWPpZKTT
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Z68630eY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG1yVlJfBvCJR9VAV07W/p1z8cBZIt534Kr+fGCrhQNl06o/dlVx3DvZ0tkkrjpzH7ETtbYN5SEut5+wDbNmhqX6k/RifYJc69mNZ6zGZha7AhT1ZFPE
    TCAjgrmQjcHeKL7Nk0gpvNIB9cX7sKWk0rRrljnV1imAg/2qfvMmSYNR9m4rJe4MNZjwCCjEoKW7zYcMZcSVbhSqnd+HerXCeAxyktYE+oGcktpZA2o4LVMW
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=ZNa7TQ0pAAAA:8 a=VwQbUJbxAAAA:8 a=U5eyg_PKTedS9A6cQXUA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=vJYgOXllGJzHSJiAounk:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752955AbeEOQLW (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 12:11:22 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55478 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752972AbeEOQLT (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 15 May 2018 12:11:19 -0400
X-Google-Smtp-Source: AB8JxZr4z+xyR3CPEpa0V2oC4RWOj8NbBnJW/DWEDcUpyAF5oHVwgE0qMIigjX9WJ7DNco29lnj5Wg==
Subject: Re: [PATCH 1/2] Convert target drivers to use sbitmap
To: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        qla2xxx-upstream@qlogic.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
References: <20180515160043.27044-1-willy@infradead.org>
 <20180515160043.27044-2-willy@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3a56027b-47bc-dcb8-a465-3670031572f1@kernel.dk>
Date: Tue, 15 May 2018 10:11:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180515160043.27044-2-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/15/18 10:00 AM, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> The sbitmap and the percpu_ida perform essentially the same task,
> allocating tags for commands.  Since the sbitmap is more used than
> the percpu_ida, convert the percpu_ida users to the sbitmap API.

It should also be the same performance as percpu_ida in light use, and
performs much better at > 50% utilization of the tag space. I think
that's better justification than "more used than".

> diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
> index 4435bf374d2d..28bcffae609f 100644
> --- a/drivers/target/iscsi/iscsi_target_util.c
> +++ b/drivers/target/iscsi/iscsi_target_util.c
> @@ -17,7 +17,7 @@
>   ******************************************************************************/
>  
>  #include <linux/list.h>
> -#include <linux/percpu_ida.h>
> +#include <linux/sched/signal.h>
>  #include <net/ipv6.h>         /* ipv6_addr_equal() */
>  #include <scsi/scsi_tcq.h>
>  #include <scsi/iscsi_proto.h>
> @@ -147,6 +147,28 @@ void iscsit_free_r2ts_from_list(struct iscsi_cmd *cmd)
>  	spin_unlock_bh(&cmd->r2t_lock);
>  }
>  
> +int iscsit_wait_for_tag(struct se_session *se_sess, int state, int *cpup)
> +{
> +	int tag = -1;
> +	DEFINE_WAIT(wait);
> +	struct sbq_wait_state *ws;
> +
> +	if (state == TASK_RUNNING)
> +		return tag;
> +
> +	ws = &se_sess->sess_tag_pool.ws[0];
> +	for (;;) {
> +		prepare_to_wait_exclusive(&ws->wait, &wait, state);
> +		if (signal_pending_state(state, current))
> +			break;
> +		schedule();
> +		tag = sbitmap_queue_get(&se_sess->sess_tag_pool, cpup);
> +	}
> +
> +	finish_wait(&ws->wait, &wait);
> +	return tag;
> +}

Seems like that should be:


	ws = &se_sess->sess_tag_pool.ws[0];
	for (;;) {
		prepare_to_wait_exclusive(&ws->wait, &wait, state);
		if (signal_pending_state(state, current))
			break;
		tag = sbitmap_queue_get(&se_sess->sess_tag_pool, cpup);
		if (tag != -1)
			break;
		schedule();
	}

	finish_wait(&ws->wait, &wait);
	return tag;

>  /*
>   * May be called from software interrupt (timer) context for allocating
>   * iSCSI NopINs.
> @@ -155,9 +177,11 @@ struct iscsi_cmd *iscsit_allocate_cmd(struct iscsi_conn *conn, int state)
>  {
>  	struct iscsi_cmd *cmd;
>  	struct se_session *se_sess = conn->sess->se_sess;
> -	int size, tag;
> +	int size, tag, cpu;
>  
> -	tag = percpu_ida_alloc(&se_sess->sess_tag_pool, state);
> +	tag = sbitmap_queue_get(&se_sess->sess_tag_pool, &cpu);
> +	if (tag < 0)
> +		tag = iscsit_wait_for_tag(se_sess, state, &cpu);
>  	if (tag < 0)
>  		return NULL;

Might make sense to just roll the whole thing into iscsi_get_tag(), that
would be cleaner.

sbitmap should provide a helper for that, but we can do that cleanup
later. That would encapsulate things like the per-cpu caching hint too,
for instance.

Rest looks fine to me.

-- 
Jens Axboe

