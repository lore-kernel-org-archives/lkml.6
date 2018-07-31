Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0C8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBC020844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBC020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbeGaUhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:37:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731423AbeGaUhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:37:14 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0729330820E1;
        Tue, 31 Jul 2018 18:55:35 +0000 (UTC)
Received: from [10.10.124.209] (ovpn-124-209.rdu2.redhat.com [10.10.124.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27EA420161A1;
        Tue, 31 Jul 2018 18:55:32 +0000 (UTC)
Subject: Re: [PATCH 18/26] target/iscsi: Allocate session IDs from an IDA
To:     Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180621212835.5636-1-willy@infradead.org>
 <20180621212835.5636-19-willy@infradead.org> <5B59FB56.9090901@redhat.com>
 <5B5A014D.9060901@redhat.com> <20180727193814.GB3825@bombadil.infradead.org>
 <5B5B892D.1000305@redhat.com> <yq1wotcw49i.fsf@oracle.com>
 <20180731181510.GA16794@bombadil.infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Varun Prakash <varun@chelsio.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5B60B09E.3040402@redhat.com>
Date:   Tue, 31 Jul 2018 13:55:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180731181510.GA16794@bombadil.infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 31 Jul 2018 18:55:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 01:15 PM, Matthew Wilcox wrote:
> On Mon, Jul 30, 2018 at 10:03:21PM -0400, Martin K. Petersen wrote:
>>
>> Mike,
>>
>>>> How about I take it through my tree to minimise the amount of rebasing
>>>> I'll need to do?  I'm already dependent on the nvdimm tree and I'd rather
>>>> not depend on the scsi tree as well.  I'll queue it up in front of my
>>>> IDA change to maximise its backportability.
>>>
>>> Ccing Martin, because he has been handling target patches.
>>
>> That's fine with me.
>>
>> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
> 
> Thanks, Martin.  Mike, can I have your Signed-off-by: on the original patch?

Yes,

Signed-off-by: Mike Christie <mchristi@redhat.com>


> What Fixes: line should this have?  As far as I can tell, the bug is present
> all the way back to its introduction, so:
> 
> Fixes: e48354ce078c ("iscsi-target: Add iSCSI fabric support for target v4.1")
> 
> yes?

The session_index bug was in that patch, but I think it correctly kfreed
the session in __iscsi_target_login_thread.


I think it was this one that added the early kfree bug:

commit 0957627a99604f379d35831897a2aa15272528fc
Author: Nicholas Bellinger <nab@linux-iscsi.org>
Date:   Fri Nov 4 11:36:38 2011 -0700

    iscsi-target: Fix sess allocation leak in iscsi_login_zero_tsih_s1

Dan's tools probably just did not catch the iscsi_login_zero_tsih_s1 ->
iscsi_login_set_conn_values call that sets conn->sess then later
kfree(conn->sess) call in the error handling in __iscsi_target_login_thread.
