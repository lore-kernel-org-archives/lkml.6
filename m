Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811DFC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D7220844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D7220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbeGYNbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:31:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728942AbeGYNbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:31:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 28577C324;
        Wed, 25 Jul 2018 12:20:09 +0000 (UTC)
Received: from [10.10.123.162] (ovpn-123-162.rdu2.redhat.com [10.10.123.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DD941687E;
        Wed, 25 Jul 2018 12:19:54 +0000 (UTC)
Subject: Re: [Qemu-devel] [RFC v3] qemu: Add virtio pmem device
To:     Pankaj Gupta <pagupta@redhat.com>
References: <20180713075232.9575-1-pagupta@redhat.com>
 <20180713075232.9575-4-pagupta@redhat.com>
 <783786ae-2e85-2376-448c-1e362c3d4d48@redhat.com>
 <399916154.53931292.1532494899706.JavaMail.zimbra@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, kwolf@redhat.com,
        haozhong zhang <haozhong.zhang@intel.com>, jack@suse.cz,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        riel@surriel.com, niteshnarayanlal@hotmail.com, david@redhat.com,
        ross zwisler <ross.zwisler@intel.com>, lcapitulino@redhat.com,
        hch@infradead.org, mst@redhat.com, stefanha@redhat.com,
        imammedo@redhat.com, pbonzini@redhat.com,
        dan j williams <dan.j.williams@intel.com>, nilal@redhat.com
From:   Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d3fe397a-024d-faf7-8854-bb8e9ea17f53@redhat.com>
Date:   Wed, 25 Jul 2018 07:19:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <399916154.53931292.1532494899706.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 25 Jul 2018 12:20:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 25 Jul 2018 12:20:09 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eblake@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25/2018 12:01 AM, Pankaj Gupta wrote:

>>
>> This patch has no n/M in the subject line; but is included in a thread
>> that also has a 0/2 cover letter, as well as 1/2 and 2/2 patches in
>> separate mails.  Is that intentional?
> 
> Yes, kernel series has 0-2 patches and Qemu has this one. I thought its
> good to keep separate numbering for both the sets.

Ah, that makes sense. The cover letter didn't make it obvious to me that 
this was two separate series to two projects, but related enough that 
both series have to be incorporated for the feature to work and thus 
cross-posted under a single cover letter.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
