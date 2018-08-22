Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02EEC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6175C214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6175C214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbeHVRWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:22:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:40259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729021AbeHVRWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:22:38 -0400
Received: from homer.simpson.net ([185.146.51.41]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mda8q-1fT7f93yIe-00PNYp; Wed, 22
 Aug 2018 15:57:28 +0200
Message-ID: <1534946246.8087.11.camel@gmx.de>
Subject: Re: bisected - arm64 kvm unit test failures
From:   Mike Galbraith <efault@gmx.de>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Wed, 22 Aug 2018 15:57:26 +0200
In-Reply-To: <77ab9a57-b3ad-d8fa-7dc8-b94527f56139@arm.com>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532768831.9882.71.camel@gmx.de> <1532847330.1618.8.camel@gmx.de>
         <1532864867.1618.32.camel@gmx.de> <1532967899.30205.62.camel@gmx.de>
         <1533061729.12487.26.camel@gmx.de>
         <c96d252c-6ed7-320e-0d47-c4b78af20ce0@arm.com>
         <1534945105.8087.8.camel@gmx.de>
         <77ab9a57-b3ad-d8fa-7dc8-b94527f56139@arm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CWo/pp58KMqItmhHBOGFjuwFH+xgw1CRsRvtx9ViSwRp80FQktv
 bUI8YosiLvcuffDzuJKs/74ZWowZGT4xtcsKNUnJdjtaI+APGurWQDy5o/y0RPIsigXUuNy
 kcnXMSnzyPbcQ+T6vIOJMd1yXu2ZXeYpNdM2dFY6j4JwP1AgdPSU8Q3edaSY3xw9piWy4kv
 4EGIhxtS3jPUAUMPN03Cw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AueG14YRsQU=:HwXPXaqlaaLQX8Snh7l51T
 vAPmBsGGr3Y72ddmDtXREb3OK5crrGhzpxxpS5qSgQPm1RRy72U+6JtV/fPI8tvTJSidfFXHj
 zRS+WumOLomZyc7MYbJ2Vug8WM50hOeOI/2OCBnS93bSofDbIb2OR9bvL0WrlvtBWeRjoKZlT
 atFsQXv0vJ2ClEzeahbgBoYZqEDIlR5zWE77SYwrKYYVmXiAI/itb+lWXazc5f6pb0v4REJWE
 ynOyye392qmavSw2lwqdkVMyAV++3eAm+vghGttImuw9L120ipJeYHkFKj8EtOKWVBXAS3QL6
 7VCzbRbx5nYlWxs0G9Q+snMkWulmFZopOpO2QAvHHoFYBXKtpMRQHryRf3Egs3SMbJcl3F9tY
 dOhdp8npHRtI7OK2AnYewnN8kuZ6tCN85x7R8leIWfMvS3JgZRsVC7QipUakeJET2+DMxH7sD
 uBZmTZirtaAduvIERwl2TUh2mSW63bX36WSMjH3EpgsuOihXNcd3I+shJz7/pn7Hc7c8ZYDaD
 MOmlxoV/pj102XVGQ/s67sjq46uc0pLGs2YrAa36Un8Mloobsj9Tq9O1hB5wVg9cDzCndkKO5
 U2t2DPYJ3OFa+k7c2x0sPWQORJZMR7DCe7IcnecBa4O9mf2Un5TxLu1LCMwKCjebAJDo2jniT
 iTvl0eLfavx5ZJi7J4yvVyYCU46itmmFikDCKhW1wAGGMmlMiuH1gR3ZMefrPXp7WpuiUyebd
 zxUEqdHG0aB5M5x0zlwke1Fma9FAgpJzGjO15bbSOWDf3TutdKXg1atF9sjRt2NaHoSzNqjr+
 Mk3FOxx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-22 at 14:50 +0100, Marc Zyngier wrote:
> On 22/08/18 14:38, Mike Galbraith wrote:
> > On Tue, 2018-08-21 at 16:34 +0100, Marc Zyngier wrote:
> >> Could you give that patchlet[1] a go? It solves a similar issue for me
> >> on a different platform.
> >>
> >> [1] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-August/032469.html
> > 
> > Yup, all better.
> 
> Now I'm not sure it actually fixes anything. Alex's test case seem to
> have opened a new can of worms... In tracing hell at the moment.

I'll keep the test box reserved a while longer.  When you get it's
other leg stuffed into the casket, if you want testing, holler.

	-Mike
