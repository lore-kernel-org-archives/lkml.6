Return-Path: <byungchul.park@lge.com>
X-Google-Smtp-Source: AG47ELsOl1khHx+QlSIhkDvDCPFI//oPVnsKRAurnxOtaWMfR7Li5o0quAVJ6eQuPpwprvVvelKP
ARC-Seal: i=1; a=rsa-sha256; t=1521156399; cv=none;
        d=google.com; s=arc-20160816;
        b=Bmn17Vnv0+oUoRvz/fjNUjeS4CufVCzd//Hpg5xBUxTsIkee3X0OXuGK1AHeyIDj5R
         usdC0CQl74Ycmbqn1JVD0Nf6GNNAM7mB3XSNS8UBMADiK2sDMGsEH/fMgMjEwckBJFxa
         d99AAgjOdCUU7HoTwW4T/jdNGEQUF2dP0f8I1RRNsaJrihvoYlpawH/AkD/4EeTdEfE0
         UUPI5nQiVBz1yBSympmyMvLwuFAE7WTmI4J58KyZLxgkK2Fj6gvH2jXYaZWJhvZrpXJy
         DvzcO6lqknjZ+JvKTa2KiCxCOK5cXeWlW6CQfsLVI1H96GIHHXXNzeJovVqfxovfM+xB
         ujAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=n6baGMxMsqxoZs4Y1WcaoUIHBVJH9a005pSbmS7+zs4=;
        b=GPBrUeDUtxeSPVdUNPIn5pwHSvahetJHsnMUf5+fugty9ABOtr9MyVbqzvZ4SkfXWt
         tZFkV66jV8ICRQ91pt29wcAbR1Oi04+mpkguwlykpWwgH2rUEHBitb5rfkmFoPgd2FDQ
         5nvvEUqhp3NY0cA3BAHw0fgFtD/Od1L/a38vHfawr245+kEfLFSdGLCPzs/XMPM1h195
         21rvlLxnR3xI4NLQ0jkn6NlaGazp/DB34NePHwx1N5eWpHfF1yZPeUPANT+BUcX+qJUV
         ZthjGNpgqibPNyxYBUBPDbACspR8+LibEMNHH12D03oNe/A0sWk2AczF7YH56YDE8RB+
         Pgeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of byungchul.park@lge.com designates 156.147.23.51 as permitted sender) smtp.mailfrom=byungchul.park@lge.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of byungchul.park@lge.com designates 156.147.23.51 as permitted sender) smtp.mailfrom=byungchul.park@lge.com
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.184
X-Original-MAILFROM: byungchul.park@lge.com
Subject: Re: [PATCH] kthread: finer-grained lockdep/cross-release completion
To: Peter Zijlstra <peterz@infradead.org>, Daniel Vetter <daniel@ffwll.ch>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
 Marta Lofstedt <marta.lofstedt@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shaohua Li <shli@fb.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>,
 Daniel Vetter <daniel.vetter@intel.com>, kernel-team@lge.com,
 Amir Goldstein <amir73il@gmail.com>, Theodore Ts'o <tytso@mit.edu>
References: <20171207100849.407-1-daniel.vetter@ffwll.ch>
 <20171208105419.jdzene5wrsriwm2n@hirez.programming.kicks-ass.net>
 <20171211091928.cpw3srz2rddmruxj@phenom.ffwll.local>
 <20171218071159.GW26573@phenom.ffwll.local>
 <CA+55aFwD+0hhehWHmh8PW9eDCVtEBTi9KCmCrJXZRUFj77r82Q@mail.gmail.com>
 <20171219095925.GY26573@phenom.ffwll.local>
 <aae95b90-a0c8-4825-17fb-b31eb1aecf80@lge.com>
 <CAKMK7uHdk1CT9YP00fb0mpBQdg_Di6CKv+z5ZXSS9Q4tbOcwAg@mail.gmail.com>
 <20180315124130.GY4064@hirez.programming.kicks-ass.net>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <30162a1d-74d4-3bce-f901-12a29f38632e@lge.com>
Date: Fri, 16 Mar 2018 08:26:33 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315124130.GY4064@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1586119401963161178?=
X-GMAIL-MSGID: =?utf-8?q?1595048092465726007?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/15/2018 9:41 PM, Peter Zijlstra wrote:
> On Thu, Mar 15, 2018 at 11:31:57AM +0100, Daniel Vetter wrote:
>> Is there any progress on getting cross-release enabled again?
> 
> Not yet, I'm still fighting the meltdown/spectre induced backlog.
> 
> We'll get to it eventually.

Please let me know when you get available so that I can start.

-- 
Thanks,
Byungchul
