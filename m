Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeEVKyf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:54:35 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43864 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbeEVKyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:54:32 -0400
X-Google-Smtp-Source: AB8JxZqfdf4HzLjfSNMjMfAAfKuX/ep2HNcpP8Ro4zKz4Iq6+oEJzhSUgjLMIDX+lGlaa0oIth2o+A==
Date: Tue, 22 May 2018 16:24:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Joel Fernandes (Google.)" <joelaf@google.com>,
        linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>,
        claudio@evidence.eu.com, kernel-team@android.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Message-ID: <20180522105429.yn2omuz63oa2w3ez@vireshk-i7>
References: <20180518185501.173552-1-joel@joelfernandes.org>
 <20180522103415.cuutobi5kbhj4gcw@vireshk-i7>
 <20180522105006.hvntwnhzzvhznij2@vireshk-i7>
 <4393838.cQWhzXzUcj@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4393838.cQWhzXzUcj@aspire.rjw.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-18, 12:50, Rafael J. Wysocki wrote:
> Ugly indeed.

Hehe. I was thinking, maybe we can write wrapper helpers around lock/unlock
which are stored as pointers in sg_policy. So that those are only set to
non-NULL values (or non-Noop routines) for slow-switching single policy or
any-switching shared policy systems. Then we can get rid of such conditional
locking attempts :)

-- 
viresh
