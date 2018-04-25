Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755974AbeDYRSo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:18:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755832AbeDYRSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:18:01 -0400
Date: Wed, 25 Apr 2018 19:17:57 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
        David.Panariti@amd.com, akpm@linux-foundation.org
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
Message-ID: <20180425171757.GA10441@redhat.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <87muxsbmkp.fsf@xmission.com>
 <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
 <877eowa5qh.fsf@xmission.com>
 <20180425135552.GD7592@redhat.com>
 <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25, Andrey Grodzovsky wrote:
>
> here (drm_sched_entity_fini) is also a bad idea, but we still want to be
> able to exit immediately
> and not wait for GPU jobs completion when the reason for reaching this code
> is because of KILL
> signal to the user process who opened the device file.

Can you hook f_op->flush method?

Oleg.
