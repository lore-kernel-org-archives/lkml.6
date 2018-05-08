Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755707AbeEHUgn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 16:36:43 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40676 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752749AbeEHUgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 16:36:42 -0400
X-Google-Smtp-Source: AB8JxZoU4Re+v0iDWGVFq8B9ksaiGEnfWFezfHHCywbJS25+GazeDI5VXH7CD8FBLs7fqT/W6D+s5HE3aWRPLe0K9go=
MIME-Version: 1.0
In-Reply-To: <20180508103427.w2rq3vz3f66y4cxh@vireshk-i7>
References: <20180508073340.13114-1-dietmar.eggemann@arm.com>
 <20180508082242.bre6sjfvefhz6xc3@vireshk-i7> <8cf21b1a-ca6e-fed7-43c5-94c66ff5986b@arm.com>
 <20180508094526.ajyjrwytguhv4xpe@vireshk-i7> <20180508100227.GB3752@e108498-lin.cambridge.arm.com>
 <20180508103427.w2rq3vz3f66y4cxh@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 8 May 2018 22:36:40 +0200
X-Google-Sender-Auth: hTxRYeSn3SxVV60oXEgWHeQYocQ
Message-ID: <CAJZ5v0iN0msbi=ad34nS8eVfGGS1UD-qUeHPeAvq=yW3-4HKCQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "cpufreq: schedutil: Don't restrict kthread to
 related_cpus unnecessarily"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 8, 2018 at 12:34 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 08-05-18, 11:02, Quentin Perret wrote:
>> The sugov kthreads are DL tasks so they're not impacted by EAS. But even
>> if you take EAS out of the picture, those kthreads are assigned to a
>> "random" CPU at boot time and stay there forever (because that's how DL
>> works). Is this what we want ?
>
> Okay, I didn't knew that DL threads don't migrate at all. I don't
> think that's what we want then specially for big LITTLE platforms. But
> for the rest, I don't know. Take example of Qcom krait. Each CPU has a
> separate policy, why shouldn't we allow other CPUs to run the kthread?

Because that makes things more complex and harder to debug in general.

What's the exact reason why non-policy CPUs should ever run the sugov
kthread for the given policy?
