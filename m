Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E07C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B2F22510
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B2F22510
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbeKNBOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:14:19 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39075 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387822AbeKNBOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:14:17 -0500
Received: by mail-qk1-f194.google.com with SMTP id q70so2444742qkh.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 07:15:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tx49J2syjhWOEueDdZkU118sh/wS8PhhlwJCc02l8bg=;
        b=blnlYpSd5WmP/08xukvxBM40ugSkkgTl5Es0mnwW5SPFyyQ9TadxBnkBiMSKTaEgX8
         OQnZkPoPPrB6VPIxdARaG2dJlC4PaUEt4eEHpcIJNv8S5I752AiODWUgS1+Ap4hTnvqI
         K9LVRdVrvz4J/XRWkJ9dwXy2zOBEKzR0v1gJfAIuOdJZK3I3IwaZw4sLSExgv9hfs734
         2DxMRQ2Hm+vweDDexu3rP+86JskTHPMK9MUfSPPW9hshm3jmwJhogVvp2bJEQwMwsMiV
         89VR7istZpLmJMNep1Uv5iiN+knn4cnCjzmAqK4IhJskfkLXFfwlE28gC9/SwHp3PJJh
         n52A==
X-Gm-Message-State: AGRZ1gK6ZasSuOaCHP1O67VxzMpdAyNlXroeQ68wpZ8MJGP4/N8pV1P0
        dowrKPwhONhBghEuiIHO6dopWQ==
X-Google-Smtp-Source: AJdET5czo3Hm3F0rzsetw51D8BYE8A7ov9SUHGAVrb20OvsdkQNTUAC6jEQLgYR4oWDVHHEAvUMFog==
X-Received: by 2002:a0c:f9c3:: with SMTP id j3mr5703733qvo.107.1542122142800;
        Tue, 13 Nov 2018 07:15:42 -0800 (PST)
Received: from [10.150.73.190] (161.sub-174-227-144.myvzw.com. [174.227.144.161])
        by smtp.gmail.com with ESMTPSA id z8sm5073239qto.45.2018.11.13.07.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:15:41 -0800 (PST)
Subject: Re: Official Linux system wrapper library?
To:     Joseph Myers <joseph@codesourcery.com>,
        Florian Weimer <fweimer@redhat.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
 <20181111081725.GA30248@1wt.eu>
 <3664a508-ca74-4ff0-39a6-34543194a24e@gmail.com>
 <878t1zx4gj.fsf@oldenburg.str.redhat.com>
 <alpine.DEB.2.21.1811121641040.6607@digraph.polyomino.org.uk>
From:   Carlos O'Donell <carlos@redhat.com>
Openpgp: preference=signencrypt
Organization: Red Hat
Message-ID: <85ce01c3-0704-b915-e591-437a051d371c@redhat.com>
Date:   Tue, 13 Nov 2018 10:15:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811121641040.6607@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/18 11:43 AM, Joseph Myers wrote:
> On Sun, 11 Nov 2018, Florian Weimer wrote:
> 
>> People may have disappeared from glibc development who have objected to
>> gettid.  I thought this was the case with strlcpy/strlcat, but it was
>> not.
> 
> Well, I know of two main people who were objecting to the notion of adding 
> bindings for all non-obsolescent syscalls, Linux-specific if not suitable 
> for adding to the OS-independent GNU API, and neither seems to have posted 
> in the past year.
> 
>> At present, it takes one semi-active glibc contributor to block addition
>> of a system call.  The process to override a sustained objection has
>> never been used successfully, and it is a lot of work to get it even
>> started.
> 
> We don't have such a process.  (I've suggested, e.g. in conversation with 
> Carlos at the Cauldron, that we should have something involving a 
> supermajority vote of the GNU maintainers for glibc in cases where we're 
> unable to reach a consensus in the community as a whole.)
 
... and I need a good excuse to propose such a process :-)

-- 
Cheers,
Carlos.
