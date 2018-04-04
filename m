Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbeDDV0N (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 17:26:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36741 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752313AbeDDV0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 17:26:12 -0400
X-Google-Smtp-Source: AIpwx4/I/34lhsdrt4rgbVmH/LRxYrYdb7/nqvOn4h0nj0Rqn30+HQXWL34BpYZ25JemJ/uTukiEsQ==
Date: Thu, 5 Apr 2018 00:26:10 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] prctl: Deprecate non PR_SET_MM_MAP operations
Message-ID: <20180404212610.GI15783@uranus.lan>
References: <20180404185523.GG15783@uranus.lan>
 <ca6a276b-d986-c977-9448-6cfc3ebef0f8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca6a276b-d986-c977-9448-6cfc3ebef0f8@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 02:16:33PM -0700, Yang Shi wrote:
> On 4/4/18 11:55 AM, Cyrill Gorcunov wrote:
> > An ability to manipulate mm_struct fields was introduced in
> > sake of CRIU in first place. Later we provide more suitable
> > and safe operation PR_SET_MM_MAP where all fields to be modifed
> > are passed in one structure which allows us to make more detailed
> > verification.
> > 
> > -
> >   	if (arg5 || (arg4 && (opt != PR_SET_MM_AUXV &&
> 
> This PR_SET_MM_AUXV should be removed too? There is not callsite to
> prctl_set_auxv() anymore.

Yeah, good point. Will update.
