Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186DCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4E520832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4E520832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeK2CA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:00:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbeK2CA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:00:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB4557621F;
        Wed, 28 Nov 2018 14:59:01 +0000 (UTC)
Received: from jlaw-desktop.bos.csb (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81849705BC;
        Wed, 28 Nov 2018 14:59:01 +0000 (UTC)
Subject: Re: [RFC PATCH 0/1] support ftrace and -ffunction-sections
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <1542745158-25392-1-git-send-email-joe.lawrence@redhat.com>
 <a6c4b12d-389e-8919-d37b-50ba73319b8f@redhat.com>
 <20181127210942.4067ad46@vmware.local.home>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <02ee4864-21aa-d150-b376-d6a775d7cc7d@redhat.com>
Date:   Wed, 28 Nov 2018 09:59:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181127210942.4067ad46@vmware.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 28 Nov 2018 14:59:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2018 09:09 PM, Steven Rostedt wrote:
> On Tue, 27 Nov 2018 15:27:14 -0500
> Joe Lawrence <joe.lawrence@redhat.com> wrote:
> 
>> Gentle ping...  I took a dive through the rhkl-archives and found a few
>> older discussions:
> 
> Thanks for the reminder, my INBOX is totally out of control with
> Plumbers followed by Turkey Day.
> 
> [ ... snip ... ]
> 
> I'm fine with just applying your patch. Today, for x86, there's a gcc
> option that adds the __mcount_loc automatically without doing any
> whitelisting (it doesn't run recordmcount.*). It just adds anything that
> is traced, thus it has to work for all possible cases now.
> 

Ah right, -mcount-record ...  I must have been using an older gcc w/o
-mcount-record in my testing.  Thanks for taking a look and merging.

Regards,

-- Joe
