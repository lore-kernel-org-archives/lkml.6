Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639DAC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A1E21479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A1E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeLFIkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:40:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728941AbeLFIkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:40:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 528E95276F;
        Thu,  6 Dec 2018 08:40:41 +0000 (UTC)
Received: from nostromo.localnet (ovpn-204-252.brq.redhat.com [10.40.204.252])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1305060CD1;
        Thu,  6 Dec 2018 08:40:39 +0000 (UTC)
Subject: Re: [PATCH 0/2] Fix return code and improve feature check for
 synthetic uevents
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, jeyu@kernel.org, linux-kernel@vger.kernel.org,
        msekleta@redhat.com
References: <20181205112745.12276-1-prajnoha@redhat.com>
 <20181205163044.GB7185@kroah.com>
From:   Peter Rajnoha <prajnoha@redhat.com>
Message-ID: <a2ca5544-55d2-10d4-cc6e-a3554c84b341@redhat.com>
Date:   Thu, 6 Dec 2018 09:40:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181205163044.GB7185@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 06 Dec 2018 08:40:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dňa 5. 12. 2018 o 17:30 Greg KH napísal(a):
> On Wed, Dec 05, 2018 at 12:27:43PM +0100, Peter Rajnoha wrote:
>> Two small patches to aid handling of synthetic uevents back in userspace:
>>
>>   - Return error code back to userspace on /sys/.../uevent file write
>>     failure so userspace knows and it can act accordingly.
>>
>>   - Add new 'kernel/uevent_features' sysfs file to make it possible for
>>     userspace to check that the extended synthetic uevent arguments are
>>     supported without relying on kernel version check only.
>>
>> Peter Rajnoha (2):
>>   kobject: return error code if writing /sys/.../uevent fails
>>   kobject: add kernel/uevent_features sysfs file
> 
> Did you send this series twice?  Which one should I pay attention to?
> 
> confused,
> 
> greg k-h
> 

They're same, I just sent it again because I forgot to add the LKML list
with the first one. So please take the latter one with that list on CC.
Sorry for the confusion.

-- 
Peter
