Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeDRQJk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 12:09:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35665 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbeDRQJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 12:09:39 -0400
Subject: Re: [RFC PATCH v3 1/3] ima: extend clone() with IMA namespace support
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        tycho@docker.com, serge@hallyn.com, sunyuqiong1988@gmail.com,
        david.safford@ge.com, mkayaalp@cs.binghamton.edu,
        James.Bottomley@HansenPartnership.com, Yuqiong Sun <suny@us.ibm.com>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
References: <1522159038-14175-1-git-send-email-stefanb@linux.vnet.ibm.com>
 <1522159038-14175-2-git-send-email-stefanb@linux.vnet.ibm.com>
 <87sh8lcecn.fsf@xmission.com> <1523636702.3272.63.camel@linux.vnet.ibm.com>
From: John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <d8c30d7d-c679-9323-7a25-d3148e9b96c6@canonical.com>
Date: Wed, 18 Apr 2018 09:09:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523636702.3272.63.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13/2018 09:25 AM, Mimi Zohar wrote:
> [Cc'ing John Johansen]
> 
> On Tue, 2018-03-27 at 18:01 -0500, Eric W. Biederman wrote:
> [...]
>> As such I expect the best way to create the ima namespace is by simply
>> writing to securityfs/imafs.  Possibly before the user namespace is
>> even unshared.  That would allow IMA to keep track of things from
>> before a container is created.
> 

I do think this is generally the right approach for LSMs when looking
forward to LSM stacking and more LSMs.


> My initial thought was to stage IMA namespacing with just IMA-audit
> first, followed by either IMA-measurement or IMA-appraisal.  This
> would allow us to get the basic IMA namespacing framework working and
> defer dealing with the securityfs related namespacing of the IMA
> policy and measurement list issues to later.
> 
> By tying IMA namespacing to a securityfs ima/unshare file, we would
> need to address the securityfs issues first.
> 

well it depends on what you want to do. It would be possible to have
a simple file (not a jump link) within securityfs that IMA could use
without having to deal with all the securityfs issues first. However it
does require that securityfs (not necessarily imafs) be visible within
the mount namespace of the task doing the setup.
