Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937687AbeBUObW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:31:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934310AbeBUObU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:31:20 -0500
Date: Wed, 21 Feb 2018 15:31:17 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/2] perf, tools, stat: Reset ids counter when retrying
 events
Message-ID: <20180221143117.GB2565@krava>
References: <20171006020029.13339-1-andi@firstfloor.org>
 <20171006020029.13339-2-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171006020029.13339-2-andi@firstfloor.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2017 at 07:00:29PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>

ouch, sry for overlooking this

> 
> perf stat can retry opening events. After opening an file descriptor
> it adds the ids to the ecsel. Each event keeps a running
> count of ids. When we decide to close an evsel and retry
> with a different configuration this count needs to be reset,
> otherwise it can overflow the buffer.

how can this happen? we call store_counter_ids at the
end of the loop, when the evsel is all done and can't
be reconfigured

thanks,
jirka
