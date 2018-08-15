Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FEFC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 05:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2368216E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 05:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2368216E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeHOHsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 03:48:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:58991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbeHOHsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 03:48:24 -0400
Received: from homer.simpson.net ([185.191.216.245]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0y8F-1g9orp2RA7-00v6A9; Wed, 15
 Aug 2018 06:57:42 +0200
Message-ID: <1534309061.26284.17.camel@gmx.de>
Subject: Re: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
From:   Mike Galbraith <efault@gmx.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Wed, 15 Aug 2018 06:57:41 +0200
In-Reply-To: <20180815035921.GA5865@dhcp-128-65.nay.redhat.com>
References: <1533737025.4936.3.camel@gmx.de>
         <20180810084501.GA11901@dhcp-128-65.nay.redhat.com>
         <20180810102846.GA31327@dhcp-128-65.nay.redhat.com>
         <1533922786.5083.7.camel@gmx.de>
         <20180815035921.GA5865@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yxpKSsJLVNcB9DAuUnRxgIlTrLt8CoCVRWrwZiuPHlq33yUSEj9
 NOEwiiYyX4Ir3GZbcbfZsmiWQHsAo6r6D/NLe5NWt60KoICVPTqKQVshbQXYg1oeJ3JCtSI
 nHYD40s0JIESlbQlvlOXsh+0WNlTFTSQDfRJwTJfRXGpG1xKaqcZg6q6ZmxlIG5RL23+3co
 6VRXtVqgSSolpH6x6TQuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zuTBlHWTmZk=:Qv2XXlcsTv0s/DAAAG/+rH
 dg+JK6sHkX9X23JLLBrbT70VNJaNkjHftUl5YpJWBo4SL88RornxccOVNBlLie6Fd/4RQ8s/h
 l+PtYqOcmCMO4gCi8+0W8JTLD+IycWaoxZIoHK3kU3bCRHzKZ/0w3oz9zqrW62+itCBDWhgD+
 gF+/et259Cv1d+JXMf9eQ5qdW38KgucK+WOYKsYJx3wSt8lD+gZJiLHYIT7MmFJxa5wNqWOYT
 W//48I7BoKNn64t2zIXmMtJg6ZN1WtvaiOYQeQMYFnoo95lLsHo2CSyF5TTBNhyg9ebJRWUgf
 bf0/vYEceLT61RZOqcIc5EswGi0Q5AlG7EW/BUdOnDCHUa9YQHzP3ZE0oNzPUY6B9cvLawYTQ
 n3bHosraxVomN/kLUyIZ9AKnFYGYG2MtFSAHL/EoiLY47eHBtXsHgYr+5IFUCZC/0YMi7xj19
 p48cD5yVysGMdxkfPPL2YE7B4x8qlLtcWPcs4LuzUPUk4G+RnXI4K00FxOU3xAfT1luGKfFyG
 s7qqePGydtDDHwZmFc8zH2lnkKIVa1do1znSW+500QwJSmkKPltNxTeUlbh57IQqEUy1l322K
 YGlWloE9LA8S+9K6LYQaZfHFH3UpR3KuevuKZ1MKAM5nonbfv12VVl1+8vB/qnCoQteF+VJGn
 XHKHlVOmyGce0IU8DOphm9EVAzJyXdhrJsQ70/qi5qC7l+yA6G0lxYH41kldCci13FTfqpF1Z
 a/57vMNNKjMPmHixYTL2gzyl3rAhRMaNp6VWyXA3GB7uWWk1maMmPHq+2iRaIJ3fFRoi7bw3L
 Z66fKVb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-15 at 11:59 +0800, Dave Young wrote:
> > Does this improve things, and plug the no boot hole?
> 
> Would you mind to tune my patch with some acpi_rsdp checking and add
> some error message in case kexec load failure? Eg. suggest people to use
> append acpi_rsdp for noefi booting etc.

Yeah, -ENODEV is better than hanging, but not very informative.

> I'm still not very satisfied with the code cleanup..

Not surprising, I didn't like it much either (ergo interrogative).

	-Mike
