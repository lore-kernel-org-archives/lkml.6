Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeDGL7I (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 07:59:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:48204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751447AbeDGL7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 07:59:07 -0400
Subject: Re: [RFC 0/2] To introduce xenwatch multithreading (xen mtwatch)
To: Dongli Zhang <dongli.zhang@oracle.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc: boris.ostrovsky@oracle.com, ian.jackson@eu.citrix.com,
        wei.liu2@citrix.com, srinivas.eeda@oracle.com
References: <1523100355-27647-1-git-send-email-dongli.zhang@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <5c8c5c98-c16f-2df4-8582-90b5facc9f54@suse.com>
Date: Sat, 7 Apr 2018 13:59:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523100355-27647-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/18 13:25, Dongli Zhang wrote:
> This is to introduce "xenwatch multithreading" (or "multithreaded xenwatch",
> abbreviated as 'mtwatch'). The implementation of xen mtwatch involves below
> components:
> 
> * dom0 linux kernel
> * xen toolstack
> 
> Here are what the RFC is going to discuss:
> 
> - what is the problem
> - what is the objective
> - what is the solution

Instead of creating one thread per domU, wouldn't it make much more
sense to use another mechanism, e.g. a workqueue, to deliver the
watch events? This would be one central place, wouldn't need any
changes in Xen tools or complex mechanisms to select the correct
thread, save resources, and domUs would benefit, too.


Juergen
