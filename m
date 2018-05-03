Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeECMkt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:40:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:43019 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbeECMkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:40:47 -0400
Message-ID: <1525351221.9956.4.camel@gmx.de>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Date: Thu, 03 May 2018 14:40:21 +0200
In-Reply-To: <20180503122808.GZ12217@hirez.programming.kicks-ass.net>
References: <20180417142119.GA4511@codeblueprint.co.uk>
         <20180420095005.GH4064@hirez.programming.kicks-ass.net>
         <20180424133325.GA3179@codeblueprint.co.uk>
         <1525349542.9956.2.camel@gmx.de>
         <20180503122808.GZ12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Mhwmdhf+jSzP9cnAtS4oZlYn5YvAYsei5WhCKCq8KVnsZ+8k3Mv
 Cs998eGquwGwnn7o99mPuOVPaj5oGax+N5NtZC6z/XTXobdgUj3CjFuPdbdWu5VUk2iUTT8
 QgP/jq53HFhks8sdWNRaC2D/svjDT1qS15UxLufQo76Zz9xr/iIn5iqfOzmCLLYqhZNIZoy
 3xKKmp/XYtjVhWEOJg4xQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n/pnxpDiroA=:6KJdMJXgmc4RXKOk74/Go7
 sRp2jpftEwbm9famEryZKVGrHsEV08a0RoSelKtL3cGbemdzFCK2NBU/U1Q9wfBUvpHsgSSz/
 4/RJTPun5FocIHcX05IOuKn0f1KhDRpaRvgJlyq61lyLPiQLU8zF1yfC+bSRBfzvEgBwl8zqi
 fo/cjwHdKtFj4SPPyEriOW/zistdhOYn+l9mLEVxWIFk3msTVsCxJQ0bf1yxfTrIff6aRMb4x
 xiICP9iCLAFQYoB4ArBlT8xJlyymLPdJEJ5ZWWjb63aYywx7eCFFDVOjzzA6dP1BdsUhgQFCt
 UDDMrwdSnt0bvkFHTrse6NBTgG4Q7sPViz2ftz0jDFXJsoG8meIKMVKkYt5MFysT0m1LALJWq
 AbUmnjSNmf8QN0bIQM4V6Od1Q2iFm0bhKritJzBAis1CQbJwgwCQRNU0ZIBy+sG3GnUF/uTAw
 9MxGDV5TVztheFABjrxGjwdadFRhmL69JTcna/YTiq6+gWb11Bf6bm/zbKXBnhzqqpaHcjbFL
 /wgzdJ0Q8LLmK9aCmfkVDwlmT3m0QeDxrg/jpwDudd3h08l5Akpa71mJkAwOgrUv2xVVBOAxE
 CF0MLsDoGBQHrqVf3dCO3xaVKLOgoQLMonvmjT2lnR4A0H87WIGm6AY8w4WDgTGcPqxJkIHsb
 oE63dOXGOUOAp/H3wG2+om9HWSPf9JYd5j4welL3RCGpbD/QH7udsddRjAt3cplemm4bATUB2
 +aCJo4GUbf1CcTD7trHuSUEl/EE1+Q97mpt+IM6dMOwudhsGEzUMEyXOc9vjVZNVXJE3icI4+
 9efEOoz
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-03 at 14:28 +0200, Peter Zijlstra wrote:
> 
> Hurm.. I don't see how this is 'new'. We moved the wakeup out from under
> stopper lock, but that should not affect the RCU state.

No, not new, just an additional woes from same spot.

	-Mike
