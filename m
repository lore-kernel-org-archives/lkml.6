Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934458AbeBMKz6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:55:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934011AbeBMKz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:55:56 -0500
Subject: Re: [PATCH 2/2] x86/speculation: Support "Enhanced IBRS" on future
 CPUs
To: David Woodhouse <dwmw2@infradead.org>, tglx@linutronix.de,
        x86@kernel.org, kvm@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, arjan.van.de.ven@intel.com,
        dave.hansen@intel.com
References: <1518449255-2182-1-git-send-email-dwmw@amazon.co.uk>
 <1518449255-2182-2-git-send-email-dwmw@amazon.co.uk>
 <7e2e5ad1-49b6-1fdb-4a62-8ad6aefc30a0@redhat.com>
 <1518509708.12890.33.camel@infradead.org>
 <27c85759-e662-d281-f8a0-0a80ca8ee18f@redhat.com>
 <1518517262.12890.43.camel@infradead.org>
 <1518518198.12890.48.camel@infradead.org>
 <02bd3fdd-1b73-6cab-fb09-38ba933396bd@redhat.com>
 <1518519234.12890.58.camel@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b55a1e8a-a70f-b007-e4d7-6864d7bdd683@redhat.com>
Date: Tue, 13 Feb 2018 11:55:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1518519234.12890.58.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2018 11:53, David Woodhouse wrote:
>> You have my vote. :)  Really, IBRS_ALL makes no sense and it would be
>> nice to know _why_ Intel is pushing something that makes no sense.
> No, IBRS_ALL *does* make sense. It's not a complete fix, but it's as
> much of a fix as they should shoe-horn into the generation of CPUs
> which are currently going to the fabs.
> 
> With IBRS_ALL they presumably add tags to the predictions with the VMX
> mode and ring, to give complete protection against predictions being
> used in a more privileged mode. 

Yeah, but I still don't get why they need an MSR to turn those tags on.
Is it basically a chicken bit in the wrong direction?

Paolo
