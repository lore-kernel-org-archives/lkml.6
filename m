Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1594BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCD920892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCD920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbeLFJH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:07:26 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:34640 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727575AbeLFJH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:07:26 -0500
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.53 with ESMTP; 6 Dec 2018 18:07:23 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO WMRRD11NA101CK) (10.178.30.142)
        by 156.147.1.151 with ESMTP; 6 Dec 2018 18:07:23 +0900
X-Original-SENDERIP: 10.178.30.142
X-Original-MAILFROM: chanho.min@lge.com
From:   "Chanho Min" <chanho.min@lge.com>
To:     "'Pavel Machek'" <pavel@ucw.cz>
Cc:     "'Oleg Nesterov'" <oleg@redhat.com>,
        "'Ingo Molnar'" <mingo@kernel.org>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        "'Linux List Kernel Mailing'" <linux-kernel@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Peter Zijlstra'" <a.p.zijlstra@chello.nl>,
        "'Michal Hocko'" <mhocko@suse.com>, <seungho1.park@lge.com>
References: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com> <20181203074700.GA21240@gmail.com> <20181203115601.GA31795@redhat.com> <20181204091736.GD73770@gmail.com> <20181205143618.GA9535@redhat.com> <02a901d48d41$40aff110$c20fd330$@lge.com> <20181206085748.GA16059@amd>
In-Reply-To: <20181206085748.GA16059@amd>
Subject: RE: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux 4.20-rc4)
Date:   Thu, 6 Dec 2018 18:07:23 +0900
Message-ID: <02b101d48d43$19ef85c0$4dce9140$@lge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIyDiMBIRrrGJHCkbd/uAm7qO0xxAFZXsAJAsWB798CKEutVQITr4gzAwLaDcsBvPt/0aRNkkqQ
Content-Language: ko
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > I am sorry for the reverting this patch. It's also my fault that
> > I didn't check lockdep. But, We decided to keep this patch in our product.
> > Freeze fail is a real problem we've had for the last two years,
> > whereas lockdep's notice is not a real problem.
> > We hope this issue will be resolved soon.
> 
> I guess it makes sense for your usage.
> 
> How often do you see the failures without the patch?
Very rare, it happens about 1 in 1000 suspends.

Chanho,

