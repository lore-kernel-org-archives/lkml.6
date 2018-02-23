Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbeBWSFw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 13:05:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751527AbeBWSFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 13:05:51 -0500
Subject: Re: [PATCH] KVM: SVM: Fix sparse: incorrect type in argument 1
 (different base types)
To: Brijesh Singh <brijesh.singh@amd.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc: kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
References: <20180219161228.46931-1-brijesh.singh@amd.com>
 <20180221174910.GI30522@ZenIV.linux.org.uk>
 <f55f25f6-559d-bb93-5605-af66678438c2@amd.com>
 <20180221201839.GK30522@ZenIV.linux.org.uk>
 <f8b22e16-73b4-340a-7387-c8c7270e9432@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <561de7e2-84a6-7372-b561-b035ff390ac5@redhat.com>
Date: Fri, 23 Feb 2018 19:05:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f8b22e16-73b4-340a-7387-c8c7270e9432@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2018 16:56, Brijesh Singh wrote:
> 
> 
> On 02/21/2018 02:18 PM, Al Viro wrote:
>> On Wed, Feb 21, 2018 at 01:59:55PM -0600, Brijesh Singh wrote:
>>
>>> Sure, checking access_ok() does not guarantee that later
>>> copy_from_user() will not fail. But it does eliminate one possible
>>> reason for the failure. We are trying to validate most of the user
>>> inputs before we invoke  SEV command.
>>
>> That makes no sense whatsoever.  If user is deliberately fuzzing
>> your code or trying to DoS it, that "validation" doesn't buy you
>> anything - they can just as well feed you NULL, after all.
>>
> 
> 
> Currently, we let user query the blob length with params.len == 0 ||
> param.uaddr == NULL. We could limit it to just params.len == 0.
> 
> 
>> What is the rationale for that?  "Userland is accidentally feeding
>> us garbage pointers" is the case where slowness is the least of your
>> concerns...
>>
> 
> My intent was to do some obvious failure checks on user inputs before
> invoking the HW. I do see your point that if userspace is feeding us
> garbage then slowness is least of our concern. If you think that we
> should not be using access_ok() in this particular case then I am okay
> with it.

Can you please send a patch?  Thanks!

Paolo
