Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753293AbeBLRHy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:07:54 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33732 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbeBLRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:07:50 -0500
X-Google-Smtp-Source: AH8x227BnAPfkQm9sk4599cFE6BnGCc+W6MvDvNnC6ZW5nXVt+edAvPLXiTe8KJCKvDcbnGXr1xroA==
Date: Mon, 12 Feb 2018 09:07:47 -0800
From: Tejun Heo <tj@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        dri-devel@lists.freedesktop.org, Peter Wu <peter@lekensteyn.nl>,
        nouveau@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Pierre Moreau <pierre.morrow@free.fr>, linux-kernel@vger.kernel.org,
        Ismo Toijala <ismo.toijala@gmail.com>, intel-gfx@lists.freedesktop.org,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH 1/5] workqueue: Allow retrieval of current task's work
 struct
Message-ID: <20180212170747.GX695913@devbig577.frc2.facebook.com>
References: <cover.1518338788.git.lukas@wunner.de>
 <2d8f603074131eb87e588d2b803a71765bd3a2fd.1518338788.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d8f603074131eb87e588d2b803a71765bd3a2fd.1518338788.git.lukas@wunner.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Feb 11, 2018 at 10:38:28AM +0100, Lukas Wunner wrote:
> Introduce a helper to retrieve the current task's work struct if it is
> a workqueue worker.
> 
> This allows us to fix a long-standing deadlock in several DRM drivers
> wherein the ->runtime_suspend callback waits for a specific worker to
> finish and that worker in turn calls a function which waits for runtime
> suspend to finish.  That function is invoked from multiple call sites
> and waiting for runtime suspend to finish is the correct thing to do
> except if it's executing in the context of the worker.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

I wonder whether it's too generic a name but there are other functions
named in a similar fashion and AFAICS current_work isn't used by
anyone in the tree, so it seems okay.

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route as you see fit.

Thanks.

-- 
tejun
