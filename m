Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932651AbeCLRLh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 13:11:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932326AbeCLRLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 13:11:36 -0400
Subject: Re: [PATCH 1/3] x86/kvm/vmx: read MSR_FS_BASE from current->thread
To: Andy Lutomirski <luto@kernel.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm list <kvm@vger.kernel.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20180312140300.6166-1-vkuznets@redhat.com>
 <20180312140300.6166-2-vkuznets@redhat.com>
 <327f3194-715c-7aa7-f1bb-9ee1073f5b99@redhat.com>
 <CALCETrWmytXxC7tSiqCqFOs1Cvz_-u0=YVn7VoRSOr7k6kdkjA@mail.gmail.com>
 <36451719-2905-22e2-6c9b-bbb676e7e663@redhat.com>
 <CALCETrWmAhHijX9O1HzD0Jp=Rgawrx9jiYQh5MrXHfA0=15iuw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7de8802b-e463-ef3b-79b2-024696e8aca1@redhat.com>
Date: Mon, 12 Mar 2018 18:11:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWmAhHijX9O1HzD0Jp=Rgawrx9jiYQh5MrXHfA0=15iuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2018 18:00, Andy Lutomirski wrote:
>> Why in save_..._legacy?  If it is about FSGSBASE, shouldn't it be in
>> save_fsgs?  (Or if not I'm missing what the comment should be about).
> It could be in save_fsgs(), I guess.  The main point is to make it
> clear to readers of the code in save_fsgs(), the legacy helpers, etc
> that there's another piece of code in KVM that makes the same set of
> somewhat problematic assumptions and that will need updating for
> FSGSBASE.

Okay, that's a good idea.

Paolo
