Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FA9C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98834213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98834213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeJIApL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:45:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:35398 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726291AbeJIApK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:45:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0308BB0A5;
        Mon,  8 Oct 2018 17:32:22 +0000 (UTC)
Date:   Mon, 8 Oct 2018 19:32:16 +0200
From:   Borislav Petkov <bp@suse.de>
To:     "Singh, Brijesh" <brijesh.singh@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: X86: Add missing KVM_AMD dependency
Message-ID: <20181008173216.GJ6490@zn.tnic>
References: <1538765165-19177-1-git-send-email-linux@roeck-us.net>
 <749a21f9-ad88-af0e-bed7-b505ac57568d@redhat.com>
 <20181005220325.GA24365@roeck-us.net>
 <713d35b9-5dd5-284f-b514-7d2295a2db34@redhat.com>
 <b489282b-912d-e79d-3b7a-77784b8c51c9@roeck-us.net>
 <c7ae3d1a-5ec0-b2bb-b752-44ea99b1fdcd@redhat.com>
 <5e1de49e-9ec5-b11b-d38b-845d0274dc03@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e1de49e-9ec5-b11b-d38b-845d0274dc03@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 02:52:46PM +0000, Singh, Brijesh wrote:
> Does it make sense to move all the SEV specific code in svm-sev.c ?
> I am looking to add SEV migration support very soon, and can see
> myself adding more SEV command handling which will grow svm.c further.

Amen to that - svm.c is pretty huge already. And if you end up moving
facilities, you can simply call it sev.c

Just my 2¢.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
