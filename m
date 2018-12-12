Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2120BC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C499C20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C499C20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solarflare.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeLLRLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:11:07 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:34034 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726922AbeLLRLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:11:07 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us3.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 7D2719C00EA;
        Wed, 12 Dec 2018 17:11:05 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Dec 2018 09:11:01 -0800
Subject: Re: [PATCH v2 0/4] Static calls
To:     Nadav Amit <namit@vmware.com>, Josh Poimboeuf <jpoimboe@redhat.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <0e96ac37-d5c5-86b6-833c-0de01ba18f0d@solarflare.com>
 <20181211180521.ljdvnnztjnvoijge@treble>
 <86D72260-838C-4CE0-ACE3-BE92A3E9CFD8@vmware.com>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <899194d1-9777-71ed-70db-212d2983a400@solarflare.com>
Date:   Wed, 12 Dec 2018 17:11:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <86D72260-838C-4CE0-ACE3-BE92A3E9CFD8@vmware.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24280.005
X-TM-AS-Result: No-6.570200-4.000000-10
X-TMASE-MatchedRID: scwq2vQP8OEOwH4pD14DsPHkpkyUphL9EtdrY/Wb3fNtw+n+iKWyyE7d
        KmAMKi3ayBGYSGbi6KF6NFxU6UzhW8uY+x+wpWIHz5rIW0RbS5gVATEbq/G3PMzx6z1tcKfOYz3
        gRzJw0jBSVviQICSjpMt3+x4RStaZZfoccan3KT5PtFVFuufzC+imxgRHwEwm9VvJjT/N2QZrQn
        EsHq4OJm6J2zhTMQBN6zOSo1h3c0DoQeawBxNOVh47EGkpGeA9fS0Ip2eEHnzWRN8STJpl3PoLR
        4+zsDTtFAQvQYa7pINDddl/4iE1w6CscJepy2nYf/j3Wkumya0O4NLXne7mHg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.570200-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24280.005
X-MDID: 1544634665-DQ6y6pfxDdmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/18 05:59, Nadav Amit wrote:
> Thanks for cc’ing me. (I didn’t know about the other patch-sets.)
Well in my case, that's because I haven't posted any yet.  (Will follow up
 shortly with what I currently have, though it's not pretty.)

Looking at your patches, it seems you've got a much more developed learning
 mechanism.  Mine on the other hand is brutally simple but runs continuously
 (i.e. after we patch we immediately enter the next 'relearning' phase);
 since it never does anything but prod a handful of percpu variables, this
 shouldn't be too costly.

Also, you've got the macrology for making all indirect calls use this,
 whereas at present I just have an open-coded instance on a single call site
 (I went with deliver_skb in the networking stack).

So I think where we probably want to go from here is:
 1) get Josh's static_calls in.  AIUI Linus seems to prefer the out-of-line
    approach; I'd say ditch the inline version (at least for now).
 2) build a relpolines patch series that uses
   i) static_calls for the text-patching part
  ii) as much of Nadav's macrology as is applicable
 iii) either my or Nadav's learning mechanism; we can experiment with both,
      bikeshed it incessantly etc.

Seem reasonable?

-Ed
