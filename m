Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbeAaWX7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 17:23:59 -0500
Received: from smtp-18-i6.italiaonline.it ([213.209.14.18]:44746 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751360AbeAaWX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 17:23:58 -0500
x-libjamoibt: 1601
X-CNFS-Analysis: v=2.2 cv=cZCiljLM c=1 sm=1 tr=0
 a=XeJ7lniyEEjQtHijZ6FjDA==:117 a=XeJ7lniyEEjQtHijZ6FjDA==:17
 a=IkcTkHD0fZMA:10 a=-hwUz_SmDC9gzLOuhQ8A:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] Rename inode_cmp_iversion{+raw} to
 inode_eq_iversion{+raw}
To: Matthew Wilcox <willy@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20180131204309.32474-1-kreijack@libero.it>
 <20180131215509.GD28275@bombadil.infradead.org>
From: Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <77e08780-5f8b-5efd-d92d-c633f7b277a6@libero.it>
Date: Wed, 31 Jan 2018 23:23:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180131215509.GD28275@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEbNe7LlNjmwBJU3nhG26bnEAkIcOmD8WiWExTyTg+laQW34Rpng1TqBcuXU1wyu+klVZMsGBLYTuENljcEROfFErSEdBs7f0e83KlCouNJVr6ZyNq3C
 AQdoCcAbb4Im4dFB8LI2LgyLE5MltMpWdaWR3TZ2zknI3vu78ulMyLpckjYCGGWoLbHaQPG6vbgj/M0/XDPkhKk2kgmoUJl7iF5Zu5TafF9B8SgJcglxlR7O
 MSiaxfYKMySpus2xe3N3VMZ446Cpu4NrTaMrtKrYlr8boLHfWwV3RaOrdIkxO/7YW44pkpyArrwOZPDPYJMJQg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/31/2018 10:55 PM, Matthew Wilcox wrote:
> On Wed, Jan 31, 2018 at 09:43:09PM +0100, Goffredo Baroncelli wrote:
>> The function inode_cmp_iversion{+raw} is counter-intuitive, because it
>> returns true when the counters are different and false when these are equal.
>>
>> Rename it to inode_eq_iversion{+raw}, which will returns true when
>> the counters are equal and false otherwise.
> 
> A lot of places use !inode_eq_iversion().  I think we should have both
> inode_eq_iversion() and inode_ne_iversion().

A function is needed because before doing the comparing, a "conversion"
is needed. 
My feeling is that the positive "form" is the more natural. And the notion
"!*eq*" is intuitive as the "*ne*".


> 
> Also, we have 'inode' in the name, why keep the 'i'?  inode_eq_version()
> and inode_ne_version() are shorter.  We could even go so far as
> iversion_eq() and iversion_ne() if keeping 'iversion' in the string
> is important.

All the functions introduced by Jeff are in the form inode_<verb>_iversion. 
So for consistency, inode_eq_iversion() makes sense.

> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
