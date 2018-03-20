Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753277AbeCTMjb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:39:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51356 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753019AbeCTMj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:39:28 -0400
Date: Tue, 20 Mar 2018 13:39:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, corbet@lwn.net,
        rjw@rjwysocki.net, lenb@kernel.org, hpa@zytor.com
Subject: Re: [PATCH 3/5] x86/smpboot: Make the check code more clear in
 prefill_possible_map()
Message-ID: <20180320123918.GS4043@hirez.programming.kicks-ass.net>
References: <20180320110432.28127-1-douly.fnst@cn.fujitsu.com>
 <20180320110432.28127-4-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320110432.28127-4-douly.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 07:04:30PM +0800, Dou Liyang wrote:
> case 1: no  | no  | no | -->  min (setup_possible_cpus, nr_cpu_ids, setup_max_cpus)
> case 2: no  | no  | yes| -->  min (setup_possible_cpus, nr_cpu_ids)
> case 3: no  | yes | no | -->  1                                    
> case 4: no  | yes | yes| -->  1
> case 5: yes | no  | no | -->  min (num_processors, nr_cpu_ids, setup_max_cpus)
> case 6: yes | no  | yes| -->  min (num_processors + disabled_cpus, nr_cpu_ids)
> case 7: yes | yes | no | -->  1 
> case 8: yes | yes | yes| -->  1

The case number is off by one ;-)
