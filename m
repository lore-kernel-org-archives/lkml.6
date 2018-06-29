Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA965C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652A527B86
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652A527B86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753763AbeF2H0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:26:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1675 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751712AbeF2H01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:26:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52E90307CF31;
        Fri, 29 Jun 2018 07:26:27 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-112.phx2.redhat.com [10.3.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CA8277343;
        Fri, 29 Jun 2018 07:26:24 +0000 (UTC)
Subject: Re: [PATCH v8 2/5] ipc: IPCMNI limit check for semmni
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>
References: <1529317698-16575-1-git-send-email-longman@redhat.com>
 <1529317698-16575-3-git-send-email-longman@redhat.com>
 <20180628223906.GB331@wotan.suse.de>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d0596d73-1130-3ee5-a8ee-b8a9e8989d45@redhat.com>
Date:   Fri, 29 Jun 2018 15:26:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180628223906.GB331@wotan.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 29 Jun 2018 07:26:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/2018 06:39 AM, Luis R. Rodriguez wrote:
> On Mon, Jun 18, 2018 at 06:28:15PM +0800, Waiman Long wrote:
>> For SysV semaphores, the semmni value is the last part of the 4-element
>> sem number array. To make semmni behave in a similar way to msgmni and
>> shmmni, we can't directly use the _minmax handler. Instead, a special
>> sem specific handler is added to check the last argument to make sure
>> that it is limited to the [0, IPCMNI] range. An error will be returned
>> if this is not the case.
> Sorry my time has run out, and will be on vacation until July 10th. If
> this can wait until then then great, otherwise hopefully Kees can take
> a look. It would be wonderful to get Eric's review on this as well.
>
>   Luis

Thanks for the review. I will try to get other reviewer to chime in.

Kees and Eric, do you have comments on this patchset?

Cheers,
Longman

